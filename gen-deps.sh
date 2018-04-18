#!/bin/sh -e
cd "$(dirname "$0")"

echo generating dependencies for main workspace
rm -fr 3rdparty
external-tools/bazel-deps.sh generate -r "$(pwd)" -s 3rdparty/workspace.bzl -d dependencies.yaml
external-tools/bazel-deps.sh generate -r "$(pwd)" -s 3rdparty/scalafmt_workspace.bzl -d runners/scalafmt/dependencies.yaml
# TODO: upstream feature for bazel-deps
sed -i '2s!^.*$!load("//rules/bazel:jvm_external.bzl", "java_import_external")\nload("//rules:external.bzl", "scala_import_external")!' 3rdparty/workspace.bzl 3rdparty/scalafmt_workspace.bzl

echo generating dependencies for tests workspace
rm -fr tests/3rdparty
external-tools/bazel-deps.sh generate -r "$(pwd)/tests" -s 3rdparty/workspace.bzl -d dependencies.yaml
# TODO: upstream feature for bazel-deps
sed -i '2s!^.*$!load("@rules_scala_annex//rules/bazel:jvm_external.bzl", "java_import_external")\nload("@rules_scala_annex//rules:external.bzl", "scala_import_external")!' tests/3rdparty/workspace.bzl

./format.sh
