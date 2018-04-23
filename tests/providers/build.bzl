load(
    "@rules_scala_annex//rules:providers.bzl",
    "ScalaConfiguration",
    "ZincConfiguration",
)

def _implementation(ctx):
    return []

consume_scala_configuration = rule(
    implementation = _implementation,
    attrs = {
        "configuration": attr.label(
            mandatory = True,
            providers = [ScalaConfiguration],
        ),
    },
)

consume_zinc_configuration = rule(
    implementation = _implementation,
    attrs = {
        "configuration": attr.label(
            mandatory = True,
            providers = [ZincConfiguration],
        ),
    },
)

consume_scala_and_zinc_configuration = rule(
    implementation = _implementation,
    attrs = {
        "configuration": attr.label(
            mandatory = True,
            providers = [ScalaConfiguration, ZincConfiguration],
        ),
    },
)
