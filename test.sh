#!/bin/bash -e
set -o pipefail
cd "$(dirname "$0")"

find tests -name test -type f | sort | while read f; do
    "$f"
    echo
done

trap echo ERR
