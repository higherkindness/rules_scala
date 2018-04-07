#!/bin/bash

if [ -z "$1" ]; then
    location=.
else
    location=$1
fi

function check_bazel_command() {
    if [ "$1" != bazel ]; then
        return 1
    fi
    case "$2" in
        build|test)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

for file in $(find $location -name 'test' | sort); do

    echo ":::"
    echo "  test file: $file"
    echo ":::"

    extras=()

    rc_file=$(dirname $file)/bazel.rc
    if [ -f "$rc_file" ]; then
        extras+=("--bazelrc=$rc_file")
    fi

    while IFS= read -r line; do
        if [[ $line == ">"* ]]; then
            echo $line
            set -- ${line##>}
            check_bazel_command $1 $2
            if [ $? -ne 0 ]; then
                echo "$@ is a bad bazel command!"
                continue
            fi
            $1 $extras ${@:2}
            if [ $? -ne 0 ]; then
                echo "Command failed!"
                exit -1
            fi

        elif [[ $line == "->"* ]]; then
            echo $line
            set -- ${line##>}
            check_bazel_command $1 $2
            if [ $? -ne 0 ]; then
                echo "$@ is a bad bazel command!"
                continue
            fi
            $1 $extras ${@:2}
            if [ $? -eq 0 ]; then
                #t_show "$t_res"
                echo "Expected command to fail!"
                exit -1
            fi
        fi

    done < $file
done

echo "Testing success!"
