#!/bin/bash -e
set -o pipefail
cd "$(dirname "$0")"

if [ "$1" != check ]; then
    bazel build $(bazel query 'kind("annex_scala_format_test", //...)')
    bazel query 'kind("annex_scala_format_test", //...)' --output package | while read package; do bazel-bin/"$package"/*-format .; done
else
    bazel query 'kind("annex_scala_format_test", //...)' | xargs bazel test
fi

[ "$1" != check ] || BUILDIFIER_ARGS=-mode=check

find $(pwd) -not \( -path $(pwd)/external-tools -prune \) -type f \( -iname BUILD -o -iname BUILD.bazel -o -iname WORKSPACE \) -print0 \
    | xargs -0 external-tools/buildifier.sh -showlog $BUILDIFIER_ARGS

find $(pwd) -not \( -path $(pwd)/external-tools -prune \) -type f -iname "*.bzl" -not -path $(pwd)/rules/external.bzl -not -path $(pwd)/rules/bazel/jvm_external.bzl -print0 \
    | xargs -0 external-tools/buildifier.sh -showlog --type=bzl $BUILDIFIER_ARGS
