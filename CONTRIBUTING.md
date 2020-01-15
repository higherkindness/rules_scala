# Contributing guidelines

Contributions should follow the [principals](../README.md#principals) of rules_scala_annex.

## Documentation

To generate the [Stardoc](https://github.com/bazelbuild/skydoc),

```
$ ./scripts/gen-docs.sh
```

## Formatting

[Buildifier](https://github.com/bazelbuild/buildtools/blob/master/buildifier) is used to format Skylark files,
and [Scalafmt](https://scalameta.org/scalafmt/) is used to format Scala files. To run them,

```
$ ./scripts/format.sh
```

## Maven deps

[rules_jvm_external](https://github.com/bazelbuild/rules_jvm_external) is used to generate maven deps. If you need to change
dependencies, modify `maven_install` in the following different `workspace.bzl` files

```
rules/scala/workspace.bzl
rules/scala_proto/workspace.bzl
rules/scalafmt/workspace.bzl
tests/workspace.bzl
```
To reference the dependency, use the `name` attribute of the `maven_install` rule as the repository name and the versionless dependency as the target. E.g. `@<maven_install_name>//:<versionless_dependency>`.

For example, if you'd like to add `org.scala-sbt:compiler-interface:1.2.1` as a dependency, simply add it to the `artifacts` list in `maven_install` with the attribute `name = "annex"`, and then refer to it with `@annex//:org_scala_sbt_compiler_interface`.

```
maven_install(
    name = "annex",
    artifacts = [
        "org.scala-sbt:compiler-interface:1.2.1",
    ],
    repositories = [
        "https://repo.maven.apache.org/maven2",
    ],
)
```

## Tests

Tests are bash shell scripts that may be run individually or together.
rules_scala_annex is tested on Ubuntu and OS X for the most recent thee minor versions of Bazel.

```
$ # runs all tests
$ ./scripts/test.sh
```

```
$ # runs all tests in tests/dependencies/
$ ./scripts/test.sh tests/dependencies/
```
