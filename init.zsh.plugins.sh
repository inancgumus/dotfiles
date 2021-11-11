#
# Install these plugins on new computers
#

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  brew
  git

  cp
  extract
  history
  knife
  knife_ssh
  osx
  zsh-autosuggestions
  # zsh-syntax-highlighting

  colorize
  colored-man-pages

  golang

  docker
  docker-compose
  docker-machine
  kubectl
)


#
# highlights usual commands: echo, ls, touch, ...
#
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
