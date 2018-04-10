load("//rules:providers.bzl", "JarsToLabels")

# Note to future authors:
#
# Tread lightly when modifying this code! IntelliJ support needs
# to be tested manually: manually [re-]import an intellij project
# and ensure imports are resolved (not red) and clickable
#

def scala_import_implementation(ctx):

    direct_binary_jars = []
    for jar in ctx.attr.jars:
        for file in jar.files:
            if not file.basename.endswith("-sources.jar"):
                direct_binary_jars += [file]

    return [
        _scala_import_java_info(ctx, direct_binary_jars),
        _scala_import_jars_to_labels(ctx, direct_binary_jars),
    ]

def _scala_import_java_info(ctx, direct_binary_jars):
    # merge all deps, exports, and runtime deps into single JavaInfo instances

    s_deps = java_common.merge(_collect(JavaInfo, ctx.attr.deps))
    s_exports = java_common.merge(_collect(JavaInfo, ctx.attr.exports))
    s_runtime_deps = java_common.merge(_collect(JavaInfo, ctx.attr.runtime_deps))

    # build up our final JavaInfo provider

    compile_time_jars = depset(
        direct = direct_binary_jars,
        transitive = [
            s_exports.transitive_compile_time_jars])

    transitive_compile_time_jars = depset(
        transitive = [
            compile_time_jars,
            s_deps.transitive_compile_time_jars,
            s_exports.transitive_compile_time_jars])

    transitive_runtime_jars = depset(
        transitive = [
            compile_time_jars,
            s_deps.transitive_runtime_jars,
            s_exports.transitive_runtime_jars,
            s_runtime_deps.transitive_runtime_jars])

    return java_common.create_provider(
        ctx.actions,
        use_ijar = False,
        compile_time_jars = compile_time_jars,
        transitive_compile_time_jars = transitive_compile_time_jars,
        transitive_runtime_jars = transitive_runtime_jars)

def _scala_import_jars_to_labels(ctx, direct_binary_jars):
    # build up JarsToLabels
    # note: consider moving this to an aspect

    lookup = {}
    for jar in direct_binary_jars:
        lookup[jar.path] = ctx.label

    for entry in ctx.attr.deps:
        if JavaInfo in entry:
            for jar in entry[JavaInfo].compile_jars:
                lookup[jar.path] = entry.label
        if JarsToLabels in entry:
            lookup.update(entry[JarsToLabels].lookup)

    for entry in ctx.attr.exports:
        if JavaInfo in entry:
            for jar in entry[JavaInfo].compile_jars:
                lookup[jar.path] = entry.label
        if JarsToLabels in entry:
            lookup.update(entry[JarsToLabels].lookup)

    return JarsToLabels(lookup = lookup)

# Filters an iterable for entries that contain a particular
# index and returns a collection of the indexed values.
def _collect(index, iterable):
    return [
        entry[index]
        for entry in iterable
        if index in entry
    ]
