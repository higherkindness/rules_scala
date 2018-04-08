load("//rules:bazel_deps.bzl", "scala_import")
scala_import(
    name = "bloop_backend",
    jars = [
        "//external:jar/ch/epfl/scala/bloop_backend_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/lihaoyi:sourcecode_2_12",
        "//3rdparty/jvm/io/get_coursier:coursier_2_12",
        "//3rdparty/jvm/io/get_coursier:coursier_cache_2_12",
        "//3rdparty/jvm/io/github/soc:directories",
        "//3rdparty/jvm/io/methvin:directory_watcher_better_files_2_12",
        "//3rdparty/jvm/io/monix:monix_2_12",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_sbt:librarymanagement_ivy_2_12",
        "//3rdparty/jvm/org/scala_sbt:test_agent",
        "//3rdparty/jvm/org/scala_sbt:test_interface",
        ":nailgun_server",
        ":zinc_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_import(
    name = "bloop_config",
    jars = [
        "//external:jar/ch/epfl/scala/bloop_config_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/geirsson:metaconfig_core_2_12",
        "//3rdparty/jvm/com/geirsson:metaconfig_docs_2_12",
        "//3rdparty/jvm/com/geirsson:metaconfig_typesafe_config_2_12",
        "//3rdparty/jvm/com/typesafe:config",
        "//3rdparty/jvm/io/circe:circe_derivation_2_12",
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_import(
    name = "bloop_frontend",
    jars = [
        "//external:jar/ch/epfl/scala/bloop_frontend_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/github/alexarchambault:case_app_2_12",
        "//3rdparty/jvm/io/monix:monix_2_12",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":bloop_backend",
        ":bloop_config",
        ":bsp_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "bsp_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/bsp_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/trueaccord/scalapb:scalapb_runtime_2_12",
        "//3rdparty/jvm/io/github/scalapb_json:scalapb_circe_2_12",
        "//3rdparty/jvm/org/scalameta:lsp4s_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "compiler_interface",
    exports = [
        "//external:jar/ch/epfl/scala/compiler_interface"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_sbt:util_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "nailgun_server",
    exports = [
        "//external:jar/ch/epfl/scala/nailgun_server"
    ],
    runtime_deps = [
        "//3rdparty/jvm/net/java/dev/jna:jna",
        "//3rdparty/jvm/net/java/dev/jna:jna_platform"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_2_12"
    ],
    runtime_deps = [
        ":zinc_classfile_2_12",
        ":zinc_compile_core_2_12",
        ":zinc_core_2_12",
        ":zinc_ivy_integration_2_12",
        ":zinc_persist_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_apiinfo_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_apiinfo_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_classfile_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_classfile_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_classpath_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_classpath_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_compile_core_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_compile_core_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators_2_12",
        "//3rdparty/jvm/org/scala_sbt:launcher_interface",
        "//3rdparty/jvm/org/scala_sbt:util_control_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_core_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_core_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_sbt:io_2_12",
        "//3rdparty/jvm/org/scala_sbt:util_logging_2_12",
        "//3rdparty/jvm/org/scala_sbt:util_relation_2_12",
        ":compiler_interface",
        ":zinc_apiinfo_2_12",
        ":zinc_classpath_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_ivy_integration_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_ivy_integration_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_persist_2_12",
    exports = [
        "//external:jar/ch/epfl/scala/zinc_persist_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/trueaccord/scalapb:scalapb_runtime_2_12",
        "//3rdparty/jvm/org/scala_sbt:sbinary_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


