load("@rules_jvm_external//:defs.bzl", "maven_install")

def test_2_12_artifacts():
    return [
        "org.specs2:specs2-common_2.12:4.12.3",
        "org.specs2:specs2-core_2.12:4.12.3",
        "org.specs2:specs2-matcher_2.12:4.12.3",
        "org.scalatest:scalatest_2.12:3.2.9",
        "org.scalacheck:scalacheck_2.12:1.15.4",
    ]

def test_2_12_dependencies():
    maven_install(
        name = "annex_test_2_12",
        artifacts = test_2_12_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex_test//:annex_test_2_12_install.json",
    )
