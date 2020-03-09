load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("@rules_jvm_external//:defs.bzl", "maven_install")

_SRC_FILEGROUP_BUILD_FILE_CONTENT = """
filegroup(
    name = "src",
    srcs = glob(["**/*.scala", "**/*.java"]),
    visibility = ["//visibility:public"]
)"""

def scala_artifacts():
    return [
        "org.scala-lang:scala-compiler:2.12.10",
        "org.scala-lang:scala-library:2.12.10",
        "org.scala-lang:scala-reflect:2.12.10",
        "net.sourceforge.argparse4j:argparse4j:0.8.1",
        "org.jacoco:org.jacoco.core:0.7.5.201505241946",
        "com.lihaoyi:sourcecode_2.12:0.1.4,",
        "org.scala-sbt:test-interface:1.0",
        "org.scala-sbt:util-interface:1.3.0",
        "org.scala-sbt:util-logging_2.12:1.3.0",
        "org.scala-sbt:compiler-interface:1.3.4",
        "org.scala-sbt:zinc-compile-core_2.12:1.3.4",
        "org.scala-sbt:zinc_2.12:1.3.4",
        "org.scala-sbt:zinc-persist_2.12:1.3.4",
        "org.scala-sbt:zinc-core_2.12:1.3.4",
        "org.scala-sbt:zinc-apiinfo_2.12:1.3.4",
        "org.scala-sbt:zinc-classpath_2.12:1.3.4",
        "ch.epfl.scala:bloop-frontend_2.12:1.0.0",
        "com.thesamet.scalapb:scalapb-runtime_2.12:0.9.0",
    ]

def scala_repositories(java_launcher_version = "0.29.1"):
    maven_install(
        name = "annex",
        artifacts = scala_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
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
        sha256 = "b124911194dfcb850df7cdd5d2d7cc3280a21045832a9a90499e73934fb8504d",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.11/1.3.4/compiler-bridge_2.11-1.3.4-sources.jar",
    )

    http_archive(
        name = "compiler_bridge_2_12",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "24cd30dcb37c2b24f962118f49489c98a66b49600cfd7fbb9eab68475ddd56a2",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.3.4/compiler-bridge_2.12-1.3.4-sources.jar",
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
