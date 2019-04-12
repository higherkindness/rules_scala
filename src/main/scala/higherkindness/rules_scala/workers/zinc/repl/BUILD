load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "repl",
    srcs = glob(["**/*.scala"]),
    scala = "//src/main/scala:zinc",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "//src/main/scala/higherkindness/rules_scala/workers/common",
        "@maven//:net_sourceforge_argparse4j_argparse4j",
        "@maven//:org_scala_sbt_compiler_interface",
        "@maven//:org_scala_sbt_util_interface",
        "@maven//:org_scala_sbt_util_logging_2_12",
        "@maven//:org_scala_sbt_zinc_2_12",
        "@maven//:org_scala_sbt_zinc_compile_core_2_12",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
