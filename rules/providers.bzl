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
    },
)

def _declare_scala_configuration_implementation(ctx):
    return [
        java_common.merge(_collect(JavaInfo, ctx.attr.compiler_classpath)),
        ScalaConfiguration(
            compiler_classpath = ctx.files.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
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
    },
)

def _declare_zinc_configuration_implementation(ctx):
    return [ZincConfiguration(
        compiler_bridge = ctx.files.compiler_bridge,
    )]

declare_zinc_configuration = rule(
    attrs = {
        "compiler_bridge": attr.label(
            allow_single_file = True,
            mandatory = True,
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
