# Scalafmt

Create .scalafmt.conf at the repo root (may be empty). And add to the WORKSPACE

```python
load("@rules_scala_annex//rules/scalafmt:workspace.bzl", "scalafmt_repositories", "scalafmt_default_config")
scalafmt_repositories()
scalafmt_default_config()
```

And in BUILD

```python
load("@rules_scala_annex//rules:scalafmt.bzl", "scala_format_test")
scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
```

Then

```
# check format, with diffs and non-zero exit in case of differences
$ bazel test :format

# format files in-place
$ bazel run :format
```
