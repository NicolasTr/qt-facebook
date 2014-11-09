#!/bin/bash -ex

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
./qt-opensource-linux-x64-android-${QT_VERSION}.run & 

# Go through it
sleep 3 \
    && xdotool key Return && sleep 10 \
    && xdotool key ctrl+a && sleep 1 \
    && xdotool type $(pwd)/Qt && sleep 1 \
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
