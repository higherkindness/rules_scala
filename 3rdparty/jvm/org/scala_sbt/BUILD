load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "compiler_interface",
    exports = [
        "//external:jar/org/scala_sbt/compiler_interface"
    ],
    runtime_deps = [
        ":util_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "io_2_12",
    exports = [
        "//external:jar/org/scala_sbt/io_2_12"
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
    name = "launcher_interface",
    exports = [
        "//external:jar/org/scala_sbt/launcher_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "librarymanagement_core_2_12",
    exports = [
        "//external:jar/org/scala_sbt/librarymanagement_core_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:gigahorse_okhttp_2_12",
        "//3rdparty/jvm/com/jcraft:jsch",
        "//3rdparty/jvm/com/squareup/okhttp3:okhttp_urlconnection",
        ":util_cache_2_12",
        ":util_position_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "librarymanagement_ivy_2_12",
    exports = [
        "//external:jar/org/scala_sbt/librarymanagement_ivy_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:sjson_new_core_2_12",
        "//3rdparty/jvm/org/scala_sbt/ivy:ivy",
        ":librarymanagement_core_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "sbinary_2_12",
    exports = [
        "//external:jar/org/scala_sbt/sbinary_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "test_agent",
    exports = [
        "//external:jar/org/scala_sbt/test_agent"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "test_interface",
    exports = [
        "//external:jar/org/scala_sbt/test_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "util_cache_2_12",
    exports = [
        "//external:jar/org/scala_sbt/util_cache_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:sjson_new_murmurhash_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "util_control_2_12",
    exports = [
        "//external:jar/org/scala_sbt/util_control_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "util_interface",
    exports = [
        "//external:jar/org/scala_sbt/util_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "util_logging_2_12",
    exports = [
        "//external:jar/org/scala_sbt/util_logging_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:sjson_new_core_2_12",
        "//3rdparty/jvm/com/eed3si9n:sjson_new_scalajson_2_12",
        "//3rdparty/jvm/com/lmax:disruptor",
        "//3rdparty/jvm/jline:jline",
        "//3rdparty/jvm/org/apache/logging/log4j:log4j_api",
        "//3rdparty/jvm/org/apache/logging/log4j:log4j_core",
        "//3rdparty/jvm/org/scala_lang:scala_reflect"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "util_position_2_12",
    exports = [
        "//external:jar/org/scala_sbt/util_position_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "util_relation_2_12",
    exports = [
        "//external:jar/org/scala_sbt/util_relation_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_2_12",
    exports = [
        "//external:jar/org/scala_sbt/zinc_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
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
        "//external:jar/org/scala_sbt/zinc_apiinfo_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_classfile_2_12",
    exports = [
        "//external:jar/org/scala_sbt/zinc_classfile_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_classpath_2_12",
    exports = [
        "//external:jar/org/scala_sbt/zinc_classpath_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_compiler"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_compile_core_2_12",
    exports = [
        "//external:jar/org/scala_sbt/zinc_compile_core_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators_2_12",
        ":launcher_interface",
        ":util_control_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_core_2_12",
    exports = [
        "//external:jar/org/scala_sbt/zinc_core_2_12"
    ],
    runtime_deps = [
        ":compiler_interface",
        ":io_2_12",
        ":util_logging_2_12",
        ":util_relation_2_12",
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
        "//external:jar/org/scala_sbt/zinc_ivy_integration_2_12"
    ],
    runtime_deps = [
        ":librarymanagement_core_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "zinc_persist_2_12",
    exports = [
        "//external:jar/org/scala_sbt/zinc_persist_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/trueaccord/scalapb:scalapb_runtime_2_12",
        ":sbinary_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


