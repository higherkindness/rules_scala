#!/bin/sh -e

case "$1" in

    "build")
        bazel build //...
        ;;

    "test")
        ./test.sh
        ;;

    "lint")
        ./setup-tools.sh --skip-deps
        ./format.sh -mode=check
        ;;
    "install-bazel")
        if [[ "${TRAVIS_OS_NAME}" == "osx" ]]; then
            OS=darwin
        else
            sysctl kernel.unprivileged_userns_clone=1
            sudo apt-get update -q
            sudo apt-get install libxml2-utils -y
            OS=linux
        fi
        if [[ $V =~ .*rc[0-9]+.* ]]; then
            PRE_RC=$(expr "$V" : '\([0-9.]*\)rc.*')
            RC_PRC=$(expr "$V" : '[0-9.]*\(rc.*\)')
            URL="https://storage.googleapis.com/bazel/${PRE_RC}/${RC_PRC}/bazel-${V}-installer-${OS}-x86_64.sh"
        else
            URL="https://github.com/bazelbuild/bazel/releases/download/${V}/bazel-${V}-installer-${OS}-x86_64.sh"
        fi
        wget -O install.sh "${URL}"
        chmod +x install.sh
        ./install.sh --user
        rm -f install.sh
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
