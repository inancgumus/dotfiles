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