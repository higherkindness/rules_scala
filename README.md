# Bazel Scala Annex

[![Build Status](https://travis-ci.org/andyscott/rules_scala_annex.svg?branch=master)](https://travis-ci.org/andyscott/rules_scala_annex)

The Bazel Scala Annex is a prototyping area for [bazelbuild/rules_scala](https://github.com/bazelbuild/rules_scala) focused on exploring design changes required to support big and challenging feature asks.

At this time there isn't a formal plan on how to incorporate changes upstream other than: we want to!

## Feature list

- [x] Scala cross compilation
- [x] Zinc based backend
- [ ] Bloop based backend
- [x] testing framework support (parity with SBT)
- [x] automatic main method detection
- [x] errors on unused dependencies
- [ ] buildozer suggestions to fix unused dependency errors
- [x] IntelliJ support
- [ ] tests for IntelliJ support
- [x] scalafmt support

### rules_scala compatibility

- [x] scala_library (partial)
- [x] scala_macro_library (partial)
- [x] scala_binary (partial)
- [x] scala_import (partial)
- [x] scala_test
- [ ] scala_test_suite
- [ ] scala_library_suite
- [ ] thrift_library
- [ ] scalapb_proto_library

## Usage

Don't.

Eventually (we hope) useful and proven functionality will wind up in [bazelbuild/rules_scala](https://github.com/bazelbuild/rules_scala). Use rules_scala.

### Basic

WORKSPACE

```python
http_archive(
  name = "rules_scala_annex",
  sha256 = "<hash>",
  strip_prefix = "rules_scala_annex-<commit>",
  url = "https://github.com/andyscott/rules_scala_annex/archive/<commit>.zip",
)

load("@rules_scala_annex//rules/scala:workspace.bzl", "annex_scala_repositories")
annex_scala_repositories()

# Add a @scala repo, which is the default scala provider used by annex_scala_*
annex_scala_repository("scala", ("org.scala-lang", "2.12.4"), "@compiler_bridge_2_12//:src")
```

BUILD

```python
load("@rules_scala_annex//rules:scala.bzl", "annex_scala_library")

annex_scala_libray(
  name = "example",
  src = glob(["**/*.scala"])
)
```

### Tests

annex_scala_test supports

* Any test framework that implements the [sbt.testing.Framework interface](https://github.com/sbt/test-interface),
e.g. ScalaTest, specs2, ScalaCheck, utest.

* The [`shard_count`](https://docs.bazel.build/versions/master/be/common-definitions.html#common-attributes-tests) attribute.

* The [`--test_filter`](https://docs.bazel.build/versions/master/user-manual.html#flag--test_filter) option.

* [java_stub_template](https://github.com/bazelbuild/bazel/blob/0.12.0/src/main/java/com/google/devtools/build/lib/bazel/rules/java/java_stub_template.txt) options.

* Additional options: ANSI color codes and verbosity

* TODO: pass arguments to underlying test frameworks

```
# Run tests
$ bazel test :mytest

# Run a single test
$ bazel test --test_filter=my.test.Example :mytest

# Run all tests with Java/Scala package prefix
$ bazel test --test_filter='my.test.*' :mytest

# Debug JVM on port 5005
$ bazel test --test_arg=--debug=5005 :mytest

# Limit heap space to 1GB
$ bazel test --test_arg=--jvm_arg='-Xmx 1G' :mytest

# Don't use ANSI color codes
$ bazel test --test_arg=--color=false

# Reduce logs
$ bazel test --test_arg=--verbosity=LOW

# Generate local script to run tests
$ bazel run --script_path=script :mytest
```

### Scalafmt

Create .scalafmt.conf at the repo root (may be empty). And add to the WORKSPACE

```python
load("@rules_scala_annex//rules/scalafmt:workspace.bzl", "scalafmt_default")
scalafmt_default()
```

And in BUILD

```python
load("@rules_scala_annex//rules:scalafmt.bzl", "annex_scala_format_test")
annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
```

```
# format files
$ bazel run :format "$(bazel info | grep workspace: | cut -d' ' -f2)"
# check format
$ bazel test :format
```

### Stateful compilation

Beyond the normal per-target incremental compilation, [Zinc](https://github.com/sbt/zinc) can achieve even finer-grained
compilation by reusing dependency information collected on previous runs.

Stateful compilers like Zinc [operate outside](https://groups.google.com/forum/#!topic/bazel-discuss/3iUy5jxS3S0) the
Bazel paradigm, and Bazel cannot enforce correctness. Technically, this caveat applies to all worker strategies:
performance is improving by maintaining state, but improper state may be shared across actions. In Zinc's case, the risk
is higher, because the sharing is (intentionally) aggressive.

To enable Zinc's stateful compilation, add `--worker_extra_flag=ScalaCompile=--persistent_dir=~/.cache/bazel-zinc`.

## Contributing

#### Buildifier

[Buildifier](https://github.com/bazelbuild/buildtools/blob/master/buildifier) is used to format Skylark files. To run
it,

```
$ ./setup-tools.sh # first time
$ ./format.sh
```

#### Maven deps

[Bazel-deps](https://github.com/johnynek/bazel-deps) is used to generate maven deps. If you need to change
dependencies, modify dependencies.yaml and

```
$ ./setup-tools.sh # first time
$ ./gen-deps.sh
```

#### Tests

```
$ # runs all tests
$ ./test.sh
```

```
$ # runs all tests in tests/dependencies/
$ ./test.sh tests/dependencies/
```
