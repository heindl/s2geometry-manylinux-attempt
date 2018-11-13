#!/usr/bin/env bash

set -e -x

if [[ "$(uname -m)" = i686 ]]; then
	TOOLCHAIN_URL='https://github.com/Noctem/pogeo-toolchain/releases/download/v1.3/gcc-7.1-binutils-2.28-centos5-i686.tar.bz2'
else
	TOOLCHAIN_URL='https://github.com/Noctem/pogeo-toolchain/releases/download/v1.3/gcc-7.1-binutils-2.28-centos5-x86-64.tar.bz2'
fi

cd /opt/
curl -L "$TOOLCHAIN_URL" -o toolchain.tar.bz2
tar -xf toolchain.tar.bz2
rm toolchain.tar.bz2