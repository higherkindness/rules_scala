# Core usage

* [Workers](#workers)
* [Strict & unused deps](#strict--unused-deps)
* [Tests](#tests)
  * [Example Commands](#example-commands)
  * [Isolation](#isolation)

## Workers

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

The directory is resolved relative to `bazel info execution_root`. It should be relative, so as to be scoped to the
workspace. (It is not safe for use by multiple Bazel instances.) Stateful compilation is currently not compatible with
`--worker_sandboxing`.

## Strict & unused deps

This feature shares concepts with
[Java strict and unused deps](https://blog.bazel.build/2017/06/28/sjd-unused_deps.html). The default toolchain uses two defines (`--define=scala_deps_x=y`):

* `scala_deps_direct` - Require that direct usages of libraries come only from immediately declared deps.
* `scala_deps_used` - Require that any immediate deps are deps are directly used.

Each define may have a value of:

* `error` - Check before creating the jar. (default)
* `off` - Do not check.

Failed checks emit suggested [buildozer](https://github.com/bazelbuild/buildtools/tree/master/buildozer) commands.

You may also toggle deps check via [configure_zinc_scala](configure_zinc_scala.md):

* `deps_direct` - Work the same as `scala_deps_direct`.
* `deps_used` - Work the same as `scala_deps_used`.

## Tests

`scala_test` supports

* Any test framework that implements the [sbt.testing.Framework interface](https://github.com/sbt/test-interface),
e.g. ScalaTest, specs2, ScalaCheck, utest.

* The [`shard_count`](https://docs.bazel.build/versions/master/be/common-definitions.html#common-attributes-tests) attribute.

* The [`--test_filter=<filter_expression>`](https://docs.bazel.build/versions/master/user-manual.html#flag--test_filter) option.
  * The syntax of the `<filter_expression>` varies by test framework, and not all test frameworks support the `test_filter` option at this time.
  * For specs2, `<filter_expression>` simply matches full `.`-separated classnames. Add the test name after the classname to run a single test.
    * example: `my.package.MyTest`
    * example: `my.package.MyTest#some test name here` (remember to escape the whitespace)

* [java_stub_template](https://github.com/bazelbuild/bazel/blob/0.27.0/src/main/java/com/google/devtools/build/lib/bazel/rules/java/java_stub_template.txt) options.

* Additional options: ANSI color codes and verbosity

* Passing arguments to underlying test frameworks

### Example Commands

Run tests
```
$ bazel test :mytest
```

Run a single test (specs2)
```
$ bazel test --test_filter=my.test.Example :mytest
```

Run all tests with Java/Scala package prefix (specs2)
```
$ bazel test --test_filter='my.test.*' :mytest
```

Run a single test from a file that contains multiple tests (specs2)
```
$ bazel test --test_filter='my.test.Example#.*some test name here.*' :mytest
```

Pass arguments to underlying test framework
```
$ bazel test --test_arg=--framework_args='-oDF -l org.scalatest.tags.Slow' :mytest
```

Debug JVM on port 5005
```
$ bazel test --test_arg=--debug=5005 :mytest
```

Limit heap space to 1GB
```
$ bazel test --test_arg=--jvm_arg='-Xmx 1G' :mytest
```

Don't use ANSI color codes
```
$ bazel test --test_arg=--color=false
```

Reduce logs
```
$ bazel test --test_arg=--verbosity=LOW
```

Generate local script to run tests
```
$ bazel run --script_path=script :mytest
```

Run tests one at a time and see output as the tests run
```
$ bazel test --test_output=streamed :mytest
```

Stop tests from being cached
```
$ bazel test --nocache_test_results :mytest
```

Run tests multiple times to test stability
```
$ bazel test --runs_per_test=100 :mytest
```

### Isolation

The `isolation` parameter determines how tests are isolated from each other.

* `"none"` (default) - Tests in a shard are run in the same JVM process. This is fastest.
* `"classloader"` - Each test is run in a separate classloader. This protects against most global state. Any deps listed `shared_deps` do not have their classes reloaded.
* `"process"` - Each test runs in a new JVM process. This protects against global state and memory leaks. `jvm_flags` applies to both the parent process and the subprocess.
JVM flags added via `--test_arg=` apply only to the parent, unless `--test_arg=--subprocess_arg=` is used, e.g. `--test_arg=--subprocess_arg=--debug=5005`.
