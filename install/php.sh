logLine "installing: php thingies"

if isInstalled 'phpbrew'; then
  warn "phpbrew is already installed"
else
  info "installing: phpbrew\c"
  runCmdNONL curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
  runCmdNONL chmod +x phpbrew
  runCmdNONL sudo mv phpbrew /usr/local/bin/phpbrew
  runCmd phpbrew init
fi
