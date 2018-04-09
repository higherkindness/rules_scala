#!/bin/sh -e
cd "$(dirname "$0")"/external-tools/buildtools
find $(pwd)/../.. -not \( -path ./external-tools -prune \) -type f \( -iname BUILD -o -iname BUILD.bazel -o -iname WORKSPACE \) -print0 \
    | xargs -0 bazel run buildifier -- -showlog "$@"
