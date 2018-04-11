load(
    "@rules_scala_annex//rules:compat.bzl",
    "scala_library",
    "scala_macro_library",
)

scala_library(
    name = "Runtime",
    srcs = ["Runtime.scala"],
    tags = ["manual"],
)

scala_library(
    name = "Exported",
    srcs = ["Exported.scala"],
    tags = ["manual"],
    runtime_deps = [":Runtime"],
)

scala_library(
    name = "ExportOnly",
    tags = ["manual"],
    exports = [":Exported"],
)

scala_library(
    name = "OtherLib",
    srcs = ["OtherLib.scala"],
    tags = ["manual"],
    deps = [":ExportOnly"],
)

scala_macro_library(
    name = "MacroTest",
    srcs = ["MacroTest.scala"],
    tags = ["manual"],
)

java_library(
    name = "OtherJavaLib",
    srcs = ["OtherJavaLib.java"],
    tags = ["manual"],
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
