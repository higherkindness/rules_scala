load(
    "@rules_scala_annex//rules:providers.bzl",
    _LabeledJars = "LabeledJars",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaInfo = "ScalaInfo",
    _ScalaRulePhase = "ScalaRulePhase",
    _ZincConfiguration = "ZincConfiguration",
    _ZincInfo = "ZincInfo",
)
load("//rules/common:private/utils.bzl", _collect = "collect", _write_launcher = "write_launcher")
load(":private/import.bzl", _create_intellij_info = "create_intellij_info")

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

scala_library_private_attributes = runner_common_attributes

scala_binary_private_attributes = dict({
    "_java": attr.label(
        default = Label("@bazel_tools//tools/jdk:java"),
        executable = True,
        cfg = "host",
    ),
    "_java_stub_template": attr.label(
        default = Label("@anx_java_stub_template//file"),
        allow_single_file = True,
    ),
}, **runner_common_attributes)

scala_test_private_attributes = scala_binary_private_attributes


def run_phases(ctx, phases):
    scala_configuration = ctx.attr.scala[_ScalaConfiguration]
    sdeps = java_common.merge(_collect(JavaInfo, scala_configuration.runtime_classpath + ctx.attr.deps))
    init = struct(
        scala_configuration = scala_configuration,
        # todo: probably can remove this from init
        sdeps = sdeps,
    )

    # TODO: allow plugins to select insertion point
    phase_providers = [p[_ScalaRulePhase] for p in ctx.attr.plugins if _ScalaRulePhase in p]
    phases = [(pp.name, pp.function) for pp in phase_providers] + phases

    print("phases: %s" % ", ".join([name for (name, _) in phases]))

    gd = {
        "init": init,
        "out": struct(
            providers = [],
            output_groups = {},
        ),
    }
    g = struct(**gd)
    for (name, function) in phases:
        p = function(ctx, g)
        if p != None:
            gd[name] = p
            g = struct(**gd)

    return g

_SINGLE_JAR_MNEMONIC = "SingleJar"

#
# PHASE: resources
#
# Resource files are merged into a zip archive.
#
# The output is returned in the jar field so the singlejar
# phase will merge it into the final jar.
#

def _phase_resources(ctx, g):
    zipper_inputs, _, zipper_manifests = ctx.resolve_command(tools = [ctx.attr._zipper])

    if ctx.files.resources:
        jar = ctx.actions.declare_file("{}/resources.zip".format(ctx.label.name))
        args = ctx.actions.args()
        args.add("c", jar)
        args.set_param_file_format("multiline")
        args.use_param_file("@%s")
        for file in ctx.files.resources:
            args.add("{}={}".format(_resources_make_path(file, ctx.attr.resource_strip_prefix), file.path))
        ctx.actions.run(
            arguments = [args],
            executable = ctx.executable._zipper,
            inputs = ctx.files.resources,
            input_manifests = zipper_manifests,
            outputs = [jar],
            tools = zipper_inputs,
        )
        return struct(jar = jar)
    else:
        return struct()

def _resources_make_path(file, strip_prefix):
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

#
# PHASE: compile
#
# Compiles Scala sources ;)
#

def _phase_compile(ctx, g):
    runner = ctx.toolchains["@rules_scala_annex//rules/scala:runner_toolchain_type"]
    class_jar = ctx.actions.declare_file("{}/classes.jar".format(ctx.label.name))

    splugins = java_common.merge(_collect(JavaInfo, ctx.attr.plugins + g.init.scala_configuration.global_plugins))

    zinc_configuration = ctx.attr.scala[_ZincConfiguration]

    srcs = [file for file in ctx.files.srcs if file.extension.lower() in ["java", "scala"]]
    src_jars = [file for file in ctx.files.srcs if file.extension.lower() in ["srcjar"]]

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
        if _ScalaInfo in dep and dep[_ScalaInfo].macro
    ]
    compile_classpath = depset(order = "preorder", transitive = macro_classpath + [g.init.sdeps.transitive_compile_time_jars])

    tmp = ctx.actions.declare_directory("{}/tmp".format(ctx.label.name))

    javacopts = [
        ctx.expand_location(option, ctx.attr.data)
        for option in ctx.attr.javacopts + java_common.default_javac_opts(ctx, java_toolchain_attr = "_java_toolchain")
    ]

    zincs = [dep[_ZincInfo] for dep in ctx.attr.deps if _ZincInfo in dep]

    args = ctx.actions.args()
    args.add_all(depset(transitive = [zinc.deps for zinc in zincs]), map_each = _compile_analysis)
    args.add("--compiler_bridge", zinc_configuration.compiler_bridge)
    args.add_all("--compiler_classpath", g.init.scala_configuration.compiler_classpath)
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
    args.add("--tmp", tmp.path)
    args.add_all("--", srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [runner.runner])
    inputs = depset(
        [zinc_configuration.compiler_bridge] + g.init.scala_configuration.compiler_classpath + ctx.files.data + ctx.files.srcs + runner_inputs,
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
        execution_requirements = {"no-sandbox": "1", "supports-workers": "1"},
        arguments = [args],
    )

    jars = []
    for jar in g.javainfo.java_info.outputs.jars:
        jars.append(jar.class_jar)
        jars.append(jar.ijar)
    zinc_info = _ZincInfo(
        apis = apis,
        deps_files = depset([apis, relations], transitive = [zinc.deps_files for zinc in zincs]),
        label = ctx.label,
        relations = relations,
        deps = depset(
            [struct(
                apis = apis,
                jars = jars,
                label = ctx.label,
                relations = relations,
            )],
            transitive = [zinc.deps for zinc in zincs],
        ),
    )

    g.out.providers.append(zinc_info)
    return struct(
        jar = class_jar,
        # todo: see about cleaning up & generalizing fields below
        zinc_info = zinc_info,
        used = used,
        mains_file = mains_file,
    )

def _compile_analysis(analysis):
    return [
        "--analysis",
        "_{}".format(analysis.label),
        analysis.apis.path,
        analysis.relations.path,
    ] + [jar.path for jar in analysis.jars]

#
# PHASE: depscheck
# Dependencies are checked to see if they are used/unused.
# Success files are outputted if dependency checking was "successful"
# according to the configuration/options.

def _phase_depscheck(ctx, g):
    deps_toolchain = ctx.toolchains["@rules_scala_annex//rules/scala:deps_toolchain_type"]
    deps_checks = {}
    labeled_jars = depset(transitive = [dep[_LabeledJars].values for dep in ctx.attr.deps])
    deps_inputs, _, deps_input_manifests = ctx.resolve_command(tools = [deps_toolchain.runner])
    for name in ("direct", "used"):
        deps_check = ctx.actions.declare_file("{}/depscheck_{}.success".format(ctx.label.name, name))
        deps_args = ctx.actions.args()
        deps_args.add(name, format = "--check_%s=true")
        deps_args.add_all("--direct", [dep.label for dep in ctx.attr.deps], format_each = "_%s")
        deps_args.add_all(labeled_jars, map_each = _depscheck_labeled_group)
        deps_args.add("--label", ctx.label, format = "_%s")
        deps_args.add_all("--whitelist", [dep.label for dep in ctx.attr.deps_used_whitelist], format_each = "_%s")
        deps_args.add("--")
        deps_args.add(g.compile.used)
        deps_args.add(deps_check)
        deps_args.set_param_file_format("multiline")
        deps_args.use_param_file("@%s", use_always = True)
        ctx.actions.run(
            mnemonic = "ScalaCheckDeps",
            inputs = [g.compile.used] + deps_inputs,
            outputs = [deps_check],
            executable = deps_toolchain.runner.files_to_run.executable,
            input_manifests = deps_input_manifests,
            execution_requirements = {"supports-workers": "1"},
            arguments = [deps_args],
        )
        deps_checks[name] = deps_check

    outputs = []

    if deps_toolchain.direct == "error":
        outputs.append(deps_checks["direct"])
    if deps_toolchain.used == "error":
        outputs.append(deps_checks["used"])

    g.out.output_groups["depscheck"] = depset(outputs)

    return struct(
        toolchain = deps_toolchain,
        checks = deps_checks,
        outputs = outputs,
    )

def _depscheck_labeled_group(labeled_jars):
    return (["--group", "_{}".format(labeled_jars.label)] + [jar.path for jar in labeled_jars.jars.to_list()])

#
# PHASE: singlejar
#
# Creates a single jar output from any resource jars as well
# as any jar entries from previous phases. The output is the
# output is written to ctx.outputs.jar.
#
# Additionally, this phase checks for missing outputs from previous
# phases. This allows phases to error, cleanly, by declaring a file
# in the outputs field but _without_ actually creating it.
#

def _phase_singlejar(ctx, g):
    inputs = [g.compile.jar] + ctx.files.resource_jars
    args = ctx.actions.args()
    args.add("--exclude_build_data")
    args.add("--normalize")

    for file in [f for f in ctx.files.resource_jars if f.extension.lower() in ["jar"]]:
        args.add("--sources")
        args.add(file)

    for v in [getattr(g, k) for k in dir(g)[::-1] if k not in ["to_json", "to_proto"]]:
        if hasattr(v, "jar"):
            jar = getattr(v, "jar")
            args.add("--sources", jar)
            inputs.append(jar)
        if hasattr(v, "outputs"):
            # Declare all phase outputs as inputs but _don't_ include them in the args
            # for singlejar to process. This will cause the build to fail, cleanly, if
            # any declared outputs are missing from previous phases.
            inputs.extend(getattr(v, "outputs"))

    args.add("--output", ctx.outputs.jar)
    args.add("--warn_duplicate_resources")
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    ctx.actions.run(
        arguments = [args],
        executable = ctx.executable._singlejar,
        execution_requirements = {"supports-workers": "1"},
        mnemonic = _SINGLE_JAR_MNEMONIC,
        inputs = inputs,  # TODO: build up inputs as a depset
        outputs = [ctx.outputs.jar],
    )

#
# PHASE: javainfo
#
# Builds up the JavaInfo provider. And the ScalaInfo, while we're at it.
# And DefaultInfo.
#

def _phase_javainfo(ctx, g):
    sruntime_deps = java_common.merge(_collect(JavaInfo, ctx.attr.runtime_deps))
    sexports = java_common.merge(_collect(JavaInfo, ctx.attr.exports))
    scala_configuration_runtime_deps = _collect(JavaInfo, g.init.scala_configuration.runtime_classpath)

    if len(ctx.attr.srcs) == 0:
        java_info = java_common.merge([g.init.sdeps, sexports])
    else:
        compile_jar = java_common.run_ijar(
            ctx.actions,
            jar = ctx.outputs.jar,
            target_label = ctx.label,
            java_toolchain = ctx.attr._java_toolchain,
        )

        source_jar = java_common.pack_sources(
            ctx.actions,
            output_jar = ctx.outputs.jar,
            sources = ctx.files.srcs,
            host_javabase = ctx.attr._host_javabase,
            java_toolchain = ctx.attr._java_toolchain,
        )

        java_info = JavaInfo(
            compile_jar = compile_jar,
            neverlink = getattr(ctx.attr, "neverlink", False),
            output_jar = ctx.outputs.jar,
            source_jar = source_jar,
            exports = [sexports],
            runtime_deps = [sruntime_deps] + scala_configuration_runtime_deps,
            deps = [g.init.sdeps],
        )

    scala_info = _ScalaInfo(
        macro = ctx.attr.macro,
        scala_configuration = g.init.scala_configuration,
    )

    output_group_info = OutputGroupInfo(
        **g.out.output_groups
    )

    g.out.providers.extend([
        output_group_info,
        java_info,
        scala_info,
    ])

    return struct(
        output_group_info = output_group_info,
        java_info = java_info,
        scala_info = scala_info,
    )

#
# PHASE: ijinfo
#
# Creates IntelliJ info
#

def _phase_ijinfo(ctx, g):
    intellij_info = _create_intellij_info(ctx.label, ctx.attr.deps, g.javainfo.java_info)
    g.out.providers.append(intellij_info)
    return struct(intellij_info = intellij_info)

#
# PHASE: library_defaultinfo
#
# Creates DefaultInfo for Scala libraries
#

def _phase_library_defaultinfo(ctx, g):
    g.out.providers.append(DefaultInfo(
        files = depset([ctx.outputs.jar]),
    ))

#
# PHASE: binary_deployjar
#
# Writes the optional deploy jar that includes all of the dependencies
#

def _phase_binary_deployjar(ctx, g):
    transitive_rjars = g.javainfo.java_info.transitive_runtime_jars
    rjars = depset([ctx.outputs.jar], transitive = [transitive_rjars])
    _binary_deployjar_build_deployable(ctx, rjars.to_list())

def _binary_deployjar_build_deployable(ctx, jars_list):
    # This calls bazels singlejar utility.
    # For a full list of available command line options see:
    # https://github.com/bazelbuild/bazel/blob/master/src/java_tools/singlejar/java/com/google/devtools/build/singlejar/SingleJar.java#L311
    args = ctx.actions.args()
    args.add("--normalize")
    args.add("--compression")
    args.add("--sources")
    args.add_all([j.path for j in jars_list])
    if getattr(ctx.attr, "main_class", ""):
        args.add_all(["--main_class", ctx.attr.main_class])
    args.add_all(["--output", ctx.outputs.deploy_jar.path])

    ctx.actions.run(
        inputs = jars_list,
        outputs = [ctx.outputs.deploy_jar],
        executable = ctx.executable._singlejar,
        execution_requirements = {"supports-workers": "1"},
        mnemonic = _SINGLE_JAR_MNEMONIC,
        progress_message = "scala deployable %s" % ctx.label,
        arguments = [args],
    )

#
# PHASE: binary_launcher
#
# Writes a Scala binary launcher
#

def _phase_binary_launcher(ctx, g):
    mains_file = g.compile.mains_file
    files = _write_launcher(
        ctx,
        "{}/".format(ctx.label.name),
        ctx.outputs.bin,
        g.javainfo.java_info.transitive_runtime_deps,
        jvm_flags = [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags],
        main_class = ctx.attr.main_class or "$(head -1 $JAVA_RUNFILES/{}/{})".format(ctx.workspace_name, mains_file.short_path),
    )

    g.out.providers.append(DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset([ctx.outputs.bin, ctx.outputs.jar]),
        runfiles = ctx.runfiles(
            files = files + ctx.files.data + [mains_file],
            transitive_files = depset(
                direct = [ctx.executable._java],
                order = "default",
                transitive = [g.javainfo.java_info.transitive_runtime_deps],
            ),
            collect_default = True,
        ),
    ))

#
# PHASE: test_launcher
#
# Writes a Scala test launcher
#

def _phase_test_launcher(ctx, g):

    files = ctx.files._java + [g.compile.zinc_info.apis]

    test_jars = g.javainfo.java_info.transitive_runtime_deps
    runner_jars = ctx.attr.runner[JavaInfo].transitive_runtime_deps
    all_jars = [test_jars, runner_jars]

    args = ctx.actions.args()
    args.add("--apis", g.compile.zinc_info.apis.short_path)
    args.add_all("--frameworks", ctx.attr.frameworks)
    if ctx.attr.isolation == "classloader":
        shared_deps = java_common.merge(_collect(JavaInfo, ctx.attr.shared_deps))
        args.add("--isolation", "classloader")
        args.add_all("--shared_classpath", shared_deps.transitive_runtime_deps, map_each = _test_launcher_short_path)
    elif ctx.attr.isolation == "process":
        subprocess_executable = ctx.actions.declare_file("{}/subprocess".format(ctx.label.name))
        subprocess_runner_jars = ctx.attr.subprocess_runner[JavaInfo].transitive_runtime_deps
        all_jars.append(subprocess_runner_jars)
        files += _write_launcher(
            ctx,
            "{}/subprocess-".format(ctx.label.name),
            subprocess_executable,
            subprocess_runner_jars,
            "annex.SubprocessTestRunner",
            [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags],
        )
        files.append(subprocess_executable)
        args.add("--isolation", "process")
        args.add("--subprocess_exec", subprocess_executable.short_path)
    args.add_all("--", g.javainfo.java_info.transitive_runtime_jars, map_each = _test_launcher_short_path)
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file("{}/test.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    files.append(args_file)

    files += _write_launcher(
        ctx,
        "{}/".format(ctx.label.name),
        ctx.outputs.bin,
        runner_jars,
        "annex.TestRunner",
        [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags] + [
            "-Dbazel.runPath=$RUNPATH",
            "-DscalaAnnex.test.args=${{RUNPATH}}{}".format(args_file.short_path),
        ],
    )

    g.out.providers.append(DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset([ctx.outputs.jar]),
        runfiles = ctx.runfiles(
            collect_data = True,
            collect_default = True,
            files = files,
            transitive_files = depset([], transitive = all_jars),
        ),
    ))

def _test_launcher_short_path(file):
    return file.short_path

#
# PHASE: coda
#
# Creates the final rule return structure
#

def _phase_coda(ctx, g):
    return struct(
        java = g.ijinfo.intellij_info,
        providers = g.out.providers,
    )


shared_prologue = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
]

scala_library_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("library_defaultinfo", _phase_library_defaultinfo),
    ("coda", _phase_coda),
]

scala_binary_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("binary_deployjar", _phase_binary_deployjar),
    ("binary_launcher", _phase_binary_launcher),
    ("coda", _phase_coda),
]

scala_test_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("test_launcher", _phase_test_launcher),
    ("coda", _phase_coda),
]

def scala_library_implementation(ctx):
    return run_phases(ctx, scala_library_phases).coda

def scala_binary_implementation(ctx):
    return run_phases(ctx, scala_binary_phases).coda

def scala_test_implementation(ctx):
    return run_phases(ctx, scala_test_phases).coda
