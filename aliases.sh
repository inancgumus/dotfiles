# Development aliases
alias ..='cd ../'

alias m="make"
alias ls='exa -lahF -h --git --color=always -s type'

source "$dotfiles/aliases.docker.sh"
source "$dotfiles/aliases.k8s.sh"
source "$dotfiles/aliases.tools.sh"
source "$dotfiles/aliases.git.sh"
source "$dotfiles/aliases.redis.sh"

# i'm not using rails anymore.
# source "$dotfiles/aliases.rails.sh"
