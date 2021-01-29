load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "scala_library")

scala_library(
    name = "LibA1",
    srcs = [
         "LibA1.scala",
    ],
    scala = "//external:scala_annex_scala",
    plugins = [
        "//src/main/scala/higherkindness/rules_scala/used_deps",
    ],
    visibility = ["//visibility:public"],
)

scala_library(
    name = "LibA2",
    srcs = [
         "LibA2.scala",
    ],
    scala = "//external:scala_annex_scala",
    plugins = [
        "//src/main/scala/higherkindness/rules_scala/used_deps",
    ],
    visibility = ["//visibility:public"],
)

scala_library(
    name = "LibB",
    srcs = [
         "LibB.scala",
    ],
    deps = [
         ":LibA1",
         ":LibA2",
    ],
    scala = "//external:scala_annex_scala",
    plugins = [
        "//src/main/scala/higherkindness/rules_scala/used_deps",
    ],
    visibility = ["//visibility:public"],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
