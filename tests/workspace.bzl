load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("@rules_scala_annex//rules:external.bzl", "scala_import_external")
load("//3rdparty:maven.bzl", "list_dependencies")

def maven_dependencies():
    for dep in list_dependencies():
        if dep["lang"] == "java":
            java_import_external(**dep["import_args"])
        else:
            scala_import_external(**dep["import_args"])
