load("//rules:scala.bzl",
        "annex_scala_library",
        "annex_scala_binary")

annex_scala_library(
    name = "macro-spoor-plugin",
    srcs = glob(["**/*.scala"], exclude = ["**/*Test.scala"]),
    scala = "@scala_annex_scala_2_12",
    deps = [
        "@scala_annex_scala_2_12_scala_compiler//jar",
        "@scala_annex_scala_2_12_scala_reflect//jar",
    ],
    deps_used_whitelist = [        
        "@scala_annex_scala_2_12_scala_reflect//jar",
    ],
    resources = ["scalac-plugin.xml"],
    visibility = ["//visibility:public"],    
)

annex_scala_binary(
    name = "macro-spoor-plugin-usage",
    srcs = glob(["**/*Test.scala"]),
    scala = "@scala_annex_scala_2_12",
    plugins = [
        ":macro-spoor-plugin",        
    ],
    deps = [
         "@scala_annex_com_lihaoyi_sourcecode_2_12",
    ],
    deps_used_whitelist = [        
    ],
    visibility = ["//visibility:public"],
)
