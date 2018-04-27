load(
    "@io_bazel_rules_scala//scala:scala.bzl",
    "scala_library",
    "scala_macro_library",
    "scala_binary",
    "scala_test",
    "scala_test_suite",
)

scala_library(
    name = "Runtime",
    srcs = ["Runtime.scala"],
)

scala_library(
    name = "Exported",
    srcs = ["Exported.scala"],
    runtime_deps = [":Runtime"],
)

scala_library(
    name = "ExportOnly",
    exports = [":Exported"],
)

scala_library(
    name = "OtherLib",
    srcs = ["OtherLib.scala"],
    deps = [":ExportOnly"],
)

scala_macro_library(
    name = "MacroTest",
    srcs = ["MacroTest.scala"],
)

java_library(
    name = "OtherJavaLib",
    srcs = ["OtherJavaLib.java"],
)

scala_library(
    name = "HelloLib",
    srcs = ["HelloLib.scala"],
    deps = [
        ":Exported",
        ":MacroTest",
        ":OtherJavaLib",
        ":OtherLib",
    ],
)

scala_binary(
    name = "ScalaBinary",
    srcs = ["ScalaBinary.scala"],
    main_class = "scala.test.ScalaBinary",
    print_compile_time = True,
    deps = [
        ":HelloLib",
        ":MacroTest",
    ],
)

scala_test(
    name = "HelloLibTest",
    size = "small",  # Not a macro, can pass test-specific attributes.
    srcs = ["HelloLibTest.scala"],
    deps = [
        ":HelloLib",
    ],
)

scala_test_suite(
    name = "HelloLibTestSuite",
    size = "small",  # Not a macro, can pass test-specific attributes.
    srcs = glob(["HelloLibTest*.scala"]),
    deps = [
        ":HelloLib",
    ],
)
