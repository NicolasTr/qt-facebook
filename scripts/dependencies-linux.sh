#!/bin/bash -ex

########################################################################################################################
# Linux
########################################################################################################################

sudo apt-get update
sudo apt-get install -y wget python-software-properties build-essential libgd2-xpm ia32-libs ia32-libs-multiarch

# Java
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java7-installer ant

# To install qt
sudo apt-get install -y expect xvfb libxrender-dev libfontconfig-dev xdotool libgl1-mesa-dev psmisc

########################################################################################################################
# Android NDK
########################################################################################################################

wget -c http://dl.google.com/android/ndk/android-ndk-r9d-linux-x86_64.tar.bz2 -O android-ndk-r9d-linux-x86_64.tar.bz2
tar xf android-ndk-r9d-linux-x86_64.tar.bz2 --no-same-owner
mv android-ndk-r9d android-ndk

########################################################################################################################
# Android SDK
########################################################################################################################

wget -c http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz -O android-sdk_r23.0.2-linux.tgz
tar xf android-sdk_r23.0.2-linux.tgz --no-same-owner
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
install-android-package build-tools-21.0.2
install-android-package android-19
install-android-package addon-google_apis-google-19
#install-android-package sys-img-x86-android-19

########################################################################################################################
# Qt
########################################################################################################################

wget -c http://download.qt-project.org/official_releases/qt/5.3/5.3.2/qt-opensource-linux-x64-android-5.3.2.run \
     -O qt-opensource-linux-x64-android-5.3.2.run
chmod +x qt-opensource-linux-x64-android-5.3.2.run

# Start the display
Xvfb :1 -screen 0 1024x768x8 & 
sleep 3
export DISPLAY=':1'

# Start the installer
qt-opensource-linux-x64-android-5.3.2.run & 

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
if [ -d /opt/Qt5.3.2 ]
then
    ln -f -s /opt/Qt5.3.2 Qt
else
    ln -f -s ~/Qt5.3.1 Qt 
fi

