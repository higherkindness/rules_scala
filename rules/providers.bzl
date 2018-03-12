ScalaConfiguration = provider(
    doc = "Provides access to the Scala compiler with Zinc",
    fields = {
        "version"            : "the Scala full version",
        "binary_version"     : "the Scala binary version",
        "compiler_bridge"    : "the compiled Zinc compiler bridge",
        "compiler_classpath" : "the compiler classpath",
        "runtime_classpath"  : "the minimal runtime classpath",
    },
)
