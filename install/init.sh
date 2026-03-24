#!/bin/bash

#
# WARNING:
#
# DO NOT RUN THIS DIRECTLY.
#
# USE: ./install.sh
#


home=$(eval echo ~${SUDO_USER})
dev="$home/Desktop/dev"
dotfiles="$dev/dotfiles"

export DOTKIT_DIR="$dev/dotkit"
export DOTFILES_DIR="$dotfiles"

source "$DOTKIT_DIR/install/bootstrap.sh"

#
# WARNING:
#
# CONFIGURE YOUR SECRETS ACCORDINGLY
# WARNING: DO NOT SHARE THIS ON GITHUB ETC!
#
secrets="$dev/secrets.sh"
if [ ! -f $secrets ]; then
	warn "\rfatal: couldn't find the secrets file in: '$secrets'"
	exit 1
fi
source "$secrets"