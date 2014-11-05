#!/bin/bash -ex

./scripts/dependencies-$(uname | tr '[:upper:]' '[:lower:]').sh
./scripts/dependencies.sh

export FACEBOOK_SDK_VERSION=3.20.0
cd vendor
git clone --branch sdk-version-${FACEBOOK_SDK_VERSION} https://github.com/facebook/facebook-android-sdk.git
git clone --branch sdk-version-${FACEBOOK_SDK_VERSION} https://github.com/facebook/facebook-ios-sdk.git
./android-sdk/tools/android update project --subprojects --target android-9 --path facebook-android-sdk/facebook
cd ..
