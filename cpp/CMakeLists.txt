cmake_minimum_required(VERSION 2.8.9)
project (Rift)

set (CMAKE_CXX_STANDARD 11)

#For the shared library:
set (PROJECT_LINK_LIBS librocksdb.a libzmq.a libflatbuffers.a)
link_directories(/usr/local/Cellar/rocksdb/5.11.3/lib/ /usr/local/Cellar/zeromq/4.2.5/lib/ /usr/local/Cellar/flatbuffers/1.8.0/lib/)
 
include_directories(/usr/local/Cellar/rocksdb/5.11.3/include/ /usr/local/Cellar/zeromq/4.2.5/include/ /usr/local/Cellar/flatbuffers/1.8.0/include/)
 
add_executable(rift-node main.cpp)
#target_link_libraries(rift-node librocksdb.a libzmq.a libflatbuffers.a)
target_link_libraries(rift-node ${PROJECT_LINK_LIBS})