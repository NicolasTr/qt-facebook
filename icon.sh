#!/bin/bash -ex

DIR=$(pwd)
cd /tmp

sudo apt-get install -y imagemagick librsvg2-bin

wget -c http://upload.wikimedia.org/wikipedia/en/7/75/Qt-logo.svg -O ${DIR}/Qt-logo.svg
convert ${DIR}/Qt-logo.svg -resize 859x1024 Qt-logo-859x1024.png
convert Qt-logo-859x1024.png -background transparent -gravity center -extent 1024x1024 Qt-logo-1024x1024.png

wget -c http://upload.wikimedia.org/wikipedia/commons/c/c2/F_icon.svg -O ${DIR}/Facebook-logo.svg
convert ${DIR}/Facebook-logo.svg -resize 384x384 Facebook-logo-384x384.png

convert Qt-logo-1024x1024.png Facebook-logo-384x384.png -geometry +640+640 -composite ${DIR}/icon-1024x1024.png
convert ${DIR}/icon-1024x1024.png -resize 128x128 ${DIR}/icon-128x128.png
