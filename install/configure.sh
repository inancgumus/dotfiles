#!/bin/bash


# if sourced, we need the init file.
# normally, this init file gets included by install.sh
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
	source './init.sh'
fi


logHead "CONFIGURING"


logLine "configuring: git\c"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
runCmdNONL git config --global user.name "$GIT_NAME"
runCmdNONL git config --global user.email "$GIT_EMAIL"
runCmdNONL git config --global credential.helper osxkeychain
runCmd git config --global push.default current



# for the last correct the permissions to surpass errors
# from wrongdoing brew formulas' weird permission handlings
logLine "configuring: homebrew"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
takeover '~/Library/Logs'

info "cleaning it up\c"
runCmd brew cleanup

info "hashing last login from terminal"
runCmd touch $HOME/.hushlogin

logLine "configuring: mac os x defaults"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source "osxdefaults.sh"