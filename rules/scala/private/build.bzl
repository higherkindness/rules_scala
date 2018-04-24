# used by rules/scala/BUILD for compat.bzl

def _no_ijar_implementation(ctx):
    java_info = ctx.attr.dep[JavaInfo]
    return [
        java_common.create_provider(
            use_ijar = False,
            compile_time_jars = java_info.full_compile_jars,
            transitive_runtime_jars = java_info.transitive_runtime_jars,
        ),
    ]

no_ijar = rule(
    implementation = _no_ijar_implementation,
    attrs = {
        "dep": attr.label(
            mandatory = True,
            providers = [JavaInfo],
        ),
    },
)
