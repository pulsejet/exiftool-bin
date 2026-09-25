#!/bin/bash

# Install cpanm
curl -L http://cpanmin.us | perl - --self-upgrade

# Perl modules
# https://github.com/exiftool/exiftool/blob/master/windows_exiftool
cpanm Archive::Zip PAR PAR::Packer IO::String
zip -y -q -r cpanm-log.zip ~/.cpanm/

# Get repo
wget -O exiftool.zip https://github.com/exiftool/exiftool/archive/refs/tags/13.59.zip
unzip -q exiftool.zip
rm exiftool.zip
cd exiftool-*
rm -rf windows_exiftool html t

# Build fully-packed exiftool (interpreter + deps + exiftool code)
ARGS=`awk '!/^#/ && !/Win32|Brotli/' pp_build_exe.args | tr '\n' ' '`
pp $ARGS
mv exiftool.exe ../

# Build generic packed-perl binary (interpreter + deps, no app script packed).
# Packs the eperl stub, which runs an external script at run time:
RUNTIME_DEPS=`awk '/^-M / && !/Win32|Brotli/' pp_build_exe.args | tr '\n' ' '`
pp --reusable -o eperl.exe -T eperl $RUNTIME_DEPS -M JSON::PP -M FindBin ../eperl.pl
mv eperl.exe ../
echo 'Built successfully'
