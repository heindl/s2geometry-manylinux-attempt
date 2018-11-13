#!/usr/bin/env bash

CONFIG_DIR=$(dirname "${BASH_SOURCE[0]}")

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    build_s2geometry
    if [ -n "$IS_OSX" ]; then
        brew install cmake > /dev/null
        brew install gflags
        brew install google-glog
    else

    fi
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
        cd /tmp/
        curl https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz | tar xvz
        cd cmake-3.11.4 && ./bootstrap && make && make install > /dev/null
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
        && cmake  .. \
        && make \
        && make install)

    touch ${CONFIG_DIR}/s2geometry-stamp

}

#function setup_alien {
#    if [ -e ${CONFIG_DIR}/alien-stamp ]; then return; fi
#    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#    subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"
#    yum install -y alien
#    touch ${CONFIG_DIR}/alien-stamp
#}

#function install_with_alien {
#    local deb_name=$1
#    local url=$2
#    if [ -e ${CONFIG_DIR}/${deb_name}-stamp ]; then return; fi
#    local arch_sdir="${ARCHIVE_SDIR:-archives}"
#    # Make the archive directory in case it doesn't exist
#    mkdir -p $arch_sdir
#    local out_archive="${arch_sdir}/${deb_name}.deb"
#    # Fetch the archive if it does not exist
#    if [ ! -f "$out_archive" ]; then
#        curl -L $url > $out_archive
#        alien -r $out_archive
#        yum install package.deb
#    fi
#    touch ${CONFIG_DIR}/${deb_name}-stamp
#}

#function update_wget {
#    cd ~
#    wget http://ftp.gnu.org/gnu/wget/wget-1.16.tar.gz
#    yum -y remove wget
#    tar -xzvf wget-1.16.tar.gz
#    cd wget-1.16
#    ./configure --with-ssl=openssl --with-libssl-prefix=/usr/lib64/openssl --prefix=/usr > /dev/null
#    make && make install
#}

function update_glibc {
    cd /tmp/
    if [ -e ${CONFIG_DIR}/glibc-stamp ]; then return; fi
    curl http://ftp.gnu.org/gnu/glibc/glibc-2.14.tar.gz | tar zxv
    cd glibc-2.14 && mkdir build && cd build
    ../configure --prefix=/opt/glibc-2.14 --enable-multiarch=no && make -j4 && make install
#   export LD_LIBRARY_PATH=/opt/glibc-2.14/lib
    touch ${CONFIG_DIR}/glibc-stamp
}
function install_gtest {

    if [ -n "$IS_OSX" ]; then

        brew install gflags
        brew install google-glog

    else

        yum install -y openssl-devel
        yum install -y python-devel
        update_glibc

        # Upgrade glibc

#        curl https://codeload.github.com/google/googletest/tar.gz/release-1.8.0 | tar xvz
#        cd googletest-release-1.8.0/googletest/
#        mkdir build && cd build && cmake .. && make && make install
#
#
#        gcc4.0-c++-4.0.0-0.2mdk.i586.rpm https://rpmfind.net/linux/Mandriva/official/10.2/i586/media/contrib/gcc4.0-c++-4.0.0-0.2mdk.i586.rpm
#        libgtest0-1.7.0-2.mga7.i586.rpm https://rpmfind.net/linux/mageia/distrib/cauldron/i586/media/core/release/libgtest0-1.7.0-2.mga7.i586.rpm
#        gcc-7.3.0-5.mga7.i586.rpm https://rpmfind.net/linux/mageia/distrib/cauldron/i586/media/core/release/gcc-7.3.0-5.mga7.i586.rpm
#        libgtest-devel-1.7.0-2.mga7.i586.rpm https://rpmfind.net/linux/mageia/distrib/cauldron/i586/media/core/release/libgtest-devel-1.7.0-2.mga7.i586.rpm
#
#        setup_alien
#        # libgtest-dev
#        yum install -y libgtest-dev
#
#        # libssl-devel
#        yum install -y libssl-devel
#        # libgflags-dev
#        install_with_alien libgflags-dev http://ftp.br.debian.org/debian/pool/main/g/gflags/libgflags-dev_2.1.2-4_amd64.deb
#        # libgoogle-glog-dev
#        install_with_alien libgoogle-glog-dev http://ftp.br.debian.org/debian/pool/main/g/google-glog/libgoogle-glog-dev_0.3.4-2_amd64.deb

    fi

}

#function install_libssl {
#    if [ -e libssl-dev-stamp ]; then return; fi
#    yum -y install epel-release
#    yum install -y openssl-devel
#    touch libssl-dev-stamp
#}