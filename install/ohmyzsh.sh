logLine "installing: oh my zsh"

# run the zsh installer in passive mode
# so it won't ask questions and spin off a zsh shell.
export RUNZSH=no
export CHSH=no

info "installing oh my zsh\c"
runCmd sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# NOTE: you should select one of the powerline fonts for your terminal preferences.
logLine "installing: powerline 10k"

installBrewCaskPackage 'font-hack-nerd-font'
installBrewPackage 'romkatv/powerlevel10k/powerlevel10k'
installBrewPackage 'powerline-go'

info "cloning: zsh zsh-autosuggestions plugin\c"
runCmd git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

installBrewPackage 'zsh-syntax-highlighting'
