load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaRulePhase = "ScalaRulePhase",
)

def _foo_before_javainfo(ctx, g):
    if hasattr(g, "javainfo"):
        fail("javainfo shouldn't be in the globals, yet")

def _foo_after_javainfo(ctx, g):
    if not hasattr(g, "javainfo"):
        fail("javainfo should be in the globals by now")

def _foo_after_coda(ctx, g):
    if not hasattr(g, "compile"):
        fail("expected to run after compilation")

    print("plugin phase success")

def _my_plugin_implementation(ctx):
    sdeps = java_common.merge([dep[JavaInfo] for dep in ctx.attr.deps])
    return [
        sdeps,
        _ScalaRulePhase(
            phases = [
                ("-", "javainfo", "foo_before_javainfo", _foo_before_javainfo),
                ("+", "javainfo", "foo_after_javainfo", _foo_after_javainfo),
                ("+", "coda", "foo_after_coda", _foo_after_coda),
            ],
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
