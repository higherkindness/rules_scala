workspace(name = "rules_scala_annex")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

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

load("//rules/scala:workspace.bzl", "scala_repositories", "scala_register_toolchains")

scala_repositories()

scala_register_toolchains()

load("//rules/scalafmt:workspace.bzl", "scalafmt_repositories", "scalafmt_default_config")

scalafmt_repositories()

scalafmt_default_config(".scalafmt.conf")

load(
    "//rules/scala_proto:workspace.bzl",
    "scala_proto_repositories",
    "scala_proto_register_toolchains",
)

scala_proto_repositories()

scala_proto_register_toolchains()
