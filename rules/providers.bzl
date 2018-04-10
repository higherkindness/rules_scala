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

ScalaInfo = provider(
    doc = 'Provider for cross versioned scala outputs',
    fields = {
        'java_infos' : 'JavaInfo providers keyed by scala version',
    },
)

JarsToLabels = provider(
    doc = 'provides a mapping from jar files to defining labels for improved end user experience',
    fields = {
        'lookup' : 'dictionary with jar files as keys and labels as values',
    },
)
