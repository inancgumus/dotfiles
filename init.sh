#!/bin/bash

source "$dotfiles/exports.sh"
source "$dotfiles/paths.sh"
source "$dotfiles/colors.sh"
source "$dotfiles/functions.sh"
# source "$dotfiles/completions.sh"
# source "$dotfiles/bash_prompt.sh"

#
# init language environments
#
source "$dotfiles/env.go.sh"
source "$dotfiles/env.gcloud.sh"
#source "$dotfiles/env.java.sh"
#source "$dotfiles/env.nodejs.sh"
#source "$dotfiles/env.php.sh"
#source "$dotfiles/env.python.sh"
#source "$dotfiles/env.ruby.sh"

# Temporary Fix for OSX Monterey test race detector bug.
# https://github.com/golang/go/issues/49138
export MallocNanoZone=0

source "$dotfiles/init.zsh.sh"
source "$dotfiles/init.zsh.keys.sh"
source "$dotfiles/powerline.sh"

source "$dotfiles/aliases.sh"

source "$dotfiles/fortune.sh"
