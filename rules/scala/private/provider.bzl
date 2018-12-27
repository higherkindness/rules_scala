load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaRulePhase = "ScalaRulePhase",
    _ZincConfiguration = "ZincConfiguration",
)
load(
    "//rules/scala:private/phases.bzl",
    _phase_bootstrap_compile = "phase_bootstrap_compile",
    _phase_compile = "phase_compile",
    _phase_depscheck = "phase_depscheck",
)

def configure_bootstrap_scala_implementation(ctx):
    return [
        _ScalaConfiguration(
            compiler_classpath = ctx.attr.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
            runtime_classpath = ctx.attr.runtime_classpath,
            version = ctx.attr.version,
        ),
        _ScalaRulePhase(
            phases = [
                ("=", "compile", "compile", _phase_bootstrap_compile),
            ],
        ),
    ]

def configure_zinc_scala_implementation(ctx):
    return [
        _ScalaConfiguration(
            compiler_classpath = ctx.attr.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
            runtime_classpath = ctx.attr.runtime_classpath,
            version = ctx.attr.version,
        ),
        _ZincConfiguration(
            compiler_bridge = ctx.file.compiler_bridge,
            compile_worker = ctx.attr._compile_worker,
            deps_worker = ctx.attr._deps_worker,
        ),
        _ScalaRulePhase(
            phases = [
                ("=", "compile", "compile", _phase_compile),
                ("+", "compile", "depscheck", _phase_depscheck),
            ],
        ),
    ]
