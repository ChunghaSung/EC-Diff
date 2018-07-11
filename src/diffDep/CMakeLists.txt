add_library(diffDep MODULE 
  diffDep.cpp
  utils/utils.cpp)

#find_library(Z3_LIB z3)
#set(Z3_LIB /usr/lib/libz3.so)
#message(STATUS "Z3 PATH: ${Z3_LIB}")

#target_link_libraries(diffDep ${Z3_LIB})
