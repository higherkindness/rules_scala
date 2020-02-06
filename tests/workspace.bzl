load("@rules_jvm_external//:defs.bzl", "maven_install")

def test_artifacts():
    return [
        "org.scala-sbt:compiler-interface:1.2.1",
        "org.scala-lang.modules:scala-xml_2.12:1.0.6",
        "org.scalacheck:scalacheck_2.12:1.13.4",
        "org.scalacheck:scalacheck_2.11:1.13.4",
        "org.specs2:specs2-matcher_2.12:4.0.3",
        "org.specs2:specs2-common_2.12:4.0.3",
        "org.specs2:specs2-core_2.12:4.0.3",
        "org.specs2:specs2-matcher_2.11:3.9.5",
        "org.specs2:specs2-common_2.11:3.9.5",
        "org.specs2:specs2-core_2.11:3.9.5",
        "com.thesamet.scalapb:scalapb-runtime_2.12:0.9.0",
        "com.thesamet.scalapb:lenses_2.12:0.9.0",
        "com.google.protobuf:protobuf-java:3.9.0",
        "org.scalatest:scalatest_2.12:3.0.4",
        "org.scalactic:scalactic_2.12:3.0.4",
    ]

def test_dependencies():
    maven_install(
        name = "annex_test",
        artifacts = test_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex_test//:annex_test_install.json",
    )
