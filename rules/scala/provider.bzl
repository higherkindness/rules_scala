ScalaConfiguration = provider(
    doc = "Provides access to the Scala compiler with Zinc",
    fields = {
        "version": "the Scala full version",
        "compiler_bridge": "the compiled Zinc compiler bridge",
        "compiler_classpath": "the compiler classpath",
        "runtime_classpath": "the minimal runtime classpath",
    },
)

BasicScalaConfiguration = provider(
    doc = "Provides access to the Scala compiler",
    fields = {
        "version": "the Scala full version",
        "compiler_classpath": "the compiler classpath",
        "runtime_classpath": "the minimal runtime classpath",
    },
)

IntellijInfo = provider(
    doc = "Provider for IntelliJ",
    fields = {
        "outputs": "java_output_jars",
        "transitive_exports": "labels of transitive dependencies",
    },
)

ScalaInfo = provider(
    doc = "Provider for cross versioned scala outputs",
    fields = {
        "analysis": "Zinc analysis file",
    },
)

JarsToLabels = provider(
    doc = "provides a mapping from jar files to defining labels for improved end user experience",
    fields = {
        "lookup": "dictionary with jar files as keys and labels as values",
    },
)
