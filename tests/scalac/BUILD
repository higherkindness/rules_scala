load(
        "@rules_scala_annex//rules:scalac.bzl",
        "scalac_library",
        "scalac_binary",
)

scalac_library(
    name = "hello_world_lib",
    srcs = ["HelloWorldLib.scala"],
    scala = "@scala_2_12",
)

scalac_binary(
    name = "hello_world_bin",
    srcs = ["HelloWorldBin.scala"],
    deps = [":hello_world_lib"],
    main_class = "anx.HelloWorld",
    scala = "@scala_2_12",
)
