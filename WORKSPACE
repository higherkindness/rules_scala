workspace(name = "rules_scala_annex")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
    name = "io_bazel",
    sha256 = "f44ad96857209fe76d7321185d1b9ad6861a469752432ffaccaf838858708cdf",
    strip_prefix = "bazel-defd737761be2b154908646121de47c30434ed51",
    urls = ["https://github.com/bazelbuild/bazel/archive/defd737761be2b154908646121de47c30434ed51.zip"],
)

http_archive(
    name = "io_bazel_skydoc",
    sha256 = "4e9bd9ef65af54dedd997b408fa26c2e70c30ee8e078bcc1b51a33cf7d7f9d7e",
    strip_prefix = "skydoc-77e5399258f6d91417d23634fce97d73b40cf337",
    urls = ["https://github.com/bazelbuild/skydoc/archive/77e5399258f6d91417d23634fce97d73b40cf337.zip"],
)

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.6.0",
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "2c8f8614fb1be709d68abaab6b4791682aa7db2048012dd4642d3a50b4f67cb3",
    strip_prefix = "protobuf-0038ff49af882463c2af9049356eed7df45c3e8e",
    urls = ["https://github.com/google/protobuf/archive/0038ff49af882463c2af9049356eed7df45c3e8e.zip"],
)

http_archive(
    name = "rules_jvm_external",
    sha256 = "63a9162eb8b530da76453857bd3404db8852080976b93f237577f8000287e73d",
    strip_prefix = "rules_jvm_external-1.3",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/1.3.zip",
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
