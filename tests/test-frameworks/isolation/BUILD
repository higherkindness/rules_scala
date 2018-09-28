load("@rules_scala_annex//rules:scala.bzl", "scala_library", "scala_test")

scala_library(
    name = "global",
    srcs = ["Global.scala"],
    scala = "@scala_2_12",
)

scala_test(
    name = "classloader",
    srcs = ["Test.scala"],
    isolation = "classloader",
    scala = "@scala_2_12",
    deps = [
        ":global",
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "classloader-jvm",
    srcs = ["TestJvm.scala"],
    isolation = "classloader",
    scala = "@scala_2_12",
    deps = [
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "classloader-shared",
    srcs = ["Test.scala"],
    isolation = "classloader",
    scala = "@scala_2_12",
    shared_deps = [":global"],
    deps = [
        ":global",
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "none",
    srcs = ["Test.scala"],
    scala = "@scala_2_12",
    deps = [
        ":global",
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "none-jvm",
    srcs = ["TestJvm.scala"],
    isolation = "none",
    scala = "@scala_2_12",
    deps = [
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "process",
    srcs = ["Test.scala"],
    isolation = "process",
    scala = "@scala_2_12",
    deps = [
        ":global",
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "process-2_11",
    srcs = ["Test.scala"],
    isolation = "process",
    scala = "@scala_2_11",
    deps = [
        ":global",
        "@org_specs2_specs2_common_2_11",
        "@org_specs2_specs2_core_2_11",
        "@org_specs2_specs2_matcher_2_11",
    ],
)

scala_test(
    name = "process-jvm",
    srcs = ["TestJvm.scala"],
    isolation = "process",
    scala = "@scala_2_12",
    deps = [
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)
