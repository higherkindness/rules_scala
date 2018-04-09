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

## Contributing

#### Buildifier

[Buildifier](https://github.com/bazelbuild/buildtools/blob/master/buildifier) is used to format Skylark files. To run
it,

```
$ ./setup-tools.sh # first time
$ ./format.sh
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


