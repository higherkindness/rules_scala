load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")

def scala_3_artifacts():
    return [
        "org.scala-lang:scala3-compiler_3:3.0.2",
        "org.scala-lang:scala3-library_3:3.0.2",
        "org.scala-sbt:compiler-interface:1.5.7",
        maven.artifact("org.scala-lang", "scala3-sbt-bridge", "3.0.2", neverlink = True),
    ]

def scala_3_repositories():
    maven_install(
        name = "annex_3",
        artifacts = scala_3_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex//:annex_3_install.json",
    )
