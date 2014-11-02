#!/bin/bash -ex

./scripts/dependencies-$(uname | tr '[:upper:]' '[:lower:]').sh
./scripts/dependencies.sh
