### Differences with bazelbuild/rules_scala

* Better handling of macros and ijars. See [#445](https://github.com/bazelbuild/rules_scala/issues/445) and [#632](https://github.com/bazelbuild/bazel/issues/632#issuecomment-383318341).
  * Detect missing `macro = True` attribute. See [#366](https://github.com/bazelbuild/rules_scala/issues/366).
* Supports neverlink. See [#213](https://github.com/bazelbuild/rules_scala/issues/213).
* Optionally allows for fine-grained incrementality with stateful Zinc compilation. See [bazel-discuss](https://groups.google.com/forum/#!topic/bazel-discuss/3iUy5jxS3S0) and [#328](https://github.com/bazelbuild/rules_scala/issues/328).
* Does not support intransitive classpaths, matching Java rules. See [#432](https://github.com/bazelbuild/rules_scala/pull/423).
* Tools written in Scala, using bootstrapping rules as necessary.
* Uses [`depset`](https://docs.bazel.build/versions/master/skylark/lib/depset.html) and [`Args`](https://docs.bazel.build/versions/master/skylark/lib/Args.html)
to completely defer expanding transitive dependency lists until execution time.
* Supports many Scala versions: 2.10-2.13, Typelevel, Dotty, and anything else compatible with Zinc's compiler-bridge.
* Allows for multiple Scala versions in the same workspace. See [#80](https://github.com/bazelbuild/rules_scala/issues/80) and [#393](https://github.com/bazelbuild/rules_scala/issues/393).
  * For example, `higherkindness/rules_scala` tools use Scala 2.12, but that doesn't affect any client projects.
* Robustly supports buildozer recommendations via an aspect.
* Supports for all Scala test frameworks via sbt [test-interface](https://github.com/sbt/test-interface).
* Support test sharding, custom test framework arguments (including options to the JVM itself).
* Supports optional classloader and process-level isolation for tests, similar to sbt's `fork := true`.
* Supports scalafmt.
* Supports Scaladoc. See [#230](https://github.com/bazelbuild/rules_scala/issues/230) and [#256](https://github.com/bazelbuild/rules_scala/issues/256).
* Has consistently formatted code, via buildifier and scalafmt. See [#74](https://github.com/bazelbuild/rules_scala/issues/474).
* Reorganized and simplified file and code structure. Less than 8 KLOC excluding tests and dependency resolutions. (`git ls-files | grep -v '^test\|/maven.bzl$\|*.md' | xargs cat | wc -l`)
* Reorganized Travis CI builds, including better cache reuse.
* Easy dependency managment of internal tools using bazel-deps.
