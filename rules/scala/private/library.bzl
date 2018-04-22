load("@rules_scala_annex//rules/scala:provider.bzl", "ScalaConfiguration", "ScalaInfo")
load(":private/import.bzl", "create_intellij_info")

def _filesArg(files):
    return ([str(len(files))] + [file.path for file in files])

runner_common_attributes = {
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain"),
    ),
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        cfg = "host",
    ),
}

def runner_common(ctx):
    runner = ctx.toolchains["@rules_scala_annex//rules/scala:runner_toolchain_type"].runner

    configuration = ctx.attr.scala[ScalaConfiguration]
    configuration_runtime_deps = _collect(JavaInfo, configuration.runtime_classpath)

    sdeps = java_common.merge(_collect(JavaInfo, ctx.attr.deps))
    sruntime_deps = java_common.merge(_collect(JavaInfo, ctx.attr.runtime_deps))
    sexports = java_common.merge(_collect(JavaInfo, ctx.attr.exports))
    splugins = java_common.merge(_collect(JavaInfo, ctx.attr.plugins))

    mains_file = ctx.actions.declare_file("{}.jar.mains.txt".format(ctx.label.name))
    analysis = ctx.actions.declare_file("{}/analysis.gz".format(ctx.label.name))
    apis = ctx.actions.declare_file("{}/apis.gz".format(ctx.label.name))

    if len(ctx.attr.srcs) == 0:
        java_info = java_common.merge([sdeps, sexports])
    else:
        java_info = JavaInfo(
            output_jar = ctx.outputs.jar,
            use_ijar = ctx.attr.use_ijar,
            sources = ctx.files.srcs,
            deps = [sdeps],
            runtime_deps = [sruntime_deps] + configuration_runtime_deps,
            exports = [sexports],
            actions = ctx.actions,
            java_toolchain = ctx.attr._java_toolchain,
            host_javabase = ctx.attr._host_javabase,
        )

    args = ctx.actions.args()
    if hasattr(args, "add_all"):  # Bazel 0.13.0+
        args.add("--compiler_bridge", configuration.compiler_bridge)
        args.add_all("--compiler_classpath", configuration.compiler_classpath)
        args.add_all("--classpath", sdeps.transitive_deps)
        args.add_all("--direct_classpath", sdeps.compile_jars)
        args.add("--label={}".format(ctx.label))
        args.add("--main_manifest", mains_file)
        args.add("--output_analysis", analysis)
        args.add("--output_apis", apis)
        args.add("--output_jar", ctx.outputs.jar)
        args.add("--plugins", splugins.transitive_runtime_deps)
        args.add("--require_direct", "true")
        args.add("--require_used", "true")
        args.add("--")
        args.add_all(ctx.files.srcs)
    else:
        args.add("--compiler_bridge")
        args.add(configuration.compiler_bridge)
        args.add("--compiler_classpath")
        args.add(configuration.compiler_classpath)
        args.add("--classpath")
        args.add(sdeps.transitive_deps)
        args.add("--direct_classpath")
        args.add(sdeps.compile_jars)
        args.add("--label={}".format(ctx.label))
        args.add("--main_manifest")
        args.add(mains_file)
        args.add("--output_analysis")
        args.add(analysis)
        args.add("--output_apis")
        args.add(apis)
        args.add("--output_jar")
        args.add(ctx.outputs.jar)
        args.add("--plugin")
        args.add(splugins.transitive_runtime_deps)
        args.add("--require_direct=true")
        args.add("--require_used=true")
        args.add("--")
        args.add(ctx.files.srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [runner])
    inputs = depset(
        [configuration.compiler_bridge] + configuration.compiler_classpath + ctx.files.srcs + runner_inputs,
        transitive = [
            sdeps.transitive_deps,
            splugins.transitive_runtime_deps,
        ],
    )
    outputs = [ctx.outputs.jar, mains_file, analysis, apis]

    # todo: different execution path for nosrc jar?
    ctx.actions.run(
        mnemonic = "ScalaCompile",
        inputs = inputs,
        outputs = outputs,
        executable = runner.files_to_run.executable,
        input_manifests = input_manifests,
        execution_requirements = {"supports-workers": "1"},
        arguments = [args],
    )

    return struct(
        analysis = analysis,
        apis = apis,
        java_info = java_info,
        scala_info = ScalaInfo(analysis = analysis),
        intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info),
        files = depset([ctx.outputs.jar]),
        mains_files = depset([mains_file]),
    )

annex_scala_library_private_attributes = runner_common_attributes

def annex_scala_library_implementation(ctx):
    res = runner_common(ctx)
    return struct(
        providers = [
            res.java_info,
            res.scala_info,
            res.intellij_info,
            DefaultInfo(
                files = res.files,
            ),
            OutputGroupInfo(
                analysis = depset([res.analysis, res.apis]),
            ),
        ],
        java = res.intellij_info,
    )

def _collect(index, iterable):
    return [
        entry[index]
        for entry in iterable
        if index in entry
    ]
