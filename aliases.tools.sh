alias cat='bat --theme Dracula'
# usage: download <file-output-name> <download-url>
alias download="aria2c -c -j32 -s32 -x16 -o"
alias find='fd -c=always'
alias ls='eza -hF -h --git --color=always -s type'
alias m="make"

# use bat as the man page colorizer
export MANPAGER="sh -c 'col -bx | bat --theme Dracula -l man -p'"

alias cri=chrome-remote-interface
