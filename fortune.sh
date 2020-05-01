#
# For reference (very good examples!)
# http://www.mewbies.com/acute_terminal_fun_01_get_ascii-fied_on_the_terminal.htm#fortune
#

function lucky {
    declare -a styles=("dog" "cat" "mouse" "peek" "stone" "cc" "ian_jones")
    style=${styles[$RANDOM % ${#styles[@]}+1 ]}

    # -ph5v0 means:
    #   5px horizontal padding (h5)
    #   0px vertical padding (v0)
    #
    # -k 1 means:
    #   remove leading and trailing lines
    fortune -s | boxes -d $style -ph3v0 -k 1 | lolcat

    #
    # this selects a random color but let's use lolcat instead for rainbow coloring...
    #
    # declare -a colors=("purple" "green" "yellow" "red" "cyan")
    # color=${colors[$RANDOM % ${#colors[@]}+1 ]}
    # echo -e "${(P)color}\c"
    # fortune | boxes -d $style -ph5v0 -k 1
    # echo -e "${nc}\c"
}

if hash fortune 2>/dev/null; then
    # clear
    lucky
fi
