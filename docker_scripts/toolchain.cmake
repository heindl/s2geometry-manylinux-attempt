set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_BUILD_TYPE Release)

IF (CMAKE_SYSTEM_PROCESSOR STREQUAL "i686")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -I/opt/devtools-7.2/include -m32")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I/opt/devtools-7.2/include -m32")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath -Wl,/opt/devtools-7.2/lib")
else()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -I/opt/devtools-7.2/include -m64")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I/opt/devtools-7.2/include -m64")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath -Wl,/opt/devtools-7.2/lib64:/opt/devtools-7.2/lib")
endif()

set(CMAKE_FORCE_C_COMPILER /opt/devtools-7.2/bin/gcc GNU)
set(CMAKE_FORCE_CXX_COMPILER /opt/devtools-7.2/bin/g++ GNU)

# set(CMAKE_CROSSCOMPILING TRUE)

# set(CMAKE_FIND_ROOT_PATH /opt/devtools-7.2)



# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


