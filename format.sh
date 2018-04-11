#!/bin/sh -e
cd "$(dirname "$0")"
find $(pwd) -not \( -path $(pwd)/external-tools -prune \) -type f \( -iname BUILD -o -iname BUILD.bazel -o -iname WORKSPACE \) -print0 \
    | xargs -0r external-tools/buildifier.sh -showlog "$@"
