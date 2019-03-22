load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("//3rdparty:maven.bzl", "list_dependencies")

_SRC_FILEGROUP_BUILD_FILE_CONTENT = """
filegroup(
    name = "src",
    srcs = glob(["**/*.scala", "**/*.java"]),
    visibility = ["//visibility:public"]
)"""

def scala_repositories():
    for dep in list_dependencies():
        java_import_external(**dep["import_args"])

    BAZEL_JAVA_LAUNCHER_VERSION = "0.22.0"
    java_stub_template_url = (
        "raw.githubusercontent.com/bazelbuild/bazel/" +
        BAZEL_JAVA_LAUNCHER_VERSION +
        "/src/main/java/com/google/devtools/build/lib/bazel/rules/java/" +
        "java_stub_template.txt"
    )

    http_file(
        name = "anx_java_stub_template",
        sha256 = "1483b4ab1a3e8dd6754db50098d9d904533797777e6c3872425b5b1787138935",
        urls = [
            "https://mirror.bazel.build/%s" % java_stub_template_url,
            "https://%s" % java_stub_template_url,
        ],
    )

    http_archive(
        name = "compiler_bridge_2_11",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "355abdd13ee514a239ed48b6bf8846f2a1d9d78bca8df836028d0156002ea08a",
        url = "http://central.maven.org/maven2/org/scala-sbt/compiler-bridge_2.11/1.2.1/compiler-bridge_2.11-1.2.1-sources.jar",
    )

    http_archive(
        name = "compiler_bridge_2_12",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "d7a5dbc384c2c86479b30539cef911c256b7b3861ced68699b116e05b9357c9b",
        url = "http://central.maven.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.1/compiler-bridge_2.12-1.2.1-sources.jar",
    )

    jvm_maven_import_external(
        name = "scala_compiler_2_12_8",
        artifact = "org.scala-lang:scala-compiler:2.12.8",
        licenses = ["notice"],
        server_urls = ["http://central.maven.org/maven2"],
    )
    jvm_maven_import_external(
        name = "scala_library_2_12_8",
        artifact = "org.scala-lang:scala-library:2.12.8",
        licenses = ["notice"],
        server_urls = ["http://central.maven.org/maven2"],
    )
    jvm_maven_import_external(
        name = "scala_reflect_2_12_8",
        artifact = "org.scala-lang:scala-reflect:2.12.8",
        licenses = ["notice"],
        server_urls = ["http://central.maven.org/maven2"],
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
