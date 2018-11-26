load("@rules_scala_annex//rules:scalafmt.bzl", "scala_format_test")
load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library", "scala_test")

### scala_format_test ###
scala_format_test(
    name = "formatted",
    srcs = ["formatted.scala"],
)

scala_format_test(
    name = "unformatted",
    srcs = ["unformatted.scala"],
)

scala_format_test(
    name = "unformatted-copy",
    srcs = ["unformatted.tmp.scala"],
)

### scala_binary ###
scala_binary(
    name = "formatted-binary",
    srcs = ["formatted.scala"],
    format = True,
)

scala_binary(
    name = "unformatted-binary",
    srcs = ["unformatted.scala"],
    format = True,
)

scala_binary(
    name = "unformatted-binary-copy",
    srcs = ["unformatted.tmp.scala"],
    format = True,
)

### scala_library ###
scala_library(
    name = "formatted-library",
    srcs = ["formatted.scala"],
    format = True,
)

scala_library(
    name = "unformatted-library",
    srcs = ["unformatted.scala"],
    format = True,
)

scala_library(
    name = "unformatted-library-copy",
    srcs = ["unformatted.tmp.scala"],
    format = True,
)

### scala_test ###
scala_test(
    name = "formatted-test",
    srcs = ["formatted.scala"],
    format = True,
)

scala_test(
    name = "unformatted-test",
    srcs = ["unformatted.scala"],
    format = True,
)

scala_test(
    name = "unformatted-test-copy",
    srcs = ["unformatted.tmp.scala"],
    format = True,
)
