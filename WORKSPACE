workspace(name = "rules_scala_annex")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//rules/common:private/utils.bzl", "require_bazel_version")

require_bazel_version("0.11.0")

http_archive(
    name = "com_google_protobuf",
    sha256 = "7404d040865a031e80c2810cd9453eafefb2bbbf5f5f9a282b1d071d8e12c4bf",
    strip_prefix = "protobuf-3.5.2",
    urls = ["https://github.com/google/protobuf/archive/v3.5.2.zip"],
)

load("//rules/scala:workspace.bzl", "annex_scala_repositories", "annex_scala_register_toolchains")

annex_scala_repositories()

annex_scala_register_toolchains()

load("//rules/scalafmt:workspace.bzl", "annex_scalafmt_repositories", "scalafmt_default_config")

annex_scalafmt_repositories()

scalafmt_default_config(".scalafmt.conf")

load(
    "//rules/scala_proto:workspace.bzl",
    "scala_proto_repositories",
    "scala_proto_register_toolchains",
)

scala_proto_repositories()

scala_proto_register_toolchains()
