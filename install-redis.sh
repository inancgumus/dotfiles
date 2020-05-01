logLine "installing: redis"

installBrewPackage 'redis'
info "starting: redis\c"
runCmd launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist