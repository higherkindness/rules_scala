load("@rules_scala_annex//rules:scala.bzl", "scala_library", "scala_test")

scala_test(
    name = "test-a",
    srcs = [
        "TestA.scala",        
    ],
    scala = "//scala:2_12",
    runtime_deps = [
        "@hamcrest_core//jar",
        "@junit_interface//jar",
    ],
    deps = [
        "@junit//jar",
        ":a",
        ":b",
    ]
)

scala_library(
    name = "a",
    srcs = [
        "A.scala",
    ],
    scala = "//scala:2_12",
    deps = [
    ":b",
    ]
)

scala_library(
    name = "b",
    srcs = [
        "B.scala",
    ],
    scala = "//scala:2_12",
)
