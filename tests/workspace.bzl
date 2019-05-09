load("@rules_jvm_external//:defs.bzl", "maven_install")

def maven_dependencies():
    maven_install(
        name = "annex_test",
        artifacts = [
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
            "com.thesamet.scalapb:scalapb-runtime_2.12:0.7.4",
            "com.thesamet.scalapb:lenses_2.12:0.7.0",
            "com.google.protobuf:protobuf-java:3.5.1",
            "org.scalatest:scalatest_2.12:3.0.4",
            "org.scalactic:scalactic_2.12:3.0.4",
        ],
        repositories = [
            "http://central.maven.org/maven2",
        ],
        fetch_sources = True,
    )
