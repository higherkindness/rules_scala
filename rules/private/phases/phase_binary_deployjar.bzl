load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
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
        compression = True,
    )
