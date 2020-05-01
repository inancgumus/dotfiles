# colorful terminal
export CLICOLOR=1
export LSCOLORS=fxFxaxExcxexexaxaxaxFx

# normal Colors
black="\033[0;30m"        # black
red="\033[0;31m"          # red
green="\033[0;32m"        # green
yellow="\033[0;33m"       # yellow
blue="\033[0;34m"         # blue
purple="\033[0;35m"       # purple
cyan="\033[0;36m"         # cyan
white="\033[0;37m"        # white

# bold
bblack="\033[1;30m"       # black
bred="\033[1;31m"         # red
bgreen="\033[1;32m"       # green
byellow="\033[1;33m"      # yellow
bblue="\033[1;34m"        # blue
bpurple="\033[1;35m"      # purple
bcyan="\033[1;36m"        # cyan
bwhite="\033[1;37m"       # white

# background
onblack="\033[40m"       # black
onred="\033[41m"         # red
ongreen="\033[42m"       # green
onyellow="\033[43m"      # yellow
onblue="\033[44m"        # blue
onpurple="\033[45m"      # purple
oncyan="\033[46m"        # cyan
onwhite="\033[47m"       # white

nc="\033[0m"             # color reset


ALERT=${bwhite}${onred}  # bold white on red background

goUpCode="\033[1a"			# go to the previous line
checkSign="\xE2\x9C\x93"
errSign="\xE2\x9C\x97"


source "$dotfiles/colors.grep.sh"
source "$dotfiles/colors.man.sh"