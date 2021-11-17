load("@rules_scala_annex//rules:scala.bzl", "scala_library", "scala_test")

scala_test(
    name = "test-all",
    srcs = [
        "TestAll.scala",
    ],
    scala = "//scala:2_13",
    runtime_deps = [
        "@hamcrest_core//jar",
        "@junit_interface//jar",
    ],
    deps = [
        ":a1",
        ":a2",
        ":b1",
        "@junit//jar",
    ],
)

java_test(
    name = "test-b2",
    srcs = [
        "TestB2.java",
    ],
    test_class = "TestB2",
    deps = [
        ":b2",
        "@junit//jar",
    ],
)

scala_library(
    name = "a1",
    srcs = [
        "A1.scala",
    ],
    scala = "//scala:2_13",
    deps = [
        ":b1",
    ],
)

scala_library(
    name = "b1",
    srcs = [
        "B1.scala",
    ],
    scala = "//scala:2_13",
)

scala_library(
    name = "a2",
    srcs = [
        "A2.scala",
    ],
    scala = "//scala:2_13",
    deps = [
        ":b2",
    ],
)

#
# As it stands I can't seem to generate coverage for Java libraries pulled into
# a scala_test target.
#
# The java_library is instrumented, but doesn't have the .uninstrumented files
# that Bazel seems to expect. There are a few code paths for code coverage, so
# down the road we can explore how to fix this...
#

java_library(
    name = "b2",
    srcs = [
        "B2.java",
    ],
    deps = [
        ":c2",
    ],
)

scala_library(
    name = "c2",
    srcs = [
        "C2.scala",
    ],
    scala = "//scala:2_13",
)
