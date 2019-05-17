#!/bin/bash -e

#
# Sets up required tools, such as bazel-deps and Bazel's buildtools
#

set -eox pipefail
cd "$(dirname "$0")/.."

. ./scripts/prepare-path.sh --force

STARTUP_BAZEL_OPTS=(
    --bazelrc=../../.bazelrc_shared
)

BAZEL_OPTS=(
    --disk_cache=../../.bazel_cache
    --experimental_strict_action_env
)
mkdir -p .bazel_cache

rm -fr external-tools/buildtools

mkdir -p external-tools/buildtools
echo Downloading buildtools
curl -L -sS https://github.com/bazelbuild/buildtools/archive/6f2bf0da7e7b7c9dadd652ec7698eabb542bd0d7.tar.gz | tar zxf - --strip 1 -C external-tools/buildtools
echo Building buildifier
(cd external-tools/buildtools; bazel "${STARTUP_BAZEL_OPTS}" run "${BAZEL_OPTS[@]}" --script_path=../buildifier.sh buildifier)

