FROM ubuntu as compile_time
RUN apt-get update

RUN apt-get install -y curl git make cmake g++ build-essential autoconf libtool pkg-config

## rocks db
RUN apt-get install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
RUN git clone https://github.com/facebook/rocksdb.git
RUN cd rocksdb && make -j 4 static_lib && make install

## grpc
RUN apt-get install -y libgflags-dev libgtest-dev
RUN apt-get install -y clang libc++-dev
RUN git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc
RUN cd grpc/ && git submodule update --init &&  make -j 4 && make install

## flatbuffers
RUN git clone https://github.com/google/flatbuffers.git
RUN cd /flatbuffers && cmake . && make -j 4 && make install && cp flatc /usr/local/bin

## nanomsg
RUN apt-get -y install wget tar
RUN wget https://github.com/nanomsg/nanomsg/archive/1.1.2.tar.gz && tar -xvzf 1.1.2.tar.gz
RUN cd nanomsg-1.1.2 && cmake . && make && make install

## protobuf
RUN apt-get install -y autoconf automake libtool curl make g++ unzip
RUN wget https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-cpp-3.5.1.tar.gz
RUN tar -xvzf protobuf-cpp-3.5.1.tar.gz
RUN cd protobuf-3.5.1/ && ./autogen.sh && ./configure && make -j 4 && make check && make install


FROM ubuntu
COPY --from=compile_time /usr/local /usr/local/
RUN apt-get update
RUN apt-get install -y make cmake git g++ libzmq5-dev
# RUN git clone https://github.com/nikhilsimha/Rift.git
COPY cpp /Rift/cpp/
RUN cd /Rift/cpp && cmake . && make

