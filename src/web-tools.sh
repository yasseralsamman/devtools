#!/bin/bash
# Web tools functions for devtools script
#

# Install web tools
function install_web_tools() {
  add-apt-repository ppa:ondrej/php -y &>> log.txt & spinner "Adding PPA for PHP "
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

  apt-get -y install "${web_tools[@]/#/}" &>> log.txt & spinner "Installing Web Tools "
  update-alternatives --set php /usr/bin/php${option_php_version} &>> log.txt
  service apache2 restart &>> log.txt & spinner "Restarting Web Server "

  pear channel-discover pear.twig-project.org &>> log.txt & spinner "Discover PEAR channels"
  pear update-channels &>> log.txt & spinner "Updating PEAR channels"
  pecl update-channels &>> log.txt & spinner "Updating PECL channels"
  pear upgrade &>> log.txt & spinner "Upgrading PEAR Repo"
  pecl upgrade &>> log.txt & spinner "Upgrading PECL Library"
  pecl install uploadprogress &>> log.txt & spinner "Install Uploadprogress"
  touch /etc/php/${option_php_version}/mods-available/uploadprogress.ini
  echo -e "extension=uploadprogress.so " > /etc/php/${option_php_version}/mods-available/uploadprogress.ini
  php5enmod uploadprogress &>> log.txt & spinner "Enabling Uploadprogress"
  pear install twig/CTwig &>> log.txt & spinner "Installing Twig Ext"
  touch /etc/php/${option_php_version}/mods-available/twig.ini
  echo -e "extension=twig.so " > /etc/php/${option_php_version}/mods-available/twig.ini
  php5enmod twig &>> log.txt & spinner "Enabling Twig Ext"
  service apache2 restart &>> log.txt & spinner "Restarting Web Server"
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer &>> log.txt & spinner "Installing Composer"
}
