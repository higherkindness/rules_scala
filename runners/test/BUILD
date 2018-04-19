load("//rules:build.bzl", "annex_scala_library")

annex_scala_library(
    name = "runner",
    srcs = glob(["src/main/scala/**/*.scala"]),
    scala = "@scala_2_12",
    visibility = ["//visibility:public"],
    deps = [
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
        "@scala_annex_org_scala_sbt_compiler_interface",
        "@scala_annex_org_scala_sbt_test_interface",
        "@scala_annex_org_scala_sbt_zinc_apiinfo_2_12",
        "@scala_annex_org_scala_sbt_zinc_core_2_12",
        "@scala_annex_org_scala_sbt_zinc_persist_2_12",
    ],
)
