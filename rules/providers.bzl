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

ScalaTestingFramework = provider(
    doc = "Provides basic information about a Scala Testing framework",
    fields = {
        "framework_class"    : "the fully qualified class implementing sbt.testing.Framework",
    },
)

ScalaInfo = provider(
    doc = 'Provider for cross versioned scala outputs',
    fields = {
        'java_infos' : 'JavaInfo providers keyed by scala version'
    },
)
