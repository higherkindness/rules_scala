load(":internal/utils.bzl", utils = "root")
load(":providers.bzl",
     "ScalaConfiguration",
     "ScalaInfo",
)

###
######
###


def annex_scala_runner_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        runner = ctx.attr.runner,
    )]

def annex_configure_scala_implementation(ctx):
    compiler_bridge = _compile_compiler_bridge(
        ctx,
        compiler_classpath = ctx.files.compiler_classpath,
        compiler_bridge_classpath = ctx.files.compiler_bridge_classpath,
        compiler_bridge_sources_jar = ctx.attr.compiler_bridge.java.source_jars.to_list()[0],
    )

    return [ScalaConfiguration(
        version = ctx.attr.version,
        organization = ctx.attr.organization,
        binary_version = ctx.attr.binary_version,
        compiler_bridge = compiler_bridge,
        compiler_classpath = ctx.files.compiler_classpath,
        runtime_classpath = ctx.files.runtime_classpath,
    )]

annex_configure_scala_private_attributes = {
    "_java": attr.label(
        default     = Label("@bazel_tools//tools/jdk:java"),
        executable  = True,
        cfg         = "host",
    ),
    "_jar": attr.label(
        default     = Label("@bazel_tools//tools/jdk:jar"),
        executable  = True,
        cfg         = "host",
    ),
    "_jar_creator": attr.label(
        default     = Label('//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper:jarcreator_bin'),    
        executable  = True,
        cfg         = "host",
    ),
}

def _compile_compiler_bridge(
        ctx,
        compiler_classpath,
        compiler_bridge_classpath,
        compiler_bridge_sources_jar,
        suffix = None,
        jar = None,
        jar_creator = None,
        java = None,
):
    """
    compiles the zinc compiler bridge for a specific version of Scala
    """

    if suffix == None: suffix = ctx.label.name
    if jar == None: jar = ctx.executable._jar
    if jar_creator == None: jar_creator = ctx.executable._jar_creator
    if java == None: java = ctx.executable._java

    compiler_bridge = ctx.actions.declare_file(
        "compiler-bridge_%s.jar" % suffix)

    compiler_classpath_str = ':'.join([file.path for file in compiler_classpath])
    compiler_bridge_classpath_str = ':'.join([file.path for file in compiler_bridge_classpath])
    compiler_bridge_classpath_str = compiler_classpath_str + ':' + compiler_bridge_classpath_str

    inputs = depset()
    inputs += [jar]
    inputs += [java]
    inputs += compiler_classpath
    inputs += compiler_bridge_classpath
    inputs += [compiler_bridge_sources_jar]
    inputs += [ctx.executable._jar_creator]

    ctx.actions.run_shell(
        progress_message = "compiling zinc compiler bridge %s" % suffix,
        inputs = inputs,
        outputs = [compiler_bridge],
        command = utils.strip_margin("""
          |#!/bin/bash
          |
          |mkdir bridge_src
          |mkdir bridge_bin
          |
          |pushd bridge_src
          |../{jar} xf ../{compiler_bridge_sources_jar}
          |popd
          |
          |{java} \\
          |  -cp {compiler_classpath} \\
          |  scala.tools.nsc.Main \\
          |  -cp {compiler_bridge_classpath} \\
          |  -d bridge_bin \\
          |  `find bridge_src -name "*.scala"`
          |
          |{jar_creator} {out_file} bridge_bin 2> /dev/null
          |
          |""".format(
              jar = jar.path,
              jar_creator = jar_creator.path,
              java = java.path,
              compiler_bridge_sources_jar = compiler_bridge_sources_jar.path,
              compiler_classpath = compiler_classpath_str,
              compiler_bridge_classpath = compiler_bridge_classpath_str,
              out_file = compiler_bridge.path)
        ),
    )

    return compiler_bridge

###
######
###

def _filesArg(files):
    return [str(len(files))] + [file.path for file in files]

def _stringsArg(strings):
    return [str(len(strings))] + [string for string in strings]

def _collect_crossed_deps(current_version, deps):
    res = []
    for dep in deps:
        if ScalaInfo in dep:
            res += [
                java_info
                for version, java_info in dep[ScalaInfo].java_infos
                if version == current_version]
    return res

def _runner_common(ctx):
    runner = ctx.toolchains['//rules:runner_toolchain_type'].runner

    universal_plugins = [plugin[JavaInfo] for plugin in ctx.attr.plugins if JavaInfo in plugin]
    universal_deps = [dep[JavaInfo] for dep in ctx.attr.deps if JavaInfo in dep]
    universal_exports = [export[JavaInfo] for export in ctx.attr.exports if JavaInfo in export]

    frameworks = []
    if hasattr(ctx.attr, 'frameworks'):
        frameworks = ctx.attr.frameworks

    java_infos = []
    files = depset()
    mains_files = depset()
    for entry in ctx.attr.scala:
        configuration = entry[ScalaConfiguration]

        splugin = java_common.merge(
            universal_plugins + _collect_crossed_deps(configuration.version, ctx.attr.plugins))

        sdep = java_common.merge(
            universal_deps + _collect_crossed_deps(configuration.version, ctx.attr.deps))

        sexport = java_common.merge(
            universal_exports + _collect_crossed_deps(configuration.version, ctx.attr.exports))

        #print("%s : %s" % (ctx.label.name, splugin.transitive_runtime_jars))
        #print("%s : %s" % (ctx.label.name, sdep.compile_jars))
        #print("%s : %s" % (ctx.label.name, sexport.compile_jars))
        print(configuration.version)

        project_name = utils.safe_name(ctx.attr.name)
        target_directory = ctx.actions.declare_directory(
            "%s/%s/target" % (ctx.label.name, configuration.version))
        classes_directory = ctx.actions.declare_directory(
            "%s/classes" % target_directory.path)
        output = ctx.actions.declare_file(
            "%s/bin/%s.jar" % (target_directory.path, project_name))
        mains_file = ctx.actions.declare_file(
            "%s/bin/%s.jar.mains.txt" % (target_directory.path, project_name))
        bloop_config = ctx.actions.declare_file(
            "%s/.bloop/%s.json" % (target_directory.path, project_name))
        print(bloop_config.path)

        if len(ctx.attr.srcs) == 0:
            java_info = java_common.merge([sdep, sexport])
        else:
            java_info = JavaInfo(
                output_jar = output,
                use_ijar = ctx.attr.use_ijar,
                sources = ctx.files.srcs,
                deps = [sdep],
                exports = [sexport],
                runtime_deps = [java_common.create_provider(runtime_jars = configuration.runtime_classpath)],
                actions = ctx.actions,
                java_toolchain = ctx.attr._java_toolchain,
            )

        args = ctx.actions.args()
        args.add(True) # verbose
        args.add(bloop_config.path) # bloopConfig
        args.add(project_name) # projectName
        args.add(ctx.build_file_path) # buildFilePath
        args.add(output.path) # outputJar
        args.add(classes_directory.path) # outputDir
        args.add(target_directory.path) # targetDir
        args.add(configuration.version) # scalaVersion
        args.add(configuration.organization) # scalaOrganization
        args.add(_filesArg(configuration.compiler_classpath)) # compilerClasspath
        args.add(configuration.compiler_bridge.path) # compilerBridge
        args.add(_filesArg(splugin.transitive_runtime_deps)) # pluginsClasspath
        args.add(_filesArg(ctx.files.srcs)) # sources
        args.add(_filesArg(sdep.transitive_deps)) # compilationClasspath
        args.add(_filesArg(sdep.compile_jars)) # allowedClasspath
        args.add(True) # toggle for testOptions
        args.add(_stringsArg(frameworks)) # optional: testOptions

        args_file = ctx.actions.declare_file(
            "%s/bin/%s.args" % (ctx.label.name, configuration.version))
        ctx.actions.write(args_file, args)

        runner_inputs, _, input_manifests = ctx.resolve_command(tools=[runner])

        inputs = depset()
        inputs += runner_inputs
        inputs += [configuration.compiler_bridge]
        inputs += configuration.compiler_classpath
        inputs += sdep.transitive_deps
        inputs += ctx.files.srcs
        inputs += splugin.transitive_runtime_deps
        inputs += [args_file]

        outputs = [output, mains_file, classes_directory, bloop_config, target_directory]

        # todo: different execution path for nosrc jar?
        ctx.actions.run(
            mnemonic = 'ScalaCompile',
            inputs = inputs,
            outputs = outputs,
            executable = runner.files_to_run.executable,
            input_manifests = input_manifests,
            execution_requirements = { "supports-workers": "1" },
            arguments = ["@%s" % args_file.path]
        )

        files += [output, bloop_config]
        mains_files += [mains_file]
        java_infos += [(configuration.version, java_info)]

    return struct(
        scala_info = ScalaInfo(
            java_infos = java_infos,
        ),
        files = files,
        mains_files = mains_files
    )

_runner_common_attributes = {
    "_java_toolchain": attr.label(default = Label("@bazel_tools//tools/jdk:current_java_toolchain")),    
}

annex_scala_library_private_attributes = _runner_common_attributes
annex_scala_binary_private_attributes = utils.merge_dicts(_runner_common_attributes, {
    "_java": attr.label(
        default     = Label("@bazel_tools//tools/jdk:java"),
        executable  = True,
        cfg         = "host",
    ),
    "_java_stub_template": attr.label(
        default     = Label("@anx_java_stub_template//file"),
    ),
})
annex_scala_test_private_attributes = _runner_common_attributes

def annex_scala_library_implementation(ctx):
    res = _runner_common(ctx)
    return [
        res.scala_info,
        DefaultInfo(
            files = res.files)
    ]

def annex_scala_binary_implementation(ctx):
    res = _runner_common(ctx)

    # this is all super sketchy...
    # for the time being

    java_info = res.scala_info.java_infos[0][1]
    mains_file = res.mains_files.to_list()[0]

    launcher = ctx.new_file("%s_launcher.sh" % ctx.label.name)
    utils.write_launcher(
        ctx,
        launcher,
        java_info.transitive_runtime_deps,
        main_class = "",
        jvm_flags = ""
    )

    prelauncher = ctx.new_file("%s.sh" % ctx.label.name)
    ctx.actions.write(
        output = prelauncher,
        content = utils.strip_margin("""
          |{launcher} $(head -1 {mains_file}) "$@"
          |""".format(
              launcher = launcher.short_path,
              mains_file = mains_file.short_path
          )),
        is_executable = True
    )

    return [
        res.scala_info,
        DefaultInfo(
            executable = prelauncher,
            files      = res.files,
            runfiles   = ctx.runfiles(
                files = [launcher, mains_file],
                transitive_files = depset(
                    order      = "default",
                    direct     = [ctx.executable._java],
                    transitive = [java_info.transitive_runtime_deps],
                ),
                collect_default = True
            ),
        )
    ]

def annex_scala_test_implementation(ctx):
    res = _runner_common(ctx)

    runner = ctx.new_file("%s_anx_test_all.sh" % ctx.label.name)

    ctx.file_action(
        output = runner,
        content = utils.strip_margin("""
          |#!/bin/bash
          |echo OKIE DOKIE
          |"""),
        executable = True
    )

    return [res.scala_info] + [DefaultInfo(
        executable = runner,
        runfiles = ctx.runfiles([
            runner
        ]),
        files = res.files
    )]
