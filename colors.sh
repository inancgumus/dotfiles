# colorful terminal
export CLICOLOR=1
export LSCOLORS=fxFxaxExcxexexaxaxaxFx

# normal Colors
black="\033[0;30m"
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
blue="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
white="\033[0;37m"

# bold
bblack="\033[1;30m"
bred="\033[1;31m"
bgreen="\033[1;32m"
byellow="\033[1;33m"
bblue="\033[1;34m"
bpurple="\033[1;35m"
bcyan="\033[1;36m"
bwhite="\033[1;37m"

# background
onblack="\033[40m"
onred="\033[41m"
ongreen="\033[42m"
onyellow="\033[43m"
onblue="\033[44m"
onpurple="\033[45m"
oncyan="\033[46m"
onwhite="\033[47m"

nc="\033[0m"						# color reset

goUpCode="\033[1a"					# go to the previous line
checkSign="\xE2\x9C\x93"
errSign="\xE2\x9C\x97"

source "$dotfiles/colors.grep.sh"
source "$dotfiles/colors.man.sh"