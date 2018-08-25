load("@rules_scala_annex//rules:providers.bzl", "IntellijInfo")

scala_import_private_attributes = {
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain"),
    ),
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        cfg = "host",
    ),
}

def scala_import_implementation(ctx):
    default_info = DefaultInfo(
        files = depset(ctx.files.jars + ctx.files.srcjar),
    )

    if ctx.files.jars:
        output_jar = ctx.files.jars[0]

        # TODO: maybe eventually we should use this. Right now it produces
        # a warning:
        #   WARNING: Duplicate name in Manifest: <MANIFEST.MF entry>.
        #   Ensure that the manifest does not have duplicate entries, and
        #   that blank lines separate individual sections in both your
        #   manifest and in the META-INF/MANIFEST.MF entry in the jar file.
        #
        # It does this for all kinds of MANIFEST.MF entries. For example:
        #   * Implementation-Version
        #   * Implementation-Title
        #   * Implementation-URL
        # and a bunch of others
        #
        # compile_jar = java_common.stamp_jar(
        #     ctx.actions,
        #     jar = output_jar,
        #     target_label = ctx.label,
        #     java_toolchain = ctx.attr._java_toolchain,
        # )

        source_jar = java_common.pack_sources(
            ctx.actions,
            output_jar = output_jar,
            source_jars = ctx.files.srcjar or ctx.files.jars,
            host_javabase = ctx.attr._host_javabase,
            java_toolchain = ctx.attr._java_toolchain,
        )

        java_info = JavaInfo(
            output_jar = output_jar,
            compile_jar = output_jar,
            source_jar = source_jar,
            deps = [dep[JavaInfo] for dep in ctx.attr.deps],
            runtime_deps = [runtime_dep[JavaInfo] for runtime_dep in ctx.attr.runtime_deps],
            exports = [export[JavaInfo] for export in ctx.attr.exports],
        )
    else:
        java_info = java_common.merge([dep[JavaInfo] for dep in ctx.attr.deps])

    intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info)

    return struct(
        # IntelliJ reads from java
        java = intellij_info,
        providers = [
            intellij_info,
            java_info,
        ],
    )

def create_intellij_info(label, deps, java_info):
    # note: tried using transitive_exports from a JavaInfo that was given non-empty exports, but it was always empty
    return IntellijInfo(
        outputs = java_info.outputs,
        transitive_exports = depset(
            [label],
            transitive = [(dep[IntellijInfo] if IntellijInfo in dep else dep[JavaInfo]).transitive_exports for dep in deps],
        ),
    )
