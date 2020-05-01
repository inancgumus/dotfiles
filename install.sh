#!/bin/bash

source 'install-init.sh'

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


logHead 'WELCOME!'

source 'install-ssh-keys.sh'
source 'install-xcode.sh'
source 'install-brew.sh'
source 'install-fonts.sh'
source 'install-ohmyzsh.sh'
source 'install-tools.sh'
source 'install-ruby.sh'
source 'install-python.sh'
source 'install-java.sh'
source 'install-php.sh'
source 'install-js.sh'
# source 'install-redis.sh'
source 'install-apps.sh'
source 'install-configure.sh'
source 'install-links.sh'

logHead "HAPPY DOODEEEYNG !"
info "\nFor logs, see: install.log\n"