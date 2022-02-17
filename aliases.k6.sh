alias kbt='go test ./common ./chromium ./tests -failfast -race'
alias kbtv="kbt -v"
alias kbtd="XK6_BROWSER_LOG=debug kbt"
alias kbtt="XK6_BROWSER_LOG=trace kbt"
alias kbl='golangci-lint run'

alias kbr='xk6 run -q'
alias kbrd="XK6_BROWSER_LOG=debug kbr"
alias kbrt="XK6_BROWSER_LOG=trace kbr"
