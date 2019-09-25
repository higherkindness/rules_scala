load(
    "//rules/scalafmt:private/test.bzl",
    _build_format = "build_format",
    _format_runner = "format_runner",
    _format_tester = "format_tester",
)

#
# PHASE: phase_scalafmt_nondefault_outputs
#
# Outputs to format the scala files when it is explicitly specified
#

def phase_scalafmt_nondefault_outputs(ctx, g):
    if ctx.attr.format:
        manifest, files = _build_format(ctx)
        _format_runner(ctx, manifest, files)
        _format_tester(ctx, manifest, files)
    else:
        ctx.actions.write(
            output = ctx.outputs.scalafmt_runner,
            content = "",
            is_executable = True,
        )
        ctx.actions.write(
            output = ctx.outputs.scalafmt_testrunner,
            content = "",
            is_executable = True,
        )
