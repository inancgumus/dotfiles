[user]
	name = İnanç Gümüş
	email = m@inanc.io
	signingkey = 8C37266A4C4EA29D0C56A690459E5519E1A180A2

[credential]
	helper = osxkeychain

[core]
  editor = vim
  autocrlf = input
  safecrlf = false
  whitespace = cr-at-eol
  pager = diff-so-fancy | less --tabs=4 -RFX

[pager]
  log = diff-so-fancy | less --tabs=4 -RFX
  show = diff-so-fancy | less --tabs=4 -RFX
  diff = diff-so-fancy | less --tabs=4 -RFX

[interactive]
	diffFilter = diff-so-fancy --patch

[color]
  ui = true
  diff = true

[push]
	default = current
	autoSetupRemote = true

[rebase]
  autosquash = true

[pull]
  rebase = true

[rerere]
  enabled = true

[branch]
  autosetuprebase = always

[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
  required = true
	process = git-lfs filter-process

[alias]
	set-upstream = !git branch --set-upstream-to=origin/$(git symbolic-ref --short HEAD)
[diff]
	tool = ksdiff
[clean]
	requireForce = false
[color "diff-highlight"]
	oldNormal = red bold
	oldHighlight = red bold 52
	newNormal = green bold
	newHighlight = green bold 22
[http]
	cookiefile = /Users/inanc/.gitcookies
	postBuffer = 524288000

[includeIf "gitdir:~/grafana/"]
    path = ~/grafana/.gitconfig
[fetch]
	prune = true

[init]
	defaultBranch = main

# Enforce SSH
[url "ssh://git@github.com/"]
  insteadOf = https://github.com/

# use this if it doesn't work
# go env -w GOPRIVATE=github.com/grafana
[gpg]
	program = gpg
[commit]
	gpgsign = true
