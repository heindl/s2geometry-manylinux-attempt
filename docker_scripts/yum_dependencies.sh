#!/usr/bin/env bash

set -e -x

source ${CONFIG_DIR}/multibuild/common_utils.sh
source ${CONFIG_DIR}/multibuild/library_builders.sh

build_swig
build_openssl

#yum update
#yum install -y glibc-devel
#yum install -y openssl-devel
#yum install -y python-devel