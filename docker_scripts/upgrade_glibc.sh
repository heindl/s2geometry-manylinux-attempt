#!/usr/bin/env bash

set -e -x

GCC_VERSION=2.18

cd /root
curl -L https://ftp.gnu.org/pub/gnu/glibc/glibc-${GCC_VERSION}.tar.bz2 -o glibc-${GCC_VERSION}.tar.bz2
tar -xf glibc-${GCC_VERSION}.tar.bz2
cd glibc-${GCC_VERSION}
mkdir build
cd build
../configure --prefix=${BUILD_PREFIX} --with-headers=${BUILD_PREFIX}/include
#../configure --prefix=${BUILD_PREFIX}
make -j4
make install