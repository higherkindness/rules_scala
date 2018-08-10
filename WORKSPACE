workspace(name = "rules_scala_annex")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//rules/common:private/utils.bzl", "require_bazel_version")

require_bazel_version("0.11.0")

http_archive(
    name = "com_google_protobuf",
    sha256 = "d7a221b3d4fb4f05b7473795ccea9e05dab3b8721f6286a95fffbffc2d926f8b",
    strip_prefix = "protobuf-3.6.1",
    urls = ["https://github.com/google/protobuf/archive/v3.6.1.zip"],
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
