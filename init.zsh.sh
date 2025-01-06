ZSH_THEME="robbyrussell"

source "$dotfiles/init.zsh.plugins.sh"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
HIST_STAMPS="dd.mm.yyyy"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Path to your oh-my-zsh installation.
export ZSH="$home/.oh-my-zsh"

# Enable GPG keys for Github
export GPG_TTY=$(tty)

source $ZSH/oh-my-zsh.sh
# eval "$(starship init zsh)"

# disable printing % at the end of the line.
# for example, in curl, zsh adds % at the end of the line
# if the line doesn't end with a newline.
unsetopt PROMPT_SP
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""