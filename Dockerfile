#FROM quay.io/pypa/manylinux1_x86_64

FROM numenta/manylinux1_x86_64_centos6

ENV CONFIG_DIR /root
#ENV BUILD_PREFIX /opt/toolchain
#
#COPY --chown=root ./docker_scripts/install_cmake.sh ${CONFIG_DIR}/docker_scripts/install_cmake.sh
#RUN chmod -R 770 ${CONFIG_DIR}/docker_scripts
#RUN ${CONFIG_DIR}/docker_scripts/install_cmake.sh
#
#RUN yum install -y make m4 diffutils bzip2 glibc-devel
#RUN curl -L https://github.com/squeaky-pl/centos-devtools/releases/download/7.2/gcc-7.2.0-binutils-2.29.1-x86_64.tar.bz2 | tar -C / -xj
#
RUN yum install -y swig python-devel

COPY --chown=root ./s2geometry ${CONFIG_DIR}/s2geometry
RUN chmod -R 770 ${CONFIG_DIR}/s2geometry
#
#ENV PATH="/opt/devtools-7.2/bin:${PATH}"

#COPY --chown=root ./docker_scripts ${CONFIG_DIR}/docker_scripts
#RUN chmod -R 770 ${CONFIG_DIR}/docker_scripts
#
#RUN ${CONFIG_DIR}/docker_scripts/download_gcc.sh
#
#RUN ${CONFIG_DIR}/docker_scripts/upgrade_glibc.sh
#
#COPY --chown=root ./multibuild ${CONFIG_DIR}/multibuild
#RUN chmod -R 770 ${CONFIG_DIR}/multibuild
##
#RUN ${CONFIG_DIR}/docker_scripts/yum_dependencies.sh

#COPY --chown=root ./docker_scripts/yum_dependencies.sh ${CONFIG_DIR}/docker_scripts/yum_dependencies.sh
#RUN chmod -R 770 ${CONFIG_DIR}/docker_scripts
#RUN ${CONFIG_DIR}/docker_scripts/yum_dependencies.sh
#
#COPY --chown=root ./docker_scripts/install_cmake.sh ${CONFIG_DIR}/docker_scripts/install_cmake.sh
#RUN chmod -R 770 ${CONFIG_DIR}/docker_scripts
#RUN ${CONFIG_DIR}/docker_scripts/install_cmake.sh
#
#COPY --chown=root ./upgrade_glibc.sh ${BUILD_PREFIX}/upgrade_glibc.sh

#
##RUN ${BUILD_PREFIX}/upgrade_glibc.sh
#
#COPY --chown=root ./s2geometry ${CONFIG_DIR}/s2geometry
#RUN chmod -R 770 ${CONFIG_DIR}/s2geometry
###
#COPY --chown=root ./docker_scripts/toolchain.cmake ${CONFIG_DIR}/docker_scripts/toolchain.cmake
#COPY --chown=root ./docker_scripts/build_s2.sh ${CONFIG_DIR}/docker_scripts/build_s2.sh
#RUN chmod -R 770 ${CONFIG_DIR}/docker_scripts

COPY --chown=root ./docker_scripts ${CONFIG_DIR}/docker_scripts
RUN chmod -R 770 ${CONFIG_DIR}/docker_scripts

RUN ${CONFIG_DIR}/docker_scripts/build_s2.sh