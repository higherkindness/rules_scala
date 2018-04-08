#!/bin/sh -e
cd "$(dirname "$0")"

rm -fr external-tools

mkdir -p external-tools/buildtools
echo Downloading buildtools
curl -L -sS https://github.com/bazelbuild/buildtools/archive/a8cd34f034f2ae1e206eec896cf12d38a0cb26fb.tar.gz | tar zxf - --strip 1 -C external-tools/buildtools

PACKAGES="$(find external-tools -iname BUILD -o -iname BUILD.bazel | xargs dirname | tr '\n' ,)"

(
  echo '# generated';
  echo build "--deleted_packages=$PACKAGES"
  echo query "--deleted_packages=$PACKAGES"
  echo test "--delete_packages=$PACKAGES"
) > tools/bazel-external-tools.rc
