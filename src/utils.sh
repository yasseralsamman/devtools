#!/bin/bash
# Utilities installation functions for devtools script
#

# Update sources
function update_sources() {
  apt-get update &> /dev/null & spinner "Updating Sources "
}

function install_utils() {
  local utils=('vim'
               'links'
               'lynx'
               'git'
               'diffutils'
               'htop'
               'curl'
               'wget'
               'p7zip-full'
               'unzip'
               'zip'
               'libc6:i386'
               'libncurses5:i386'
               'libstdc++6:i386'
               'lib32z1'
               'libbz2-1.0:i386'
              )
  apt-get -y install "${utils[@]/#/}" &> /dev/null & spinner "Installing Utilities "
  ln -s /usr/bin/nodejs /usr/bin/node &> /dev/null
  install_java
  install_nodejs
}

function install_nodejs() {
  local njsversion=$option_nodejs_version
  curl -sL "https://deb.nodesource.com/setup_${option_nodejs_version}.x" | sudo -E bash - &> /dev/null & spinner "Adding PPA for NodeJS "
  apt-get install nodejs &> /dev/null & spinner "Installing NodeJS${option_nodejs_version}"
}

function install_java() {
  local jversion="oracle-java${option_jdk_version}-installer"
  apt-add-repository ppa:webupd8team/java -y &> /dev/null & spinner "Adding PPA for JDK "
  update_sources
  echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  apt-get -y install "${jversion}" &> /dev/null & spinner "Installing JDK${option_jdk_version}"
}
