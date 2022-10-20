#!/bin/bash

# Get tag
GIT_TAG=`echo $(git describe --tags --abbrev=0)`
echo "Tag is $GIT_TAG"

# Dependencies
sudo apt update
sudo apt install make gcc libperl-dev wget curl

# Install cpanm
curl -L http://cpanmin.us | sudo perl - --self-upgrade

# Perl modules
sudo cpanm Archive::Zip PAR PAR::Packer IO::String

# Get repo
wget -O exiftool.zip https://github.com/exiftool/exiftool/archive/refs/tags/12.49.zip
unzip exiftool.zip
rm exiftool.zip
cd exiftool-*

# Build
ARGS=`awk '!/^#/ && !/Win32/' pp_build_exe.args | tr '\n' ' '`
pp $ARGS
mv exiftool.exe ../
echo 'Built successfully'
