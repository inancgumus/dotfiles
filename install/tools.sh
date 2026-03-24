logLine "installing: tools"

# install more recent versions of some os x tools
installBrewPackage 'coreutils'
installBrewPackage 'findutils'
installBrewPackage 'bash'

installBrewPackage 'gnu-sed'
installBrewPackage 'smimesign' # for using GNU keys on Github
installBrewPackage 'git'
installBrewPackage 'wget'
installBrewPackage 'curl'
installBrewPackage 'watch'
installBrewPackage 'tree'

installBrewPackage 'eza'      # ls alternative
installBrewPackage 'bat'      # cat alternative
installBrewPackage 'fd'       # find alternative
installBrewPackage 'tldr'     # practical man pages - community driven
installBrewPackage 'glow'     # cli markdown renderer
installBrewPackage 'lynx'     # cli browser
installBrewPackage 'pandoc'   # document format converter
installBrewPackage 'docker'
installBrewPackage 'diff-so-fancy'

installBrewPackage 'media-info'
installBrewPackage 'cmake'

installBrewPackage 'ffmpeg'

installBrewPackage 'fortune'  # prints a fortune cookie message
installBrewPackage 'lolcat'   # prints rainbow text
installBrewPackage 'boxes'    # prints in a box

# install security tools
installBrewPackage 'tor'
installBrewPackage 'torsocks'
