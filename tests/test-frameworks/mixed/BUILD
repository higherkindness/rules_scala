load("//rules:build.bzl", "annex_scala_test")

annex_scala_test(
    name = "mixed",
    srcs = glob(["*.scala"]),    
    deps = [
        "//3rdparty/jvm/org/scalacheck",
    ],
    scala = [
        "@scalas//:scala_2_12_4",   
    ],
    tags = ["manual"],
)
