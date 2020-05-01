[user]
	name = Inanc Gumus
	email = m@inanc.io

[credential]
	helper = osxkeychain

[core]
  editor = vim
  autocrlf = input
  safecrlf = false
  whitespace = cr-at-eol
  pager = "diff-so-fancy | less --tabs=2 -RFX"

[color]
  ui = true
  diff = true

[push]
	default = current

[rebase]
  autosquash = true

[pull]
  rebase = true

[rerere]
  enabled = true

[branch]
  autosetuprebase = always

[filter "lfs"]
  clean = git-lfs clean %f
  smudge = git-lfs smudge %f
  required = true

[alias]
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
