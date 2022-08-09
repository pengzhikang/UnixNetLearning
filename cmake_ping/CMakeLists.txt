
# CMake 最低版本号要求
cmake_minimum_required (VERSION 3.16)

# set(CMAKE_BUILD_TYPE "Release")
# 项目信息
project (cmake_ping)

set(CMAKE_CXX_FLAGS "-O0 -Wall -Wextra -std=c++11")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CMAKE_CXX_FLAGS}")


#<-------------------------------------------------->

#设置c++的版本并添加多线程的使用
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pthread")

#设置输出文件的路径
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/release)


#添加依赖库路径
set(SRCPATH "${CMAKE_CURRENT_SOURCE_DIR}/src")
# link_directories(/usr/lib)
link_directories("/usr/lib/aarch64-linux-gnu")
Option(PING6 "ping6 tools" OFF)
if (PING6)
    set(testname cmake_ping6)
    set(OpenSSL_Depend crypto)
    set(Resolv_Depend resolv)
    set(REQUIRE_CPP 
        "${SRCPATH}/ping6.c"
        "${SRCPATH}/ping_common.c")
else()
    set(testname cmake_ping)
    set(REQUIRE_CPP 
        "${SRCPATH}/ping.c"
        "${SRCPATH}/ping_common.c")
endif()
#添加头文件路径
include_directories(/usr/include)
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include/")
# include_directories(/usr/include/c++/7/)
include_directories("${CMAKE_CURRENT_SOURCE_DIR}")
# include_directories("${MYLIBPATH}/include/modbus")



#指定生成目标
add_executable(${testname} ${REQUIRE_CPP})
if (PING6)
    target_link_libraries(${testname} ${OpenSSL_Depend})
    target_link_libraries(${testname} ${Resolv_Depend})
endif()
target_link_libraries(${testname} stdc++fs)

