#!/bin/bash
# DevTools v1.0 For Ubuntu 14.04
# Smart Bash Scripts For Web & Mobile Development Tools
# core.sh
#

# load src
chmod +x src/helper.sh
chmod +x src/utils.sh
. ./src/helper.sh
. ./src/utils.sh

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
    "all-custom")
      command_install_utils=1
      command_install_web_tools=1
      command_install_db=1
      command_install_mobile_tools=1
      shift # past argument=value
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
    --db-user=*)
      option_db_user="${param#*=}"
      shift # past argument=value
    ;;
    --db-pass=*)
      option_db_pass="${param#*=}"
      shift # past argument=value
    ;;
    --set-alias=*)
      option_db_pass="${param#*=}"
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

if [[ $error_unknown_command -gt 0 ]] ; then
  printf "\n%s\n\n" "${error_unknown_command_msg}"
  exit
fi

# echo "command_install_utils = ${command_install_utils}"
# echo "command_install_web_tools = ${command_install_web_tools}"
# echo "command_install_db = ${command_install_db}"
# echo "command_install_mobile_tools = ${command_install_mobile_tools}"
# echo "option_web_server = ${option_web_server}"
