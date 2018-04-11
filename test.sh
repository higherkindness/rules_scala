#!/bin/bash

#
# Test script runner.
#
# Test scripts are loosely modeled after SBT's scripted scripts
# https://www.scala-sbt.org/1.0/docs/Testing-sbt-plugins.html
#

set -a

if [ -z "$1" ]; then
    location=.
else
    location=$1
fi

echo $location
location="${location##/}"
echo $location
location="${location##tests/}"
echo $location
cd tests

for file in $(find $location -name 'test' | sort); do

    echo ":::"
    echo "  test file: $file"
    echo ":::"

    extras=()
    test_dir=$(dirname $file)
    test_dir=${test_dir#./}
    rc_file="$test_dir/bazel.rc"
    if [ -f "$rc_file" ]; then
        extras+=("--bazelrc=$rc_file")
    fi

    while IFS= read -r line; do
        if [[ $line == ">"* ]]; then
            echo $line

            IFS=$'\n' args=( $(xargs -n1 <<< "${line##>}") )

            for i in "${!args[@]}"; do
                if [[ ${args[$i]} == :* ]]; then
                    args[$i]="//$test_dir${args[$i]}"
                fi
                args[$i]=${args[$i]//\\/\\\\}
            done

            set -- "${args[@]}"

            echo "= $1 $extras ${@:2}"
            echo
            eval "$1 $extras ${@:2}"

            if [ $? -ne 0 ]; then
                echo "Command failed!"
                exit -1
            fi

        elif [[ $line == "->"* ]]; then
            echo $line

            IFS=$'\n' args=( $(xargs -n1 <<< "${line##->}") )

            for i in "${!args[@]}"; do
                if [[ ${args[$i]} == :* ]]; then
                    args[$i]="//$test_dir${args[$i]}"
                fi
                args[$i]=${args[$i]//\\/\\\\}
            done

            set -- "${args[@]}"

            echo "= $1 $extras ${@:2}"
            echo
            eval "$1 $extras ${@:2}"

            if [ $? -eq 0 ]; then
                echo "Expected command to fail!"
                exit -1
            fi
        fi

    done < $file
done

echo "Testing success!"
