logLine "installing: homebrew"


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