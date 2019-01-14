#!/bin/bash -e

#
# Ensures that the 'bazel' launcher command is on the current path, creating
# a very trivial one that forwards to ./tools/bazel if needed.
#

set -o pipefail
cd "$(dirname "$0")/.."

if [[ ! -z "$__ALREADY_PREPARED_BAZEL_PATH" ]]; then
    echo "prepare-path: bazel already prepared"
elif ([ "$1" = "--force" ] || ! hash bazel >/dev/null 2>&1); then
    echo 'prepare-path: creating one-off bazel launcher'
    path_entry=$(mktemp -d)
    runner="$path_entry/bazel"
    cat > "$runner" <<'EOF'
#!/bin/bash
find_workspace() {
  if [ ! -f WORKSPACE ]; then
    cd ..
    find_workspace
  fi
}
workspace=$(find_workspace; pwd)
# use parent workspace, if needed
if ! [ -f "$workspace/tools/bazel" ]; then
   workspace=$(cd $workspace/..; find_workspace; pwd)
fi
exec "$workspace/tools/bazel" "$@"
EOF
    chmod +x "$runner"
    export __ALREADY_PREPARED_BAZEL_PATH=1
    export PATH=$path_entry:$PATH
else
    echo 'prepare-path: using host bazel launcher'
fi
