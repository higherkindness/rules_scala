load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library", "scala_test")
load(
    "@rules_scala_annex//rules/common:private/utils.bzl",
    _PROPAGATABLE_TAGS = "PROPAGATABLE_TAGS",
)

scala_binary(
    name = "binary-all-propagatable",
    srcs = ["A.scala"],
    scala = "//scala:2_13",
    tags = ["manual"] + _PROPAGATABLE_TAGS,
)

scala_library(
    name = "library-no-propagatable",
    srcs = ["A.scala"],
    scala = "//scala:2_13",
    tags = [
        "manual",
        "requires-network",
    ],
)

scala_test(
    name = "test-no-remote-only",
    srcs = ["A.scala"],
    scala = "//scala:2_13",
    tags = [
        "manual",
        "no-remote",
    ],
)
