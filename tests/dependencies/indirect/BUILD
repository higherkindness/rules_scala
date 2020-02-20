load("@rules_scala_annex//rules:scala.bzl", "scala_library")
load("@rules_scala_annex//rules:providers.bzl", "reconfigure_deps_configuration")

# used_deps off
reconfigure_deps_configuration(
    name = "scala_used_deps_off",
    provider = "//scala:2_12",
    used = "off",
)

scala_library(
    name = "used_deps_off_a",
    srcs = ["A.scala"],
    scala = ":scala_used_deps_off",
)

scala_library(
    name = "used_deps_off_b",
    srcs = ["B.scala"],
    scala = ":scala_used_deps_off",
    deps = [":used_deps_off_a"],
)

scala_library(
    name = "used_deps_off_c",
    srcs = ["C.scala"],
    scala = ":scala_used_deps_off",
    deps = [":used_deps_off_b"],
)

# direct_deps off
reconfigure_deps_configuration(
    name = "scala_direct_deps_off",
    direct = "off",
    provider = "//scala:2_12",
)

scala_library(
    name = "direct_deps_off_a",
    srcs = ["A.scala"],
    scala = ":scala_direct_deps_off",
)

scala_library(
    name = "direct_deps_off_b",
    srcs = ["B.scala"],
    scala = ":scala_direct_deps_off",
    deps = [":direct_deps_off_a"],
)

scala_library(
    name = "direct_deps_off_c",
    srcs = ["C.scala"],
    scala = ":scala_direct_deps_off",
    deps = [":direct_deps_off_b"],
)

# toggle used_deps and direct_deps via --define
scala_library(
    name = "define_a",
    srcs = ["A.scala"],
    scala = "@rules_scala_annex//src/main/scala:zinc_2_12_10",
)

scala_library(
    name = "define_b",
    srcs = ["B.scala"],
    scala = "@rules_scala_annex//src/main/scala:zinc_2_12_10",
    deps = [":define_a"],
)

scala_library(
    name = "define_c",
    srcs = ["C.scala"],
    scala = "@rules_scala_annex//src/main/scala:zinc_2_12_10",
    deps = [":define_b"],
)
