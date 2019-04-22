## Macros and ijars

Using [ijar](https://github.com/bazelbuild/bazel/tree/master/third_party/ijar) poses a challenge in Scala because Scala macros are resolved during compilation. If a Scala macro references methods stripped away by ijar, things break.
However, forgoing `ijar` use altogether is sub-optimal---using `ijar` dramatically decreases unnecessary recompilation between builds.

`higherkindness/rules_scala` strives to optimally integrate `ijar` and Scala macros as follows:

1. `scala_library`, `scala_binary`, and `scala_test` have a Boolean `macro` attribute which must be set to true if the rule contains any Scala macros
2. During the classpath resolution phase, we set `macro_classpath` to contain the transitive runtime classpaths of all `deps` for which `macro = true`
3. We let `JavaInfo` always use `ijar`
   * If `macro` was false, we get useful ijars
   * If `macro` was true, we get problematic ijars; however, this won't be an issue:
4. During compilation, we have `macro_classpath` precede the compile classpath of the merged `JavaInfo`, forcing the compiler to use the full classes

This lets us make use of ijars as much as possible, without breaking things due to Scala macro usage.