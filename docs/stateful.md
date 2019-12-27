# Stateful compilation

Beyond the normal per-target incremental compilation, [Zinc](https://github.com/sbt/zinc) can achieve even finer-grained
compilation by reusing dependency information collected on previous runs.

Stateful compilers like Zinc [operate outside](https://groups.google.com/forum/#!topic/bazel-discuss/3iUy5jxS3S0) the
Bazel paradigm, and Bazel cannot enforce correctness. Technically, this caveat applies to all worker strategies:
performance is improving by maintaining state, but improper state may be shared across actions. In Zinc's case, the risk
is higher, because the sharing is (intentionally) aggressive.

To enable Zinc's stateful compilation, add

```
--worker_extra_flag=ScalaCompile=--persistence_dir=.bazel-zinc
```

Additionally, intermediate inputs to compilation can be cached, for a significant performance benefit in some cases, by
```
--worker_extra_flag=ScalaCompile=--extracted_file_cache=.bazel-zinc-outputs
```
