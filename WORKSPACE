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
    sha256 = "0963c6ae20340ce41f225a99cacbcba8422cebe4f82937f3d9fa3f5dd7ae7342",
    strip_prefix = "protobuf-9f604ac5043e9ab127b99420e957504f2149adbe",
    urls = ["https://github.com/google/protobuf/archive/9f604ac5043e9ab127b99420e957504f2149adbe.zip"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

http_archive(
    name = "rules_jvm_external",
    sha256 = "55e8d3951647ae3dffde22b4f7f8dee11b3f70f3f89424713debd7076197eaca",
    strip_prefix = "rules_jvm_external-2.0.1",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/2.0.1.zip",
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
