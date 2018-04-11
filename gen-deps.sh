#!/bin/sh -e
rm -fr 3rdparty

cd "$(dirname "$0")"

external-tools/bazel-deps.sh generate -r "$(pwd)" -s 3rdparty/workspace.bzl -d dependencies.yaml

./format.sh
