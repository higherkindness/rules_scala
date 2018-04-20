load("@rules_scala_annex//rules:providers.bzl", "BasicScalaConfiguration")
load("@rules_scala_annex//rules:internal/utils.bzl", "strip_margin")

def basic_scala_library_implementation(ctx):
    name = ctx.label.name
    jar = ctx.executable._jar
    java = ctx.executable._java
    jar_creator = ctx.executable._jar_creator

    output = ctx.actions.declare_file("%s.jar" % name)

    scala = ctx.attr.scala[BasicScalaConfiguration]

    s_dep = java_common.merge([
        dep[JavaInfo]
        for dep in ctx.attr.deps
        if JavaInfo in dep
    ])

    # Note: we pull in transitive_compile_time_jars for the time being
    # to make development of runners way easier (bloop/zinc have big dep graphs).
    # Consider removing transitive_compile_time_jars in the future.
    compile_deps = s_dep.full_compile_jars + s_dep.transitive_compile_time_jars
    runtime_deps = s_dep.transitive_runtime_jars

    compiler_classpath_str = ":".join([file.path for file in scala.compiler_classpath])
    compile_classpath_str = ":".join([file.path for file in (compile_deps + scala.runtime_classpath)])

    inputs = depset()
    inputs += [jar]
    inputs += [java]
    inputs += [jar_creator]
    inputs += ctx.files.srcs
    inputs += scala.compiler_classpath
    inputs += scala.runtime_classpath
    inputs += compile_deps

    ctx.actions.run_shell(
        inputs = inputs,
        outputs = [output],
        command = strip_margin(
            """
          |set -eo pipefail
          |
          |mkdir tmp/classes
          |
          |{java} \\
          |  -cp {compiler_classpath} \\
          |  scala.tools.nsc.Main \\
          |  -cp {compile_classpath} \\
          |  -d tmp/classes \\
          |  {srcs}
          |
          |{jar_creator} {output} tmp/classes 2> /dev/null
          |""".format(
                jar = jar.path,
                java = java.path,
                jar_creator = jar_creator.path,
                compiler_classpath = compiler_classpath_str,
                compile_classpath = compile_classpath_str,
                srcs = " ".join([file.path for file in ctx.files.srcs]),
                output = output.path,
            ),
        ),
    )

    return [
        DefaultInfo(
            files = depset([output]),
        ),
        java_common.create_provider(
            use_ijar = False,
            compile_time_jars = [output],
            runtime_jars = [output] + runtime_deps.to_list() + scala.runtime_classpath,
        ),
    ]

basic_scala_library = rule(
    implementation = basic_scala_library_implementation,
    attrs = {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "scala": attr.label(
            default = "@scala//:scala_basic",
            mandatory = True,
            providers = [BasicScalaConfiguration],
        ),
        "_java": attr.label(
            default = Label("@bazel_tools//tools/jdk:java"),
            executable = True,
            cfg = "host",
        ),
        "_jar": attr.label(
            default = Label("@bazel_tools//tools/jdk:jar"),
            executable = True,
            cfg = "host",
        ),
        "_jar_creator": attr.label(
            default = Label("//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper:jarcreator_bin"),
            executable = True,
            cfg = "host",
        ),
    },
    fragments = ["java"],
)

def basic_scala_binary(
        name,
        srcs,
        deps,
        main_class,
        scala,
        visibility):
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
        main_class = main_class,
    )
