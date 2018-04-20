#!/bin/bash -e
RUNPATH="${TEST_SRCDIR-$0.runfiles}"/%workspace%

while read original formatted; do
    if ! cmp -s "$RUNPATH/$original" "$RUNPATH/$formatted"; then
        echo $original
        if [ -z "$1" ]; then
            diff "$RUNPATH/$original" "$RUNPATH/$formatted" || true
            EXIT=1
        else
            cp "$RUNPATH/$formatted" "$1/$original"
        fi
    fi
done < "$RUNPATH"/%manifest%

exit $EXIT
