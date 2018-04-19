workspace(name = "rules_scala_annex")

load("//rules:internal/utils.bzl", "require_bazel_version")

require_bazel_version("0.11.0")

http_archive(
    name = "com_google_protobuf",
    sha256 = "7404d040865a031e80c2810cd9453eafefb2bbbf5f5f9a282b1d071d8e12c4bf",
    strip_prefix = "protobuf-3.5.2",
    urls = ["https://github.com/google/protobuf/archive/v3.5.2.zip"],
)

load("//rules:workspace.bzl", "annex_scala_repository", "annex_scala_repositories", "scalafmt_default_config")

annex_scala_repositories()

annex_scala_repository(
    "scala_2_12",
    ("org.scala-lang", "2.12.4"),
    "@compiler_bridge_2_12//jar",
)

register_toolchains("//runners/common:configurable_runner_toolchain")

scalafmt_default_config(".scalafmt.conf")
