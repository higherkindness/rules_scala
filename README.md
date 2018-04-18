# Bazel Scala Annex

[![Build Status](https://travis-ci.org/andyscott/rules_scala_annex.svg?branch=master)](https://travis-ci.org/andyscott/rules_scala_annex)

The Bazel Scala Annex is a prototyping area for [bazelbuild/rules_scala](https://github.com/bazelbuild/rules_scala) focused on exploring design changes required to support big and challenging feature asks.

At this time there isn't a formal plan on how to incorporate changes upstream other than: we want to!

## Feature list

- [x] Scala cross compilation
- [x] Zinc based backend
- [ ] Bloop based backend
- [ ] testing framework support (**WIP**)
- [x] automatic main method detection
- [x] errors on unused dependencies
- [ ] buildozer suggestions to fix unused dependency errors
- [ ] IntelliJ support
- [ ] tests for IntelliJ support
- [x] scalafmt support

### rules_scala compatibility

- [x] scala_library (partial)
- [x] scala_macro_library (partial)
- [x] scala_binary (partial)
- [x] scala_import (partial)
- [ ] scala_test
- [ ] scala_test_suite
- [ ] scala_library_suite
- [ ] thrift_library
- [ ] scalapb_proto_library

## Options

#### Verbose Scala worker output
Add `--worker_extra_flag=ScalaCompile=--verbose` to your build options. The worker will print a formatted version of all inputs being passed from Bazel.

```
env:
  isWorker            : true
  extraFlags          : List(
    --verbose)
options:
  verbose             : true,
  outputJar           : bazel-out/darwin-fastbuild/bin/tests/strategy/worker_extra_flag/library/bin/2.11.0.jar,
  outputDir           : bazel-out/darwin-fastbuild/bin/tests/strategy/worker_extra_flag/library/classes/2.11.0,
  scalaVersion        : 2.11.0,
  compilerClasspath   : List(
    external/org_scala_lang_scala_compiler_2_11_0/jar/scala-compiler-2.11.0.jar
    external/org_scala_lang_scala_reflect_2_11_0/jar/scala-reflect-2.11.0.jar
    external/org_scala_lang_scala_library_2_11_0/jar/scala-library-2.11.0.jar),
  compilerBridge      : bazel-out/darwin-fastbuild/bin/external/scalas/compiler-bridge_scala_2_11_0.jar,
  pluginsClasspath    : Nil,
  sources             : List(
    tests/strategy/worker_extra_flag/code.scala),
  compilationClasspath: Nil,
  allowedClasspath    : Nil,
  testOptions         : Some(TestOptions(List()))
```

## Usage

Don't.

Eventually (we hope) useful and proven functionality will wind up in [bazelbuild/rules_scala](https://github.com/bazelbuild/rules_scala). Use rules_scala.

### WORKSPACE

```python
http_archive(
  name = "rules_scala_annex",
  sha256 = "<hash>",
  strip_prefix = "rules_scala_annex-<commit>",
  url = "https://github.com/andyscott/rules_scala_annex/archive/<commit>.zip",
)

load("@rules_scala_annex//rules:workspace.bzl", "annex_scala_repositories")
annex_scala_repositories()
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
load("@rules_scala_annex//rules:workspace.bzl", "scalafmt_default")
scalafmt_default()
```

And in BUILD

```python
load("@rules_scala_annex//rules:build.bzl", "annex_scala_format_test")
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


