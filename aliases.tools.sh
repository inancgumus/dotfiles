alias cat='bat --theme Dracula'
# usage: download <file-output-name> <download-url>
alias download="aria2c -c -j32 -s32 -x16 -o"
alias find='fd -c=always'
alias ls='eza -hF -h --git --color=always -s type'
alias m="make"
alias tree='tree --dirsfirst --noreport --gitignore'

# use bat as the man page colorizer
export MANPAGER="sh -c 'col -bx | bat --theme Dracula -l man -p'"

alias cri=chrome-remote-interface
alias checkdomain="(read domain; whois \$domain | grep -qciE 'Domain not found.' && echo -e '\033[0;32mAvailable\033[0m' || echo -e '\033[0;31mNot available\033[0m') <<<"
