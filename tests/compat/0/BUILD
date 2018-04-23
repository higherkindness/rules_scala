load(
    "@rules_scala_annex//rules/scala:compat.bzl",
    "scala_library",
    "scala_macro_library",
    "scala_binary",
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

scala_binary(
    name = "ScalaBinary",
    srcs = ["ScalaBinary.scala"],
    main_class = "scala.test.ScalaBinary",
    #print_compile_time = True,
    deps = [
        ":HelloLib",
        ":MacroTest",
    ],
)
