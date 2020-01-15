load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("@rules_jvm_external//:defs.bzl", "maven_install")

_SRC_FILEGROUP_BUILD_FILE_CONTENT = """
filegroup(
    name = "src",
    srcs = glob(["**/*.scala", "**/*.java"]),
    visibility = ["//visibility:public"]
)"""

def scala_repositories(java_launcher_version = "0.29.1"):
    maven_install(
        name = "annex",
        artifacts = [
            "org.scala-sbt:compiler-interface:1.2.1",
            "org.scala-sbt:util-interface:1.2.1",
            "org.scala-lang:scala-compiler:2.12.8",
            "org.scala-lang:scala-library:2.12.8",
            "org.scala-lang:scala-reflect:2.12.8",
            "net.sourceforge.argparse4j:argparse4j:0.8.1",
            "org.jacoco:org.jacoco.core:0.7.5.201505241946",
            "com.lihaoyi:sourcecode_2.12:0.1.4,",
            "org.scala-sbt:zinc_2.12:1.2.1",
            "org.scala-sbt:test-interface:1.0",
            "org.scala-sbt:util-interface:1.2.0",
            "org.scala-sbt:zinc-compile-core_2.12:1.2.1",
            "org.scala-sbt:zinc-persist_2.12:1.2.1",
            "org.scala-sbt:zinc-core_2.12:1.2.1",
            "org.scala-sbt:zinc-apiinfo_2.12:1.2.1",
            "org.scala-sbt:zinc-classpath_2.12:1.2.1",
            "org.scala-sbt:compiler-interface:1.2.1",
            "ch.epfl.scala:bloop-frontend_2.12:1.0.0",
            "com.thesamet.scalapb:scalapb-runtime_2.12:0.9.0",
            "org.scala-sbt:util-logging_2.12:1.2.0",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex//:annex_install.json",
    )

    java_stub_template_url = (
        "raw.githubusercontent.com/bazelbuild/bazel/" +
        java_launcher_version +
        "/src/main/java/com/google/devtools/build/lib/bazel/rules/java/" +
        "java_stub_template.txt"
    )

    http_file(
        name = "anx_java_stub_template",
        sha256 = "e6531a6539ec1e38fec5e20523ff4bfc883e1cc0209eb658fe82eb918eb49657",
        urls = [
            "https://mirror.bazel.build/%s" % java_stub_template_url,
            "https://%s" % java_stub_template_url,
        ],
    )

    http_archive(
        name = "compiler_bridge_2_11",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "355abdd13ee514a239ed48b6bf8846f2a1d9d78bca8df836028d0156002ea08a",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.11/1.2.1/compiler-bridge_2.11-1.2.1-sources.jar",
    )

    http_archive(
        name = "compiler_bridge_2_12",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "d7a5dbc384c2c86479b30539cef911c256b7b3861ced68699b116e05b9357c9b",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.1/compiler-bridge_2.12-1.2.1-sources.jar",
    )

    jvm_maven_import_external(
        name = "scala_compiler_2_12_8",
        artifact = "org.scala-lang:scala-compiler:2.12.8",
        licenses = ["notice"],
        server_urls = ["https://repo.maven.apache.org/maven2"],
    )
    jvm_maven_import_external(
        name = "scala_library_2_12_8",
        artifact = "org.scala-lang:scala-library:2.12.8",
        licenses = ["notice"],
        server_urls = ["https://repo.maven.apache.org/maven2"],
    )
    jvm_maven_import_external(
        name = "scala_reflect_2_12_8",
        artifact = "org.scala-lang:scala-reflect:2.12.8",
        licenses = ["notice"],
        server_urls = ["https://repo.maven.apache.org/maven2"],
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
