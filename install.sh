#!/bin/bash

source 'install_init.sh'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# WARNING!!!
#
# SET THESE SETTINGS HERE!
#
# Below settings are defaults.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# export DEFAULT_COMPUTER_NAME="inanc"
# export GIT_NAME="Inanc Gumus"
# export GIT_EMAIL="m@inanc.io"


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
logHead 'INSTALLING THE DEVELOPMENT ENVIRONMENT'


logLine "Configuring .ssh keys"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
info "removing: $home/.ssh\c"
runCmd rm -rf "$home/.ssh"
link "$dev/ssh" "$home/.ssh"

info "deleting all the ssh agent keys\c"
runCmd ssh-add -D

info "ensuring the keys have proper permissions\c"
runCmd chmod -R 700 "$home/.ssh"

info "adding your key to the os x key chain\c"
runCmd ssh-add -K "$home/.ssh/id_rsa_minancio"



logLine "installing: xcode"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
info "...\c"
runCmd xcode-select --install


logLine "installing: homebrew"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if isInstalled 'brew'; then
  warn "homebrew is already installed"
else
  info "...\c"
  runCmd ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi



info "assigning user permissions...\c"
runCmd mkdir -p /usr/local /Library/Caches/Homebrew
takeover '/usr/local'
takeover '/Library/Caches/Homebrew'
takeover '~/Library/Logs'


info "updating: homebrew...\c"
runCmd brew update

# https://github.com/Homebrew/homebrew-cask/issues/58046
info "fixing: brew known error: see: #58046\c"
runCmd /usr/bin/find "$(brew --prefix)/Caskroom/"*'/.metadata' -type f -name '*.rb' -print0 | /usr/bin/xargs -0 /usr/bin/perl -i -pe 's/depends_on macos: \[.*?\]//gsm;s/depends_on macos: .*//g'


logLine "installing: some homebrew helpers"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewTap 'homebrew/services'


logLine "installing: fonts"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewTap 'homebrew/cask-fonts'
installBrewCaskPackage 'font-inconsolata'
installBrewCaskPackage 'font-anonymous-pro'
installBrewCaskPackage 'font-fira-mono'
installBrewCaskPackage 'font-fira-code'


logLine "installing: oh my zsh"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
info "installing oh my zsh\c"
runCmd sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# NOTE: you should select one of the powerline fonts for your terminal preferences.
logLine "installing: powerline 10k"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewCaskPackage 'font-hack-nerd-font'
installBrewPackage 'romkatv/powerlevel10k/powerlevel10k'
installBrewPackage 'powerline-go'

info "cloning: zsh zsh-autosuggestions plugin\c"
runCmd git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

installBrewPackage 'zsh-syntax-highlighting'



logLine "installing: tools"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install more recent versions of some os x tools
installBrewPackage 'coreutils'
installBrewPackage 'findutils'
installBrewPackage 'bash'

installBrewPackage 'gnu-sed'
installBrewPackage 'git'
installBrewPackage 'wget'
installBrewPackage 'curl'
installBrewPackage 'watch'
installBrewPackage 'tree'
installBrewPackage 'exa'  # ls alternative
installBrewPackage 'bat'  # cat alternative
installBrewPackage 'fd'   # find alternative
installBrewPackage 'tldr' # practical man pages - community driven
installBrewCaskPackage 'heroku-toolbelt'
installBrewPackage 'docker'
installBrewPackage 'media-info'
installBrewPackage 'cmake'


if isBrewPackageInstalled 'ffmpeg'; then
  warn "ffmpeg is already installed"
else
  info "installing: ffmpeg\c"
  runCmd brew install ffmpeg \
    --with-chromaprint --with-fdk-aac \
    --with-fontconfig --with-freetype \
    --with-frei0r --with-game-music-emu \
    --with-libass --with-libbluray \
    --with-libbs2b --with-libcaca \
    --with-libgsm --with-libmodplug \
    --with-libsoxr --with-libssh \
    --with-libvidstab --with-libvorbis \
    --with-libvpx --with-opencore-amr \
    --with-openh264 --with-openjpeg \
    --with-openssl --with-opus \
    --with-rtmpdump --with-rubberband \
    --with-sdl2 --with-snappy \
    --with-speex --with-tesseract \
    --with-theora --with-tools \
    --with-two-lame --with-wavpack \
    --with-webp --with-x265 \
    --with-xz
fi


# install security tools
# install tor
installBrewPackage 'tor'
installBrewPackage 'torsocks'

# tox secure messaging
installBrewTap 'Tox/tox'
installBrewPackage 'openal-soft'
installBrewPackage 'freealut'
installBrewPackage 'libconfig'
installBrewPackage 'libnotify'

if isBrewPackageInstalled 'libtoxcore'; then
  info "installing: libtoxcore\c"
  runCmd brew install --HEAD libtoxcore
fi
if isBrewPackageInstalled 'toxic'; then
  info "installing: toxic\c"
  runCmd brew install --HEAD toxic
fi


logLine "installing: ruby thingies"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewPackage 'rbenv'
installBrewPackage 'ruby-build'

info "rbenv: init\c"
runCmd eval "$(rbenv init -)"
LATEST_RUBY_VERSION=$(rbenv install -l | grep -E "^[0-9 .]*(-p[0-9]*)?$" | tail -n 1)


# allow using utf-8 chars in irb
installBrewPackage 'readline'

info "configuring: rbenv\c"
runCmd CONFIGURE_OPTS="--with-readline-dir=/usr/local/Cellar/readline/6.3.8" \
          rbenv install -s $LATEST_RUBY_VERSION

info "setting ruby version to $LATEST_RUBY_VERSION\c"
runCmd rbenv global $LATEST_RUBY_VERSION

info "installing: bundle\c"
runCmd gem install bundle


# practical man pages
info "installing: bropages\c"
runCmd gem install bropages


logLine "installing: python thingies"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewPackage 'python'

  info "unlinking: python\c"
  runCmd brew unlink python
  sleep 1

  info "relinking: python\c"
  runCmdNONL brew link --overwrite python
  runCmd brew linkapps python


info "updating pip...\c"
runCmd pip install --upgrade pip


installBrewCaskPackage 'xquartz'


# fixes for pil, matplotlib etc
installBrewPackage 'jpeg'
installBrewPackage 'libpng'
  
  info "unlinking: libpng\c"
  runCmd brew unlink libpng
  
  sleep 1
  info "relinking: libpng\c"
  runCmd brew link --overwrite libpng


installBrewPackage 'freetype'
reCreateFile '/usr/local/lib/libpng16.16.dylib'


# matplotlib requires gdal
installBrewCaskPackage 'gdal-framework'
installBrewCaskPackage 'anaconda'
installBrewTap 'homebrew/science'
installBrewCaskPackage 'octave'

installBrewPackage 'matplotlib'

installBrewPackage 'pyenv'
installBrewPackage 'pyenv-virtualenv'

if isBrewPackageInstalled 'gnuplot'; then
  warn "uninstalling: gnuplot, already installed\c"
  runCmd brew uninstall gnuplot
fi

info "installing: gnuplot\c"
runCmd brew install gnuplot --with-x11


# own pip directory to surpass warnings
takeover "$home/Library/Logs/pip"


#installPipPackage 'virtualenvwrapper'
installPipPackage 'readline'
installPipPackage 'ipython'
installPipPackage 'pyzmq'
installPipPackage 'jinja2'
installPipPackage 'tornado'
installPipPackage 'Pygments'
installPipPackage 'cheat' # practical man pages


# config for virtualenvwrapper
takeover "$home/.virtualenvs"


logLine "installing: java thingies"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewCaskPackage 'java'


# appends to bash_profile but will be removed at the end of "this" file
# we will rewrite the bash_profile to get rid of it
# added line by jabba is already in our bash_profile in dropbox
if [ -d "$home/.jabba" ]; then
  warn "jabba java version manager is already installed"
else
  info "installing: jabba\c"
  runCmd curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
fi

logLine "installing: php thingies"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if isInstalled 'phpbrew'; then
  warn "phpbrew is already installed"
else
  info "installing: phpbrew\c"
  runCmdNONL curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
  runCmdNONL chmod +x phpbrew
  runCmdNONL sudo mv phpbrew /usr/local/bin/phpbrew
  runCmd phpbrew init
fi



logLine "installing: node.js"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewPackage 'node'
installBrewPackage 'nvm'
installNodePackage 'nodemon'
# installNodePackage 'grunt'
# installNodePackage 'bower'
# installNodePackage 'mocha'



# logLine "installing: redis"
# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# installBrewPackage 'redis'
# info "starting: redis\c"
# runCmd launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist



logHead "INSTALLING APPS"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installApp 'cyberduck'
installApp 'kindle'
installApp 'iterm2'
installApp 'unrar'
installApp 'sublime-text3'
installApp 'spotify'
installApp 'skype'
installApp 'slack'
installApp 'virtualbox'
installApp 'vlc'
# installApp 'vagrant'
# installApp 'flash'
# installApp 'flash-player'



logHead "CONFIGURING"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source 'install_configure.sh'


logHead "LINKING SCRIPTS"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source 'install_links.sh'



logHead "HAPPY DOODEEEYNG !"
info "For logs, see: install.log"