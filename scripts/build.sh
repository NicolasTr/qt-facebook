#!/bin/bash -ex

export ANDROID_NDK_ROOT=$(pwd)/vendor/android-ndk
export ANDROID_SDK_ROOT=$(pwd)/vendor/android-sdk
export QT_ROOT=$(pwd)/vendor/Qt
cd $1

function build {
    QMAKE=$(find ${QT_ROOT} | grep $1/bin/qmake | head -n 1)
    ANDROID_DEPLOY_QT=$(find ${QT_ROOT} | grep $1/bin/androiddeployqt | head -n 1 || true)
    mkdir -p build/$1
    
    cd build/$1
    ${QMAKE} ../../project.pro
    make
    
    DEPLOYMENT_SETTINGS=$(ls -1 | grep "deployment-settings.json" || true)
    if [ -n "${ANDROID_DEPLOY_QT}" ] && [ -n "${DEPLOYMENT_SETTINGS}" ]
    then
        make install INSTALL_ROOT=android
        ${ANDROID_DEPLOY_QT} \
            --input ${DEPLOYMENT_SETTINGS} \
            --output android \
            --release \
            --android-platform android-19  # Should use ${ANDROID_API_LEVEL}
    fi
    cd ../..
}

build android_armv7
build gcc_64

