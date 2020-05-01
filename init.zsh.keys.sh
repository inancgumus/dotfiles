#
# zsh keys
#

# delete the word at left
backward-kill-dir () {
  local WORDCHARS=${WORDCHARS/\/}
  zle backward-kill-word
}
zle -N backward-kill-dir

# ctrl+r cmd search
bindkey '^R' history-incremental-search-backward

# reverse delete a word: binds to alt+backspace
bindkey '^[^?' backward-kill-dir

# enable emacs (vim like) key bindings
bindkey -e

bindkey '^[[1;5C' forward-word   # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word  # [Ctrl-LeftArrow] - move backward one word
