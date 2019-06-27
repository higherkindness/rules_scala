load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaInfo = "ScalaInfo",
)
load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
    _collect = "collect",
)

def phase_classpaths(ctx, g):
    plugin_skip_jars = java_common.merge(
        _collect(JavaInfo, g.init.scala_configuration.compiler_classpath +
                           g.init.scala_configuration.runtime_classpath),
    ).transitive_runtime_jars.to_list()

    actual_plugins = []
    for plugin in ctx.attr.plugins + g.init.scala_configuration.global_plugins:
        deps = [dep for dep in plugin[JavaInfo].transitive_runtime_jars.to_list() if dep not in plugin_skip_jars]
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
