load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "scala_library")

scala_library(
    name = "used_deps",
    srcs = glob(["**/*.scala"]),
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [        
        "@scala_annex_scala_2_12_scala_compiler//jar",
        "@scala_annex_scala_2_12_scala_reflect//jar",
    ],
    resource_jars = [
        ":resources",
    ],
)

_gen_plugin_xml_cmd = """
cat > $@ << EOF
<plugin>
  <name>name</name>
  <classname>higherkindness.rules_scala.used_deps.UsedDepsPlugin</classname>
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

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
