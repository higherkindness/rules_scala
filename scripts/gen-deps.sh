#!/bin/sh -e

#
# Regenerates the 3rdparty dependency directories using bazel-deps tools
#

cd "$(dirname "$0")/.."

echo generating dependencies for tests workspace
rm -fr tests/3rdparty
external-tools/bazel-deps.sh generate -r "$(pwd)/tests" -s 3rdparty/maven.bzl -d dependencies.yaml

./scripts/format.sh
