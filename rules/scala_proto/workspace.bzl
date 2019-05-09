load("@rules_jvm_external//:defs.bzl", "maven_install")

def scala_proto_register_toolchains():
    native.register_toolchains("@rules_scala_annex//rules/scala_proto:scalapb_scala_proto_toolchain")

def scala_proto_repositories():
    maven_install(
        name = "annex_proto",
        artifacts = [
            "com.github.os72:protoc-jar:3.5.1.1",
            "com.thesamet.scalapb:compilerplugin_2.12:0.7.4",
            "com.thesamet.scalapb:protoc-bridge_2.12:0.7.3",
        ],
        repositories = [
            "http://central.maven.org/maven2",
        ],
        fetch_sources = True,
    )
