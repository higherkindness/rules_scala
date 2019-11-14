## Specifying the Scala version to use

The scala version used by a buildable target is specified via the `ScalaConfiguration` passed in to the rule's `scala` attribute.

This attribute defaults to using the `default_scala` specified via `bind` in the `WORKSPACE` file of the repo. For example, suppose the `ScalaConfiguration` you wish to default to is defined by `//scala:2_11_12`. In your `WORKSPACE`, you would include:

```python
bind(
    name = "default_scala",
    actual = "//scala:2_11_12",
)
```

We provide two means of creating the `ScalaConfiguration`: `configure_bootstrap_scala` and `configure_zinc_scala`. The former is required by the latter.

Example:

```python
compiler_classpath_2_12_8 = [
    "@scala_compiler_2_12_8//jar",
    "@scala_library_2_12_8//jar",
    "@scala_reflect_2_12_8//jar",
]

runtime_classpath_2_12_8 = [
    "@scala_library_2_12_8//jar",
]

# This creates a basic ScalaConfiguration that relies on the scalac compiler
configure_bootstrap_scala(
    name = "bootstrap_2_12_8",
    compiler_classpath = compiler_classpath_2_12_8,
    runtime_classpath = runtime_classpath_2_12_8,
    version = "2.12.8",
    visibility = ["//visibility:public"],
)

# compiler bridge needed to configure zinc compiler
scala_library(
    name = "compiler_bridge_2_12_8",
    srcs = [
        "@compiler_bridge_2_12//:src",
    ],
    scala = ":bootstrap_2_12_8",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_12_8 + [
        "@scala_annex_org_scala_sbt_compiler_interface//jar",
        "@scala_annex_org_scala_sbt_util_interface//jar",
    ],
)

# This augments the configuration to configure the zinc compiler
configure_zinc_scala(
    name = "zinc_2_12_8",
    compiler_bridge = ":compiler_bridge_2_12_8",
    compiler_classpath = compiler_classpath_2_12_8,
    runtime_classpath = runtime_classpath_2_12_8,
    version = "2.12.8",
    visibility = ["//visibility:public"],
)
```

It is possible to use a different `ScalaConfiguration` on different build targets. All you need to do is specify a different one in the `scala` attribute. If no `scala` attribute is specified, the `default_scala` bound to in your `WORKSPACE` is used.

For example:

```python
scala_library(
  name = "example_compiled_with_scalac",
  srcs = glob(["**/*.scala"])
  scala = "<package>:bootstrap_2_12_8
)

scala_library(
  name = "example_compiled_with_zinc",
  srcs = glob(["**/*.scala"])
  scala = "<package>:zinc_2_12_8
)

# This would use whatever //external:default_scala points to (i.e. what you bind default_scala to in your WORKSPACE)
scala_library(
  name = "example_compiled_with_default_scala",
  srcs = glob(["**/*.scala"])
)
```
