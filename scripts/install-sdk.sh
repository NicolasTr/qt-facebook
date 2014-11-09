#!/bin/bash -ex

ANDROID_SDK_VERSION=r23.0.2
ANDROID_API_LEVEL=18
ANDROID_BUILD_TOOLS_VERSION=21.0.2

wget -c http://dl.google.com/android/android-sdk_${ANDROID_SDK_VERSION}-linux.tgz -O android-sdk_${ANDROID_SDK_VERSION}-linux.tgz
tar xf android-sdk_${ANDROID_SDK_VERSION}-linux.tgz --no-same-owner
mv android-sdk-linux android-sdk

function install-android-package {
        expect -c "
            set timeout -1;
            spawn android-sdk/tools/android update sdk --no-ui --all --filter $1;
            expect {
                \"Do you accept the license\" { exp_send \"y\r\" ; exp_continue }
                eof
            }
        " | tee /tmp/android-sdk-update.txt
        if cat /tmp/android-sdk-update.txt | grep "nothing to install"
        then
            echo "Installation of $1 failed" 1>&2
            exit -1
        fi
}

install-android-package platform-tools
install-android-package build-tools-${ANDROID_BUILD_TOOLS_VERSION}
install-android-package android-${ANDROID_API_LEVEL}
install-android-package addon-google_apis-google-${ANDROID_API_LEVEL}
install-android-package sys-img-x86-android-${ANDROID_API_LEVEL}

install-android-package android-9
install-android-package addon-google_apis-google-9
