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
               'nodejs'
               'node-less'
               'npm'
               'libc6:i386'
               'libncurses5:i386'
               'libstdc++6:i386'
               'lib32z1'
               'libbz2-1.0:i386'
              )
  apt-get -y install "${utils[@]/#/}" &> /dev/null & spinner "Installing Utilities "
  ln -s /usr/bin/nodejs /usr/bin/node &> /dev/null
  install_java
}

function install_java() {
  local jversion="oracle-java${option_jdk_version}-installer"
  apt-add-repository ppa:webupd8team/java -y &> /dev/null & spinner "Adding PPA for JDK "
  update_sources
  apt-get -y install "${jversion}" &> /dev/null & spinner "Installing JDK${option_jdk_version}"
}
