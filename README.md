# Bazel Scala Annex

[![Build Status](https://travis-ci.org/andyscott/rules_scala_annex.svg?branch=master)](https://travis-ci.org/andyscott/rules_scala_annex)

The Bazel Scala Annex is a prototyping area for [bazelbuild/rules_scala](https://github.com/bazelbuild/rules_scala) focused on exploring design changes required to support big and challenging feature asks.

Annex strives to (1) follow Bazel best practices, (2) be flexible by building against standard interfaces, and (3) to be as simple and maintainable. If the right design principals are kept, implementing additional features should be simple and straightforward.

At this time there isn't a formal plan on how to incorporate changes upstream other than: we want to!

## Features

### Feature list

- [x] Scala cross compilation
- [x] Zinc based backend
- [ ] Bloop based backend
- [x] testing framework support (parity with SBT)
- [x] REPL
- [x] automatic main method detection
- [x] errors on unused dependencies
- [x] buildozer suggestions to fix unused dependency errors
- [x] IntelliJ support
- [ ] tests for IntelliJ support
- [x] scalafmt support

Additionally, Annex can emulate @io_bazel_rules_scala.

- [x] scala_library (partial)
- [x] scala_macro_library (partial)
- [x] scala_binary (partial)
- [x] scala_import (partial)
- [x] scala_test
- [x] scala_test_suite
- [ ] scala_library_suite
- [ ] thrift_library
- [ ] scalapb_proto_library

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

### Basic

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

### Tests

`scala_test` supports

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

The `isolation` parameter determines how tests are isolated from each other.

* `"none"` (default) - Tests in a shard are run in the same JVM process. This is fastest.
* `"classloader"` - Each test is run in a separate classloader. This protects against most global state. Any deps listed `shared_deps` do not have their classes reloaded.
* `"process"` - Each test runs in a new JVM process. This protects against global state and memory leaks. `jvm_flags` applies to both the parent process and the subprocess.
JVM flags added via `--test_arg=` apply only to the parent, unless `--test_arg=--subprocess_arg=` is used, e.g. `--test_arg=--subprocess_arg=--debug=5005`.

### Scalafmt

Create .scalafmt.conf at the repo root (may be empty). And add to the WORKSPACE

```python
load("@rules_scala_annex//rules/scalafmt:workspace.bzl", "scalafmt_repositories", "scalafmt_default_config")
scalafmt_repositories()
scalafmt_default_config()
```

And in BUILD

```python
load("@rules_scala_annex//rules:scalafmt.bzl", "scala_format_test")
scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
```

```
# check format, with diffs and non-zero exit in case of differences
$ bazel test :format

# format files in-place
$ bazel run :format
```

### Strict & unused deps

This feature shares concepts with
[Java strict and unused deps](https://blog.bazel.build/2017/06/28/sjd-unused_deps.html). The default toolchain uses two defines (`--define=scala_deps_x=y`):

* `scala_deps_direct` - Require that direct usages of libraries come only from immediately declared deps
* `scala_deps_used` - Require that any immediate deps are deps are directly used.

Each define may have a value of:

* `error` - Check before creating the jar.
* `check` - Check when building with --output_group=deps_check. (default)
* `off` - Do not check.

Failed checks emit suggested [buildozer](https://github.com/bazelbuild/buildtools/tree/master/buildozer) commands.


### Workers

To run JVM processes as persistent workers,

```
--strategy=ScalaCheckDeps=worker
--strategy=ScalaCompile=worker
--strategy=SingleJar=worker
```

You may pass additional flags to worker JVMs:

```
--worker_extra_flag=ScalaCompile=--jvm_flag=-Xmx=1g
--worker_extra_flag=ScalaCompile=--jvm_flag=-XX:SoftRefLRUPolicyMSPerMB=50
```

### Stateful compilation

Beyond the normal per-target incremental compilation, [Zinc](https://github.com/sbt/zinc) can achieve even finer-grained
compilation by reusing dependency information collected on previous runs.

Stateful compilers like Zinc [operate outside](https://groups.google.com/forum/#!topic/bazel-discuss/3iUy5jxS3S0) the
Bazel paradigm, and Bazel cannot enforce correctness. Technically, this caveat applies to all worker strategies:
performance is improving by maintaining state, but improper state may be shared across actions. In Zinc's case, the risk
is higher, because the sharing is (intentionally) aggressive.

To enable Zinc's stateful compilation, add

```
--worker_extra_flag=ScalaCompile=--persistent_dir=.bazel-zinc
```

The directory is resolved relative to `bazel info execution_root`. It should be relative, so as to be scoped to the
workspace. (It is not safe for use by multiple Bazel instances.) Stateful compilation is currently not compatible with
`--worker_sandboxing`.

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
