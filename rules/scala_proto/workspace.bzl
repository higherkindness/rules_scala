load("@rules_jvm_external//:defs.bzl", "maven_install")

def scala_proto_register_toolchains():
    native.register_toolchains("@rules_scala_annex//rules/scala_proto:scalapb_scala_proto_toolchain")

def scala_proto_repositories():
    maven_install(
        name = "annex_proto",
        artifacts = [
            "com.github.os72:protoc-jar:3.8.0",
            "com.thesamet.scalapb:compilerplugin_2.12:0.9.0",
            "com.thesamet.scalapb:protoc-bridge_2.12:0.7.8",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex//:annex_proto_install.json",
    )
