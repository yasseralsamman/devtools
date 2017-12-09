#!/bin/bash
# Web tools functions for devtools script
#

# Install web tools
function install_web_tools() {
  add-apt-repository ppa:ondrej/php -y &> /dev/null & spinner "Adding PPA for PHP "
  update_sources
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
                    "php${option_php_version}-zip"
                    "libapache2-mod-php${option_php_version}"
                  )

  apt-get -y install "${web_tools[@]/#/}" &> /dev/null & spinner "Installing Web Tools "
  update-alternatives --set php /usr/bin/php${option_php_version} &> /dev/null
  service apache2 restart &> /dev/null & spinner "Restarting Web Server "

  pear channel-discover pear.twig-project.org &> /dev/null & spinner "Discover PEAR channels"
  pear update-channels &> /dev/null & spinner "Updating PEAR channels"
  pecl update-channels &> /dev/null & spinner "Updating PECL channels"
  pear upgrade &> /dev/null & spinner "Upgrading PEAR Repo"
  pecl upgrade &> /dev/null & spinner "Upgrading PECL Library"
  pecl install uploadprogress &> /dev/null & spinner "Install Uploadprogress"
  touch /etc/php/${option_php_version}/mods-available/uploadprogress.ini
  echo -e "extension=uploadprogress.so " > /etc/php/5.6/mods-available/uploadprogress.ini
  php5enmod uploadprogress &> /dev/null & spinner "Enabling Uploadprogress"
  pear install twig/CTwig &> /dev/null & spinner "Installing Twig Ext"
  touch /etc/php/${option_php_version}/mods-available/twig.ini
  echo -e "extension=twig.so " > /etc/php/5.6/mods-available/twig.ini
  php5enmod twig &> /dev/null & spinner "Enabling Twig Ext"
  service apache2 restart &> /dev/null & spinner "Restarting Web Server"
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer &> /dev/null & spinner "Installing Composer"
}
