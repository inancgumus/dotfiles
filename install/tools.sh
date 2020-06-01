logLine "installing: tools"

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
installBrewPackage 'docker'
installBrewPackage 'media-info'
installBrewPackage 'cmake'

# a tool for mem debugging, leak detection, and profiling.
installBrewPackage '--HEAD' 'https://raw.githubusercontent.com/LouisBrunner/valgrind-macos/master/valgrind.rb'

installBrewPackage 'fortune'
installBrewPackage 'lolcat'
installBrewPackage 'boxes'


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