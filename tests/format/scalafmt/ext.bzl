load(
    "@rules_scala_annex//rules:scala.bzl",
    "make_scala_binary",
    "make_scala_library",
    "make_scala_test",
)
load(
    "@rules_scala_annex//rules:scalafmt/ext.bzl",
    "ext_with_non_default_format",
)

scala_binary = make_scala_binary(ext_with_non_default_format)

scala_library = make_scala_library(ext_with_non_default_format)

scala_test = make_scala_test(ext_with_non_default_format)
