load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_skydoc//skylark:stardoc.bzl", "stardoc")

[
    stardoc(
        name = paths.replace_extension(file, "_doc").replace("/", "_"),
        out = paths.replace_extension(file, ".md").replace("/", "_"),
        input = file,
        deps = [
            ":bzl_internal",
            "@rules_scala_annex//rules:bzl",
        ],
    )
    for file in glob(["**/*.bzl"])
]

pkg_tar(
    name = "docs",
    srcs = [paths.replace_extension(file, ".md").replace("/", "_") for file in glob(["**/*.bzl"])],
    mode = "0644",
)

bzl_library(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//visibility:public"],
    deps = [":private_bzl"],
)

# Bizzaro @rules_scala_annex// vs // differences
bzl_library(
    name = "bzl_internal",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//visibility:public"],
    deps = [":private_bzl"],
)

bzl_library(
    name = "private_bzl",
    srcs = [
        "//rules/common:bzl",
        "//rules/external/third_party/bazel/tools/build_defs/repo:bzl",
        "//rules/jvm:bzl",
        "//rules/private:bzl",
        "//rules/scala:bzl",
        "//rules/scala_proto:bzl",
        "//rules/scalafmt:bzl",
    ],
    deps = ["@bazel_skylib//lib:dicts"],
)
