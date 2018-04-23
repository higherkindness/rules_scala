load("@rules_scala_annex//rules/scala:provider.bzl", "BasicScalaConfiguration")
load("//rules/common:private/utils.bzl", "strip_margin")
load(":private/import.bzl", "create_intellij_info")

basic_scala_library_private_attributes = {
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        cfg = "host",
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
        default = Label("@rules_scala_annex//rules/common/third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper:jarcreator_bin"),
        executable = True,
        cfg = "host",
    ),
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain"),
    ),
}

def basic_scala_library_implementation(ctx):
    name = ctx.label.name
    jar = ctx.executable._jar
    java = ctx.executable._java
    jar_creator = ctx.executable._jar_creator

    output = ctx.actions.declare_file("%s.jar" % name)

    scala = ctx.attr.scala[BasicScalaConfiguration]

    deps = [dep[JavaInfo] for dep in scala.runtime_classpath + ctx.attr.deps]

    sdep = java_common.merge(deps)

    # Note: we pull in transitive_compile_time_jars for the time being
    # to make development of runners way easier (bloop/zinc have big dep graphs).
    # Consider removing transitive_compile_time_jars in the future.
    compile_deps = sdep.transitive_compile_time_jars
    runtime_deps = sdep.transitive_runtime_jars

    compiler_classpath_str = ":".join([file.path for file in scala.compiler_classpath])
    compile_classpath_str = ":".join([file.path for file in compile_deps])

    inputs = depset()
    inputs += [jar]
    inputs += [java]
    inputs += [jar_creator]
    inputs += ctx.files.srcs
    inputs += scala.compiler_classpath
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
                srcs = " ".join([file.path for file in ctx.files.srcs if file.path.endswith(".java") or file.path.endswith(".scala")]),
                src_jars = " ".join([file.path for file in ctx.files.srcs if file.path.endswith(".srcjar")]),
                output = output.path,
            ),
        ),
    )

    java_info = JavaInfo(
        output_jar = output,
        use_ijar = False,
        sources = ctx.files.srcs,
        deps = deps,
        runtime_deps = [dep[JavaInfo] for dep in ctx.attr.runtime_deps],
        actions = ctx.actions,
        host_javabase = ctx.attr._host_javabase,
        java_toolchain = ctx.attr._java_toolchain,
    )

    intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info)

    return struct(
        providers = [
            DefaultInfo(
                files = depset([output]),
            ),
            java_info,
            intellij_info,
        ],
        java = java_info,
    )
