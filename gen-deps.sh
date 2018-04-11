#!/bin/sh -e
rm -fr 3rdparty

cd "$(dirname "$0")"

echo generating dependencies for main workspace
external-tools/bazel-deps.sh generate -r "$(pwd)" -s 3rdparty/workspace.bzl -d dependencies.yaml
echo generating dependencies for tests workspace
external-tools/bazel-deps.sh generate -r "$(pwd)/tests" -s 3rdparty/workspace.bzl -d dependencies.yaml

./format.sh
