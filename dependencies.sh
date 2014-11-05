#!/bin/bash -ex

./scripts/dependencies-$(uname | tr '[:upper:]' '[:lower:]').sh
./scripts/dependencies.sh

export FACEBOOK_SDK_VERSION=3.20.0
cd vendor
git clone --branch sdk-version-${FACEBOOK_SDK_VERSION} git@github.com:facebook/facebook-android-sdk.git
git clone --branch sdk-version-${FACEBOOK_SDK_VERSION} git@github.com:facebook/facebook-ios-sdk.git
cd ..
