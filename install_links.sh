#!/bin/bash

# if sourced, we need the init file.
# normally, this init file gets included by install.sh
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
	source './install_init.sh'
fi


logLine "installing links"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

link "$dotfiles/octaverc.sh" "$home/.octaverc"
link "$dotfiles/vimrc.sh" "$home/.vimrc"
link "$dotfiles/inputrc.sh" "$home/.inputrc"

reCreateFile "$home/.gitconfig"
link "$dotfiles/gitconfig.sh" "$home/.gitconfig"

reCreateFile "$home/.npmrc"
link "$dotfiles/npmrc.sh" "$home/.npmrc"

link "/usr/X11/lib/libpng15.dylib" "/usr/local/lib/libpng16.16.dylib"
# link "/usr/local/opt/redis/*.plist" "~/Library/LaunchAgents"


info "installing links: nvm..."
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reCreateDirectory "$home/.nvm"
cp $(brew --prefix nvm)/nvm-exec ~/.nvm/ 2>/dev/null || :


# doing this last because older commands can override it
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reCreateFile "$home/bash_profile"
echo "source \"${dotfiles}/bash_profile\"" > "$home/.bash_profile"