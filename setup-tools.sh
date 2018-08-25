#!/bin/bash -e
cd "$(dirname "$0")"

BAZEL_OPTS=(
    --disk_cache=../../.bazel_cache
    --experimental_strict_action_env
)
mkdir -p .bazel_cache

rm -fr external-tools/buildtools

mkdir -p external-tools/buildtools
echo Downloading buildtools
curl -L -sS https://github.com/bazelbuild/buildtools/archive/a8cd34f034f2ae1e206eec896cf12d38a0cb26fb.tar.gz | tar zxf - --strip 1 -C external-tools/buildtools
echo Building buildifier
(cd external-tools/buildtools; bazel run "${BAZEL_OPTS[@]}" --script_path=../buildifier.sh buildifier)

if [ "$1" != '--skip-deps' ]; then
    rm -fr external-tools/bazel-deps

    mkdir -p external-tools/bazel-deps
    echo Downloading bazel-deps
    # TODO: move back to johnynek/bazel-deps when it supports scala_import_external
    curl -L -sS https://github.com/lucidsoftware/bazel-deps/archive/2b1f550f6a6ececdda4233a47b8429b9f98826f1.tar.gz | tar zxf - --strip 1 -C external-tools/bazel-deps

    echo Building bazel-deps
    (cd external-tools/bazel-deps; bazel run "${BAZEL_OPTS[@]}" --script_path=../bazel-deps.sh parse)
fi
