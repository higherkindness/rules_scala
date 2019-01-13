#!/bin/bash -e

#
# Ensures that the 'bazel' launcher command is on the current path, creating
# a very trivial one that forwards to ./tools/bazel if needed.
#

set -o pipefail
cd "$(dirname "$0")"

if ! hash bazel >/dev/null 2>&1; then
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
find_workspace
exec ./tools/bazel "$@"
EOF
    chmod +x "$runner"
    export PATH=$path_entry:$PATH
else
    echo 'prepare-path: using host bazel launcher'
fi
