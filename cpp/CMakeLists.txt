cmake_minimum_required(VERSION 2.8.9)
project (Rift)
set (CMAKE_CXX_STANDARD 11)

# generated files go here
set(GEN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/gen)

############################ FLAT BUFFERS ##################################
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/BuildFlatBuffers.cmake)

set(SCHEMA_DIR ${CMAKE_CURRENT_SOURCE_DIR}/schema)
file(GLOB_RECURSE SCHEMAS ${SCHEMA_DIR}/**.fbs)


set(GEN_FBS_DIR ${GEN_DIR}/fbs)
add_executable(flatc IMPORTED GLOBAL)
set_target_properties(
    flatc 
    PROPERTIES 
        IMPORTED_LOCATION /usr/local/bin/flatc        
)

set(FLATBUFFERS_FLATC_SCHEMA_EXTRA_ARGS --grpc --cpp)

build_flatbuffers("${SCHEMAS}"
                  "${SCHEMA_DIR}"
                  build_fbs
                  ""
                  "${GEN_FBS_DIR}"
                  ""
                  "")

# dockerize the build environment to make it work on aws
############################# DEPENDENCY SETUP ################################
set (PROJECT_DEPS_DIR /usr/local/Cellar)
set (PROJECT_LINK_LIBS librocksdb.a libzmq.a libflatbuffers.a libgrpc.a libgrpc++.a)

link_directories(
    ${PROJECT_DEPS_DIR}/rocksdb/5.11.3/lib/ 
    ${PROJECT_DEPS_DIR}/zeromq/4.2.5/lib/ 
    ${PROJECT_DEPS_DIR}/flatbuffers/1.9.0/lib/
    ${PROJECT_DEPS_DIR}/grpc/1.10.1/lib/
    /usr/local/lib
)  

include_directories(
    ${PROJECT_DEPS_DIR}/rocksdb/5.11.3/include/ 
    ${PROJECT_DEPS_DIR}/zeromq/4.2.5/include/ 
    ${PROJECT_DEPS_DIR}/flatbuffers/1.9.0/include/
    ${PROJECT_DEPS_DIR}/grpc/1.10.1/include/
    /usr/local/include    
    ${GEN_DIR}/)


################################ BUILD ######################################
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin)
add_executable(rift-node main.cpp)
add_dependencies(rift-node build_fbs)
target_link_libraries(rift-node ${PROJECT_LINK_LIBS})