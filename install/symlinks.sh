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


logLine "installing links: nvm..."
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reCreateDirectory "$home/.nvm"

info "copying nvm-exec to ~/.nvm\c"
[[ -f "$(brew --prefix nvm 2>/dev/null)/nvm-exec" ]] && runCmd cp "$(brew --prefix nvm)/nvm-exec" "$home/.nvm/"


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
mkdir -p "$home/.config"
link "$dotfiles/starship.toml" "$home/.config/starship.toml"

# link claude code config (memory, projects, skills)
# only links if $dev/.claude/ dirs exist (not present on a fresh machine)
if [[ -d "$dev/.claude/memory" ]]; then
  mkdir -p "$home/.claude"
  reCreateDirectory "$home/.claude/memory"
  link "$dev/.claude/memory" "$home/.claude/memory"
fi
if [[ -d "$dev/.claude/projects" ]]; then
  mkdir -p "$home/.claude"
  reCreateDirectory "$home/.claude/projects"
  link "$dev/.claude/projects" "$home/.claude/projects"
fi
if [[ -d "$dev/.claude/skills" ]]; then
  mkdir -p "$home/.claude"
  reCreateDirectory "$home/.claude/skills"
  link "$dev/.claude/skills" "$home/.claude/skills"
fi
