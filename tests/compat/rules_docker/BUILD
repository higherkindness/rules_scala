load("@io_bazel_rules_docker//scala:image.bzl", "scala_image")
load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "dep",
    srcs = ["dep.scala"],
)

scala_image(
    name = "container",
    srcs = ["container.scala"],
    jvm_flags = ["-Xmx56g"],
    main_class = "anx.Container",
    deps = [
        ":dep",
    ],
)
