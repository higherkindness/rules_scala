load("@rules_scala_annex//rules/scala:provider.bzl", "BasicScalaConfiguration")
load("//rules/common:private/utils.bzl", "strip_margin")
load("//rules/common:private/utils.bzl", "write_launcher")
load("//rules/scala:private/import.bzl", "create_intellij_info")

_common_private_attributes = {
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

scalac_library_private_attributes = _common_private_attributes
scalac_binary_private_attributes = _common_private_attributes + {
    "_java_stub_template": attr.label(
        default = Label("@anx_java_stub_template//file"),
    ),
}

def scalac_binary_implementation(ctx):
    res = _scalac_common(ctx)
    launcher = ctx.new_file("%s.sh" % ctx.label.name)
    write_launcher(
        ctx,
        launcher,
        res['java_info'].transitive_runtime_deps,
        main_class = ctx.attr.main_class,
        jvm_flags = [],
    )
    return _format_providers(ctx, res + {
        'executable': launcher
    })

def scalac_library_implementation(ctx):
    res = _scalac_common(ctx)
    return _format_providers(ctx, res)

def _scalac_common(ctx):
    name = ctx.label.name
    jar = ctx.executable._jar
    java = ctx.executable._java
    jar_creator = ctx.executable._jar_creator

    output_jar = ctx.actions.declare_file("%s.jar" % name)

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

    srcs = [
        file.path
        for file in ctx.files.srcs
        if file.path.endswith(".java") or file.path.endswith(".scala")
    ]

    src_jars = [
        file.path
        for file in ctx.files.srcs
        if file.path.endswith(".srcjar")
    ]

    if len(src_jars) > 0:
        fail("source jars aren't yet supported for direct scalac rules")

    srcs_string = " ".join(srcs)
    src_jars_string = " ".join(src_jars)

    ctx.actions.run_shell(
        inputs = inputs,
        outputs = [output_jar],
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
            |{jar_creator} {output_jar} tmp/classes 2> /dev/null
            |""".format(
                jar = jar.path,
                java = java.path,
                jar_creator = jar_creator.path,
                compiler_classpath = compiler_classpath_str,
                compile_classpath = compile_classpath_str,
                srcs = srcs_string,
                src_jars = src_jars_string,
                output_jar = output_jar.path,
            ),
        ),
    )

    java_info = JavaInfo(
        output_jar = output_jar,
        use_ijar = False,
        sources = ctx.files.srcs,
        deps = deps,
        actions = ctx.actions,
        host_javabase = ctx.attr._host_javabase,
        java_toolchain = ctx.attr._java_toolchain,
    )

    return {
        'output_jar': output_jar,
        'java_info': java_info,
    }


# TODO: put me in a common place?

def _create_default_info(ctx, blob):
    args = {}
    if 'executable' in blob:
        args += {
            'executable': blob['executable'],
            'runfiles': ctx.runfiles(
                transitive_files = depset(
                    order = "default",
                    direct = [ctx.executable._java],
                    transitive = [blob['java_info'].transitive_runtime_deps],
                ),
                collect_default = True,
            )
        }

    files = []
    if 'output_jar' in blob:
        files += [blob['output_jar']]
    args += { 'files': depset(files) }
    return DefaultInfo(**args)

def _format_providers(ctx, blob):

    default_info = _create_default_info(ctx, blob)
    java_info = blob['java_info']
    intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info)

    return struct(
        providers = [
            default_info,
            java_info,
            intellij_info,
        ],
        java = java_info,
    )
