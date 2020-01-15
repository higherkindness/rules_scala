load("@rules_jvm_external//:defs.bzl", "maven_install")

def scalafmt_repositories():
    maven_install(
        name = "annex_scalafmt",
        artifacts = [
            "org.scalameta:parsers_2.12:4.2.0",
            "com.geirsson:metaconfig-core_2.12:0.8.3",
            "org.scalameta:scalafmt-core_2.12:jar:2.0.0",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex//:annex_scalafmt_install.json",
    )

def scalafmt_default_config(path = ".scalafmt.conf"):
    build = []
    build.append("filegroup(")
    build.append("    name = \"config\",")
    build.append("    srcs = [\"{}\"],".format(path))
    build.append("    visibility = [\"//visibility:public\"],")
    build.append(")")
    native.new_local_repository(name = "scalafmt_default", build_file_content = "\n".join(build), path = "")
