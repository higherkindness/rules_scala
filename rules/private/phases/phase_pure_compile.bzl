load(
    "@rules_scala_annex//rules:providers.bzl"
)

#
# PHASE: compile
#
# Compiles Scala sources ;)
#

def phase_zinc_compile(ctx, g):
    pure_configuration = fail("OH NOES")

    mains_file = ctx.actions.declare_file("{}.jar.mains.txt".format(ctx.label.name))
    tmp = ctx.actions.declare_directory("{}/tmp".format(ctx.label.name))

    # todo: share with other rules?
    javacopts = [
        ctx.expand_location(option, ctx.attr.data)
        for option in ctx.attr.javacopts + java_common.default_javac_opts(ctx, java_toolchain_attr = "_java_toolchain")
    ]

    args = ctx.actions.args()
    #args.add("--compiler_bridge", zinc_configuration.compiler_bridge)
    args.add_all("--compiler_classpath", g.classpaths.compiler)
    args.add_all("--classpath", g.classpaths.compile)
    args.add_all(ctx.attr.scalacopts, format_each = "--compiler_option=%s")
    args.add_all(javacopts, format_each = "--java_compiler_option=%s")
    args.add(ctx.label, format = "--label=%s")
    args.add("--main_manifest", mains_file)
    args.add("--output_jar", g.classpaths.jar)
    args.add_all("--plugins", g.classpaths.plugin)
    args.add_all("--source_jars", g.classpaths.src_jars)
    args.add("--tmp", tmp.path)
    args.add_all("--", g.classpaths.srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    worker = pure_configuration.compile_worker

    worker_inputs, _, input_manifests = ctx.resolve_command(tools = [worker])
    inputs = depset(
        [pure_configuration.compiler_bridge] + ctx.files.data + ctx.files.srcs + worker_inputs,
        transitive = [
            g.classpaths.plugin,
            g.classpaths.compile,
            g.classpaths.compiler,
        ],
    )

    outputs = [g.classpaths.jar, mains_file, tmp]

    # todo: different execution path for nosrc jar?
    ctx.actions.run(
        mnemonic = "PureScalaCompile",
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
