#!/bin/bash

# Install cpanm
curl -L http://cpanmin.us | perl - --self-upgrade

# Perl modules
cpanm Archive::Zip PAR PAR::Packer IO::String
zip -y -q -r cpanm-log.zip ~/.cpanm/

# Get repo
wget -O exiftool.zip https://github.com/exiftool/exiftool/archive/refs/tags/12.60.zip
unzip -q exiftool.zip
rm exiftool.zip
cd exiftool-*
rm -rf windows_exiftool html t

# Build
ARGS=`awk '!/^#/ && !/Win32/' pp_build_exe.args | tr '\n' ' '`
pp $ARGS
mv exiftool.exe ../
echo 'Built successfully'
