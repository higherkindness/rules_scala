load(":utils.bzl", utils = "root")

def scala_annex_toolchain_implementation(ctx):

    compiler_bridge = ctx.actions.declare_file(
        "compiler_bridge_%s.jar" % ctx.attr.binary_version)

    compiler_classpath = ':'.join([file.path for file in ctx.files.compiler_classpath])
    compiler_bridge_classpath = ':'.join([file.path for file in ctx.files.compiler_bridge_classpath])
    compiler_bridge_classpath = compiler_classpath + ':' + compiler_bridge_classpath
    compiler_bridge_sources_jar = ctx.attr.compiler_bridge.java.source_jars.to_list()[0]

    inputs = depset()
    inputs += [ctx.file.jar]
    inputs += [ctx.file.java]
    inputs += ctx.files.compiler_classpath
    inputs += ctx.files.compiler_bridge_classpath
    inputs += [compiler_bridge_sources_jar]

    ctx.actions.run_shell(
        inputs = inputs,
        outputs = [compiler_bridge],
        command = utils.strip_margin("""
          |#!/bin/bash
          |
          |mkdir bridge_src
          |mkdir bridge_bin
          |
          |pushd bridge_src
          |../{jar} xf ../{compiler_bridge_sources_jar}
          |popd
          |
          |{java} \\
          |  -cp {compiler_classpath} \\
          |  scala.tools.nsc.Main \\
          |  -cp {compiler_bridge_classpath} \\
          |  -d bridge_bin \\
          |  `find bridge_src -name "*.scala"`
          |
          |{jar} cf '{out_file}' -C bridge_bin .
          |
          |""".format(
              jar = ctx.file.jar.path,
              java = ctx.file.java.path,
              compiler_bridge_sources_jar = compiler_bridge_sources_jar.path,
              compiler_classpath = compiler_classpath,
              compiler_bridge_classpath = compiler_bridge_classpath,
              out_file = compiler_bridge.path)),
    )


    toolchain = platform_common.ToolchainInfo(
        compiler_bridge = compiler_bridge
    )
    return [toolchain]

scala_annex_toolchain_attrs = {
    'binary_version': attr.string(),
    'compiler_classpath': attr.label_list(allow_files=True),
    'compiler_bridge': attr.label(allow_files=True),
    'compiler_bridge_classpath': attr.label_list(allow_files=True),
    "jar": attr.label(
        default = Label("@bazel_tools//tools/jdk:jar"),
        single_file = True,
    ),
    "java": attr.label(
        default = Label("@bazel_tools//tools/jdk:java"),
        single_file = True,
    ),
}

common_attrs = {
    "srcs": attr.label_list(allow_files = [".scala", ".srcjar", ".java"]),
    "deps": attr.label_list(),
    "plugins": attr.label_list(allow_files = [".jar"]),
    "runtime_deps": attr.label_list(),
    "data": attr.label_list(allow_files = True, cfg = "data"),
    "resources": attr.label_list(allow_files = True),
    "resource_strip_prefix": attr.string(),
    "resource_jars": attr.label_list(allow_files = True),
    "scalacopts": attr.string_list(),
    "javacopts": attr.string_list(),
    "jvm_flags": attr.string_list(),
    "scalac_jvm_flags": attr.string_list(),
    "javac_jvm_flags": attr.string_list(),
}

scala_annex_test_attrs = {}
scala_annex_test_attrs.update(common_attrs)
scala_annex_test_outputs = {}

def scala_annex_test_implementation(ctx):
    runner = ctx.new_file("%s_annex_test_runner.sh" % ctx.label.name)
    ctx.file_action(
        output = runner,
        content = utils.strip_margin("""
          |#!/bin/bash
          |echo "HELLO"
          |sleep 1
          |echo "WORLD"
          |"""),
        executable = True
    )
    return [
        DefaultInfo(
            executable = runner,
            runfiles = ctx.runfiles([
                runner
            ]),
        ),
    ]

root = struct(
    scala_annex_toolchain = struct(
        implementation = scala_annex_toolchain_implementation,
        attrs = scala_annex_toolchain_attrs,
    ),
    scala_annex_test = struct(
        implementation = scala_annex_test_implementation,
        attrs = scala_annex_test_attrs,
        outputs = scala_annex_test_outputs,
    ),
)
