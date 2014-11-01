#!/bin/bash -ex

export ANDROID_NDK_ROOT=$(pwd)/android-ndk

function build {
	QMAKE=$(find ~/ | grep $1/bin/qmake | head -n 1)
    mkdir -p build/android-$1
    
    cd build/android-$1
    ${QMAKE} ../../project.pro
    make
    cd ..
}

build android_armv7

