# Contributing guidelines

Contributions should follow the [principals](../README.md#principals) of rules_scala_annex.

## Documentation

To generate the [Stardoc](https://github.com/bazelbuild/skydoc),

```
$ ./gen-docs.sh
```

## Formatting

[Buildifier](https://github.com/bazelbuild/buildtools/blob/master/buildifier) is used to format Skylark files,
and [Scalafmt](https://scalameta.org/scalafmt/) is used to format Scala files. To run them,

```
$ ./setup-tools.sh # first time
$ ./format.sh
```

## Maven deps

[Bazel-deps](https://github.com/johnynek/bazel-deps) is used to generate maven deps. If you need to change
dependencies, modify dependencies.yaml and

```
$ ./setup-tools.sh # first time
$ ./gen-deps.sh
```

## Tests

Tests are bash shell scripts that may be run individually or together.
rules_scala_annex is tested on Ubuntu and OS X for the most recent thee minor versions of Bazel.

```
$ # runs all tests
$ ./test.sh
```

```
$ # runs all tests in tests/dependencies/
$ ./test.sh tests/dependencies/
```
