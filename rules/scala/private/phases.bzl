load(
    "@rules_scala_annex//rules:providers.bzl",
    _LabeledJars = "LabeledJars",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaInfo = "ScalaInfo",
    _ScalaRulePhase = "ScalaRulePhase",
    _ZincConfiguration = "ZincConfiguration",
    _ZincInfo = "ZincInfo",
)
load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
    _collect = "collect",
    _strip_margin = "strip_margin",
    _write_launcher = "write_launcher",
)
load(
    "//rules/scalafmt:private/test.bzl",
    _build_format = "build_format",
    _format_runner = "format_runner",
    _format_tester = "format_tester",
)
load(
    ":private/import.bzl",
    _create_intellij_info = "create_intellij_info",
)

def run_phases(ctx, phases):
    scala_configuration = ctx.attr.scala[_ScalaConfiguration]
    init = struct(
        scala_configuration = scala_configuration,
    )

    phase_provider_sources = [ctx.attr.scala] + ctx.attr.plugins
    phase_providers = [
        p[_ScalaRulePhase]
        for p in phase_provider_sources
        if _ScalaRulePhase in p
    ]
    if phase_providers != []:
        phases = phases[:]

    for pp in phase_providers:
        for (relation, peer_name, name, function) in pp.phases:
            for idx, (needle, _) in enumerate(phases):
                if needle == peer_name:
                    if relation in ["-", "before"]:
                        phases.insert(idx, (name, function))
                    elif relation in ["+", "after"]:
                        phases.insert(idx + 1, (name, function))
                    elif relation in ["=", "replace"]:
                        phases[idx] = (name, function)

    gd = {
        "init": init,
        "out": struct(
            output_groups = {},
            providers = [],
        ),
    }
    g = struct(**gd)
    for (name, function) in phases:
        p = function(ctx, g)
        if p != None:
            gd[name] = p
            g = struct(**gd)

    return g

def phase_noop(ctx, g):
    print("noop phase")

#
# PHASE: resources
#
# Resource files are merged into a zip archive.
#
# The output is returned in the jar field so the singlejar
# phase will merge it into the final jar.
#

def phase_resources(ctx, g):
    if ctx.files.resources:
        resource_jar = ctx.actions.declare_file("{}/resources.jar".format(ctx.label.name))
        _action_singlejar(
            ctx,
            inputs = [],
            output = resource_jar,
            progress_message = "singlejar resources %s" % ctx.label.name,
            resources = {
                _resources_make_path(file, ctx.attr.resource_strip_prefix): file
                for file in ctx.files.resources
            },
        )
        return struct(jar = resource_jar)
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
# PHASE: classpaths
#
# Sets up classpaths and other common compilation items
#

def phase_classpaths(ctx, g):
    plugin_skip_jars = java_common.merge(
        _collect(JavaInfo, g.init.scala_configuration.compiler_classpath +
                           g.init.scala_configuration.runtime_classpath),
    ).transitive_runtime_jars.to_list()

    actual_plugins = []
    for plugin in ctx.attr.plugins + g.init.scala_configuration.global_plugins:
        deps = [dep for dep in plugin[JavaInfo].transitive_runtime_jars if dep not in plugin_skip_jars]
        if len(deps) == 1:
            actual_plugins.extend(deps)
        else:
            # scalac expects each plugin to be fully isolated, so we need to
            # smash everything together with singlejar
            print("WARNING! " +
                  "It is slightly inefficient to use a JVM target with " +
                  "dependencies directly as a scalac plugin. Please " +
                  "SingleJar the target before using it as a scalac plugin " +
                  "in order to avoid additional overhead.")

            plugin_singlejar = ctx.actions.declare_file(
                "{}/scalac_plugin_{}.jar".format(ctx.label.name, plugin.label.name),
            )
            _action_singlejar(
                ctx,
                inputs = deps,
                output = plugin_singlejar,
                progress_message = "singlejar scalac plugin %s" % plugin.label.name,
            )
            actual_plugins.append(plugin_singlejar)

    plugin_classpath = depset(actual_plugins)

    macro_classpath = [
        dep[JavaInfo].transitive_runtime_jars
        for dep in ctx.attr.deps
        if _ScalaInfo in dep and dep[_ScalaInfo].macro
    ]
    sdeps = java_common.merge(
        _collect(JavaInfo, g.init.scala_configuration.runtime_classpath + ctx.attr.deps),
    )
    compile_classpath = depset(
        order = "preorder",
        transitive = macro_classpath + [sdeps.transitive_compile_time_jars],
    )
    compiler_classpath = java_common.merge(
        _collect(JavaInfo, g.init.scala_configuration.compiler_classpath),
    ).transitive_runtime_jars

    srcs = [file for file in ctx.files.srcs if file.extension.lower() in ["java", "scala"]]
    src_jars = [file for file in ctx.files.srcs if file.extension.lower() in ["srcjar"]]

    jar = ctx.actions.declare_file("{}/classes.jar".format(ctx.label.name))

    return struct(
        srcs = srcs,
        compile = compile_classpath,
        compiler = compiler_classpath,
        jar = jar,
        plugin = plugin_classpath,
        sdeps = sdeps,
        src_jars = src_jars,
    )

#
# PHASE: compile
#
# Compiles Scala sources ;)
#

def phase_compile(ctx, g):
    zinc_configuration = ctx.attr.scala[_ZincConfiguration]

    apis = ctx.actions.declare_file("{}/apis.gz".format(ctx.label.name))
    infos = ctx.actions.declare_file("{}/infos.gz".format(ctx.label.name))
    mains_file = ctx.actions.declare_file("{}.jar.mains.txt".format(ctx.label.name))
    relations = ctx.actions.declare_file("{}/relations.gz".format(ctx.label.name))
    setup = ctx.actions.declare_file("{}/setup.gz".format(ctx.label.name))
    stamps = ctx.actions.declare_file("{}/stamps.gz".format(ctx.label.name))
    used = ctx.actions.declare_file("{}/deps_used.txt".format(ctx.label.name))

    tmp = ctx.actions.declare_directory("{}/tmp".format(ctx.label.name))

    javacopts = [
        ctx.expand_location(option, ctx.attr.data)
        for option in ctx.attr.javacopts + java_common.default_javac_opts(ctx, java_toolchain_attr = "_java_toolchain")
    ]

    zincs = [dep[_ZincInfo] for dep in ctx.attr.deps if _ZincInfo in dep]

    args = ctx.actions.args()
    args.add_all(depset(transitive = [zinc.deps for zinc in zincs]), map_each = _compile_analysis)
    args.add("--compiler_bridge", zinc_configuration.compiler_bridge)
    args.add_all("--compiler_classpath", g.classpaths.compiler)
    args.add_all("--classpath", g.classpaths.compile)
    args.add_all(ctx.attr.scalacopts, format_each = "--compiler_option=%s")
    args.add_all(javacopts, format_each = "--java_compiler_option=%s")
    args.add(ctx.label, format = "--label=%s")
    args.add("--main_manifest", mains_file)
    args.add("--output_apis", apis)
    args.add("--output_infos", infos)
    args.add("--output_jar", g.classpaths.jar)
    args.add("--output_relations", relations)
    args.add("--output_setup", setup)
    args.add("--output_stamps", stamps)
    args.add("--output_used", used)
    args.add_all("--plugins", g.classpaths.plugin)
    args.add_all("--source_jars", g.classpaths.src_jars)
    args.add("--tmp", tmp.path)
    args.add_all("--", g.classpaths.srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    worker = zinc_configuration.compile_worker

    worker_inputs, _, input_manifests = ctx.resolve_command(tools = [worker])
    inputs = depset(
        [zinc_configuration.compiler_bridge] + ctx.files.data + ctx.files.srcs + worker_inputs,
        transitive = [
            g.classpaths.plugin,
            g.classpaths.compile,
            g.classpaths.compiler,
        ] + [zinc.deps_files for zinc in zincs],
    )

    outputs = [g.classpaths.jar, mains_file, apis, infos, relations, setup, stamps, used, tmp]

    # todo: different execution path for nosrc jar?
    ctx.actions.run(
        mnemonic = "ScalaCompile",
        inputs = inputs,
        outputs = outputs,
        executable = worker.files_to_run.executable,
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
        mains_file = mains_file,
        used = used,
        # todo: see about cleaning up & generalizing fields below
        zinc_info = zinc_info,
    )

def _compile_analysis(analysis):
    return [
        "--analysis",
        "_{}".format(analysis.label),
        analysis.apis.path,
        analysis.relations.path,
    ] + [jar.path for jar in analysis.jars]

#
# PHASE: bootstrap compile
#
# An alternative compile phase that shells out to scalac directly
#

def phase_bootstrap_compile(ctx, g):
    if g.classpaths.plugin:
        fail("plugins aren't supported for bootstrap_scala rules")
    if g.classpaths.src_jars:
        fail("source jars supported for bootstrap_scala rules")

    inputs = depset(
        [ctx.executable._java] + ctx.files.srcs,
        transitive = [g.classpaths.compile, g.classpaths.compiler],
    )

    compiler_classpath = ":".join([f.path for f in g.classpaths.compiler])
    compile_classpath = ":".join([f.path for f in g.classpaths.compile])
    srcs = " ".join([f.path for f in g.classpaths.srcs])

    ctx.actions.run_shell(
        inputs = inputs,
        tools = [ctx.executable._jar_creator],
        outputs = [g.classpaths.jar],
        command = _strip_margin(
            """
            |set -eo pipefail
            |
            |mkdir -p tmp/classes
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
                java = ctx.executable._java.path,
                jar_creator = ctx.executable._jar_creator.path,
                compiler_classpath = compiler_classpath,
                compile_classpath = compile_classpath,
                srcs = srcs,
                output_jar = g.classpaths.jar.path,
            ),
        ),
    )

#
# PHASE: depscheck
# Dependencies are checked to see if they are used/unused.
# Success files are outputted if dependency checking was "successful"
# according to the configuration/options.
#

def phase_depscheck(ctx, g):
    deps_checks = {}
    labeled_jars = depset(transitive = [dep[_LabeledJars].values for dep in ctx.attr.deps])
    zinc_configuration = ctx.attr.scala[_ZincConfiguration]  # TODO: different provider
    worker = zinc_configuration.deps_worker
    worker_inputs, _, worker_input_manifests = ctx.resolve_command(tools = [worker])
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
            inputs = [g.compile.used] + worker_inputs,
            outputs = [deps_check],
            executable = worker.files_to_run.executable,
            input_manifests = worker_input_manifests,
            execution_requirements = {"supports-workers": "1"},
            arguments = [deps_args],
        )
        deps_checks[name] = deps_check

    outputs = []

    deps_toolchain = ctx.toolchains["@rules_scala_annex//rules/scala:deps_toolchain_type"]
    if deps_toolchain.direct == "error":
        outputs.append(deps_checks["direct"])
    if deps_toolchain.used == "error":
        outputs.append(deps_checks["used"])

    g.out.output_groups["depscheck"] = depset(outputs)

    return struct(
        checks = deps_checks,
        outputs = outputs,
        toolchain = deps_toolchain,
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

def phase_singlejar(ctx, g):
    # We're going to declare all phase outputs as inputs but skip
    # including them in the args for singlejar to process. This will
    # cause the build to fail, cleanly, if any declared outputs are
    # missing from previous phases.
    inputs = [f for f in ctx.files.resource_jars if f.extension.lower() in ["jar"]]
    phantom_inputs = []
    for v in [getattr(g, k) for k in dir(g) if k not in ["to_json", "to_proto"]]:
        if hasattr(v, "jar"):
            jar = getattr(v, "jar")
            inputs.append(jar)
        if hasattr(v, "outputs"):
            phantom_inputs.extend(getattr(v, "outputs"))

    _action_singlejar(ctx, inputs, ctx.outputs.jar, phantom_inputs)

#
# PHASE: javainfo
#
# Builds up the JavaInfo provider. And the ScalaInfo, while we're at it.
# And DefaultInfo.
#

def phase_javainfo(ctx, g):
    sruntime_deps = java_common.merge(_collect(JavaInfo, ctx.attr.runtime_deps))
    sexports = java_common.merge(_collect(JavaInfo, ctx.attr.exports))
    scala_configuration_runtime_deps = _collect(JavaInfo, g.init.scala_configuration.runtime_classpath)

    if len(ctx.attr.srcs) == 0:
        java_info = java_common.merge([g.classpaths.sdeps, sexports])
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
            deps = [g.classpaths.sdeps],
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
        java_info = java_info,
        output_group_info = output_group_info,
        scala_info = scala_info,
    )

#
# PHASE: ijinfo
#
# Creates IntelliJ info
#

def phase_ijinfo(ctx, g):
    intellij_info = _create_intellij_info(ctx.label, ctx.attr.deps, g.javainfo.java_info)
    g.out.providers.append(intellij_info)
    return struct(intellij_info = intellij_info)

#
# PHASE: library_defaultinfo
#
# Creates DefaultInfo for Scala libraries
#

def phase_library_defaultinfo(ctx, g):
    g.out.providers.append(DefaultInfo(
        files = depset([ctx.outputs.jar]),
    ))

#
# PHASE: non_default_format
#
# Format the scala files when it is explicitly specified
#

def phase_non_default_format(ctx, g):
    if ctx.attr.format:
        manifest, files = _build_format(ctx)
        _format_runner(ctx, manifest, files)
        _format_tester(ctx, manifest, files)
    else:
        ctx.actions.write(
            output = ctx.outputs.runner,
            content = "",
            is_executable = True,
        )
        ctx.actions.write(
            output = ctx.outputs.testrunner,
            content = "",
            is_executable = True,
        )

#
# PHASE: binary_deployjar
#
# Writes the optional deploy jar that includes all of the dependencies
#

def phase_binary_deployjar(ctx, g):
    main_class = None
    if getattr(ctx.attr, "main_class", ""):
        main_class = ctx.attr.main_class
    _action_singlejar(
        ctx,
        inputs = depset(
            [ctx.outputs.jar],
            transitive = [g.javainfo.java_info.transitive_runtime_jars],
        ),
        main_class = main_class,
        output = ctx.outputs.deploy_jar,
        progress_message = "scala deployable %s" % ctx.label,
    )

#
# PHASE: binary_launcher
#
# Writes a Scala binary launcher
#

def phase_binary_launcher(ctx, g):
    inputs = ctx.files.data

    if ctx.attr.main_class != "":
        main_class = ctx.attr.main_class
    else:
        mains_file = g.compile.mains_file
        inputs = inputs + [mains_file]
        main_class = "$(head -1 $JAVA_RUNFILES/{}/{})".format(ctx.workspace_name, mains_file.short_path)

    files = _write_launcher(
        ctx,
        "{}/".format(ctx.label.name),
        ctx.outputs.bin,
        g.javainfo.java_info.transitive_runtime_deps,
        jvm_flags = [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags],
        main_class = main_class,
    )

    g.out.providers.append(DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset([ctx.outputs.bin, ctx.outputs.jar]),
        runfiles = ctx.runfiles(
            files = inputs + files,
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

def phase_test_launcher(ctx, g):
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
            "higherkindness.rules_scala.common.sbt_testing.SubprocessTestRunner",
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
        "higherkindness.rules_scala.workers.zinc.test.TestRunner",
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

def phase_coda(ctx, g):
    return struct(
        java = g.ijinfo.intellij_info,
        providers = g.out.providers,
    )
