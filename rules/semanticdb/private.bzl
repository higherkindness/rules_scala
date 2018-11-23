load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaRulePhase = "ScalaRulePhase",
)

SemanticDB = provider(
    doc = "Scala SemanticDB output",
    fields = {
        "output": "the semanticdb file",
    },
)

def _phase_semanticdb_before_compile(ctx, g):
    print("semanticdb before compile phase")
    g.init.scalacopts.extend([
        "-Xplugin-require:semanticdb",
        "-Yrangepos",
        #"-P:semanticdb:targetroot:~/Desktop/foo",
    ])

def _phase_semanticdb_after_compile(ctx, g):
    print("semanticdb after compile phase")

    g.out.providers.append(SemanticDB(
        output = None,
    ))

def _my_plugin_implementation(ctx):
    # TODO: write something intelligent that allows us to pass along
    # all providers from the underlying dep
    return [
        ctx.attr.dep[JavaInfo],
        _ScalaRulePhase(
            phases = [
                ("-", "compile", "semanticdb", _phase_semanticdb_before_compile),
                ("+", "compile", "semanticdb", _phase_semanticdb_after_compile),
            ],
        ),
    ]

make_semanticdb_plugin = rule(
    attrs = {
        "dep": attr.label(
            mandatory = True,
            providers = [JavaInfo],
        ),
    },
    implementation = _my_plugin_implementation,
)
