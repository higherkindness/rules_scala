load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "example",
    srcs = ["Example.scala"],
    scala = "//scala:3",
    tags = ["manual"],
)

scala_library(
    name = "example-1",
    srcs = ["Example1.scala"],
    scala = "//scala:2_13",
    deps = [
        ":example-2",
        ":example-3",
        ":example-4",
    ],
)

scala_library(
    name = "example-2",
    srcs = ["Example2.scala"],
    scala = "//scala:3",
    deps = [
        ":example-3",
        ":example-4",
    ],
)

scala_library(
    name = "example-3",
    srcs = ["Example3.scala"],
    scala = "//scala:3",
    deps = [
        ":example-4",
    ],
)

scala_library(
    name = "example-4",
    srcs = ["Example4.scala"],
    scala = "//scala:2_13",
)
