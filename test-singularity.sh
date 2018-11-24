#!/bin/sh -e

sha=0ddc53be490bfd068162bcf29a15d5c5183af247
url="https://github.com/andyscott/singularity/archive/$sha.tar.gz"
location="singularity"
if [ ! -d "$location" ]; then
  mkdir -p "$location"
  curl -L "$url" | tar zxf - --strip-components=1 -C "$location"
fi

rules_scala_annex=$(pwd)
(
    cd "$location" && \
    bazel test \
      --announce_rc \
      --disk_cache="$rules_scala_annex/.bazel_cache" \
      --override_repository=rules_scala_annex="$rules_scala_annex" \
      --config=quick ...
)