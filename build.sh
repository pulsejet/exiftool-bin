#!/bin/bash

# Get tag
GIT_TAG=`echo $(git describe --tags --abbrev=0)`
echo "Tag is $GIT_TAG"

# Install cpanm
curl -L http://cpanmin.us | perl - --self-upgrade

# Perl modules
cpanm Archive::Zip PAR PAR::Packer IO::String
zip -r cpanm_log.zip /root/.cpanm/work

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
