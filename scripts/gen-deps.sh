#!/bin/sh -e

#
# Regenerates the external dependencies lock file using rules_jvm_external
#

cd "$(dirname "$0")/.."
echo "$(dirname "$0")/.."

echo "generating dependencies for main workspace"
bazel run @unpinned_annex//:pin
bazel run @unpinned_annex_scalafmt//:pin
bazel run @unpinned_annex_proto//:pin

echo "generating dependencies for tests workspace"
cd "tests"
bazel run @unpinned_annex_test//:pin
