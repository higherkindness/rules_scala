load(
    "@rules_scala_annex//rules:providers.bzl",
    "LabeledJars",
    "ScalaConfiguration",
    "ScalaInfo",
    "ZincConfiguration",
    "ZincInfo",
)
load("//rules/common:private/utils.bzl", "write_launcher")
load(":private/import.bzl", "create_intellij_info")

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

annex_scala_binary_private_attributes = dict({
    "_java": attr.label(
        default = Label("@bazel_tools//tools/jdk:java"),
        executable = True,
        cfg = "host",
    ),
    "_java_stub_template": attr.label(
        default = Label("@anx_java_stub_template//file"),
    ),
}, **runner_common_attributes)

annex_scala_test_private_attributes = annex_scala_binary_private_attributes

def runner_common(ctx):
    runner = ctx.toolchains["@rules_scala_annex//rules/scala:runner_toolchain_type"]

    scala_configuration = ctx.attr.scala[ScalaConfiguration]
    scala_configuration_runtime_deps = _collect(JavaInfo, scala_configuration.runtime_classpath)

    zinc_configuration = ctx.attr.scala[ZincConfiguration]

    sdeps = java_common.merge(_collect(JavaInfo, scala_configuration.runtime_classpath + ctx.attr.deps))
    sruntime_deps = java_common.merge(_collect(JavaInfo, ctx.attr.runtime_deps))
    sexports = java_common.merge(_collect(JavaInfo, ctx.attr.exports))
    splugins = java_common.merge(_collect(JavaInfo, ctx.attr.plugins))

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

    apis = ctx.actions.declare_file("{}/apis.gz".format(ctx.label.name))
    infos = ctx.actions.declare_file("{}/infos.gz".format(ctx.label.name))
    mains_file = ctx.actions.declare_file("{}.jar.mains.txt".format(ctx.label.name))
    relations = ctx.actions.declare_file("{}/relations.gz".format(ctx.label.name))
    setup = ctx.actions.declare_file("{}/setup.gz".format(ctx.label.name))
    stamps = ctx.actions.declare_file("{}/stamps.gz".format(ctx.label.name))
    used = ctx.actions.declare_file("{}/deps_used.txt".format(ctx.label.name))

    macro_classpath = [
        dep[JavaInfo].transitive_runtime_jars
        for dep in ctx.attr.deps
        if ScalaInfo in dep and dep[ScalaInfo].macro
    ]
    compile_classpath = depset(order = "preorder", transitive = macro_classpath + [sdeps.transitive_compile_time_jars])

    zipper_inputs, _, zipper_manifests = ctx.resolve_command(tools = [ctx.attr._zipper])

    if ctx.files.resources:
        resource_jar = ctx.actions.declare_file("{}/resources.zip".format(ctx.label.name))
        args = ctx.actions.args()
        args.add("c", resource_jar)
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
    else:
        resource_jar = None

    class_jar = ctx.actions.declare_file("{}/classes.jar".format(ctx.label.name))

    srcs = FileType([".java", ".scala"]).filter(ctx.files.srcs)
    src_jars = FileType([".srcjar"]).filter(ctx.files.srcs)

    tmp = ctx.actions.declare_directory("{}/tmp".format(ctx.label.name))

    javacopts = [ctx.expand_location(option, ctx.attr.data) for option in ctx.attr.javacopts + java_common.default_javac_opts(ctx, java_toolchain_attr = "_java_toolchain")]

    zincs = [dep[ZincInfo] for dep in ctx.attr.deps if ZincInfo in dep]

    args = ctx.actions.args()
    args.add_all("--analyses", depset(transitive = [zinc.deps for zinc in zincs]), map_each = _analysis)
    args.add("--compiler_bridge", zinc_configuration.compiler_bridge)
    args.add_all("--compiler_classpath", scala_configuration.compiler_classpath)
    args.add_all("--classpath", compile_classpath)
    args.add_all(runner.scalacopts + ctx.attr.scalacopts, format_each = "--compiler_option=%s")
    args.add_all(javacopts, format_each = "--java_compiler_option=%s")
    args.add(ctx.label, format = "--label=%s")
    args.add("--main_manifest", mains_file)
    args.add("--output_apis", apis)
    args.add("--output_infos", infos)
    args.add("--output_jar", class_jar)
    args.add("--output_relations", relations)
    args.add("--output_setup", setup)
    args.add("--output_stamps", stamps)
    args.add("--output_used", used)
    args.add_all("--plugins", splugins.transitive_runtime_deps)
    args.add_all("--source_jars", src_jars)
    args.add("--tmp", tmp)
    args.add_all("--", srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [runner.runner])
    inputs = depset(
        [zinc_configuration.compiler_bridge] + scala_configuration.compiler_classpath + ctx.files.data + ctx.files.srcs + runner_inputs,
        transitive = [
            splugins.transitive_runtime_deps,
            compile_classpath,
        ] + [zinc.deps_files for zinc in zincs],
    )

    outputs = [class_jar, mains_file, apis, infos, relations, setup, stamps, used, tmp]

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

    deps_toolchain = ctx.toolchains["@rules_scala_annex//rules/scala:deps_toolchain_type"]
    deps_checks = {}
    labeled_jars = depset(transitive = [dep[LabeledJars].values for dep in ctx.attr.deps])
    deps_inputs, _, deps_input_manifests = ctx.resolve_command(tools = [deps_toolchain.runner])
    for name in ("direct", "used"):
        deps_check = ctx.actions.declare_file("{}/deps_check_{}".format(ctx.label.name, name))
        deps_args = ctx.actions.args()
        deps_args.add(name, format = "--check_%s=true")
        deps_args.add_all("--direct", [dep.label for dep in ctx.attr.deps], format_each = "_%s")
        deps_args.add_all(labeled_jars, map_each = _labeled_group)
        deps_args.add("--label", ctx.label, format = "_%s")
        deps_args.add_all("--whitelist", [dep.label for dep in ctx.attr.deps_used_whitelist], format_each = "_%s")
        deps_args.add("--")
        deps_args.add(used)
        deps_args.add(deps_check)
        deps_args.set_param_file_format("multiline")
        deps_args.use_param_file("@%s", use_always = True)
        ctx.actions.run(
            mnemonic = "ScalaCheckDeps",
            inputs = [used] + deps_inputs,
            outputs = [deps_check],
            executable = deps_toolchain.runner.files_to_run.executable,
            input_manifests = deps_input_manifests,
            execution_requirements = {"supports-workers": "1"},
            arguments = [deps_args],
        )
        deps_checks[name] = deps_check

    inputs = [class_jar] + ctx.files.resource_jars
    args = ctx.actions.args()
    args.add("--exclude_build_data")
    args.add("--normalize")
    args.add("--sources", class_jar)
    if resource_jar:
        args.add("--sources", resource_jar)
        inputs.append(resource_jar)
    for file in FileType([".jar"]).filter(ctx.files.resource_jars):
        args.add("--sources")
        args.add(file)
    args.add("--output", ctx.outputs.jar)
    args.add("--warn_duplicate_resources")
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)
    if deps_toolchain.direct == "error":
        inputs.append(deps_checks["direct"])
    if deps_toolchain.used == "error":
        inputs.append(deps_checks["used"])
    ctx.actions.run(
        arguments = [args],
        executable = ctx.executable._singlejar,
        execution_requirements = {"supports-workers": "1"},
        mnemonic = "SingleJar",
        inputs = inputs,
        outputs = [ctx.outputs.jar],
    )

    jars = []
    for jar in java_info.outputs.jars:
        jars.append(jar.class_jar)
        jars.append(jar.ijar)
    zinc_info = ZincInfo(
        apis = apis,
        label = ctx.label,
        relations = relations,
        deps = depset(
            [struct(
                apis = apis,
                label = ctx.label,
                relations = relations,
                jars = jars,
            )],
            transitive = [zinc.deps for zinc in zincs],
        ),
        deps_files = depset([apis, relations], transitive = [zinc.deps_files for zinc in zincs]),
    )

    deps_check = []
    if deps_toolchain.direct != "off":
        deps_check.append(deps_checks["direct"])
    if deps_toolchain.used != "off":
        deps_check.append(deps_checks["used"])

    return struct(
        deps_check = deps_check,
        java_info = java_info,
        scala_info = ScalaInfo(macro = ctx.attr.macro, scala_configuration = scala_configuration),
        zinc_info = zinc_info,
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
                # analysis = depset([res.zinc_info.analysis, res.zinc_info.apis]),
                deps = depset(res.deps_check),
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
    return (["--group", "_{}".format(labeled_jars.label)] + [jar.path for jar in labeled_jars.jars.to_list()])

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

def annex_scala_binary_implementation(ctx):
    res = runner_common(ctx)

    # this is all super sketchy...
    # for the time being

    java_info = res.java_info
    mains_file = res.mains_files.to_list()[0]

    files = write_launcher(
        ctx,
        ctx.outputs.bin,
        java_info.transitive_runtime_deps,
        main_class = ctx.attr.main_class or "$(head -1 $JAVA_RUNFILES/{}/{})".format(ctx.workspace_name, mains_file.short_path),
        jvm_flags = [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags],
    )

    return struct(
        providers = [
            res.java_info,
            res.scala_info,
            res.zinc_info,
            res.intellij_info,
            DefaultInfo(
                executable = ctx.outputs.bin,
                files = depset([ctx.outputs.bin], transitive = [res.files]),
                runfiles = ctx.runfiles(
                    files = files + ctx.files.data + [mains_file],
                    transitive_files = depset(
                        order = "default",
                        direct = [ctx.executable._java],
                        transitive = [java_info.transitive_runtime_deps],
                    ),
                    collect_default = True,
                ),
            ),
            OutputGroupInfo(
                deps_check = depset(res.deps_check),
            ),
        ],
        java = res.intellij_info,
    )

def annex_scala_test_implementation(ctx):
    res = runner_common(ctx)

    files = ctx.files._java + [res.zinc_info.apis]

    test_jars = res.java_info.transitive_runtime_deps
    runner_jars = ctx.attr.runner[JavaInfo].transitive_runtime_deps

    args = ctx.actions.args()
    args.add("--apis", res.zinc_info.apis.short_path)
    args.add_all("--frameworks", ctx.attr.frameworks)
    args.add_all("--", res.java_info.transitive_runtime_jars, map_each = _short_path)
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file("{}/test.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    files.append(args_file)

    files += write_launcher(
        ctx,
        ctx.outputs.bin,
        runner_jars,
        "annex.TestRunner",
        [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags] + [
            "-Dbazel.runPath=$RUNPATH",
            "-DscalaAnnex.test.args=${{RUNPATH}}{}".format(args_file.short_path),
        ],
    )

    test_info = DefaultInfo(
        executable = ctx.outputs.bin,
        files = res.files,
        runfiles = ctx.runfiles(collect_default = True, collect_data = True, files = files, transitive_files = depset([], transitive = [runner_jars, test_jars])),
    )
    return struct(
        providers = [
            res.java_info,
            res.scala_info,
            res.zinc_info,
            res.intellij_info,
            test_info,
            OutputGroupInfo(
                # analysis = depset([res.zinc_info.analysis, res.zinc_info.apis]),
                deps_check = depset(res.deps_check),
            ),
        ],
        java = res.intellij_info,
    )

def _analysis(analysis):
    return "_{}={},{}={}".format(analysis.label, analysis.apis.path, analysis.relations.path, ",".join([jar.path for jar in analysis.jars]))

def _analyses(analyses):
    return [_analysis(analysis) for analysis in analyses]

def _short_path(file):
    return file.short_path

def _short_paths(files):
    return [file.short_path for file in files]
