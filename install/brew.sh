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


logLine "installing: some homebrew helpers"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
installBrewTap 'homebrew/services'