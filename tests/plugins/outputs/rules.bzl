load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaRulePhase = "ScalaRulePhase",
)

def _my_plugin_phase(ctx, g):
    print("plugin phase success")

def _my_plugin_implementation(ctx):
    sdeps = java_common.merge([dep[JavaInfo] for dep in ctx.attr.deps])
    return [
        sdeps,
        _ScalaRulePhase(
            name = "my_plugin",
            function = _my_plugin_phase,
        ),
    ]

my_plugin = rule(
    attrs = {
        "deps": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
    },
    implementation = _my_plugin_implementation,
)
