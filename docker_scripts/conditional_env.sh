#!/usr/bin/env bash

set -e -x

if [[ "$(uname -m)" = i686 ]]; then
	TOOLCHAIN_URL='https://github.com/Noctem/pogeo-toolchain/releases/download/v1.3/gcc-7.1-binutils-2.28-centos5-i686.tar.bz2'
	export LD_LIBRARY_PATH="/opt/toolchain/lib:${LD_LIBRARY_PATH}"
	MFLAG="-m32"
else
	TOOLCHAIN_URL='https://github.com/Noctem/pogeo-toolchain/releases/download/v1.3/gcc-7.1-binutils-2.28-centos5-x86-64.tar.bz2'
	export LD_LIBRARY_PATH="/toolchain/lib64:/opt/toolchain/lib:${LD_LIBRARY_PATH}"
	MFLAG="-m64"
fi

export MANYLINUX=1
export PATH="${BUILD_PREFIX}/toolchain/bin:${PATH}"
export CFLAGS="-I${BUILD_PREFIX}/toolchain/include ${MFLAG}"
export CXXFLAGS="-I${BUILD_PREFIX}/toolchain/include ${MFLAG}"

#ENV CC ${BUILD_PREFIX}/toolchain/bin/gcc
#ENV CXX ${BUILD_PREFIX}/toolchain/bin/g++