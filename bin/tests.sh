#!/bin/bash

if [ -z "$1" ]; then
    location=.
else
    location=$1
fi

function t_exec() {
    eval "$( $@ \
           > >(t_res=$(cat); typeset -p t_res) 2>&1; \
           t_ret=$?; typeset -p t_ret )"

    echo "$t_res"
    return $t_ret
}

function t_show() {
    echo ""
    echo "---------------------------------------"
    echo "$@"
    echo "---------------------------------------"
    echo ""
}

for file in $(find $location -name 'test' | sort); do
    echo ":::"
    echo "  test file: $file"
    echo ":::"
    while IFS= read -r line; do
        if [[ $line == ">"* ]]; then
            echo $line
            command=${line##>}

            #t_res=$(t_exec $command)
            $command

            if [ $? -ne 0 ]; then
                #t_show "$t_res"
                echo "Command failed!"
                exit -1
            fi
        elif [[ $line == "->"* ]]; then
            echo $line
            command=${line##->}

            #t_res=$(t_exec $command)
            $command

            if [ $? -eq 0 ]; then
                #t_show "$t_res"
                echo "Expected command to fail!"
                exit -1
            fi
        fi

    done < $file
done

echo "Testing success!"
