load(
    "@rules_scala_annex//rules:providers.bzl",
    "LabeledJars",
    "ScalaConfiguration",
    "ScalaInfo",
    "ZincConfiguration",
    "ZincInfo",
)
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
    "_singlejar": attr.label(
        cfg = "host",
        default = "@bazel_tools//tools/jdk:singlejar",
        executable = True,
    ),
    "_zipper": attr.label(
        cfg = "host",
        default = "@bazel_tools//tools/zip:zipper",
        executable = True,
    ),
}

def runner_common(ctx):
    runner = ctx.toolchains["@rules_scala_annex//rules/scala:runner_toolchain_type"]

    scala_configuration = ctx.attr.scala[ScalaConfiguration]
    scala_configuration_runtime_deps = _collect(JavaInfo, scala_configuration.runtime_classpath)

    zinc_configuration = ctx.attr.scala[ZincConfiguration]

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
            sources = ctx.files.srcs,
            deps = [sdeps],
            runtime_deps = [sruntime_deps] + scala_configuration_runtime_deps,
            exports = [sexports],
            actions = ctx.actions,
            java_toolchain = ctx.attr._java_toolchain,
            host_javabase = ctx.attr._host_javabase,
        )

    analysis = ctx.actions.declare_file("{}/analysis.gz".format(ctx.label.name))
    apis = ctx.actions.declare_file("{}/apis.gz".format(ctx.label.name))
    used = ctx.actions.declare_file("{}/deps_used.txt".format(ctx.label.name))

    macro_classpath = [
        dep[JavaInfo].transitive_runtime_jars
        for dep in ctx.attr.deps
        if ScalaInfo in dep and dep[ScalaInfo].macro
    ]
    compile_classpath = depset(order = "preorder", transitive = macro_classpath + [sdeps.transitive_compile_time_jars])

    zipper_inputs, _, zipper_manifests = ctx.resolve_command(tools = [ctx.attr._zipper])

    if ctx.files.resources:
        class_jar = ctx.actions.declare_file("{}/classes.zip".format(ctx.label.name))
        resource_jar = ctx.actions.declare_file("{}/resources.zip".format(ctx.label.name))
        args = ctx.actions.args()
        args.add("c")
        args.add(resource_jar)
        args.set_param_file_format("multiline")
        args.use_param_file("@%s")
        for file in ctx.files.resources:
            args.add("{}={}".format(_resource_path(file, ctx.attr.resource_strip_prefix), file.path))
        ctx.actions.run(
            arguments = [args],
            executable = ctx.executable._zipper,
            inputs = zipper_inputs + ctx.files.resources,
            input_manifests = zipper_manifests,
            outputs = [resource_jar],
        )

        args = ctx.actions.args()
        args.add("--exclude_build_data")
        args.add("--normalize")
        args.add("--sources")
        args.add(class_jar)
        if resource_jar:
            args.add("--sources")
            args.add(resource_jar)
        for file in FileType([".jar"]).filter(ctx.files.resource_jars):
            args.add("--sources")
            args.add(file)
        args.add("--output")
        args.add(ctx.outputs.jar)
        args.add("--warn_duplicate_resources")
        args.set_param_file_format("multiline")
        args.use_param_file("@%s", use_always = True)
        ctx.actions.run(
            arguments = [args],
            executable = ctx.executable._singlejar,
            execution_requirements = {"supports-workers": "1"},
            mnemonic = "SingleJar",
            inputs = [class_jar, resource_jar] + ctx.files.resource_jars,
            outputs = [ctx.outputs.jar],
        )
    else:
        class_jar = ctx.outputs.jar

    srcs = FileType([".java", ".scala"]).filter(ctx.files.srcs)
    src_jars = FileType([".srcjar"]).filter(ctx.files.srcs)

    args = ctx.actions.args()
    if hasattr(args, "add_all"):  # Bazel 0.13.0+
        args.add("--compiler_bridge", zinc_configuration.compiler_bridge)
        args.add_all("--compiler_classpath", scala_configuration.compiler_classpath)
        args.add_all("--classpath", compile_classpath)
        args.add_all(runner.scalacopts + ctx.attr.scalacopts, format_each = "--compiler_option=%s")
        args.add("--label={}".format(ctx.label))
        args.add("--main_manifest", mains_file)
        args.add("--output_analysis", analysis)
        args.add("--output_apis", apis)
        args.add("--output_jar", class_jar)
        args.add("--output_used", used)
        args.add("--plugins", splugins.transitive_runtime_deps)
        args.add_all("--source_jars", src_jars)
        args.add("--")
        args.add_all(srcs)
    else:
        args.add("--compiler_bridge")
        args.add(zinc_configuration.compiler_bridge)
        args.add("--compiler_classpath")
        args.add(scala_configuration.compiler_classpath)
        args.add(runner.scalacopts + ctx.attr.scalacopts, format = "--compiler_option=%s")
        args.add("--classpath")
        args.add(compile_classpath)
        args.add("--label={}".format(ctx.label))
        args.add("--main_manifest")
        args.add(mains_file)
        args.add("--output_analysis")
        args.add(analysis)
        args.add("--output_apis")
        args.add(apis)
        args.add("--output_jar")
        args.add(class_jar)
        args.add("--output_used")
        args.add(used)
        args.add("--plugin")
        args.add(splugins.transitive_runtime_deps)
        args.add("--source_jars")
        args.add(src_jars)
        args.add("--")
        args.add(srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [runner.runner])
    inputs = depset(
        [zinc_configuration.compiler_bridge] + scala_configuration.compiler_classpath + ctx.files.srcs + runner_inputs,
        transitive = [
            splugins.transitive_runtime_deps,
            compile_classpath,
        ],
    )

    outputs = [class_jar, mains_file, analysis, apis, used]

    # todo: different execution path for nosrc jar?
    ctx.actions.run(
        mnemonic = "ScalaCompile",
        inputs = inputs,
        outputs = outputs,
        executable = runner.runner.files_to_run.executable,
        input_manifests = input_manifests,
        execution_requirements = {"supports-workers": "1"},
        arguments = [args],
    )

    files = [ctx.outputs.jar]

    deps_runner = ctx.toolchains["@rules_scala_annex//rules/scala:deps_toolchain_type"].runner
    if deps_runner:
        deps_check = ctx.actions.declare_file("{}/deps.check".format(ctx.label.name))
        labeled_jars = depset(transitive = [dep[LabeledJars].values for dep in ctx.attr.deps])
        deps_args = ctx.actions.args()
        if hasattr(deps_args, "add_all"):  # Bazel 0.13.0+
            deps_args.add_all("--direct", [dep.label for dep in ctx.attr.deps], format_each = "_%s")
            deps_args.add_all(labeled_jars, before_each = "--group", map_each = _labeled_group)
            deps_args.add("--label", ctx.label, format = "_%s")
            deps_args.add_all(labeled_jars, before_each = "--group", map_each = _labeled_group)
            deps_args.add("--whitelist", [dep.label for dep in ctx.attr.deps_used_whitelist], format = "_%s")
            deps_args.add("--")
            deps_args.add(used)
            deps_args.add(deps_check)
        else:
            deps_args.add("--direct")
            deps_args.add([dep.label for dep in ctx.attr.deps], format = "_%s")
            deps_args.add(labeled_jars, before_each = "--group", map_fn = _labeled_groups)
            deps_args.add("--label")
            deps_args.add(ctx.label, format = "_%s")
            deps_args.add("--whitelist")
            deps_args.add([dep.label for dep in ctx.attr.deps_used_whitelist], format = "_%s")
            deps_args.add("--")
            deps_args.add(used)
            deps_args.add(deps_check)
        deps_args.set_param_file_format("multiline")
        deps_args.use_param_file("@%s", use_always = True)
        deps_inputs, _, deps_input_manifests = ctx.resolve_command(tools = [deps_runner])
        ctx.actions.run(
            mnemonic = "ScalaCheckDeps",
            inputs = [used] + deps_inputs,
            outputs = [deps_check],
            executable = deps_runner.files_to_run.executable,
            input_manifests = deps_input_manifests,
            execution_requirements = {"supports-workers": "1"},
            arguments = [deps_args],
        )
        files.append(deps_check)

    return struct(
        analysis = analysis,
        apis = apis,
        deps_check = deps_check,
        java_info = java_info,
        scala_info = ScalaInfo(macro = ctx.attr.macro, scala_configuration = scala_configuration),
        zinc_info = ZincInfo(analysis = analysis),
        intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info),
        files = depset(files),
        mains_files = depset([mains_file]),
    )

annex_scala_library_private_attributes = runner_common_attributes

def annex_scala_library_implementation(ctx):
    res = runner_common(ctx)
    return struct(
        providers = [
            res.java_info,
            res.scala_info,
            res.zinc_info,
            res.intellij_info,
            DefaultInfo(
                files = res.files,
            ),
            OutputGroupInfo(
                analysis = depset([res.analysis, res.apis]),
                #deps = depset([res.deps_check]),
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

"""
Ew. Bazel 0.13.0's map_each will allow us to produce multiple args from each item.
"""

def _labeled_group(labeled_jars):
    return "|".join(["_{}".format(labeled_jars.label)] + [jar.path for jar in labeled_jars.jars.to_list()])

def _labeled_groups(labeled_jars_list):
    return [_labeled_group(labeled_jars) for labeled_jars in labeled_jars_list]

def _resource_path(file, strip_prefix):
    if strip_prefix:
        if not file.short_path.startswith(strip_prefix):
            fail("{} does not have prefix {}".format(file.short_path, strip_prefix))
        return file.short_path[len(strip_prefix) + 1 - int(file.short_path.endswith("/")):]
    conventional = [
        "src/main/resources/",
        "src/test/resources/",
    ]
    for path in conventional:
        dir1, dir2, rest = file.short_path.partition(path)
        if rest:
            return rest
    return file.short_path
