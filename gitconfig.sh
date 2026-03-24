[core]
  editor = vim
  autocrlf = input
  safecrlf = false
  whitespace = cr-at-eol
  pager = diff-so-fancy | less --tabs=4 -RFX
	excludesfile = ~/.gitignore_global

[pager]
   log = diff-so-fancy | less --tabs=4 -RFX
   show = diff-so-fancy | less --tabs=4 -RFX
   diff = diff-so-fancy | less --tabs=4 -RFX

[diff]
  external = difft
 
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
[fetch]
	prune = true
[init]
	defaultBranch = main
# Enforce SSH
[url "ssh://git@github.com/"]
  insteadOf = https://github.com/

[gpg]
	format = ssh
[gpg "ssh"]
	program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign
[commit]
	gpgsign = true
[user]
	signingkey = ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1o06CC1d2ODT7vG+sNEyYPVAz+7DiXb35hm1pbaniiNFVAA8JkkRwmyrsErDGa8hrMREEv8UqjwYFTQOdjeN9jkIBasHxaNDhend/AalUgCEJ5D9+zRyvq7IyeRfAu0iGJURgtgPZWw99iKWJ/KhTgdFLPjXIpXXGtxlG9+VHeQDPzBT2ob5DUcfvCaPkF7tWT8n47evVJWSRQ6HC2HU5GyJvPP8Fggs7Wb+B+fV+Lhg4x8znCqAVC8Rr/whQ21Lwu+NfUSu6oRfllxpMNPQA1jy45DA1+MzYmiNu/3qmNAJuu6FPR/j7Yu2YCMJ2xsItXJzpLDmLUpq/PGp55BNXry5zFPLtl/2cVUTEaqZHElPngUOG+ka4qMJxJ8CmokFZpme/sVSg1mtcvxqZ+Dos912dU1a/mhUNWTnFVSF2Fr9Aq8WkldNoPdDK3/yKLWCoPnobx3tG2wYe4Ouow7v/60Az7Gc8iWJiCLJpbO12cuu2nUnUhV8Q1sjULcNcRVXVhnuqSXQhrFYBUbv1TFLe/gmwJQJ5vpij/t0g/P6JKxPD/ElT69K4bub6wPxHvXOJgMXhvpybmB0a4qUurRt9WEPTiqq4B2gADwoWcy8FTMOaWGe+RTJ0O94ACC/46psVe5J/vUEQIlb14iSqDCVtaPDAnYL02UHuFRWnTh6IHw==
	email = m@inanc.io

# Use my Grafana work credentials when in the grafana directory and subdirectories
[includeIf "gitdir:~/grafana/"]
    path = ~/grafana/.gitconfig
