load("@rules_scala_annex//rules:providers.bzl", "IntellijInfo")

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
