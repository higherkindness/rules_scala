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

* Simple core API modeled after Bazel's Java APIs
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
* [Scalafmt](docs/scalafmt.md#scalafmt) integration
* Protobuf support with ScalaPB
  * [scala_proto_library](docs/stardoc/scala_proto.md#scala_proto_library)
  * [scala_proto_toolchain](docs/stardoc/scala_proto.md#scala_proto_toolchain)
* Seamless integration with the [Bazel IntelliJ plugin](https://github.com/bazelbuild/intellij)
* [Customizable rules](docs/newdocs/phases.md#customizing-the-core-rules)
* [Multiple Scala versions in one build](docs/newdocs/scala_versions.md#specifying-the-scala-version-to-use), including Scala 3 (Dotty).
* [Optimal handling of macros and ijars](docs/newdocs/macros.md#macros-and-ijars)
* [Pass flags to Zinc compiler](docs/newdocs/zinc_flags.md)
* Modern implementation using Bazel's most idiomatic APIs

## Usage

WORKSPACE

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Load rules scala annex
rules_scala_annex_commit = "ae99fcb08bbddfc24fef00d7b13f6c065e1df8d5"
rules_scala_annex_sha256 = "1630fc7ecc7a4ffeabcdef73c7600eab9cf3fd2377db1f69b8ce1927560211ff"
http_archive(
    name = "rules_scala_annex",
    sha256 = rules_scala_annex_sha256,
    strip_prefix = "rules_scala-{}".format(rules_scala_annex_commit),
    url = "https://github.com/higherkindness/rules_scala/archive/{}.zip".format(rules_scala_annex_commit),
)

rules_jvm_external_tag = "2.9"
rules_jvm_external_sha256 = "e5b97a31a3e8feed91636f42e19b11c49487b85e5de2f387c999ea14d77c7f45"
http_archive(
    name = "rules_jvm_external",
    sha256 = rules_jvm_external_sha256,
    strip_prefix = "rules_jvm_external-{}".format(rules_jvm_external_version),
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.zip".format(rules_jvm_external_version),
)

load("@rules_scala_annex//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")
scala_repositories()
load("@annex//:defs.bzl", annex_pinned_maven_install = "pinned_maven_install")
annex_pinned_maven_install()
scala_register_toolchains()

load("@rules_scala_annex//rules/scalafmt:workspace.bzl", "scalafmt_default_config", "scalafmt_repositories")
scalafmt_repositories()
load("@annex_scalafmt//:defs.bzl", annex_scalafmt_pinned_maven_install = "pinned_maven_install")
annex_scalafmt_pinned_maven_install()
scalafmt_default_config()

load("@rules_scala_annex//rules/scala_proto:workspace.bzl", "scala_proto_register_toolchains", "scala_proto_repositories",)
scala_proto_repositories()
load("@annex_proto//:defs.bzl", annex_proto_pinned_maven_install = "pinned_maven_install")
annex_proto_pinned_maven_install()
scala_proto_register_toolchains()

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

For all rules and attributes, see the [Stardoc](docs/stardoc).
