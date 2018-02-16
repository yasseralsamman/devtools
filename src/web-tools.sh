#!/bin/bash
# Web tools functions for devtools script
#

# Install web tools
function install_web_tools() {
  add-apt-repository ppa:ondrej/php -y &>> log.txt & spinner "Adding PPA for PHP "
  update_sources
  local web_tools=( "apache2"
                    "php${option_php_version}"
                    "php${option_php_version}-cli"
                    "php${option_php_version}-common"
                    "php${option_php_version}-fpm"
                    "php-pear"
                    "php${option_php_version}-gd"
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

  # Install PHP Plugins
  pear channel-discover pear.twig-project.org &>> log.txt & spinner "Discover PEAR channels"
  pear update-channels &>> log.txt & spinner "Updating PEAR channels"
  pecl update-channels &>> log.txt & spinner "Updating PECL channels"
  pear upgrade &>> log.txt & spinner "Upgrading PEAR Repo"
  pecl upgrade &>> log.txt & spinner "Upgrading PECL Library"

  #Install Composer
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer &>> log.txt & spinner "Installing Composer"

  #Install Upload Progress PHP Extension
  wget https://github.com/Jan-E/uploadprogress/archive/master.zip &>> log.txt & spinner "Download Uploadprogress "
  unzip master.zip &>> log.txt
  cd uploadprogress-master
  phpize &>> log.txt & spinner "phpize Uploadprogress "
  ./configure &>> log.txt & spinner "Configure Uploadprogress "
  make &>> log.txt & spinner "Compile Uploadprogress "
  make install &>> log.txt & spinner "Install Uploadprogress "
  cd ..
  rm master.zip
  rm -R uploadprogress-master
  touch /etc/php/${option_php_version}/mods-available/uploadprogress.ini
  echo -e "extension=uploadprogress.so" > /etc/php/${option_php_version}/mods-available/uploadprogress.ini
  phpenmod uploadprogress &>> log.txt & spinner "Enabling Uploadprogress "

  #Restart Apache2
  service apache2 restart &>> log.txt & spinner "Restarting Web Server"

}
