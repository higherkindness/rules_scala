#!/bin/bash

. ./prepare-path.sh

case "$1" in

    "build")
        bazel build --show_progress_rate_limit=2 //...
        ;;

    "build-sans-doc")
        bazel query '//... except(//rules:*)' | xargs bazel build --show_progress_rate_limit=2
        ;;

    "test")
        ./test.sh
        ;;

    "lint")
        ./setup-tools.sh --skip-deps
        ./format.sh check
        ./gen-docs.sh && git diff --exit-code
        ;;
    "")
        echo "command not specified"
        exit 1
        ;;
    *)
        echo "$1 not understood"
        exit 1
        ;;
esac
