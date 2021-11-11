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
  echo -e "\n\n$ $@" >> install.log
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
  fi
  return 1
}

isBrewPackageInstalled () {
  # reach the package's real name
  # not its path
  arr=(${1//// })
  last=${arr[${#arr[@]} - 1]}

  # see: https://stackoverflow.com/a/67681140
  if brew list -1 | (grep -qi "^${last}\$"; ret=$?; cat >/dev/null; exit $ret); then
    return 0
  fi
  return 1
}

isBrewTapInstalled () {
  if brew tap | grep -qi "^${1}\$"; then
    return 0
  fi
  return 1
}

isBrewCaskPackageInstalled () {
  if brew list --cask -1 | grep -qi "^${1}\$"; then
    return 0
  fi
  return 1
}

isNodePackageInstalled () {
  if npm list -g | grep -qi " ${1}@"; then
    return 0
  fi
  return 1
}

isPipPackageInstalled () {
  if pip freeze | grep -Eqi "^${1}==[0-9.]+\$"; then
    return 0
  fi
  return 1
}

isVagrantPlugInInstalled () {
  if vagrant plugin list | grep -Eqi "^${1} \([0-9.]+\)\$"; then
    return 0
  fi
  return 1
}


installBrewPackage () {
  # don't check for pkg names if there multiple args
  # for example, this won't check for the package name:
  # installBrewPackage '--HEAD' 'https://raw.githubusercontent.com/LouisBrunner/valgrind-macos/master/valgrind.rb'
  if [ "$#" -eq 1 ] && isBrewPackageInstalled $1; then
    warn "brew pkg is already installed: ${1}"
    return 1
  fi

  info "installing brew pkg: ${@}\c"
  runCmd brew install -vd $@
}

installBrewTap () {
  if isBrewTapInstalled $1; then
    warn "brew tap is already installed: ${1}"
    return 1
  fi

  info "installing brew tap: ${1}\c"
  runCmd brew tap -d $1
}

installBrewCaskPackage () {
  if isBrewCaskPackageInstalled $1; then
    warn "cask pkg is already installed: ${1}"
    return 1
  fi

  info "installing cask pkg: ${1}\c"
  runCmd brew install --cask -vd install $1
}
installApp () {
  installBrewCaskPackage $1
}

installNodePackage () {
  if isNodePackageInstalled $1; then
    warn "node pkg is already installed: ${1}"
    return 1
  fi

  info "installing node pkg: ${1}\c"
  runCmd npm i --verbose -g $1
}

installPipPackage () {
  if isPipPackageInstalled $1; then
    warn "pip pkg already installed: ${1}"
    return 1
  fi

  info "installing pip pkg: ${1}\c"
  runCmd pip install --verbose $1
}

# TODO
installVagrantPlugIn () {
  if isVagrantPlugInInstalled $1; then
    warn "vagrant plugin already installed: ${1}"
    return 1
  fi

  info "installing vagrant plugin: ${1}\c"
  runCmd vagrant plugin install $1
}

reCreateDirectory () {
  if [ -d "$1" ]; then
    if [ -d "$1.old" ]; then
      info "removing dir: '$1.old'\c"
      runCmd rm -rf "$1"
    else
      info "backing up dir: '$1' ---> '$1.old'\c"
      runCmd mv "$1" "$1.old"
      runCmd mkdir "$1"
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
