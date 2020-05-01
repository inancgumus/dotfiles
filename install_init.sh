#!/bin/bash

#
# WARNING:
#
# DO NOT RUN THIS DIRECTLY.
#
# USE: ./install.sh
#


# Ask for the administrator password upfront.
# Keep-alive: update existing `sudo` time stamp until the script has finished.
sudo -v
while true; do sudo -n true; sleep 120; kill -0 "$$" || exit; done 2>/dev/null &



home=$(eval echo ~${SUDO_USER})
dev="$home/Desktop/dev"
dotfiles="$dev/dotfiles"


cd "$dotfiles"


# Remove the installation log file
rm -f install.log


source "./colors.sh"


# CONFIGURE YOUR SECRETS ACCORDINGLY
# WARNING: DO NOT SHARE THIS ON GITHUB ETC!
source "$dev/secrets.sh"


source "./install_helpers.sh"