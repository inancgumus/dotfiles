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

cd "$dotfiles/install"

source "../colors.sh"
source "helpers.sh"

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


# Remove the installation log file
rm -f install.log

# Ask for the administrator password upfront.
# Keep-alive: update existing `sudo` time stamp until the script has finished.
sudo -v
while true; do sudo -n true; sleep 120; kill -0 "$$" || exit; done 2>/dev/null &