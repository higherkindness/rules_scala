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

    classes_directory = ctx.actions.declare_directory(
        "%s/classes/%s" % (ctx.label.name, configuration.version))
    output = ctx.actions.declare_file(
        "%s/bin/%s.jar" % (ctx.label.name, configuration.version))
    mains_file = ctx.actions.declare_file(
        "%s/bin/%s.jar.mains.txt" % (ctx.label.name, configuration.version))

    if len(ctx.attr.srcs) == 0:
        java_info = java_common.merge([sdeps, sexports])
    else:
        java_info = JavaInfo(
            output_jar = output,
            use_ijar = ctx.attr.use_ijar,
            sources = ctx.files.srcs,
            deps = [sdeps],
            runtime_deps = [sruntime_deps] + configuration_runtime_deps,
            exports = [sexports],
            actions = ctx.actions,
            java_toolchain = ctx.attr._java_toolchain,
            host_javabase = ctx.attr._host_javabase,
        )

    analysis = ctx.actions.declare_file("{}/analysis/{}.proto.gz".format(ctx.label.name, configuration.version))

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [runner])

    args = ctx.actions.args()
    args.add(False)  # verbose
    args.add("")  # persistenceDir
    args.add(output.path)  # outputJar
    args.add(classes_directory.path)  # outputDir
    args.add(configuration.version)  # scalaVersion
    args.add(_filesArg(configuration.compiler_classpath))  # compilerClasspath
    args.add(configuration.compiler_bridge.path)  # compilerBridge
    args.add(_filesArg(splugins.transitive_runtime_deps))  # pluginsClasspath
    args.add(_filesArg(ctx.files.srcs))  # sources
    args.add(_filesArg(sdeps.transitive_deps))  # compilationClasspath
    args.add(_filesArg(sdeps.compile_jars))  # allowedClasspath
    args.add("_{}".format(ctx.label))  # label
    args.add(analysis.path)  # analysisPath
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file(
        "%s/bin/%s.args" % (ctx.label.name, configuration.version),
    )
    ctx.actions.write(args_file, args)

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [runner])

    inputs = depset()
    inputs += runner_inputs
    inputs += [configuration.compiler_bridge]
    inputs += configuration.compiler_classpath
    inputs += sdeps.transitive_deps
    inputs += sruntime_deps.transitive_runtime_deps
    inputs += ctx.files.srcs
    inputs += splugins.transitive_runtime_deps
    inputs += [args_file]

    outputs = [output, mains_file, classes_directory, analysis]

    # todo: different execution path for nosrc jar?
    ctx.actions.run(
        mnemonic = "ScalaCompile",
        inputs = inputs,
        outputs = outputs,
        executable = runner.files_to_run.executable,
        input_manifests = input_manifests,
        execution_requirements = {"supports-workers": "1"},
        arguments = ["@%s" % args_file.path],
    )

    return struct(
        analysis = analysis,
        java_info = java_info,
        scala_info = ScalaInfo(analysis = analysis),
        intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info),
        files = depset([output]),
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
        ],
        java = res.intellij_info,
    )

def _collect(index, iterable):
    return [
        entry[index]
        for entry in iterable
        if index in entry
    ]
