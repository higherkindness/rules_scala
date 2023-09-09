load("@rules_jvm_external//:defs.bzl", "maven_install")

def test_artifacts():
    return [
        "com.google.protobuf:protobuf-java:3.11.4",
        "com.thesamet.scalapb:lenses_2.13:0.9.0",
        "com.thesamet.scalapb:scalapb-runtime_2.13:0.11.4",
        "org.scala-lang.modules:scala-xml_2.13:2.0.0",
        "org.scala-sbt:compiler-interface:1.9.3",
        "org.scalacheck:scalacheck_2.13:1.15.4",
        "org.scalactic:scalactic_2.13:3.2.9",
        "org.scalatest:scalatest_2.13:3.2.9",
        "org.specs2:specs2-common_2.13:4.12.3",
        "org.specs2:specs2-core_2.13:4.12.3",
        "org.specs2:specs2-matcher_2.13:4.12.3",
        "org.typelevel:kind-projector_2.13.11:0.13.2",
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
