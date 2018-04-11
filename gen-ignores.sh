#!/bin/sh -e

PACKAGES0=$(find -L external-tools -iname BUILD -o -iname BUILD.bazel | xargs -n1 dirname | tr '\n' ,)
PACKAGES1=$(find -L tests -iname BUILD -o -iname BUILD.bazel | xargs -n1 dirname | tr '\n' ,)

if [ ! -z "$PACKAGES1" ] || [ ! -z "$PACKAGES1" ]; then
    echo Updating tools/deleted_packages.rc
    echo '# generated' > tools/deleted_packages.rc
    packages=$PACKAGES0,$PACKAGES1
    (
        echo "build --deleted_packages=$packages"
        echo "query --deleted_packages=$packages"
        echo "test  --deleted_packages=$packages"
    ) >> tools/deleted_packages.rc
fi
