#!/bin/bash

source "init.sh"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# WARNING!!!
#
# SET THESE SETTINGS HERE!
#
# NOTE: They have defaults.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# export DEFAULT_COMPUTER_NAME=""
# export GIT_NAME=""
# export GIT_EMAIL=""


logHead "WELCOME!"

info "\nFor details — Do: tail -f ${dotfiles}/install/install.log\n"

source "ssh-keys.sh"
source "xcode.sh"
source "brew.sh"
source "fonts.sh"
source "ohmyzsh.sh"
source "tools.sh"
source "ruby.sh"
source "python.sh"
source "java.sh"
source "php.sh"
source "js.sh"
source "redis.sh"
source "apps.sh"
source "configure.sh"
source "links.sh"

logHead "IT'S ALL DONE! HAPPY CODING!"