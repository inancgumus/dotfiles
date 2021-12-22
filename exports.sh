# added for aws cli
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR='vim'
export VISUAL_EDITOR=$EDITOR

export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups   # ignore dup cmds
export HISTSIZE=1000

export GNUTERM='x11'

HOMEBREW_PREFIX=$(brew config | grep HOMEBREW_PREFIX | awk -F': ' '{print $2}')
export BREW_HOME=$HOMEBREW_PREFIX/Cellar

export MAGICK_HOME="$home/ImageMagick-6.8.8"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

export KAFKA_HOME=/opt/kafka

export GOTRACEBACK=all
