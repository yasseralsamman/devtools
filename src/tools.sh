#!/bin/bash
# Third party softwares installation functions for devtools script
#

function install_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &> /dev/null & spinner "Add Chrome Repo Key"
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list &> /dev/null & spinner "Set Chrome Repo "
  update_sources
  apt-get -y install libnss3-nssdb &> /dev/null & spinner "Installing Dependencies "
  apt-get -y install google-chrome-stable &> /dev/null & spinner "Installing Chrome "
}

function install_atom() {
  add-apt-repository ppa:webupd8team/atom &> /dev/null & spinner "Add Atom Repo Key"
  update_sources
  apt-get install atom &> /dev/null & spinner "Installing Atom "
}
