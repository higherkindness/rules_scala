load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "instrumenter",
    srcs = glob(["**/*.scala"]),
    scala = "//src/main/scala:bootstrap",
    main_class = "higherkindness.rules_scala.workers.jacoco.instrumenter.JacocoInstrumenter",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
        "@scala_annex_org_jacoco_org_jacoco_core",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
