#!/bin/bash

#
# print a fortunate quote
#
source "$dotfiles/fortune.sh"

source "$dotfiles/init.zsh.sh"
source "$dotfiles/init.zsh.keys.sh"

source "$dotfiles/exports.sh"
source "$dotfiles/paths.sh"
source "$dotfiles/aliases.sh"
source "$dotfiles/colors.sh"
source "$dotfiles/functions.sh"
# source "$dotfiles/completions.sh"
# source "$dotfiles/bash_prompt.sh"

#
# init language environments
#
source "$dotfiles/env.go.sh"
#source "$dotfiles/env.java.sh"
#source "$dotfiles/env.nodejs.sh"
#source "$dotfiles/env.php.sh"
#source "$dotfiles/env.python.sh"
#source "$dotfiles/env.ruby.sh"
source "$dotfiles/env.gcloud.sh"

source "$dotfiles/powerline.sh"

# Temporary Fix for OSX Monterey test race detector bug.
# https://github.com/golang/go/issues/49138
export MallocNanoZone=0
