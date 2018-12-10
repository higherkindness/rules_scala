load("@rules_scala_annex//rules:scala.bzl", "configure_scala", "scala_library")

scala_library(
    name = "plugin-lib",
    srcs = ["plugin-lib.scala"],
    scala = "@scala_2_12",
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
    scala = "@scala_2_12",
    tags = ["manual"],
    deps = [
        ":plugin-lib",
        "@scala_2_12_scala_compiler//jar",
        "@scala_2_12_scala_reflect//jar",
    ],
)

scala_library(
    name = "inefficient-usage",
    srcs = ["usage.scala"],
    plugins = [
        ":plugin",
    ],
    scala = "@scala_2_12",
    tags = ["manual"],
)
