#!/bin/sh -e
cd "$(dirname "$0")"

find $(pwd) -not \( -path $(pwd)/external-tools -prune \) -type f \( -iname BUILD -o -iname BUILD.bazel -o -iname WORKSPACE \) -print0 \
    | xargs -0 external-tools/buildifier.sh -showlog "$@"

find $(pwd) -not \( -path $(pwd)/external-tools -prune \) -type f -iname "*.bzl" -not -path $(pwd)/rules/external.bzl -not -path $(pwd)/rules/bazel/jvm_external.bzl -print0 \
    | xargs -0 external-tools/buildifier.sh -showlog --type=bzl "$@"
