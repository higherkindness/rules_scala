load("//rules/jvm:private/label.bzl", _labeled_jars_implementation = "labeled_jars_implementation")

# For bedtime reading:
# https://github.com/bazelbuild/bazel/issues/4584
# https://groups.google.com/forum/#!topic/bazel-discuss/mt2llfwzmac

labeled_jars = aspect(
    implementation = _labeled_jars_implementation,
    attr_aspects = ["deps"],  # assumption
)
