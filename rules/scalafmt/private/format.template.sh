#!/bin/bash -e
RUNPATH="${TEST_SRCDIR-$0.runfiles}"/%workspace%
WORKSPACE_ROOT="${1:-$BUILD_WORKSPACE_DIRECTORY}"

if [ -f "$RUNPATH"/%manifest% ]; then
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
else
    NONDEFAULTPATH=(${RUNPATH//bin/ })
    NONDEFAULTPATH="${NONDEFAULTPATH[0]}"bin
    while read original formatted; do
        if ! cmp -s "$WORKSPACE_ROOT/$original" "$NONDEFAULTPATH/$formatted"; then
            echo $original
            cp "$NONDEFAULTPATH/$formatted" "$WORKSPACE_ROOT/$original"
        fi
    done < "$NONDEFAULTPATH"/%manifest%
fi

exit $EXIT
