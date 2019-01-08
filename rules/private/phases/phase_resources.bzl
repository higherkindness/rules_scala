load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
)
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
