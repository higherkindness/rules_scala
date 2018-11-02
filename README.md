# Bazel Scala Annex

[![Build Status](https://travis-ci.org/andyscott/rules_scala_annex.svg?branch=master)](https://travis-ci.org/andyscott/rules_scala_annex)

## Principles

1. Support the breadth of the Scala ecosystem.
2. Follow Bazel best practices.
3. Be accessible and maintainable.
4. Have high-quality documentation.

If the right design principals are kept, implementing additional features should be simple and straightforward.

## Features

* Basic library and binary rules
* Single deploy jar
* Works with all sbt-compatible test frameworks
* Multiple Scala versions in one build
* Macros
* ijars
* REPL
* Automatic main method detection
* Errors on indirect and unused dependencies
* Buildozer suggestions for dependency erors
* Scalafmt
* ScalaPB
* Worker strategy
* Optional Zinc-based stateful incremental compilation
* IntelliJ Bazel plugin integration

### Differences with rules_scala

* More correctly handles of macros and ijars. See [#445](https://github.com/bazelbuild/rules_scala/issues/445) and [#632](https://github.com/bazelbuild/bazel/issues/632#issuecomment-383318341).
  * Detect missing `macro = True` attribute. See [#366](https://github.com/bazelbuild/rules_scala/issues/366).
* More precisely and straightforwardly detects indirect and unused dependencies, via Zinc. See [#235](https://github.com/bazelbuild/rules_scala/issues/235) and [#335](https://github.com/bazelbuild/rules_scala/issues/335).
* Supports neverlink. See [#213](https://github.com/bazelbuild/rules_scala/issues/213).
* Optionally allows for fine-grained incrementality with stateful Zinc compilation. See [bazel-discuss](https://groups.google.com/forum/#!topic/bazel-discuss/3iUy5jxS3S0) and [#328](https://github.com/bazelbuild/rules_scala/issues/328).
* Does not support intransitive classpaths, matching Java rules. See [#432](https://github.com/bazelbuild/rules_scala/pull/423).
* Tools written in Scala, using bootstrapping rules as necessary.
* Uses [`depset`](https://docs.bazel.build/versions/master/skylark/lib/depset.html) and [`Args`](https://docs.bazel.build/versions/master/skylark/lib/Args.html)
to completely defer expanding transitive dependency lists until execution time.
* Supports many Scala versions: 2.10-2.13, Typelevel, Dotty, and anything else compatible with Zinc's compiler-bridge.
* Allows for multiple Scala versions in the same workspace. See [#80](https://github.com/bazelbuild/rules_scala/issues/80) and [#393](https://github.com/bazelbuild/rules_scala/issues/393).
  * For example, rules_scala_annex tools use Scala 2.12, but that doesn't affect any client projects.
* Robustly supports buildozer recommendations via an aspect.
* Supports for all Scala test frameworks via sbt [test-interface](https://github.com/sbt/test-interface).
* Support test sharding, custom test framework arguments (including options to the JVM itself).
* Supports optional classloader and process-level isolation for tests, similar to sbt's `fork := true`.
* Supports scalafmt.
* Supports Scaladoc. See [#230](https://github.com/bazelbuild/rules_scala/issues/230) and [#256](https://github.com/bazelbuild/rules_scala/issues/256).
* Has consistently formatted code, via buildifier and scalafmt. See [#74](https://github.com/bazelbuild/rules_scala/issues/474).
* Reorganized and simplified file and code structure. Less than 8 KLOC excluding tests and dependency resolutions. (`git ls-files | grep -v '^test\|/maven.bzl$\|*.md' | xargs cat | wc -l`)
* Reorganized Travis CI builds, including better cache reuse.
* Easy dependency managment of internal tools using bazel-deps.
* Tested against three most recent Bazel versions.

## Usage

WORKSPACE

```python
http_archive(
    name = "bazel_skylib",
    sha256 = "c0289fef5237c31e8462042b4cc3bdf831a3d3d135bb4a0d493a5072acecb074",
    strip_prefix = "bazel-skylib-2169ae1c374aab4a09aa90e65efe1a3aad4e279b",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/2169ae1c374aab4a09aa90e65efe1a3aad4e279b.zip"],
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "2c8f8614fb1be709d68abaab6b4791682aa7db2048012dd4642d3a50b4f67cb3",
    strip_prefix = "protobuf-0038ff49af882463c2af9049356eed7df45c3e8e",
    urls = ["https://github.com/google/protobuf/archive/0038ff49af882463c2af9049356eed7df45c3e8e.zip"],
)

http_archive(
  name = "rules_scala_annex",
  sha256 = "<hash>",
  strip_prefix = "rules_scala_annex-<commit>",
  url = "https://github.com/andyscott/rules_scala_annex/archive/<commit>.zip",
)

load("@rules_scala_annex//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repository", "scala_repositories")

scala_repositories()
scala_register_toolchains()

# Add a @scala repo, which is the default scala provider used by scala_*
scala_repository("scala", ("org.scala-lang", "2.12.4"), "@compiler_bridge_2_12//:src")
```

BUILD

```python
load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
  name = "example",
  srcs = glob(["**/*.scala"])
)
```

## Further Documentation

See [contributing guidlines](CONTRIBUTING.md) for help on contributing to this project.

* [Core usage](docs/scala.md)
* [Stateful compilation](docs/stateful.md)
* [Scalamft](docs/scalafmt.md)
