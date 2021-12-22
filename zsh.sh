# ------------------------------------------------------------------------------
#
# ENABLE THIS FOR PROFILING .zshrc
#
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
# setopt XTRACE
#
# ------------------------------------------------------------------------------


source "$HOME/Desktop/dev/dotfiles/init_paths.sh"
source "$dotfiles/init.sh"

function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0})"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    install_powerline_precmd
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# ------------------------------------------------------------------------------
#
# ENABLE THIS FOR PROFILING .zshrc
#
# THEN RUN:
# $dotfiles/sort_timings.sh <log_file_name>
#
# unsetopt XTRACE
# exec 2>&3 3>&-
#
# ------------------------------------------------------------------------------
