#!/bin/bash

# Dependencies
sudo apt update
sudo apt install make gcc libperl-dev wget curl

# Install cpanm
curl -L http://cpanmin.us | perl - --self-upgrade

# Perl modules
cpanm Archive::Zip PAR PAR::Packer IO::String

# Get repo
wget -O exiftool.zip https://github.com/exiftool/exiftool/archive/refs/tags/12.49.zip
unzip exiftool.zip
rm exiftool.zip
cd exiftool-*

# Build
ARGS=`awk '!/^#/ && !/Win32/' pp_build_exe.args | tr '\n' ' '`
pp $ARGS
