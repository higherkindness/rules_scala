workspace(name = "rules_scala_annex")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel",
    sha256 = "148d03ea395901052dc3d8a54bf04c02bb229b20f89d654047b426d56ef5f188",
    strip_prefix = "bazel-6595aefe2b3a755dd0c795e20cbf67f60a56528c",
    urls = ["https://github.com/bazelbuild/bazel/archive/6595aefe2b3a755dd0c795e20cbf67f60a56528c.zip"],
)

http_archive(
    name = "io_bazel_skydoc",
    sha256 = "4e9bd9ef65af54dedd997b408fa26c2e70c30ee8e078bcc1b51a33cf7d7f9d7e",
    strip_prefix = "skydoc-77e5399258f6d91417d23634fce97d73b40cf337",
    urls = ["https://github.com/bazelbuild/skydoc/archive/77e5399258f6d91417d23634fce97d73b40cf337.zip"],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "d54e5372d784ceb365f7d38c3dad7773f73b3b8ebc8fb90d58435a92b6a20256",
    strip_prefix = "bazel-skylib-8cecf885c8bf4c51e82fd6b50b9dd68d2c98f757",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/8cecf885c8bf4c51e82fd6b50b9dd68d2c98f757.zip"],
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "2c8f8614fb1be709d68abaab6b4791682aa7db2048012dd4642d3a50b4f67cb3",
    strip_prefix = "protobuf-0038ff49af882463c2af9049356eed7df45c3e8e",
    urls = ["https://github.com/google/protobuf/archive/0038ff49af882463c2af9049356eed7df45c3e8e.zip"],
)

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

scala_register_toolchains()

load("//rules/scalafmt:workspace.bzl", "scalafmt_default_config", "scalafmt_repositories")

scalafmt_repositories()

scalafmt_default_config(".scalafmt.conf")

load(
    "//rules/scala_proto:workspace.bzl",
    "scala_proto_register_toolchains",
    "scala_proto_repositories",
)

scala_proto_repositories()

scala_proto_register_toolchains()
