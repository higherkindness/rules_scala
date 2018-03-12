load("//rules:build.bzl", "annex_scala_test")

annex_scala_test(
    name = "scalacheck",
    srcs = glob(["*.scala"]),    
    deps = [
        "//3rdparty/jvm/org/scalacheck",
    ],
    scala = [
          #"@scalas//:scala_2_10_7",
          #"@scalas//:scala_2_11_9",
          "@scalas//:scala_2_12_4",
          "@scalas//:typelevel_scala_2_12_4-bin-typelevel-4",
    ]
)
