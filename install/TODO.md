TODO

- [x] Fix homebrew path
- [ ] Install Go
- [ ] Install Code
- [ ] Install Chrome
- [ ] Install Chromium
- [ ] Fix powerline-go
- [ ] Fix powerlevel10k
- [ ] Fix zsh
- [ ] /Users/inanc/.oh-my-zsh/plugins/gpg-agent/gpg-agent.plugin.zsh:12: command not found: gpgconf
- [ ] Fix iTerm2 cmd+left/right keys
- [ ] Fix ffmpeg
- [ ] Fix vim plugins
- [ ] This does not exist: $HOME/.vim/bundle/Vundle.vim
- [ ] Install https://github.com/powerline/fonts
- [ ] ln -sf com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
- [ ] ln -sf gpg-agent.conf ~/.gnupg/gpg-agent.conf
- [ ] import keys: gpg --keyring $DEV/secrets/pubring.kbx --export | gpg --import
- [ ] Configure gpgconf
      brew install gpg2 gnupg pinentry-mac
      mkdir ~/.gnupg
      echo 'use-agent' > ~/.gnupg/gpg.conf
      export GPG_TTY=$(tty)
      chmod 700 ~/.gnupg
      
      see for more steps: https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e

About the powerline bug:
powerline_precmd:1: no such file or directory: /usr/local/bin/powerline-go    

It's here: go/bin/powerline-go


# It doesn't install this one
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

