#!/bin/sh -e
cd "$(dirname "$0")"

echo generating dependencies for main workspace
rm -fr 3rdparty
external-tools/bazel-deps.sh generate -r "$(pwd)" -s 3rdparty/maven.bzl -d dependencies.yaml
external-tools/bazel-deps.sh generate -r "$(pwd)" -s rules/scalafmt/3rdparty/maven.bzl -d rules/scalafmt/dependencies.yaml
external-tools/bazel-deps.sh generate -r "$(pwd)" -s rules/scala_proto/3rdparty/maven.bzl -d rules/scala_proto/dependencies.yaml

echo generating dependencies for tests workspace
rm -fr tests/3rdparty
external-tools/bazel-deps.sh generate -r "$(pwd)/tests" -s 3rdparty/maven.bzl -d dependencies.yaml

./format.sh
