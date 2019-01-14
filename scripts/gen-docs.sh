#!/bin/bash

#
# Regenerates stardoc for the rules
#

cd "$(dirname "$0")/.."
set -x

rm -fr docs/stardoc
mkdir -p docs/stardoc

bazel build rules:docs
tar xf "$(bazel info bazel-bin)/rules/docs.tar" -C docs/stardoc
find docs/stardoc -size 0 -print0 | xargs -0 rm --
