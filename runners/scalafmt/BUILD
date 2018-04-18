load("//rules:build.bzl", "annex_scala_binary")

annex_scala_binary(
    name = "runner",
    srcs = glob(["src/main/scala/**/*.scala"]),
    main_class = "annex.scalafmt.ScalamftRunner",
    scala = ["@scalas//:scala_2_12_4"],
    visibility = ["//visibility:public"],
    deps = [
        "//runners/worker",
        "@scalafmt_com_geirsson_metaconfig_core_2_12",
        "@scalafmt_com_geirsson_scalafmt_core_2_12",
        "@scalafmt_net_sourceforge_argparse4j_argparse4j",
    ],
)
