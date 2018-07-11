cmake_minimum_required(VERSION 2.8.8)
project(LLVMDatalog)

find_package(LLVM REQUIRED CONFIG)

set(CXXFLAGS "-std=c++11 -Wall -fno-rtti")

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -DMK_DEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -O2")

# Old Z3 path
#set(Z3_INC /usr/include)
#find_path(Z3_INC z3++.h)
#message(STATUS "Z3PATH: ${Z3_INC}")

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "CXXFLAGS: ${CXXFLAGS}")


# Set your project compile flags. E.g. if using the C++ header files you will
# need to enable C++11 support for your compiler.
add_definitions(${LLVM_DEFINITIONS} ${CXXFLAGS})
include_directories(${LLVM_INCLUDE_DIRS} ${APRON_INCLUDE} ${Z3_INC})

add_subdirectory(diffDep)
