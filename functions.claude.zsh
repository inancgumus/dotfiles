# functions.claude.zsh — Parent settings inheritance for Claude Code
#
# PROBLEM:
#   Claude Code doesn't traverse parent directories for .claude/settings.json.
#   If you have ~/grafana/.claude/settings.json with shared config (API key,
#   model, plugins), child repos like ~/grafana/k6/ don't inherit it.
#
# SOLUTION:
#   This wrapper overrides the `claude` command. When run from any child
#   directory under ~/grafana/, it deep-merges all parent settings.json
#   files into the child's .claude/settings.local.json before launching
#   claude, then cleans up on exit.
#
# WHY settings.local.json:
#   Claude Code has a settings hierarchy: user < project < local.
#   settings.local.json is the "local" scope — highest priority, and
#   Claude automatically gitignores it. So the merged file never pollutes
#   git, and no .git/info/exclude hacks are needed.
#
# MERGE ORDER:
#   Parent settings.json files are collected from ~/grafana/ down to the
#   nearest parent. The child's own settings.local.json (if any) is
#   appended last. jq deep-merges them left to right — later files win on
#   conflicts. So: grandparent < parent < child's local settings.
#
# RUNTIME CHANGES:
#   Claude writes to settings.local.json during a session (e.g., when you
#   approve a tool permission). On exit, the wrapper diffs the current file
#   against the merge snapshot to extract only what claude changed (the
#   "delta"). Parent-inherited keys are stripped. The delta is then:
#   - Merged into the child's original settings.local.json (if it had one)
#   - Or saved as a new settings.local.json (if it didn't)
#   This way, permission approvals survive across sessions without
#   accumulating parent settings in the child's file.
#
# CRASH RECOVERY:
#   A marker file (.claude/.cc-marker) stores the PID and state. If claude
#   crashes or the shell dies before cleanup, the next wrapper invocation
#   detects the orphaned marker, checks if the PID is dead, and runs
#   cleanup automatically.
#
# SIGNAL SAFETY:
#   Cleanup runs inside zsh's `always` block (equivalent to try/finally),
#   so Ctrl+C, SIGTERM, and other signals can't skip it. The original
#   settings.local.json is restored before temp files are deleted, so even
#   a partial cleanup can't lose data.
#
# SETUP:
#   1. Requires jq: brew install jq
#   2. Sourced from dotfiles/functions.sh
#
# SCOPE:
#   Only activates under ~/grafana/ child dirs. Running claude from
#   ~/grafana/ itself (which already has .claude/settings.json) or from
#   anywhere outside ~/grafana/ passes through to the real claude binary.
#
# TEMP FILES (all cleaned up on exit):
#   .claude/.settings.local.json.bak   — backup of child's original
#   .claude/.settings.local.json.orig  — merge snapshot for delta detection
#   .claude/.settings.local.json.tmp   — intermediate merge output
#   .claude/.cc-marker                 — crash recovery state (PID, flags)

_CC_ROOT="$HOME/grafana"
_CC_MARKER=".claude/.cc-marker"

claude() {
    [[ "$PWD" == "$_CC_ROOT/"* ]] || { command claude "$@"; return; }
    _cc_recover

    local -a chain=()
    local d="$PWD"
    while d="${d%/*}"; [[ "$d" == "$_CC_ROOT"* ]]; do
        [[ -f "$d/.claude/settings.json" ]] && chain=("$d/.claude/settings.json" "${chain[@]}")
        [[ "$d" == "$_CC_ROOT" ]] && break
    done

    (( ${#chain[@]} == 0 )) && { command claude "$@"; return; }

    if ! command -v jq &>/dev/null; then
        echo "claude-wrapper: jq required (brew install jq)" >&2
        command claude "$@"
        return
    fi

    local created_dir=false backed_up=false

    [[ ! -d ".claude" ]] && mkdir ".claude" && created_dir=true

    [[ -f ".claude/settings.local.json" ]] && chain+=(".claude/settings.local.json")

    if jq -s 'reduce .[] as $item ({}; . * $item)' "${chain[@]}" > ".claude/.settings.local.json.tmp" 2>/dev/null; then
        if [[ -f ".claude/settings.local.json" ]]; then
            mv ".claude/settings.local.json" ".claude/.settings.local.json.bak"
            backed_up=true
        fi
        mv ".claude/.settings.local.json.tmp" ".claude/settings.local.json"
        jq -S . ".claude/settings.local.json" > ".claude/.settings.local.json.orig" 2>/dev/null
    else
        rm -f ".claude/.settings.local.json.tmp"
        $created_dir && rmdir ".claude" 2>/dev/null
        command claude "$@"
        return
    fi

    printf 'pid=%s\ndir=%s\nbak=%s\n' "$$" "$created_dir" "$backed_up" > "$_CC_MARKER"

    local rc
    {
        command claude "$@"
        rc=$?
    } always {
        _cc_cleanup "$backed_up" "$created_dir"
    }
    return $rc
}

_cc_recover() {
    [[ -f "$_CC_MARKER" ]] || return 0
    local pid= dir=false bak=false
    while IFS='=' read -r k v; do
        case $k in
            pid) pid=$v ;; dir) dir=$v ;; bak) bak=$v ;;
        esac
    done < "$_CC_MARKER"

    [[ -n "$pid" && "$pid" != "$$" ]] && kill -0 "$pid" 2>/dev/null && return 0
    _cc_cleanup "$bak" "$dir"
}

_cc_cleanup() {
    local bak="$1" dir="$2"

    _cc_save_runtime_changes "$bak"

    if [[ "$bak" == "true" ]]; then
        mv -f ".claude/.settings.local.json.bak" ".claude/settings.local.json" 2>/dev/null
    else
        rm -f ".claude/settings.local.json"
    fi
    rm -f "$_CC_MARKER" ".claude/.settings.local.json.orig"
    [[ "$dir" == "true" ]] && rmdir ".claude" 2>/dev/null
    return 0
}

_cc_save_runtime_changes() {
    local bak="$1"
    [[ -f ".claude/settings.local.json" && -f ".claude/.settings.local.json.orig" ]] || return 0

    local current_sorted
    current_sorted=$(jq -S . ".claude/settings.local.json" 2>/dev/null) || return 0

    [[ "$current_sorted" == "$(cat .claude/.settings.local.json.orig)" ]] && return 0

    local delta
    delta=$(jq -n --argjson orig "$(cat .claude/.settings.local.json.orig)" --argjson curr "$current_sorted" '
        $curr | with_entries(select(.value != ($orig[.key] // null)))
    ' 2>/dev/null) || return 0

    [[ "$delta" == "{}" || -z "$delta" ]] && return 0

    if [[ "$bak" == "true" && -f ".claude/.settings.local.json.bak" ]]; then
        jq -s '.[0] * .[1]' ".claude/.settings.local.json.bak" <(echo "$delta") \
            > ".claude/.settings.local.json.new" 2>/dev/null && \
            mv ".claude/.settings.local.json.new" ".claude/.settings.local.json.bak"
    else
        echo "$delta" > ".claude/.settings.local.json.bak"
    fi
}
