# fast tests
alias kbt='SKIP_FLAKY=true go test ./common ./chromium -failfast'

# slower tests
alias kbtf='SKIP_FLAKY=true go test ./tests -failfast -short'
alias kbtfd='XK6_BROWSER_LOG=debug kbtf -v'
alias kbtft='XK6_BROWSER_LOG=trace kbtf -v'

# all tests
alias kbta='SKIP_FLAKY=true go test ./common ./chromium ./tests -failfast -race'
alias kbtad="XK6_BROWSER_LOG=debug kbta -v"
alias kbtat="XK6_BROWSER_LOG=trace kbta -v"

# run scripts
alias kbr="xk6 run --with github.com/grafana/xk6-browser=."
alias kbrd="XK6_BROWSER_LOG=debug kbr"
alias kbrt="XK6_BROWSER_LOG=trace kbr"

alias kblint='BASEREV=$(git log main --pretty=format:'%h' -n 1) golangci-lint run --out-format=tab --new-from-rev "$BASEREV" ./...'
