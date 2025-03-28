alias ga='git add --all'
alias gp='git push'
alias gpu='git pull'

GIT_LOG_OPTS='--oneline --decorate --relative-date'
alias gl="git log $GIT_LOG_OPTS"
alias glp="git log $GIT_LOG_OPTS --patch"
alias gls="git log $GIT_LOG_OPTS --stat"
alias glx="git log $GIT_LOG_OPTS --pretty=full"

alias gs='git status -s'
alias gsx='git status'
alias gd='git diff --color'
alias gdn='git diff --color --name-only'
alias gdc='git diff --color --cached'
alias gci='git commit -a --verbose'
alias gcim='git commit -am --verbose'
alias gciam='ga . && gci -am $1'
alias gca='git commit --amend'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gcl='git clone'
alias grh='git reset --hard'
alias gph='git push heroku'
alias gpgh='git push github'
