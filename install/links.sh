#!/bin/bash

# if sourced, we need the init file.
# normally, this init file gets included by install.sh
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
	source './init.sh'
fi


logHead "LINKING"

link "$dotfiles/octaverc.sh" "$home/.octaverc"
link "$dotfiles/vimrc.sh" "$home/.vimrc"
link "$dotfiles/inputrc.sh" "$home/.inputrc"

reCreateDirectory "$home/.ssh"
link "$dev/ssh" "$home/.ssh"

link "$dotfiles/gitconfig.sh" "$home/.gitconfig"

reCreateFile "$home/.gitconfig"
link "$dotfiles/gitconfig.sh" "$home/.gitconfig"

reCreateFile "$home/.npmrc"
link "$dotfiles/npmrc.sh" "$home/.npmrc"

link "/usr/X11/lib/libpng15.dylib" "/usr/local/lib/libpng16.16.dylib"
# link "/usr/local/opt/redis/*.plist" "~/Library/LaunchAgents"


logLine "installing links: nvm..."
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reCreateDirectory "$home/.nvm"

info "copying nvm-exec to ~/.nvm\c"
runCmd cp $(brew --prefix nvm)/nvm-exec ~/.nvm/


# doing this last because older commands can override it
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reCreateFile "$home/bash_profile"

info "linking ~/.bash_profile"
echo "source \"${dotfiles}/bash_profile.sh\"" > "$home/.bash_profile"