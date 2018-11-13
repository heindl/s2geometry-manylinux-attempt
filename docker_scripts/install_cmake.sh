#!/usr/bin/env bash

set -e -x

cd $CONFIG_DIR
curl https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz | tar xvz
cd cmake-3.11.4
./bootstrap --no-system-libs --prefix=/opt/cmake
make
make install