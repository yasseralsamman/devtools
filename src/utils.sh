#!/bin/bash
# Utilities installation functions for devtools script
#

# Update sources
function update_sources() {
  apt-get update &>> log.txt & spinner "Updating Sources "
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
               'libc6:i386'
               'libncurses5:i386'
               'libstdc++6:i386'
               'lib32z1'
               'build-essential'
               'autoconf'
               'automake'
               'autopoint'
               'chrpath'
               'cm-super-minimal'
               'debhelper'
               'dh-autoreconf'
               'dh-strip-nondeterminism'
               'doxygen'
               'doxygen-latex'
               'gir1.2-rsvg-2.0'
               'graphviz'
               'libbz2-dev'
               'libcairo-script-interpreter2'
               'libcairo2-dev'
               'libcdt5'
               'libcgraph6'
               'libclang1-3.6'
               'libdjvulibre-dev'
               'libexif-dev'
               'libfftw3-bin'
               'libfftw3-dev'
               'libfftw3-long3'
               'libfftw3-quad3'
               'libfile-stripnondeterminism-perl'
               'libfontconfig1-dev'
               'libfreetype6-dev'
               'libgdk-pixbuf2.0-dev'
               'libglib2.0-dev'
               'libgvc6'
               'libgvpr2'
               'libharfbuzz-dev'
               'libharfbuzz-gobject0'
               'libice-dev'
               'libilmbase-dev'
               'libjasper-dev'
               'libjbig-dev'
               'libjpeg-dev'
               'libjpeg-turbo8-dev'
               'libjpeg8-dev'
               'libjs-jquery'
               'liblcms2-dev'
               'libllvm3.6v5'
               'liblqr-1-0-dev'
               'liblzma-dev'
               'libobjc-5-dev'
               'libobjc4'
               'libopenexr-dev'
               'libpango1.0-dev'
               'libpathplan4'
               'libpcre3-dev'
               'libpcre32-3'
               'libpcrecpp0v5'
               'libperl-dev'
               'libpixman-1-dev'
               'libpng12-dev'
               'libpotrace0'
               'libptexenc1'
               'libpthread-stubs0-dev'
               'librsvg2-bin'
               'librsvg2-dev'
               'libsigsegv2'
               'libsm-dev'
               'libsynctex1'
               'libtexlua52'
               'libtexluajit2'
               'libtiff5-dev'
               'libtiffxx5'
               'libwmf-dev'
               'libx11-dev'
               'libxau-dev'
               'libxcb-render0-dev'
               'libxcb-shm0-dev'
               'libxcb1-dev'
               'libxdmcp-dev'
               'libxext-dev'
               'libxft-dev'
               'libxml2-dev'
               'libxml2-utils'
               'libxrender-dev'
               'libxt-dev'
               'libzzip-0-13'
               'm4'
               'pkg-kde-tools'
               'po-debconf'
               'preview-latex-style'
               'tex-common'
               'texlive-base'
               'texlive-binaries'
               'texlive-extra-utils'
               'texlive-font-utils'
               'texlive-fonts-recommended'
               'texlive-latex-base'
               'texlive-latex-extra'
               'texlive-latex-recommended'
               'texlive-pictures'
               'x11proto-core-dev'
               'x11proto-input-dev'
               'x11proto-kb-dev'
               'x11proto-render-dev'
               'x11proto-xext-dev'
               'xorg-sgml-doctools'
               'xsltproc'
               'xtrans-dev'
               'zlib1g-dev'
               'libtiff5-dev'
               'xorg-dev'
               'libopenjp2-7-dev'
              )
  apt-get -y install "${utils[@]/#/}" &>> log.txt & spinner "Installing Utilities "
  ln -s /usr/bin/nodejs /usr/bin/node &>> log.txt
  install_java
  install_nodejs
  install_imagemagick
  # Usefull less compiler for web developers
  npm install -g less &>> log.txt & spinner "Installing Less"
}

function install_nodejs() {
  local njsversion=$option_nodejs_version
  curl -sL "https://deb.nodesource.com/setup_${option_nodejs_version}.x" | sudo -E bash - &>> log.txt & spinner "Adding PPA for NodeJS "
  apt-get install nodejs &>> log.txt & spinner "Installing NodeJS${option_nodejs_version}"
}

function install_java() {
  local jversion="oracle-java${option_jdk_version}-installer"
  apt-add-repository ppa:webupd8team/java -y &>> log.txt & spinner "Adding PPA for JDK "
  update_sources
  echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  apt-get -y install "${jversion}" &>> log.txt & spinner "Installing JDK${option_jdk_version}"
}

function install_imagemagick() {
  wget http://www.imagemagick.org/download/ImageMagick.tar.gz &>> log.txt & spinner "Downloading ImageMagick "
  tar xzvf ImageMagick.tar.gz &>> log.txt & spinner "Extracting ImageMagick "
  cd ImageMagick-7.0.*
  ./configure --with-rsvg=yes &>> log.txt & spinner "Configure ImageMagick "
  make &>> log.txt & spinner "Compiling ImageMagick "
  make install &>> log.txt & spinner "Installing ImageMagick "
  cd ..
  ldconfig /usr/local/lib
  rm ImageMagick.tar.gz
  rm -R ImageMagick-7.0.*
}
