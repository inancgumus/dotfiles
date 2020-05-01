logLine "installing: ruby thingies"

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
