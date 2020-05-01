#!/bin/bash

# -----------------------------------------------------------------------------
# HOW TO RUN?
# -----------------------------------------------------------------------------

# . ./godev.bash
# or:
# source ./godev.bash

# WARNING:
#
# 	if you run it directly like: ./godev.bash
# 	it won't save to $PATH environment variable.

# WARNING:
#
# 	Because, this file will be sourced into the current shell. We'll be
# 	clearing out all the variables we've defined.


# -----------------------------------------------------------------------------
# WHY THIS?
# -----------------------------------------------------------------------------

# 	switches the environment for go development,
# 	under $GODEV directory.

# 	if you don't run this, you can't do development
# 	on your machine because it will use homebrew's
# 	go instead.


# -----------------------------------------------------------------------------
# SETTINGS
# -----------------------------------------------------------------------------

# SET THIS TO WHERE THE GO DEVELOPMENT WILL BE DONE:
GODEV="$HOME/dev/golang"

# -----------------------------------------------------------------------------
# OK, GO!
# -----------------------------------------------------------------------------

# wrap with : to ease the regex in rempath
XPATH=":$PATH:"
rempath() {
	XPATH=$(echo $XPATH | sed 's|:[^:]*'"$1":'|:|g')
}

# removes the wrapped colons
remcolons() {
	XPATH=${XPATH:1:${#XPATH}-2}
}

# unset go env vars
unset OLD_GOROOT
if [[ ! -z "${GOROOT// }" ]]; then
	OLD_GOROOT=$GOROOT
	unset GOROOT
fi

unset OLD_GOPATH
if [[ ! -z "${GOPATH// }" ]]; then
	OLD_GOPATH=$GOPATH
fi
echo "clearing GOPATH"
unset GOPATH

# remove the existing go paths
rempath "/go/bin"
rempath "/go/libexec/bin"
remcolons

# add go binaries path to the beginning of path if it's not there.
# this will let us only to use the go binaries inside $GODEV.
if [[ $XPATH != "$GODEV/bin"* ]]; then
	XPATH="$GODEV/bin:$XPATH"
fi

# -----------------------------------------------------------------------------
# DISPLAY LOGS
# -----------------------------------------------------------------------------

if [[ -z $OLD_GOROOT ]]; then
	echo "GOROOT was empty"
else
	echo -e "OLD GOROOT: $OLD_GOROOT"
	echo -e "GOROOT is cleared"
fi

if [[ -z $OLD_GOPATH ]]; then
	echo "GOPATH was empty"
else
	echo -e "OLD GOPATH: $OLD_GOPATH"
	echo -e "GOPATH is cleared"
fi

if [[ $PATH == $XPATH ]]; then
	echo 'Nothing is changed. $PATH is fine.'
else
	echo -e "\n"
	echo -e "OLD PATH:\n\n\t$PATH\n\n"
	echo -e "NEW PATH:\n\n\t$XPATH\n"
fi

# -----------------------------------------------------------------------------
# SET AND CLEAR VARIABLES - FINISHING TOUCH
# -----------------------------------------------------------------------------

PATH=$XPATH
unset XPATH

unset GODEV
