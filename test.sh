#!/bin/bash -e
set -o pipefail
cd "$(dirname "$0")"

find tests -name test -type f | sort | while read f; do
    echo running ${f#"tests/"}...
    output=$($f 2>&1) || ( echo "$output" && exit 1 )
done

trap echo ERR
