## Phases

Most rules in `higherkindness/rules_scala` are architected using phases. Phases break down the Bazel Analysis stage into logical chunks.
For example, the implementation of `scala_binary` is:

```python
def _scala_binary_implementation(ctx):
    return _run_phases(ctx, [
        ("resources", _phase_resources),
        ("classpaths", _phase_classpaths),
        ("javainfo", _phase_javainfo),
        ("compile", _phase_noop),
        ("singlejar", _phase_singlejar),
        ("coverage", _phase_coverage_jacoco),
        ("ijinfo", _phase_ijinfo),
        ("binary_deployjar", _phase_binary_deployjar),
        ("binary_launcher", _phase_binary_launcher),
        ("coda", _phase_coda),
    ]).coda
```
The `_run_phases` method does two things:

* First, it checks for any phase alternations. New phases can be insterted before, after, or instead of an existing phase (more on this [below](#customizing-the-core-rules))
* Then, the phases are evaluated one at a time. Providers returned by each phase are available to all following phases.

## Customizing the core rules

_NOTE: This is a work in progress_

Bazel scala annex allows users to customize `scala_binary`, `scala_library`, and `scala_test` by adding/replacing [phases](#phases).
Each of these rules has a corresponding `make_<rule>(*extras)` method which takes as arguments a list of of extra config items.

For an example of this in action, see [/rules/scala_with_scalafmt.bzl](/rules/scala_with_scalafmt.bzl) and [/rules/scalafmt/ext.blz](/rules/scalafmt/ext.bzl)