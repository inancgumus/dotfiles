logLine "installing: java thingies"

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