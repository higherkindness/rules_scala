#!/bin/bash -e

#
# Reformats various files (.bzl, .scala) throughout the project
#

set -o pipefail
cd "$(dirname "$0")/.."

. ./scripts/prepare-path.sh --force

if [ "$1" != check ]; then
    bazel build $(bazel query 'kind("scala_format_test", //...)')
    bazel query 'kind("scala_format_test", //...)' --output package | while read package; do bazel-bin/"$package"/*-format .; done
else
    bazel query 'kind("scala_format_test", //...)' | xargs bazel test
fi

if [ "$1" != check ]; then
    bazel run buildifier
else
    bazel run buildifier_check
fi
