#!/bin/bash -ex

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p vendor
cd vendor

${SCRIPTS_DIR}/install-ndk.sh
${SCRIPTS_DIR}/install-sdk.sh
${SCRIPTS_DIR}/install-qt.sh
