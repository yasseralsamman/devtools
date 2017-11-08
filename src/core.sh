#!/bin/bash
# DevTools v1.0 For Ubuntu 14.04
# Smart Bash Scripts For Web & Mobile Development Tools
# core.sh
#

# load src
. ./src/helper.sh
. ./src/utils.sh
. ./src/web-tools.sh
. ./src/db.sh

# check if run in sudo permissions
check_sudo

# default values
command_show_help=0;
command_install_utils=0
command_install_web_tools=0
command_install_db=0
command_install_mobile_tools=0
option_web_server=apache2
option_php_version=5.6
option_db_server=mysql
option_db_user=root
option_db_pass=123456

# control variables
error_unknown_command=0
error_unknown_command_msg=""

# check if no params are passed
if [[ $# -lt 1 ]]; then
  show_help
  exit
fi

# parse parameters
for param in "$@"
do
case $param in
    "help")
      command_show_help=1
      break
    ;;
    "utils")
      command_install_utils=1
      shift # past argument with no value
    ;;
    "web-tools")
      command_install_web_tools=1
      shift # past argument with no value
    ;;
    "db")
      command_install_db=1
      shift # past argument with no value
    ;;
    "mobile-tools")
      command_install_mobile_tools=1
      shift # past argument with no value
    ;;
    "all-default")
      command_install_utils=1
      command_install_web_tools=1
      command_install_db=1
      command_install_mobile_tools=1
      option_web_server=apache2
      option_php_version=5.6
      option_db_server=mysql
      option_db_user=root
      option_db_pass=123456
      break
    ;;
    --web-server=*)
      option_web_server="${param#*=}"
      shift # past argument=value
    ;;
    --php-version=*)
      option_php_version="${param#*=}"
      shift # past argument=value
    ;;
    --db-server=*)
      option_db_server="${param#*=}"
      shift # past argument=value
    ;;
    --db-pass=*)
      option_db_pass="${param#*=}"
      shift # past argument=value
    ;;
    *)
      error_unknown_command=1
      error_unknown_command_msg="Unknown Command or Option: ${param}"
      break
    ;;
esac
done

# check if there were false commands or options
if [[ $error_unknown_command -gt 0 ]] ; then
  printf "\n%s\n\n" "${error_unknown_command_msg}"
  exit
fi


#### Temporary Checks , the checks will be removed when more softwares are added
# check --web-server option for any value other than apache2, this is temporary
if [[ "$option_web_server" != "apache2" ]] ; then
  printf "\n%s\n\n" "Error: --web-server option only supports apache2 ( More will be added ). Aborting."
  exit
fi

# check --web-server option for any value other than apache2, this is temporary
if [[ "$option_db_server" != "mysql" ]] ; then
  printf "\n%s\n\n" "Error: --db-server option only supports mysql ( More will be added ). Aborting."
  exit
fi
###########

# check install utils command
if [[ $command_show_help -gt 0 ]] ; then
  show_help
  exit
fi

# display intro
intro

# update sources
update_sources

# check install utils command
if [[ $command_install_utils -gt 0 ]] ; then
  install_utils
fi

# check install web tools command
if [[ $command_install_web_tools -gt 0 ]] ; then
  install_web_tools
fi

# check install database command
if [[ $command_install_db -gt 0 ]] ; then
  install_database
fi

# display outro
outro
