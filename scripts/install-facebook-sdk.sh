#!/bin/bash -ex
mkdir -p vendor && cd vendor

export FACEBOOK_SDK_VERSION=3.20.0

git clone --branch sdk-version-${FACEBOOK_SDK_VERSION} https://github.com/facebook/facebook-ios-sdk.git

git clone --branch sdk-version-${FACEBOOK_SDK_VERSION} https://github.com/facebook/facebook-android-sdk.git
./android-sdk/tools/android update project --subprojects --target android-9 --path facebook-android-sdk/facebook

