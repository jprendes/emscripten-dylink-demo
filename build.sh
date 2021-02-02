#!/bin/bash

# Get gtest source
git clone --depth 1 --branch release-1.10.0 https://github.com/google/googletest.git /gtest

# Build settings
export DEBUG=0 # 0, 1 or 2
export INITIAL_MEMORY_MB=32 # in MB

# Setup compiler flags
export CXX_FLAGS="-pthread -Wno-experimental -s DISABLE_EXCEPTION_CATCHING=0 -s INITIAL_MEMORY=$(expr $INITIAL_MEMORY_MB \* 1024 \* 1024)"
if [ "$DEBUG" == "2" ]; then
    export CXX_FLAGS="$CXX_FLAGS -s ASSERTIONS=2 -g"
elif [ "$DEBUG" == "1" ]; then
    export CXX_FLAGS="$CXX_FLAGS -s ASSERTIONS=1 -g"
else
    export CXX_FLAGS="$CXX_FLAGS -Os"
fi

export CXX_FLAGS="$CXX_FLAGS -I /gtest/googletest/include"

# Build everything
mkdir -p build

em++ $CXX_FLAGS $CXX_SIDE_FLAGS \
    -s SIDE_MODULE=1 \
    -DGTEST_HAS_PTHREAD=1 \
    -I /gtest/googletest \
    -o build/gtest.wasm \
    /gtest/googletest/src/gtest-all.cc

em++ $CXX_FLAGS $CXX_SIDE_FLAGS \
    -s SIDE_MODULE=1 \
    -s RUNTIME_LINKED_LIBS="['gtest.wasm']" \
    -o build/string-compare.wasm \
    src/string-compare.cpp \
    src/main.cpp

echo "" > /tmp/main.cpp
em++ $CXX_FLAGS \
    -s MAIN_MODULE=1 \
    -s EXIT_RUNTIME=1 \
    -s PROXY_TO_PTHREAD \
    -s RUNTIME_LINKED_LIBS="['string-compare.wasm']" \
    -o build/main.html \
    /tmp/main.cpp
