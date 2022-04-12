workspace(name = "rules_scala_annex")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# skylib

bazel_skylib_tag = "1.0.3"

bazel_skylib_sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c"

http_archive(
    name = "bazel_skylib",
    sha256 = bazel_skylib_sha256,
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{tag}/bazel-skylib-{tag}.tar.gz".format(tag = bazel_skylib_tag),
        "https://github.com/bazelbuild/bazel-skylib/releases/download/{tag}/bazel-skylib-{tag}.tar.gz".format(tag = bazel_skylib_tag),
    ],
)

skydoc_tag = "0.3.0"

skydoc_sha256 = "8762a212cff5f81505a1632630edcfe9adce381479a50a03c968bd2fc217972d"

http_archive(
    name = "io_bazel_skydoc",
    sha256 = skydoc_sha256,
    strip_prefix = "skydoc-{}".format(skydoc_tag),
    url = "https://github.com/bazelbuild/skydoc/archive/{}.zip".format(skydoc_tag),
)

# com_github_bazelbuild_buildtools

buildtools_tag = "0.29.0"

buildtools_sha256 = "05eb52437fb250c7591dd6cbcfd1f9b5b61d85d6b20f04b041e0830dd1ab39b3"

http_archive(
    name = "com_github_bazelbuild_buildtools",
    sha256 = buildtools_sha256,
    strip_prefix = "buildtools-{}".format(buildtools_tag),
    url = "https://github.com/bazelbuild/buildtools/archive/{}.zip".format(buildtools_tag),
)

load("@com_github_bazelbuild_buildtools//buildifier:deps.bzl", "buildifier_dependencies")

buildifier_dependencies()

# io_bazel_rules_go

rules_go_tag = "v0.28.0"

rules_go_sha256 = "8e968b5fcea1d2d64071872b12737bbb5514524ee5f0a4f54f5920266c261acb"

http_archive(
    name = "io_bazel_rules_go",
    sha256 = rules_go_sha256,
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/{tag}/rules_go-{tag}.zip".format(tag = rules_go_tag),
        "https://github.com/bazelbuild/rules_go/releases/download/{tag}/rules_go-{tag}.zip".format(tag = rules_go_tag),
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17")

# protobuf

protobuf_tag = "3.15.8"

protobuf_sha256 = "dd513a79c7d7e45cbaeaf7655289f78fd6b806e52dbbd7018ef4e3cf5cff697a"

http_archive(
    name = "com_google_protobuf",
    sha256 = protobuf_sha256,
    strip_prefix = "protobuf-{}".format(protobuf_tag),
    type = "zip",
    url = "https://github.com/protocolbuffers/protobuf/archive/v{}.zip".format(protobuf_tag),
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

jdk_build_file_content = """
filegroup(
    name = "jdk",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)
filegroup(
    name = "java",
    srcs = ["bin/java"],
    visibility = ["//visibility:public"],
)
"""

http_archive(
    name = "jdk8-linux",
    build_file_content = jdk_build_file_content,
    sha256 = "dd28d6d2cde2b931caf94ac2422a2ad082ea62f0beee3bf7057317c53093de93",
    strip_prefix = "jdk8u212-b03",
    url = "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_linux_hotspot_8u212b03.tar.gz",
)

http_archive(
    name = "jdk8-osx",
    build_file_content = jdk_build_file_content,
    sha256 = "3d80857e1bb44bf4abe6d70ba3bb2aae412794d335abe46b26eb904ab6226fe0",
    strip_prefix = "jdk8u212-b03",
    url = "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_mac_hotspot_8u212b03.tar.gz",
)

rules_jvm_external_tag = "4.2"

http_archive(
    name = "rules_jvm_external",
    sha256 = "cd1a77b7b02e8e008439ca76fd34f5b07aecb8c752961f9640dea15e9e5ba1ca",
    strip_prefix = "rules_jvm_external-{}".format(rules_jvm_external_tag),
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.zip".format(rules_jvm_external_tag),
)

# Scala
load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

load("@annex//:defs.bzl", annex_pinned_maven_install = "pinned_maven_install")

annex_pinned_maven_install()

scala_register_toolchains()

#  Scala 2.12

load("//rules/scala:workspace_2_12.bzl", "scala_2_12_repositories")

scala_2_12_repositories()

load("@annex_2_12//:defs.bzl", annex_2_12_pinned_maven_install = "pinned_maven_install")

annex_2_12_pinned_maven_install()

# Scala 3

load("//rules/scala:workspace_3.bzl", "scala_3_repositories")

scala_3_repositories()

load("@annex_3//:defs.bzl", annex_3_pinned_maven_install = "pinned_maven_install")

annex_3_pinned_maven_install()

# Scala fmt

load("//rules/scalafmt:workspace.bzl", "scalafmt_default_config", "scalafmt_repositories")

scalafmt_repositories()

load("@annex_scalafmt//:defs.bzl", annex_scalafmt_pinned_maven_install = "pinned_maven_install")

annex_scalafmt_pinned_maven_install()

scalafmt_default_config(".scalafmt.conf")

# Scala proto

load(
    "//rules/scala_proto:workspace.bzl",
    "scala_proto_register_toolchains",
    "scala_proto_repositories",
)

scala_proto_repositories()

scala_proto_register_toolchains()

load("@annex_proto//:defs.bzl", annex_proto_pinned_maven_install = "pinned_maven_install")

annex_proto_pinned_maven_install()
