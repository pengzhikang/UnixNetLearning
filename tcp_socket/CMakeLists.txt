
# CMake 最低版本号要求
cmake_minimum_required (VERSION 3.16)

# set(CMAKE_BUILD_TYPE "Release")
# 项目信息
project (tcp_socket)

set(CMAKE_CXX_FLAGS "-O0 -Wall -Wextra -std=c++11")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CMAKE_CXX_FLAGS}")


#<-------------------------------------------------->

#设置c++的版本并添加多线程的使用
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pthread")

#设置输出文件的路径
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/release)


#添加依赖库路径
# set(MYLIBPATH "${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/")
# link_directories(/usr/lib)
# link_directories("${MYLIBPATH}/lib")
# set(MODBUS_dep_LIBS modbus)

#添加头文件路径
include_directories(/usr/include)
include_directories("${CMAKE_CURRENT_SOURCE_DIR}")
# include_directories("${MYLIBPATH}/include/modbus")
option(Client "Compile Client src" OFF)


if(Client)
    set(testname tcpcli)
    # 查找当前目录的所有源文件
    set(REQUIRE_CPP 
    "${CMAKE_CURRENT_SOURCE_DIR}/client.c"
    )
else()
    set(testname tcpser)
    # 查找当前目录的所有源文件
    set(REQUIRE_CPP 
    "${CMAKE_CURRENT_SOURCE_DIR}/server.c"
    )
endif()



#指定生成目标
add_executable(${testname} ${REQUIRE_CPP})
# target_link_libraries(${testname} ${MODBUS_dep_LIBS})
target_link_libraries(${testname} stdc++fs)

