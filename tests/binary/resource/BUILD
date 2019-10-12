# https://github.com/higherkindness/rules_scala/issues/193

load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "lib",
    srcs = ["example.scala"],
)

scala_binary(
    name = "bin",
    main_class = "Example",
    resource_strip_prefix = package_name(),
    resources = ["example.txt"],
    runtime_deps = [":lib"],
)
