load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "bad_compile",
    srcs = ["TestMacro.scala"],
    scala = "//scala:2_13",
    deps = [
        ":macro_bad",
        "@annex//:org_scala_lang_scala_reflect_2_13_11",
    ],
)

scala_library(
    name = "macro",
    srcs = ["Macro.scala"],
    macro = True,
    scala = "//scala:2_13",
    deps = [
        ":util",
        "@annex//:org_scala_lang_scala_reflect_2_13_11",
    ],
)

scala_library(
    name = "macro_only",
    srcs = ["MacroOnly.scala"],
    macro = True,
    scala = "//scala:2_13",
    deps = [
        ":macro",
        "@annex//:org_scala_lang_scala_reflect_2_13_11",
    ],
)

scala_library(
    name = "macro_bad",
    srcs = ["Macro.scala"],
    scala = "//scala:2_13",
    deps = [
        ":util",
        "@annex//:org_scala_lang_scala_reflect_2_13_11",
    ],
)

scala_library(
    name = "util",
    srcs = ["MacroUtil.scala"],
    scala = "//scala:2_13",
    deps = ["@annex//:org_scala_lang_scala_reflect_2_13_11"],
)

scala_binary(
    name = "test_macro",
    srcs = ["TestMacro.scala"],
    scala = "//scala:2_13",
    deps = [":macro"],
)

scala_binary(
    name = "test_macro_only",
    srcs = ["TestMacroOnly.scala"],
    deps_used_whitelist = [
        ":macro_only",
    ],
    scala = "//scala:2_13",
    deps = [
        ":macro",
        ":macro_only",
    ],
)
