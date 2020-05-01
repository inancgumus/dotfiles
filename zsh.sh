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


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
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
