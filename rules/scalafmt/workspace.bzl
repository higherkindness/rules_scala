load("@rules_jvm_external//:defs.bzl", "maven_install")

def scalafmt_repositories():
    maven_install(
        name = "maven_scalafmt",
        artifacts = [
            "org.scalameta:parsers_2.12:1.7.0",
            "com.geirsson:metaconfig-core_2.12:0.4.0",
            "com.geirsson:scalafmt-core_2.12:1.5.1",
        ],
        repositories = [
            "http://central.maven.org/maven2",
        ],
    )

def scalafmt_default_config(path = ".scalafmt.conf"):
    build = []
    build.append("filegroup(")
    build.append("    name = \"config\",")
    build.append("    srcs = [\"{}\"],".format(path))
    build.append("    visibility = [\"//visibility:public\"],")
    build.append(")")
    native.new_local_repository(name = "scalafmt_default", build_file_content = "\n".join(build), path = "")
