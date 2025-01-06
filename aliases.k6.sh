# fast tests
alias kbt='go test ./common ./chromium -failfast'

# slower tests
alias kbtf='go test ./tests -failfast -short'
alias kbtfd='K6_BROWSER_LOG=debug kbtf -v'
alias kbtft='K6_BROWSER_LOG=trace kbtf -v'

# all tests
alias kbta='go test ./browser ./common ./chromium ./tests -failfast -race'
alias kbtad="K6_BROWSER_LOG=debug kbta -v"
alias kbtat="K6_BROWSER_LOG=trace kbta -v"

# run scripts
alias kbr="go run . run -q"
alias kbrh="K6_BROWSER_HEADLESS=0 kbr"
alias kbrd="K6_BROWSER_LOG=debug kbr"
alias kbrt="K6_BROWSER_LOG=trace kbr"

alias kblint='golangci-lint run --out-format=tab --new-from-rev "$(git log master --pretty=format:'%h' -n 1)" ./...'

# docs
alias kbdocsclean="rm -rf .node_modules && npm cache clean -f && npm i"
alias kbdocsrun="npm run"

# e2e tests
function kbjs() {
  GOPRIVATE="go.k6.io/k6" xk6 build latest \
    --output /tmp/k6browser \
    --with github.com/grafana/xk6-browser=.
  set -x
  for f in $(fd . 'examples/' --extension js -E 'hosts.js'); do
    echo "Running $f"
    /tmp/k6browser run -q "$f"
  done
  rm -f example-chromium.png
  rm -f screenshot.png
}