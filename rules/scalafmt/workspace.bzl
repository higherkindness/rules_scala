load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("//rules/scalafmt/3rdparty:maven.bzl", "list_dependencies")

def scalafmt_repositories():
    for dep in list_dependencies():
        java_import_external(**dep["import_args"])

def scalafmt_default_config(path = ".scalafmt.conf"):
    build = []
    build.append("filegroup(")
    build.append("    name = \"config\",")
    build.append("    srcs = [\"{}\"],".format(path))
    build.append("    visibility = [\"//visibility:public\"],")
    build.append(")")
    native.new_local_repository(name = "scalafmt_default", build_file_content = "\n".join(build), path = "")
