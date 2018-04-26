load("@rules_scala_annex//rules:providers.bzl", "LabeledJars")

def labeled_jars_implementation(target, ctx):
    if JavaInfo not in target:
        return []

    deps_labeled_jars = [dep[LabeledJars] for dep in getattr(ctx.rule.attr, "deps", []) if LabeledJars in dep]
    java_info = target[JavaInfo]
    return [
        LabeledJars(
            values = depset(
                [struct(label = ctx.label, jars = depset(transitive = [java_info.compile_jars, java_info.full_compile_jars]))],
                order = "preorder",
                transitive = [labeled_jars.values for labeled_jars in deps_labeled_jars],
            ),
        ),
    ]
