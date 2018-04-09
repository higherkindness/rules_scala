#!/bin/sh -e
rm -fr 3rdparty

cd "$(dirname "$0")"/external-tools/bazel-deps
bazel run parse -- generate -r "$(realpath ../..)" -s 3rdparty/workspace.bzl -d dependencies.yaml

exec ../../format.sh
