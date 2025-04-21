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
  keychain
  gpg-agent

  cp
  extract
  history
  knife
  knife_ssh
  macos
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

# for keychain and gpg-agent
zstyle :omz:plugins:keychain agents ssh,gpg
zstyle :omz:plugins:keychain identities id_rsa 459E5519E1A180A2

#
# highlights usual commands: echo, ls, touch, ...
#
source $HOMEBREW_PREFIX/Cellar/zsh-syntax-highlighting/0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
