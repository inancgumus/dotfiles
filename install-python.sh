logLine "installing: python thingies"

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