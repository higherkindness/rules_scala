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
    "//rules/private:phases.bzl",
    _phase_scalafmt_nondefault_outputs = "phase_scalafmt_nondefault_outputs",
)

ext_with_non_default_format = {
    "attrs": _dicts.add(
        _scala_format_attributes,
        _scala_non_default_format_attributes,
    ),
    "outputs": {
        "scalafmt_runner": "%{name}.format",
        "scalafmt_testrunner": "%{name}.format-test",
    },
    "phase_providers": [
        "//rules/scalafmt:add_non_default_format_phase",
    ],
}

def _add_non_default_format_phase_singleton_implementation(ctx):
    return [
        _ScalaRulePhase(
            phases = [
                ("-", "coda", "non_default_format", _phase_scalafmt_nondefault_outputs),
            ],
        ),
    ]

add_non_default_format_phase_singleton = rule(
    implementation = _add_non_default_format_phase_singleton_implementation,
)
