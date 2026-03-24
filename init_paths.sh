#!/bin/bash

home=$(eval echo ~${SUDO_USER})
dev="$home/Desktop/dev"
dotfiles="$dev/dotfiles"

#
# in case of a case-sensitivity issue
#
HOME=$home
DEV=$dev
DOTFILES=$dotfiles

export DOTKIT_DIR="$dev/dotkit"
export DOTFILES_DIR="$dotfiles"
export DOTKIT_CC_ROOT="$home/grafana"