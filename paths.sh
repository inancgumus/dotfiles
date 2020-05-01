# os x wasn't running path-helper
# i've added this for /etc/paths.d/go
eval `/usr/libexec/path_helper -s`

# use these commands with their normal names
# access their man pages with normal names
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

#
# DISABLED: it was too slow.
#
# gnu tools
# NOTE: this should be the first in path!
# if type brew >/dev/null 2>&1; then
#   PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
# fi

PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/bin:/usr/bin:/usr/sbin:/sbin

PATH=$PATH:/usr/local/redis/bin
PATH=$PATH:"$HOME/.rbenv/bin"
PATH=$PATH:node_modules/.bin

PATH=$PATH:./bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/dev/bin

PATH=$PATH:$MAGICK_HOME/bin

PATH=$PATH:$HOME/go/bin
PATH=$PATH:$HOME/Library/Python/3.7/bin

# finally... export the path. inanc.
export PATH="$PATH"
