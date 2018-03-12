load("@scala_annex//rules:providers.bzl", "ScalaConfiguration")
load("@scala_annex//rules:internal/utils.bzl", utils = "root")

def basic_scala_library_implementation(ctx):

    name = ctx.label.name
    jar = ctx.file.jar
    java = ctx.file.java

    output = ctx.actions.declare_file("%s.jar" % name)

    scala = ctx.attr.scala[ScalaConfiguration]

    compiler_classpath_str = ':'.join([file.path for file in scala.compiler_classpath])
    compile_classpath_str = ':'.join([file.path for file in (ctx.files.deps + scala.runtime_classpath)])

    srcs_str = ' '.join([file.path for file in ctx.files.srcs])

    inputs = depset()
    inputs += [jar]
    inputs += [java]
    inputs += ctx.files.srcs
    inputs += scala.compiler_classpath
    inputs += scala.runtime_classpath
    inputs += ctx.files.deps

    ctx.actions.run_shell(
        progress_message = "compiling annex runner",
        inputs = inputs,
        outputs = [output],
        command = utils.strip_margin("""
          |#!/bin/bash
          |
          |mkdir bin
          |
          |{java} \\
          |  -cp {compiler_classpath} \\
          |  scala.tools.nsc.Main \\
          |  -cp {compile_classpath} \\
          |  -d bin \\
          |  {srcs}
          |
          |{jar} cf '{output}' -C bin .
          |
          |""".format(
              jar = jar.path,
              java = java.path,
              compiler_classpath = compiler_classpath_str,
              compile_classpath = compile_classpath_str,
              srcs = srcs_str,
              output = output.path)
        ),
    )

    return [
        DefaultInfo(
            files = depset([output]),
        ),
        java_common.create_provider(
            use_ijar = False,
            compile_time_jars = [output],
            runtime_jars = [output] + ctx.files.deps + scala.runtime_classpath,
        ),
    ]

basic_scala_library = rule(
    implementation = basic_scala_library_implementation,
    attrs = {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "scala": attr.label(
            mandatory = True,
            providers = [ScalaConfiguration]),
        "jar": attr.label(
            default = Label("@bazel_tools//tools/jdk:jar"),
            single_file = True,
        ),
        "java": attr.label(
            default = Label("@bazel_tools//tools/jdk:java"),
            single_file = True,
        ),
    },
    fragments = ['java'],
)

def basic_scala_binary(
        name,
        srcs,
        deps,
        main_class,
        scala,
        visibility
):
    basic_scala_library(
        name = "%s-lib" % name,
        srcs = srcs,
        deps = deps,
        scala = scala,
    )

    # being lazy: use java_binary to write a launcher
    # instead of figuring out how to write it directly

    native.java_binary(
        name = name,
        visibility = visibility,
        runtime_deps = [":%s-lib" % name],
        main_class = main_class
    )
