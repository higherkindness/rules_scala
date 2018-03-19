load(":internal/utils.bzl", utils = "root")
load(":providers.bzl", "ScalaConfiguration")

def annex_configure_scala_implementation(ctx):

    compiler_bridge = compile_compiler_bridge(
        ctx,
        compiler_classpath = ctx.files.compiler_classpath,
        compiler_bridge_classpath = ctx.files.compiler_bridge_classpath,
        compiler_bridge_sources_jar = ctx.attr.compiler_bridge.java.source_jars.to_list()[0],
    )

    return [ScalaConfiguration(
        version = ctx.attr.version,
        binary_version = ctx.attr.binary_version,
        compiler_bridge = compiler_bridge,
        compiler_classpath = ctx.files.compiler_classpath,
        runtime_classpath = ctx.files.runtime_classpath,
    )]

annex_scala_test_private_attributes = {
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain")),
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"), cfg="host"),
}

def annex_scala_test_implementation(ctx):
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

    configurations = depset()
    for entry in ctx.attr.scala:
        configuration = entry[ScalaConfiguration]
        configurations += [configuration.compiler_bridge]

    return [
        DefaultInfo(
            executable = runner,
            runfiles = ctx.runfiles([
                runner
            ]),
            files = configurations
        ),
    ]


def compile_compiler_bridge(
        ctx,
        compiler_classpath,
        compiler_bridge_classpath,
        compiler_bridge_sources_jar,
        suffix = None,
        jar = None,
        java = None,
):
    """
    compiles the zinc compiler bridge for a specific version of Scala
    """

    if suffix == None: suffix = ctx.label.name
    if jar == None: jar = ctx.file.jar
    if java == None: java = ctx.file.java

    compiler_bridge = ctx.actions.declare_file(
        "compiler-bridge_%s.jar" % suffix)

    compiler_classpath_str = ':'.join([file.path for file in compiler_classpath])
    compiler_bridge_classpath_str = ':'.join([file.path for file in compiler_bridge_classpath])
    compiler_bridge_classpath_str = compiler_classpath_str + ':' + compiler_bridge_classpath_str

    inputs = depset()
    inputs += [jar]
    inputs += [java]
    inputs += compiler_classpath
    inputs += compiler_bridge_classpath
    inputs += [compiler_bridge_sources_jar]

    ctx.actions.run_shell(
        progress_message = "compiling zinc compiler bridge %s" % suffix,
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
              jar = jar.path,
              java = java.path,
              compiler_bridge_sources_jar = compiler_bridge_sources_jar.path,
              compiler_classpath = compiler_classpath_str,
              compiler_bridge_classpath = compiler_bridge_classpath_str,
              out_file = compiler_bridge.path)
        ),
    )

    return compiler_bridge
