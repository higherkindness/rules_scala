load("//rules:compat.bzl",
        "scala_library")

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
