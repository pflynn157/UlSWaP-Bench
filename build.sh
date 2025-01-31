#!/bin/bash

BUILD_DIR=./build

if [[ ! -d ./$BUILD_DIR ]]
then
    mkdir -p $BUILD_DIR
fi

if [[ $1 == "native" ]]
then
    echo "Building for Native"
    cmake . -B $BUILD_DIR -DARCH=native
elif [[ $1 == "ascc" ]]
then
    echo "Building for ASCC"
elif [[ $1 == "clean" ]]
then
    rm -rf ./build
    echo "Done cleaning"
    exit 0
else
    echo "Error: Unknown architecture."
    echo "Please specify either native or ascc."
    echo "Alternatively, specify clean to clean things up."
    exit 1
fi

cd build
make -j4
cd ..

echo "Done"
exit 0

