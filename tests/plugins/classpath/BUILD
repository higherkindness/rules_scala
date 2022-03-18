load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "plugin-lib",
    srcs = ["plugin-lib.scala"],
    scala = "//scala:2_13",
    tags = ["manual"],
)

_gen_plugin_xml_cmd = """
cat > $@ << EOF
<plugin>
  <name>plugin</name>
  <classname>plug.it.in.Plugin</classname>
</plugin>
"""

genrule(
    name = "gen-scalac-plugin.xml",
    outs = ["scalac-plugin.xml"],
    cmd = _gen_plugin_xml_cmd,
)

java_binary(
    name = "resources",
    classpath_resources = [
        ":gen-scalac-plugin.xml",
    ],
    create_executable = False,
)

scala_library(
    name = "plugin",
    srcs = ["plugin.scala"],
    resource_jars = [
        ":resources",
    ],
    scala = "//scala:2_13",
    tags = ["manual"],
    deps = [
        ":plugin-lib",
        "@annex//:org_scala_lang_scala_compiler_2_13_8",
        "@annex//:org_scala_lang_scala_reflect_2_13_8",
    ],
)

scala_library(
    name = "inefficient-usage",
    srcs = ["usage.scala"],
    plugins = [
        ":plugin",
    ],
    scala = "//scala:2_13",
    tags = ["manual"],
)
