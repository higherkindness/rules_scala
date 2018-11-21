load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("//rules/common:private/utils.bzl", "safe_name", "strip_margin")
load("//rules/scala:private/workspace.bzl", "configure_scala_repository_implementation")
load("//3rdparty:maven.bzl", "list_dependencies")

configure_scala_repository = repository_rule(
    attrs = {
        "compiler_bridge": attr.string(),
        "organization": attr.string(),
        "version": attr.string(),
    },
    implementation = configure_scala_repository_implementation,
)

def scala_repositories():
    for dep in list_dependencies():
        java_import_external(**dep["import_args"])

    BAZEL_JAVA_LAUNCHER_VERSION = "0.11.1"
    java_stub_template_url = (
        "raw.githubusercontent.com/bazelbuild/bazel/" +
        BAZEL_JAVA_LAUNCHER_VERSION +
        "/src/main/java/com/google/devtools/build/lib/bazel/rules/java/" +
        "java_stub_template.txt"
    )

    http_file(
        name = "anx_java_stub_template",
        sha256 = "2cbba7c512e400df0e7d4376e667724a38d1155db5baaa81b72ad785c6d761d1",
        urls = [
            "https://mirror.bazel.build/%s" % java_stub_template_url,
            "https://%s" % java_stub_template_url,
        ],
    )

    scala_src_build = strip_margin("""
      |filegroup(
      |    name = "src",
      |    srcs = glob(["**/*.scala", "**/*.java"]),
      |    visibility = ["//visibility:public"]
      |)""")

    http_archive(
        name = "compiler_bridge_2_11",
        build_file_content = scala_src_build,
        sha256 = "355abdd13ee514a239ed48b6bf8846f2a1d9d78bca8df836028d0156002ea08a",
        url = "http://central.maven.org/maven2/org/scala-sbt/compiler-bridge_2.11/1.2.1/compiler-bridge_2.11-1.2.1-sources.jar",
    )

    http_archive(
        name = "compiler_bridge_2_12",
        build_file_content = scala_src_build,
        sha256 = "d7a5dbc384c2c86479b30539cef911c256b7b3861ced68699b116e05b9357c9b",
        url = "http://central.maven.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.1/compiler-bridge_2.12-1.2.1-sources.jar",
    )

    scala_repository("scala_annex_scala_2_12", ("org.scala-lang", "2.12.6"), "@compiler_bridge_2_12//:src")

    native.bind(
        name = "scala_annex_scala",
        actual = "@scala_annex_scala_2_12",
    )
    native.bind(
        name = "scala_annex_scala_basic",
        actual = "@scala_annex_scala_2_12//:basic",
    )

def scala_register_toolchains():
    native.register_toolchains("@rules_scala_annex//rules/scala:config_runner_toolchain")
    native.register_toolchains("@rules_scala_annex//rules/scala:config_deps_toolchain")

def scala_repository(name, coordinates, compiler_bridge):
    configure_scala_repository(
        name = name,
        compiler_bridge = compiler_bridge,
        version = coordinates[1],
    )

    organization, version = coordinates

    native.maven_jar(
        name = "{}_scala_compiler".format(name),
        artifact = "%s:scala-compiler:%s" % (organization, version),
    )

    native.maven_jar(
        name = "{}_scala_library".format(name),
        artifact = "%s:scala-library:%s" % (organization, version),
    )

    native.maven_jar(
        name = "{}_scala_reflect".format(name),
        artifact = "%s:scala-reflect:%s" % (organization, version),
    )
