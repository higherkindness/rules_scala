# higherkindness/rules_scala

[![Build Status](https://api.travis-ci.org/higherkindness/rules_scala.svg?branch=master)](https://travis-ci.org/higherkindness/rules_scala)

`higherkindness/rules_scala` evolved, in part, from the need for Bazel adoption support for large, monorepo Scala projects.
Bazel is wonderful because it makes use of parallelism and caching to vastly improve build times. However, to see these benefits, a project must first be broken down into
tiny packages and make use of fine-grained dependencies. This is not always a realistic short-term goal for large, monorepo Scala projects.

`higherkindness/rules_scala` allows for the optional use of Zinc incremental compilation to provide a stepping stone for these projects as they migrate to Bazel.

`higherkindness/rules_scala` is written with maintainability and accessibility in mind. It aims to facilitate the transition to Bazel, and to satisfy use cases throughout the Scala ecosystem.

## Principles

1. Support the breadth of the Scala ecosystem.
2. Follow Bazel best practices.
3. Be accessible and maintainable.
4. Have high-quality documentation.

If the right design principles are kept, implementing additional features should be simple and straightforward.

## Features

* Simple Core API
  * [scala_library](docs/stardoc/scala.md#scala_library)
  * [scala_binary](docs/stardoc/scala.md#scala_binary)
  * [scala_test](docs/stardoc/scala.md#scala_test)
  * [scala_import](docs/stardoc/scala.md#scala_import)
  * [scala_repl](docs/stardoc/scala.md#scala_repl)
* [Works with all sbt-compatible test frameworks](docs/scala.md#tests)
* [Advanced Dependency Detection](docs/scala.md#strict--unused-deps)
  * Errors on indirect and unused dependencies
  * Buildozer suggestions for dependency errors
* [Optional Worker strategy](docs/scala.md#workers)
* [Optional Zinc-based stateful incremental compilation](docs/stateful.md#stateful-compilation)
* [Scalafmt](docs/scalafmt.md#scalafmt)
* ScalaPB
  * [scala_proto_library](docs/stardoc/scala_proto.md#scala_proto_library)
  * [scala_proto_toolchain](docs/stardoc/scala_proto.md#scala_proto_toolchain)
* Seamless integration with the [Bazel IntelliJ plugin](https://github.com/bazelbuild/intellij)
* [Customizable rules](docs/newdocs/phases.md#customizing-the-core-rules)
* [Multiple Scala versions in one build](docs/newdocs/scala_versions.md#specifying-the-scala-version-to-use)
* [Optimal handling of macros and ijars](docs/newdocs/macros.md#macros-and-ijars)
* [Pass flags to Zinc compiler](docs/newdocs/zinc_flags.md)

## Usage

WORKSPACE

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Load rules scala annex
rules_scala_annex_commit = "eeefae00b6e12ffd514f49c399f8d0abff7e4182"
rules_scala_annex_sha256 = "7d0bfa327d177ae3258483082b5a2c2dff763aca53a20b07b6b2cc5e866ae9fd"
http_archive(
    name = "rules_scala_annex",
    sha256 = rules_scala_annex_sha256,
    strip_prefix = "rules_scala-{}".format(rules_scala_annex_commit),
    url = "https://github.com/higherkindness/rules_scala/archive/{}.zip".format(rules_scala_annex_commit),
)

http_archive(
    name = "rules_jvm_external",
    sha256 = "515ee5265387b88e4547b34a57393d2bcb1101314bcc5360ec7a482792556f42",
    strip_prefix = "rules_jvm_external-2.1",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/2.1.zip",
)

load("@rules_scala_annex//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")
scala_repositories()
scala_register_toolchains()

# Load bazel skylib and google protobuf
git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.8.0",
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "0963c6ae20340ce41f225a99cacbcba8422cebe4f82937f3d9fa3f5dd7ae7342",
    strip_prefix = "protobuf-9f604ac5043e9ab127b99420e957504f2149adbe",
    urls = ["https://github.com/google/protobuf/archive/9f604ac5043e9ab127b99420e957504f2149adbe.zip"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

# Specify the scala compiler we wish to use; in this case, we'll use the default one specified in rules_scala_annex
bind(
    name = "default_scala",
    actual = "@rules_scala_annex//src/main/scala:zinc_2_12_8",
)
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

* [Differences with bazelbuild/rules_scala](docs/newdocs/diff_rules_scala.md)

For all rules and attributes, see the [Stardoc](docs/stardoc).
