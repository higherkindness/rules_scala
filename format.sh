#!/bin/sh -e
if [ -e external-tools/buildtools ]; then
    # TODO: disable noisy logging
    (cd external-tools/buildtools; bazel run --script_path=../buildifier buildifier)
fi

find "$(pwd)" -not \( -path ./external-tools -prune \) -type f \( -iname BUILD -o -iname BUILD.bazel -o -iname WORKSPACE \) -print0 \
    | PATH="external-tools:$PATH" xargs -0 buildifier -showlog "$@"
