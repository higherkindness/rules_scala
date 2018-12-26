load(
    "@rules_scala_annex//rules:scala.bzl",
    "bootstrap_scala_binary",
    "bootstrap_scala_library",
)

bootstrap_scala_library(
    name = "hello_world_lib",
    srcs = ["HelloWorldLib.scala"],
    scala = "//scala:2_12",
)

bootstrap_scala_binary(
    name = "hello_world_bin",
    srcs = ["HelloWorldBin.scala"],
    main_class = "anx.HelloWorld",
    scala = "//scala:2_12",
    deps = [":hello_world_lib"],
)
