#!/usr/bin/env bash

CONFIG_DIR=$(dirname "${BASH_SOURCE[0]}")

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    build_s2geometry
}

function build_wheel {
    build_pip_wheel ${CONFIG_DIR}/setup
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python ${CONFIG_DIR}/s2geometry/src/python/pywraps2_test.py
}

# The library_builder.sh version of 'get_cmake' is limited to 2.8
function get_cmake_latest {
    # Note that build_simple automatically adds a stamp
    if [ -n "$IS_OSX" ]; then
        brew install cmake > /dev/null
    else
        # https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz
        # Note that build_simple automatically adds a stamp
        build_simple cmake 3.11.4 https://cmake.org/files/v3.11 tar.gz
    fi
}

function build_s2geometry {

    get_cmake_latest
    build_openssl
    build_swig
    install_gtest

    if [ -e ${CONFIG_DIR}/s2geometry-stamp ]; then return; fi

    # -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX

    (mkdir ${CONFIG_DIR}/s2geometry/build \
        && cd ${CONFIG_DIR}/s2geometry/build \
        && cmake -DWITH_GFLAGS=ON -DWITH_GLOG=ON  .. \
        && make \
        && make install)

    touch ${CONFIG_DIR}/s2geometry-stamp

}

function setup_alien {
    if [ -e ${CONFIG_DIR}/alien-stamp ]; then return; fi
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"
    yum install -y alien
    touch ${CONFIG_DIR}/alien-stamp
}

function install_with_alien {
    local deb_name=$1
    local url=$2
    if [ -e ${CONFIG_DIR}/${deb_name}-stamp ]; then return; fi
    local arch_sdir="${ARCHIVE_SDIR:-archives}"
    # Make the archive directory in case it doesn't exist
    mkdir -p $arch_sdir
    local out_archive="${arch_sdir}/${deb_name}.deb"
    # Fetch the archive if it does not exist
    if [ ! -f "$out_archive" ]; then
        curl -L $url > $out_archive
        alien -r $out_archive
        yum install package.deb
    fi
    touch ${CONFIG_DIR}/${deb_name}-stamp
}

function install_gtest {

    if [ -n "$IS_OSX" ]; then

        brew install gflags
        brew install google-glog

    else

        setup_alien
        # libgtest-dev
        yum install -y libgtest-dev
        # libssl-devel
        yum install -y libssl-devel
        # libgflags-dev
        install_with_alien libgflags-dev http://ftp.br.debian.org/debian/pool/main/g/gflags/libgflags-dev_2.1.2-4_amd64.deb
        # libgoogle-glog-dev
        install_with_alien libgoogle-glog-dev http://ftp.br.debian.org/debian/pool/main/g/google-glog/libgoogle-glog-dev_0.3.4-2_amd64.deb

    fi

}

#function install_libssl {
#    if [ -e libssl-dev-stamp ]; then return; fi
#    yum -y install epel-release
#    yum install -y openssl-devel
#    touch libssl-dev-stamp
#}