#!/bin/bash -e
RUNPATH="${TEST_SRCDIR-$0.runfiles}"/%workspace%
WORKSPACE_ROOT="${1:-$BUILD_WORKSPACE_DIRECTORY}"

while read original formatted; do
    if ! cmp -s "$RUNPATH/$original" "$RUNPATH/$formatted"; then
        echo $original
        if [ -z "$WORKSPACE_ROOT" ]; then
            diff "$RUNPATH/$original" "$RUNPATH/$formatted" || true
            EXIT=1
        else
            cp "$RUNPATH/$formatted" "$WORKSPACE_ROOT/$original"
        fi
    fi
done < "$RUNPATH"/%manifest%

exit $EXIT
