source "$dotfiles/git-prompt.sh"

# previous settings:
CURRENT_DIR="${Yellow}\w$NC"
CURSOR="${BRed}>$NC ${BWhite}"

export PS1="$CURRENT_DIR${BYellow}\$(__git_ps1)\n$CURSOR "

unset sudo PR PSbase

# kurs icin simplify etmek icin ekledim
# gecici. sonra kaldir....
# 2018
export PS1="\[\033[001;36m\]$ \[\033[0m\]"
