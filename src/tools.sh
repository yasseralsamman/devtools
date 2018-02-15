#!/bin/bash
# Third party softwares installation functions for devtools script
#

function install_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &>> log.txt & spinner "Add Chrome Repo Key"
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list &>> log.txt & spinner "Set Chrome Repo "
  update_sources
  apt-get -y install libnss3-nssdb &>> log.txt & spinner "Installing Dependencies "
  apt-get -y install google-chrome-stable &>> log.txt & spinner "Installing Chrome "
}

function install_atom() {
  curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add - &>> log.txt & spinner "Add Atom Repo Key"
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list' & spinner "Set Atom Repo "
  update_sources
  apt-get install atom &>> log.txt & spinner "Installing Atom "
}
