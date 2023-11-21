#/bin/sh

apk update
apk add bash curl wget make gcc perl perl-utils perl-dev unzip zip musl-dev
bash build.sh
