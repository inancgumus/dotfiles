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

info "copying nvm-exec to ~/.nvm"
runCmd cp $(brew --prefix nvm)/nvm-exec "$home/.nvm/"


# doing this last because older commands can override it
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reCreateFile "$home/bash_profile"
info "linking ~/.bash_profile"
echo "source \"${dotfiles}/bash_profile.sh\"" > "$home/.bash_profile"

reCreateFile "$home/.zshrc"
info "linking ~/.zshrc"
echo "source \"${dotfiles}/zsh.sh\"" > "$home/.zshrc"


# link iterm2 configuration
reCreateFile "$home/Library/Preferences/com.googlecode.iterm2.plist"
info "linking iterm2 configuration"
link "$dotfiles/com.googlecode.iterm2.plist" "$home/Library/Preferences/com.googlecode.iterm2.plist"

# link starship config
link "$dotfiles/starship.toml" "$home/.config/starship.toml"
