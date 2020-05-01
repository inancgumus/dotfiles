source "$dotfiles/git-prompt.sh"

# previous settings:
CURRENT_DIR="${Yellow}\w$NC"
CURSOR="${BRed}>$NC ${BWhite}"

unset sudo PR PSbase


# choose your prompt:

# ? complex:
# export PS1="$CURRENT_DIR${BYellow}\$(__git_ps1)\n$CURSOR "

# ? simple:
export PS1="\[\033[001;36m\]$ \[\033[0m\]"
