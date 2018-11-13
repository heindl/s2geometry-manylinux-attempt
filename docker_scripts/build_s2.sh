#!/usr/bin/env bash

set -e -x

#source ${BUILD_PREFIX}/build_docker/conditional_env.sh



mkdir ${CONFIG_DIR}/s2geometry/build
cd ${CONFIG_DIR}/s2geometry/build
export VERBOSE=1
#/opt/cmake/bin/cmake -DCMAKE_TOOLCHAIN_FILE=${CONFIG_DIR}/docker_scripts/toolchain.cmake ..
cmake ..
make
make install