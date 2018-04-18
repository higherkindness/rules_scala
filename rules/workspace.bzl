load(
    "@rules_scala_annex//rules:internal/workspace_internal.bzl",
    "annex_configure_scala_repository_implementation",
)
load("@rules_scala_annex//rules:internal/utils.bzl", "safe_name")
load("//3rdparty:workspace.bzl", "maven_dependencies")
load("//3rdparty:scalafmt_workspace.bzl", scalafmt_maven_dependencies = "maven_dependencies")

annex_configure_scala_repository = repository_rule(
    implementation = annex_configure_scala_repository_implementation,
    attrs = {
        "versions": attr.string_list_dict(),
        "compiler_bridge_label_pattern": attr.string_dict(),
    },
)

def annex_scala_repositories(
        name,
        versions,
        compiler_bridge_label_pattern = {
            "scala": "@compiler_bridge_{binary_version}//jar",
            "typelevel_scala": "@compiler_bridge_{binary_version}//jar",
            "dotty": "@compiler_bridge_2_12//jar",
        }):
    maven_dependencies()
    scalafmt_maven_dependencies()

    for prefix, raw_versions in versions.items():
        for raw_version in raw_versions:
            organization, version = raw_version.split(":")
            saniorganization = safe_name(organization)
            saniversion = safe_name(version)

            native.maven_jar(
                name = "%s_scala_compiler_%s" % (saniorganization, saniversion),
                artifact = "%s:scala-compiler:%s" % (organization, version),
            )

            native.maven_jar(
                name = "%s_scala_library_%s" % (saniorganization, saniversion),
                artifact = "%s:scala-library:%s" % (organization, version),
            )

            native.maven_jar(
                name = "%s_scala_reflect_%s" % (saniorganization, saniversion),
                artifact = "%s:scala-reflect:%s" % (organization, version),
            )

    annex_configure_scala_repository(
        name = name,
        versions = versions,
        compiler_bridge_label_pattern = compiler_bridge_label_pattern,
    )

    BAZEL_JAVA_LAUNCHER_VERSION = "0.11.1"
    java_stub_template_url = (
        "raw.githubusercontent.com/bazelbuild/bazel/" +
        BAZEL_JAVA_LAUNCHER_VERSION +
        "/src/main/java/com/google/devtools/build/lib/bazel/rules/java/" +
        "java_stub_template.txt"
    )

    native.http_file(
        name = "anx_java_stub_template",
        urls = [
            "https://mirror.bazel.build/%s" % java_stub_template_url,
            "https://%s" % java_stub_template_url,
        ],
        sha256 = "2cbba7c512e400df0e7d4376e667724a38d1155db5baaa81b72ad785c6d761d1",
    )

    native.maven_jar(
        name = "compiler_bridge_2_11",
        artifact = "org.scala-sbt:compiler-bridge_2.11:1.1.3",
    )

    native.maven_jar(
        name = "compiler_bridge_2_12",
        artifact = "org.scala-sbt:compiler-bridge_2.12:1.1.3",
    )

    native.maven_jar(
        name = "compiler_interface",
        artifact = "org.scala-sbt:compiler-interface:1.1.3",
    )

    native.maven_jar(
        name = "util_interface",
        artifact = "org.scala-sbt:util-interface:1.1.3",
    )

def scalafmt_default_config(path = ".scalafmt.conf"):
    build = []
    build.append("filegroup(")
    build.append("    name = \"config\",")
    build.append("    srcs = [\"{}\"],".format(path))
    build.append("    visibility = [\"//visibility:public\"],")
    build.append(")")
    native.new_local_repository(name = "scalafmt_default", build_file_content = "\n".join(build), path = "")
