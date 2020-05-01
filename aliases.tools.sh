#
# usage: download <file-output-name> <download-url>
#
alias download="aria2c -c -j32 -s32 -x16 -o"

alias cat='bat'
alias bat='bat --theme Dracula'
alias find='fd -c=always'

# use bat as man page colorizer
export MANPAGER="sh -c 'col -bx | bat --theme Dracula -l man -p'"