#!/bin/bash -ex

export ANDROID_NDK_ROOT=$(pwd)/vendor/android-ndk
cd $1

function build {
	QMAKE=$(find ~/ | grep $1/bin/qmake | head -n 1)
    mkdir -p build/$1
    
    cd build/$1
    ${QMAKE} ../../project.pro
    make
    cd ../..
}

build android_armv7
build gcc_64

