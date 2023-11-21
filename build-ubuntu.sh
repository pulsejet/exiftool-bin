#!/bin/sh

apt-get update
apt-get install -y make gcc libperl-dev wget curl sudo unzip zip libssl-dev
bash build.sh
