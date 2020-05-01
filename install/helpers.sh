#!/bin/bash

logHead () {
  echo -e "\n${bpurple}******************* ${1} *******************$nc\n"
}

logLine () { 
  echo -e "${bpurple}======> $1$nc"
}

info () {
  echo -e "       ${yellow} $1$nc"
}

infoHead () { 
  echo -e "\n       ${byellow} $1$nc"
}


# runs the given command.
# puts a check sign if the previous command was succesful otherwise puts a mark sign.
runCmd() {
  echo "\n\n$ $@" >> install.log
  "$@" >> install.log 2>&1
  if [ $? = 0 ]; then
    echo -e "${goUpCode} ${green}${checkSign}$nc"
  else
    echo -e "${goUpCode} ${red}${errSign}$nc"
  fi
}

# same as runCmd — but doesn't add newlines.
runCmdNONL() {
  echo "$ $@" >> install.log
  "$@" >> install.log 2>&1
  if [ $? = 0 ]; then
    echo -en "${goUpCode} ${green}${checkSign}$nc"
  else
    echo -en "${goUpCode} ${red}${errSign}$nc"
  fi
}

warn () { 
  echo -e "        ${red}${errSign} $1$nc"
}

isInstalled () {
  if command -v $1 2&>/dev/null; then
    return 0
  else
    return 1
  fi
}

isBrewPackageInstalled () {
  # reach the package's real name
  # not its path
  arr=(${1//// })
  last=${arr[${#arr[@]} - 1]}

  if brew list -1 | grep -qi "^${last}\$"; then
    return 0
  else
    return 1
  fi
}

isBrewTapInstalled () {
  if brew tap | grep -qi "^${1}\$"; then
    return 0
  else
    return 1
  fi
}

isBrewCaskPackageInstalled () {
  if brew cask list -1 | grep -qi "^${1}\$"; then
    return 0
  else
    return 1
  fi
}

isNodePackageInstalled () {
  if npm list -g | grep -qi " ${1}@"; then
    return 0
  else
    return 1
  fi
}

isPipPackageInstalled () {
  if pip freeze | grep -Eqi "^${1}==[0-9.]+\$"; then
    return 0
  else
    return 1
  fi
}

isVagrantPlugInInstalled () {
  if vagrant plugin list | grep -Eqi "^${1} \([0-9.]+\)\$"; then
    return 0
  else
    return 1
  fi
}


installBrewPackage () {
  if isBrewPackageInstalled $1; then
    warn "brew pkg is already installed: ${1}"
  else
    info "installing brew pkg: ${1}\c"
    runCmd brew install -vd $1
  fi
}

installBrewTap () {
  if isBrewTapInstalled $1; then
    warn "brew tap is already installed: ${1}"
  else
    info "installing brew tap: ${1}\c"
    runCmd brew tap -d $1
  fi
}

installBrewCaskPackage () {
  if isBrewCaskPackageInstalled $1; then
    warn "cask pkg is already installed: ${1}"
  else
    info "installing cask pkg: ${1}\c"
    runCmd brew cask -vd install $1
  fi
}
installApp () {
  installBrewCaskPackage $1
}

installNodePackage () {
  if isNodePackageInstalled $1; then
    warn "node pkg is already installed: ${1}"
  else
    info "installing node pkg: ${1}\c"
    runCmd npm i --verbose -g $1
  fi
}

installPipPackage () {
  if isPipPackageInstalled $1; then
    warn "pip pkg already installed: ${1}"
  else
    info "installing pip pkg: ${1}\c"
    runCmd pip install --verbose $1
  fi
}

# TODO
installVagrantPlugIn () {
  if isVagrantPlugInInstalled $1; then
    warn "vagrant plugin already installed: ${1}"
  else
    info "installing vagrant plugin: ${1}\c"
    runCmd vagrant plugin install $1
  fi
}

reCreateDirectory () {
  if [ -d "$1" ]; then
    if [ -d "$1.old" ]; then
      info "removing dir: '$1.old'\c"
      runCmd rm -rf "$1"
    else
      info "backing up dir: '$1' ---> '$1.old'\c"
      runCmd mv "$1" "$1.old"
    fi
  fi  
}

reCreateFile () {
  if [ -f "$1" ]; then
    if [ -f "$1.old" ]; then
      info "removing file: '$1.old'\c"
      runCmd rm -f "$1"
    else
      info "backing up file: '$1' ---> '$1.old'\c"
      runCmd mv "$1" "$1.old"
    fi
  fi
}

takeover () {
  info "chown: $USER:staff --> $1\c"
  runCmd sudo chown -f $USER:staff $1
}

takeoverRoot () {
  info "chown: root:staff --> $1\c"
  runCmd sudo chown -R root:staff $1
}

link() {
  info "linking: '$1' --> '$2'\c"
  runCmd ln -sf "$1" "$2"
}