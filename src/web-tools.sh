#!/bin/bash
# Web tools functions for devtools script
#

# Install web tools
function install_web_tools() {
  add-apt-repository ppa:ondrej/php -y &> /dev/null & spinner "Adding PPA for PHP "
  local web_tools=( "apache2"
                    "php${option_php_version}"
                    "php-pear"
                    "php${option_php_version}-gd"
                    "php${option_php_version}-mcrypt"
                    "php${option_php_version}-curl"
                    "php${option_php_version}-dev"
                    "php${option_php_version}-mysqlnd"
                    "php${option_php_version}-tidy"
                    "php${option_php_version}-xmlrpc"
                    "php${option_php_version}-xml"
                    "php${option_php_version}-mbstring"
                    "libapache2-mod-php${option_php_version}"
                  )

  apt-get -y install "${web_tools[@]/#/}" &> /dev/null & spinner "Installing Web Tools "
  update-alternatives --set php /usr/bin/php${option_php_version}
  service apache2 restart &> /dev/null & spinner "Restarting Web Server "
}
