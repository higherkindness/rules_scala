load("//rules:scala.bzl", "bootstrap_scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

bootstrap_scala_binary(
    name = "deps",
    srcs = glob(["**/*.scala"]),
    main_class = "higherkindness.rules_scala.workers.deps.DepsRunner",
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
