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

  sudo apt install gradle &>> log.txt & spinner "Installing Gradle"
  npm install -g cordova &>> log.txt & spinner "Installing Cordova"
  npm install -g ionic &>> log.txt & spinner "Installing Ionic"
}
