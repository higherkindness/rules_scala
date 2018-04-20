load("@rules_scala_annex//rules/scala:provider.bzl", "IntellijInfo", "JarsToLabels")

def scala_import_implementation(ctx):
    default_info = DefaultInfo(
        files = depset(ctx.files.jars + ctx.files.srcjar),
    )

    java_info = JavaInfo(
        output_jar = ctx.files.jars[0],
        use_ijar = False,
        source_jars = ctx.files.srcjar or ctx.files.jars,
        deps = [dep[JavaInfo] for dep in ctx.attr.deps],
        actions = ctx.actions,
    )

    intellij_info = create_intellij_info(ctx.label, ctx.attr.deps, java_info)

    return struct(
        # IntelliJ reads from java
        java = intellij_info,
        providers = [
            intellij_info,
            java_info,
            _scala_import_jars_to_labels(ctx, ctx.files.jars),
        ],
    )

def create_intellij_info(label, deps, java_info):
    # note: tried using transitive_exports from a JavaInfo that was given non-empty exports, but it was always empty
    return IntellijInfo(
        outputs = java_info.outputs,
        transitive_exports = depset(
            [label],
            transitive = [(dep[IntellijInfo] if IntellijInfo in dep else dep[JavaInfo]).transitive_exports for dep in deps],
        ),
    )

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
            for jar in entry[JavaInfo].compile_jars.to_list():
                lookup[jar.path] = entry.label
        if JarsToLabels in entry:
            lookup.update(entry[JarsToLabels].lookup)

    return JarsToLabels(lookup = lookup)
