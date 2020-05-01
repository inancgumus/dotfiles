#
# Install on new computers:
#
# https://github.com/powerline/fonts
#

function powerline_precmd() {
    PS1="$(/usr/local/bin/powerline-go -error $? -shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

#
# this makes powerline more powerful
#
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
