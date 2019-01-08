load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
)

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
