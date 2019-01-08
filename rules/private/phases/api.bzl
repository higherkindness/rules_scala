load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaRulePhase = "ScalaRulePhase",
)

def run_phases(ctx, phases):
    phase_providers = [
        p[_ScalaRulePhase]
        for p in [ctx.attr.scala] + ctx.attr.plugins + ctx.attr._phase_providers
        if _ScalaRulePhase in p
    ]

    if phase_providers != []:
        phases = adjust_phases(phases, [p for pp in phase_providers for p in pp.phases])

    gd = {
        "init": struct(
            scala_configuration = ctx.attr.scala[_ScalaConfiguration],
        ),
        "out": struct(
            output_groups = {},
            providers = [],
        ),
    }
    g = struct(**gd)
    for (name, function) in phases:
        p = function(ctx, g)
        if p != None:
            gd[name] = p
            g = struct(**gd)

    return g

def adjust_phases(phases, adjustments):
    if len(adjustments) == 0:
        return phases
    phases = phases[:]
    for (relation, peer_name, name, function) in adjustments:
        for idx, (needle, _) in enumerate(phases):
            if needle == peer_name:
                if relation in ["-", "before"]:
                    phases.insert(idx, (name, function))
                elif relation in ["+", "after"]:
                    phases.insert(idx + 1, (name, function))
                elif relation in ["=", "replace"]:
                    phases[idx] = (name, function)
    return phases
