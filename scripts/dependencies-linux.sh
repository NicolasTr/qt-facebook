#!/bin/bash -ex

sudo apt-get update
sudo apt-get install -y wget 

if lsb_release -a | grep 12.04
then
    sudo apt-get install -y python-software-properties
    sudo apt-get install -y build-essential libgd2-xpm ia32-libs ia32-libs-multiarch
else
    sudo apt-get install -y software-properties-common    
    
    sudo dpkg --add-architecture i386
    sudo apt-get update    
    sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
fi

# Java
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java7-installer ant

# To install qt
sudo apt-get install -y expect xvfb libxrender-dev libfontconfig-dev xdotool libgl1-mesa-dev psmisc
