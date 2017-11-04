#!/bin/bash
# Helper functions for devtools script
#

# Display help information
function show_help() {
cat <<EOF

    DevTools - Smart Bash Scripts For Web & Mobile Development Tools
    Version 1.0 for Ubuntu 14.04
    Contribute at https://github.com/yasseralsamman/devtools

    Usage:
      bash devtools.sh [<command_name>] [options]

    Arguments:
      command_name                   The command name [default: "help"]

    Commands:
      help                           Display this help message
      utils                          Installs basic dev utilities
      web-tools                      Installs web server and web tools
      db                             Installs database server
      mobile-tools                   Installs mobile development tools and libraries
      all-default                    Installs all the tools with default options
      all-custom                     Installs all the tools with custom options

    Options:
      --web-server=NAME              Specify web server to install [default: "apache2"]
      --php-version=VERSION          Specify php version to install [default: "5.6"]
      --db-server                    SPecify database server to install [default: "mysql"]
      --db-user=USERNAME             Specify database root user name [default: "root"]
      --db-pass=PASSWORD             Specify database root user password [default: "123456"]

EOF
}

# Display introduction when running the script
function intro() {
cat <<EOF

  DevTools - Smart Bash Scripts For Web & Mobile Development Tools
  Version 1.0 for Ubuntu 14.04
  Contribute at https://github.com/yasseralsamman/devtools
  
EOF
}

# Display goodby message when finishing the installation
function outro() {
  printf "\n%s\n\n" "Installation Complete. Have Fun !"
}

# Check if the script is run as root
function check_sudo() {
  if [ "$EUID" -ne 0 ]
    then printf "\n%s\n\n" "Error: Use sudo to run this script as root."
    exit
  fi
}

# Display spinner while installaion is in progress
function spinner() {
  local pid=$!
  local delay=0.45
  local spinstr='|/-\'
  printf "%s" "$1"
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
  printf "\t\t\t\t%s\n" " =============  Done."
}
