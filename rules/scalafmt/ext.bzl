load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaRulePhase = "ScalaRulePhase",
)
load(
    "//rules/scalafmt:private/test.bzl",
    _scala_format_attributes = "scala_format_attributes",
    _scala_non_default_format_attributes = "scala_non_default_format_attributes",
)
load(
    "//rules/scala:private/phases.bzl",
    # TODO: move this to another file
    _phase_non_default_format = "phase_non_default_format",
)

ext_with_non_default_format = {
    "attrs": _dicts.add(
        _scala_format_attributes,
        _scala_non_default_format_attributes,
    ),
    "outputs": {
        "runner": "%{name}.format",
        "testrunner": "%{name}.format-test",
    },
    "phase_providers": [
        "//rules/scalafmt:add_non_default_format_phase",
    ],
}

def _add_non_default_format_phase_singleton_implementation(ctx):
    return [
        _ScalaRulePhase(
            phases = [
                ("-", "coda", "non_default_format", _phase_non_default_format),
            ],
        ),
    ]

add_non_default_format_phase_singleton = rule(
    implementation = _add_non_default_format_phase_singleton_implementation,
)
