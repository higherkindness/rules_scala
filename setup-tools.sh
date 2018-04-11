#!/bin/sh -e
cd "$(dirname "$0")"

rm -fr external-tools/buildtools

mkdir -p external-tools/buildtools
echo Downloading buildtools
curl -L -sS https://github.com/bazelbuild/buildtools/archive/a8cd34f034f2ae1e206eec896cf12d38a0cb26fb.tar.gz | tar zxf - --strip 1 -C external-tools/buildtools
echo Building buildifier
(cd external-tools/buildtools; bazel run --script_path=../buildifier.sh buildifier)

rm -fr external-tools/bazel-deps

mkdir -p external-tools/bazel-deps
echo Downloading bazel-deps
curl -L -sS https://github.com/johnynek/bazel-deps/archive/529298cd9af9b7dfcb225fd0f4f271d4da869acc.tar.gz | tar zxf - --strip 1 -C external-tools/bazel-deps
echo Building bazel-deps
(cd external-tools/bazel-deps; bazel run --script_path=../bazel-deps.sh parse)

PACKAGES="$(find -L external-tools -iname BUILD -o -iname BUILD.bazel | xargs dirname | tr '\n' , | sed 's/,$//')"

if [ ! -z "$PACKAGES" ]; then
  echo Updating tools/bazel-external-tools.rc
  (
    echo '# generated';
    echo build "--deleted_packages=$PACKAGES"
    echo query "--deleted_packages=$PACKAGES"
    echo test "--delete_packages=$PACKAGES"
  ) > tools/bazel-external-tools.rc
fi
