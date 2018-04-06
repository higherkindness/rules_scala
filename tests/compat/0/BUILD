load("//rules:compat.bzl",
        "scala_library",
        "scala_macro_library")

scala_library(
    name = "Runtime",
    srcs = ["Runtime.scala"],
    tags = ["manual"],
)

scala_library(
    name = "Exported",
    srcs = ["Exported.scala"],
    runtime_deps = [":Runtime"],
    tags = ["manual"],
)

scala_library(
    name = "ExportOnly",
    exports = [":Exported"],
    tags = ["manual"],
)

scala_library(
    name = "OtherLib",
    srcs = ["OtherLib.scala"],
    deps = [":ExportOnly"],
    tags = ["manual"],
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
        ":OtherJavaLib",
        ":OtherLib",
        ":MacroTest",
        ":Exported"
    ],
)
