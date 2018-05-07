load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("//rules/scala_proto/3rdparty:maven.bzl", "list_dependencies")

def scala_proto_register_toolchains():
    native.register_toolchains("@rules_scala_annex//rules/scala_proto:scalapb_scala_proto_toolchain")

def scala_proto_repositories():
    for dep in list_dependencies():
        java_import_external(**dep["import_args"])
