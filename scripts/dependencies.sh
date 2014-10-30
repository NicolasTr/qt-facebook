#!/bin/bash -ex

########################################################################################################################
# Android NDK
########################################################################################################################

ANDROID_NDK_VERSION=r9d

wget -c http://dl.google.com/android/ndk/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.tar.bz2 -O android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.tar.bz2
tar xf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.tar.bz2 --no-same-owner
mv android-ndk-${ANDROID_NDK_VERSION} android-ndk

########################################################################################################################
# Android SDK
########################################################################################################################

ANDROID_SDK_VERSION=r23.0.2
ANDROID_API_LEVEL=19
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
#install-android-package sys-img-x86-android-${ANDROID_API_LEVEL}

########################################################################################################################
# Qt
########################################################################################################################

QT_VERSION=5.3.2
QT_VERSION_SHORT=$(echo ${QT_VERSION} | sed -E "s/[.][0-9]+$//g")

wget -c http://download.qt-project.org/official_releases/qt/${QT_VERSION_SHORT}/${QT_VERSION}/qt-opensource-linux-x64-android-${QT_VERSION}.run \
     -O qt-opensource-linux-x64-android-${QT_VERSION}.run
chmod +x qt-opensource-linux-x64-android-${QT_VERSION}.run

# Start the display
Xvfb :1 -screen 0 1024x768x8 & 
sleep 3
export DISPLAY=':1'

# Start the installer
qt-opensource-linux-x64-android-${QT_VERSION}.run & 

# Go through it
sleep 3 \
    && xdotool key Return && sleep 10 \
    && xdotool key Return && sleep 1 \
    && xdotool key Down && sleep 1 \
    && xdotool key space && sleep 2 \
    && xdotool key Return && sleep 1 \
    && xdotool key Tab && sleep 1 \
    && xdotool key Tab && sleep 1 \
    && xdotool key space && sleep 1 \
    && xdotool key Tab && sleep 1 \
    && xdotool key Tab && sleep 1 \
    && xdotool key Return && sleep 1 \
    && xdotool key Tab && sleep 1 \
    && xdotool key Tab && sleep 1 \
    && xdotool key Return && sleep 1 \
    && while ps | grep qt-opensource > /dev/null; do sleep 1; xdotool key alt+f; printf "."; done \
    && sleep 3 \
    && killall qtcreator || true

rm -rf Qt
if [ -d /opt/Qt${QT_VERSION} ]
then
    ln -f -s /opt/Qt${QT_VERSION} Qt
else
    ln -f -s ~/Qt${QT_VERSION} Qt 
fi
