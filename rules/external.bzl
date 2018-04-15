load("//rules/bazel:jvm_external.bzl", "jvm_import_external", "jvm_maven_import_external")

def scala_maven_import_external(
        artifact,
        server_urls,
        rule_load = "load(\"@rules_scala_annex//rules:bazel_deps.bzl\", \"scala_import\")",
        **kwargs):
    jvm_maven_import_external(
        rule_name = "scala_import",
        rule_load = rule_load,
        artifact = artifact,
        server_urls = server_urls,
        #additional string attributes' values have to be escaped in order to accomodate non-string types
        #    additional_rule_attrs = {"foo": "'bar'"},
        **kwargs
    )

def scala_import_external(
        rule_load = "load(\"@rules_scala_annex//rules:bazel_deps.bzl\", \"scala_import\")",
        **kwargs):
    jvm_import_external(
        rule_name = "scala_import",
        rule_load = rule_load,
        **kwargs
    )
