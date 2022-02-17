# TODO: make these funcs

# fast tests
alias kbt='go test ./common ./chromium -failfast'

# slower tests
alias kbtf='go test ./tests -failfast -short'
alias kbtfd='XK6_BROWSER_LOG=debug kbtf -v'
alias kbtft='XK6_BROWSER_LOG=trace kbtf -v'

# all tests
alias kbta='go test ./common ./chromium ./tests -failfast -race'
alias kbtad="XK6_BROWSER_LOG=debug kbta -v"
alias kbtat="XK6_BROWSER_LOG=trace kbta -v"

# run scripts
alias kbr='xk6 run -q'
alias kbrd="XK6_BROWSER_LOG=debug kbr"
alias kbrt="XK6_BROWSER_LOG=trace kbr"

alias kblint='golangci-lint run'
