load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "pure",
    srcs = glob(["**/*.scala"]),
    main_class = "higherkindness.rules_scala.workers.pure.compile.PureCompileWorker",
    scala = "//src/main/scala:zinc",
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
