load("@rules_scala_annex//rules:scala.bzl", "annex_scala_binary", "annex_scala_library")

annex_scala_library(
    name = "bad_compile",
    srcs = ["TestMacro.scala"],
    scala = "@scala_2_12",
    deps = [":macro_bad"],
)

annex_scala_library(
    name = "macro",
    srcs = ["Macro.scala"],
    macro = True,
    scala = "@scala_2_12",
    deps = [":util"],
)

annex_scala_library(
    name = "macro_only",
    srcs = ["MacroOnly.scala"],
    macro = True,
    scala = "@scala_2_12",
    deps = [":macro"],
)

annex_scala_library(
    name = "macro_bad",
    srcs = ["Macro.scala"],
    scala = "@scala_2_12",
    deps = [":util"],
)

annex_scala_library(
    name = "util",
    srcs = ["MacroUtil.scala"],
    scala = "@scala_2_12",
    deps = ["@scala_2_12_scala_reflect//jar"],
)

annex_scala_binary(
    name = "test_macro",
    srcs = ["TestMacro.scala"],
    scala = "@scala_2_12",
    deps = [":macro"],
)

annex_scala_binary(
    name = "test_macro_only",
    srcs = ["TestMacroOnly.scala"],
    deps_used_whitelist = [
        ":macro_only",
    ],
    scala = "@scala_2_12",
    deps = [
        ":macro",
        ":macro_only",
    ],
)
