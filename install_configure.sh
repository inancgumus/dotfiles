#!/bin/bash

# if sourced, we need the init file.
# normally, this init file gets included by install.sh
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
	source './install_init.sh'
fi



logLine "configuring: git\c"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
runCmdNONL git config --global user.name "$GIT_NAME"
runCmdNONL git config --global user.email "$GIT_EMAIL"
runCmdNONL git config --global credential.helper osxkeychain
runCmd git config --global push.default current



# for the last correct the permissions to surpass errors
# from wrongdoing brew formulas' weird permission handlings
logLine "homebrew"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
takeover '~/Library/Logs'

info "brew: cleanup\c"
runCmd brew cleanup


logLine "configuring: mac os x defaults"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source "$dotfiles/osxdefaults.sh"
logOk "OK"