#!/bin/bash
# Database Installation functions for devtools script
#

function install_database() {
  debconf-set-selections <<< "mysql-server mysql-server/root_password password ${option_db_pass}"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${option_db_pass}"
  apt-get -y install mysql-server &>> log.txt & spinner "Installing DB Server"
}
