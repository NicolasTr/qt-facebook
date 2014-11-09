#!/bin/bash -ex
mkdir -p vendor && cd vendor

ANDROID_NDK_VERSION=r9d

wget -c http://dl.google.com/android/ndk/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.tar.bz2 -O android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.tar.bz2
tar xf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.tar.bz2 --no-same-owner
mv android-ndk-${ANDROID_NDK_VERSION} android-ndk
