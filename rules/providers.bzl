load(
    "//rules/common:private/utils.bzl",
    _collect = "collect",
    _collect_optionally = "collect_optionally",
)

ScalaConfiguration = provider(
    doc = "Scala compile-time and runtime configuration",
    fields = {
        "version": "The Scala full version.",
        "compiler_classpath": "The compiler classpath.",
        "runtime_classpath": "The runtime classpath.",
        "global_plugins": "Globally enabled compiler plugins",
        "global_scalacopts": "Globally enabled compiler options",
    },
)

def _declare_scala_configuration_implementation(ctx):
    return [
        java_common.merge(_collect(JavaInfo, ctx.attr.compiler_classpath)),
        ScalaConfiguration(
            compiler_classpath = ctx.attr.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
            global_scalacopts = ctx.attr.global_scalacopts,
            runtime_classpath = ctx.attr.runtime_classpath,
            version = ctx.attr.version,
        ),
    ]

declare_scala_configuration = rule(
    attrs = {
        "version": attr.string(mandatory = True),
        "runtime_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "compiler_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "global_plugins": attr.label_list(
            doc = "Scalac plugins that will always be enabled.",
            providers = [JavaInfo],
        ),
        "global_scalacopts": attr.string_list(
            doc = "Scalac options that will always be enabled.",
        ),
    },
    doc = "Creates a `ScalaConfiguration`.",
    implementation = _declare_scala_configuration_implementation,
)

ScalaInfo = provider(
    doc = "Scala library.",
    fields = {
        "macro": "whether the jar contains macros",
        "scala_configuration": "ScalaConfiguration associated with this output",
    },
)

ZincConfiguration = provider(
    doc = "Zinc configuration.",
    fields = {
        "compiler_bridge": "compiled Zinc compiler bridge",
        "compile_worker": "the worker label for compilation with Zinc",
        "log_level": "log level for the Zinc compiler",
    },
)

DepsConfiguration = provider(
    doc = "Dependency checking configuration.",
    fields = {
        "direct": "either error or off",
        "used": "either error or off",
        "worker": "the worker label for checking used/unused deps",
    },
)

CodeCoverageConfiguration = provider(
    doc = "Code coverage related configuration",
    fields = {
        "instrumentation_worker": "the worker used for instrumenting jars",
    },
)

ScalaRulePhase = provider(
    doc = "A Scala compiler plugin",
    fields = {
        "phases": "the phases to add",
    },
)

def _reconfigure_deps_configuration_implementation(ctx):
    original_config = ctx.attr.provider[DepsConfiguration]

    direct = original_config.direct
    if ctx.attr.direct != "inherit":
        direct = ctx.attr.direct
    used = original_config.used
    if ctx.attr.used != "inherit":
        used = ctx.attr.used

    providers = [DepsConfiguration(
        direct = direct,
        used = used,
        worker = original_config.worker,
    )]
    if ScalaConfiguration in ctx.attr.provider:
        providers += [ctx.attr.provider[ScalaConfiguration]]
    if ZincConfiguration in ctx.attr.provider:
        providers += [ctx.attr.provider[ZincConfiguration]]
    if ScalaRulePhase in ctx.attr.provider:
        providers += [ctx.attr.provider[ScalaRulePhase]]

    return providers

reconfigure_deps_configuration = rule(
    attrs = {
        "provider": attr.label(
            mandatory = True,
            providers = [
                [DepsConfiguration],
            ],
        ),
        "direct": attr.string(default = "inherit"),
        "used": attr.string(default = "inherit"),
    },
    implementation = _reconfigure_deps_configuration_implementation,
)

def _declare_zinc_configuration_implementation(ctx):
    return [ZincConfiguration(
        compile_worker = ctx.attr._compile_worker,
        compiler_bridge = ctx.files.compiler_bridge,
    )]

declare_zinc_configuration = rule(
    attrs = {
        "compiler_bridge": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
        "_compile_worker": attr.label(
            default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/zinc/compile",
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
    },
    doc = "Creates a `ZincConfiguration`.",
    implementation = _declare_zinc_configuration_implementation,
)

ZincInfo = provider(
    doc = "Zinc-specific outputs.",
    fields = {
        "apis": "The API file.",
        "deps": "The depset of library dependency outputs.",
        "deps_files": "The depset of all Zinc files.",
        "label": "The label for this output.",
        "relations": "The relations file.",
    },
)

def _join_configurations_implementation(ctx):
    return (
        _collect_optionally(ScalaConfiguration, ctx.attr.configurations) +
        _collect_optionally(ZincConfiguration, ctx.attr.configurations)
    )

join_configurations = rule(
    attrs = {
        "configurations": attr.label_list(
            mandatory = True,
            providers = [
                [ScalaConfiguration],
                [ZincConfiguration],
            ],
        ),
    },
    implementation = _join_configurations_implementation,
)

# TODO: move these to another file?
# TODO: implement these with an aspect?

IntellijInfo = provider(
    doc = "Provider for IntelliJ.",
    fields = {
        "outputs": "java_output_jars",
        "transitive_exports": "labels of transitive dependencies",
    },
)

# TODO: compare to JavaInfo's owner
LabeledJars = provider(
    doc = "Exported jars and their labels.",
    fields = {
        "values": "The preorder depset of label and jars.",
    },
)
