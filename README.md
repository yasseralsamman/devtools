# DevTools
###### Smart Bash Scripts For Web &amp; Mobile Development Tools | Ubuntu 16.04
The most used web development tools in one place. Install dev tools after a fresh OS installation.

#
### Usage
Download the script and move to the downloaded folder where `devtools.sh` is placed, then run the script:
```sh
$ cd devtools
$ sudo chmod +x devtools.sh
$ sudo bash devtools.sh
```
Command syntax as the following:
` devtools.sh [<command_name>] [options] `

you can always use the help command to see what could be used:
```sh
$ sudo bash devtools.sh help
```

### Commands &amp; Options
##### 1- Utilities
#
DevTools comes bundeled with a bunch of useful utilities, like git, vim and other stuff. check ` src/utils.sh ` to see what is included.
To install utilities use the command:
```sh
$ sudo bash devtools.sh utils
```
###### Available Options
- You can choose what JDK version you want to install (6,7 and 8 are supported. JDK8 is default):
```sh
$ sudo bash devtools.sh utils --jdk-version=8
```
- You can choose what NodeJS version you want to install (6,7 and 4 are supported. NodeJS 6 is default):
```sh
$ sudo bash devtools.sh utils --nodejs-version=6
```

##### 2- Web Development Tools
#
This command will help you install the web server and other related stuff like PHP, Composer and some other extensions.
To install web tools use the command:
```sh
$ sudo bash devtools.sh web-tools
```
###### Available Options
- You can choose what web server you want to install (Only apache2 is supported for now, more will be added):
```sh
$ sudo bash devtools.sh web-tools --web-server=apache2
```
- You can chose what PHP version you want to install:
```sh
$ sudo bash devtools.sh web-tools --php-version=5.6
```
##### 3- Database Server
#
This command will automatically install and configure the database server.
```sh
$ sudo bash devtools.sh db
```
###### Available Options
- You can choose what database server you want to install (Only mysql is supported for now, more will be added):
```sh
$ sudo bash devtools.sh db --db-server=mysql
```
- You can chose the root password for your server:
```sh
$ sudo bash devtools.sh db --db-pass=123456
```
##### 4- Mobile Tools
###### Ionic Framework
This command will install Cordova and Ionic Framework via npm globally. note that if you did not install JDK or NodeJS before, this command will automatically install them, so you can use `--jdk-version` and `--nodejs-version` options.
```sh
$ sudo bash devtools.sh ionic
```
##### 5- Optional Software installation
The following commands are not included in default installation and you have to mention the command to install the software. Note that you can use multiple optional commands in one call.

###### Google Chrome
To install Google Chrome use the following command
```sh
$ sudo bash devtools.sh chrome
```

###### Atom Editor
To install Atom use the following command
```sh
$ sudo bash devtools.sh atom
```

### Contribution
Every OS version will have it's own branch as the commands and installation instructions may differ from one to another, and it's easier for people to lcate their version from branch selection. Just remember to edit the readme to match your script.
