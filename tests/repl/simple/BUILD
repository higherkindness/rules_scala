load("@rules_scala_annex//rules:scala.bzl", "scala_library", "scala_repl")

scala_library(
    name = "lib",
    srcs = ["Example.scala"],
)

scala_repl(
    name = "lib.repl",
    deps = [":lib"],
)
