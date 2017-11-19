#!/bin/bash
# Mobile tools functions for devtools script
#

function install_ionic() {
  # check whether java is installed
  if [[ $(java -version 2>&1) != *"Java"* ]] ; then
    install_java
  fi

  # check if node is installed
  if [[ $(node --version 2>&1) != *"v"* ]] ; then
    install_nodejs
  fi

  npm install -g cordova &> /dev/null & spinner "Installing Cordova"
  npm install -g ionic &> /dev/null & spinner "Installing Ionic"
}
