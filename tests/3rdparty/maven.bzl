# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def list_dependencies():
    return [
        {
            "bind_args": {
                "actual": "@com_eed3si9n_shaded_scalajson_2_12",
                "name": "jar/com/eed3si9n/shaded_scalajson_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "264051c330fca00fe57d4b4cb767c1f6b359a5603f79f63562832125c7055a40",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4.jar",
                ],
                "licenses": ["notice"],
                "name": "com_eed3si9n_shaded_scalajson_2_12",
                "srcjar_sha256": "73400e3c769019b0ea5f5f5f94e61a1ebbc3d9b6667c455524b15967a0f4e550",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_eed3si9n_sjson_new_core_2_12",
                "name": "jar/com/eed3si9n/sjson_new_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "0c67aa883ff2e703559d723dbab04e6510f0f541f5629426bf199c4719295830",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2.jar",
                ],
                "licenses": ["notice"],
                "name": "com_eed3si9n_sjson_new_core_2_12",
                "srcjar_sha256": "985acefd13801f50d51e3d45c999c8eab4e4cc32a371deb733e884da20ff9225",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_eed3si9n_sjson_new_scalajson_2_12",
                "name": "jar/com/eed3si9n/sjson_new_scalajson_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@com_eed3si9n_shaded_scalajson_2_12",
                    "@org_spire_math_jawn_parser_2_12",
                ],
                "jar_sha256": "a72ea3b3331d689e5aff14edab9b33319d3d0140e9512b87568e6311786c849d",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2.jar",
                ],
                "licenses": ["notice"],
                "name": "com_eed3si9n_sjson_new_scalajson_2_12",
                "srcjar_sha256": "820565cc1911a8e1d88789344229f92fe3dcfd747793f18fcf6e120fbe15dfd3",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in com.google.protobuf:protobuf-java promoted to 3.5.1
        # - com.thesamet.scalapb:scalapb-runtime_2.12:0.7.4 wanted version 3.5.1
        # - com.trueaccord.scalapb:scalapb-runtime_2.12:0.6.0 wanted version 3.3.1
        {
            "bind_args": {
                "actual": "@com_google_protobuf_protobuf_java",
                "name": "jar/com/google/protobuf/protobuf_java",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "b5e2d91812d183c9f053ffeebcbcda034d4de6679521940a19064714966c2cd4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1.jar",
                ],
                "licenses": ["notice"],
                "name": "com_google_protobuf_protobuf_java",
                "srcjar_sha256": "3be3115498d543851443bfa725c0c5b28140e363b3b7dec97f4028cd17040fa4",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_lihaoyi_fastparse_utils_2_12",
                "name": "jar/com/lihaoyi/fastparse_utils_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "fb6cd6484e21459e11fcd45f22f07ad75e3cb29eca0650b39aa388d13c8e7d0a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/1.0.0/fastparse-utils_2.12-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "com_lihaoyi_fastparse_utils_2_12",
                "srcjar_sha256": "19e055e9d870f2a2cec5a8e0b892f9afb6e4350ecce315ca519458c4f52f9253",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/1.0.0/fastparse-utils_2.12-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in com.lihaoyi:fastparse_2.12 promoted to 1.0.0
        # - com.thesamet.scalapb:scalapb-runtime_2.12:0.7.4 wanted version 1.0.0
        # - com.trueaccord.scalapb:scalapb-runtime_2.12:0.6.0 wanted version 0.4.2
        {
            "bind_args": {
                "actual": "@com_lihaoyi_fastparse_2_12",
                "name": "jar/com/lihaoyi/fastparse_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@com_lihaoyi_fastparse_utils_2_12",
                    "@com_lihaoyi_sourcecode_2_12",
                ],
                "jar_sha256": "1227a00a26a4ad76ddcfa6eae2416687df7f3c039553d586324b32ba0a528fcc",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/1.0.0/fastparse_2.12-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "com_lihaoyi_fastparse_2_12",
                "srcjar_sha256": "290c1e9a4bad4d3724daec48324083fd0d97f51981a3fabbf75e2de1303da5ca",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/1.0.0/fastparse_2.12-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_lihaoyi_sourcecode_2_12",
                "name": "jar/com/lihaoyi/sourcecode_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "9a3134484e596205d0acdcccd260e0854346f266cb4d24e1b8a31be54fbaf6d9",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.4/sourcecode_2.12-0.1.4.jar",
                ],
                "licenses": ["notice"],
                "name": "com_lihaoyi_sourcecode_2_12",
                "srcjar_sha256": "c5c53ba31a9f891988f9e21595e8728956be22d9ab9442e140840d0a73be8261",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.4/sourcecode_2.12-0.1.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_lihaoyi_utest_2_12",
                "name": "jar/com/lihaoyi/utest_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_scala_library",
                    "@org_scala_lang_scala_reflect",
                    "@org_scala_sbt_test_interface",
                ],
                "jar_sha256": "1bc91780bf810e0a86343a899095ba8afe3dee3c422695ca2b6f9f5299c2879a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/utest_2.12/0.6.0/utest_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "com_lihaoyi_utest_2_12",
                "srcjar_sha256": "0fa42f3133a6a1931f6bc53823fc3621b045638ae1b7d78df929be2b11dcfb0a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/utest_2.12/0.6.0/utest_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@com_lmax_disruptor",
                "name": "jar/com/lmax/disruptor",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "8c5df12a17f614464ccacc9b7c4935e5f16e694b7788e714cde4b7587d5dd266",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lmax/disruptor/3.3.6/disruptor-3.3.6.jar",
                ],
                "licenses": ["notice"],
                "name": "com_lmax_disruptor",
                "srcjar_sha256": "4b0640f3a400e434419ed772339eb8f0578a571132f1cda7bbe3eb910356e1a0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lmax/disruptor/3.3.6/disruptor-3.3.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_thesamet_scalapb_lenses_2_12",
                "name": "jar/com/thesamet/scalapb/lenses_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c3b5d16dd27a44c2a67d98e47fc9a3180c1eedcaedda36b49f87b4ac321e412a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/lenses_2.12/0.7.0/lenses_2.12-0.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "com_thesamet_scalapb_lenses_2_12",
                "srcjar_sha256": "71ed703584e650469214b4db67dba0dd27f07d8a3d5600e997550995110fe203",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/lenses_2.12/0.7.0/lenses_2.12-0.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_thesamet_scalapb_scalapb_runtime_2_12",
                "name": "jar/com/thesamet/scalapb/scalapb_runtime_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@com_google_protobuf_protobuf_java",
                    "@com_lihaoyi_fastparse_2_12",
                    "@com_thesamet_scalapb_lenses_2_12",
                    "@org_scala_lang_scala_library",
                ],
                "jar_sha256": "3c463a2bf2f6e073a57d07e9faf831ba47c336f17a1843fe009f08a769d57b8c",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/scalapb-runtime_2.12/0.7.4/scalapb-runtime_2.12-0.7.4.jar",
                ],
                "licenses": ["notice"],
                "name": "com_thesamet_scalapb_scalapb_runtime_2_12",
                "srcjar_sha256": "bf76757b9ea9b5f0202f3dc0721f58fc0edb31316c1602acd0524e7263451ece",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/scalapb-runtime_2.12/0.7.4/scalapb-runtime_2.12-0.7.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@com_trueaccord_lenses_lenses_2_12",
                "name": "jar/com/trueaccord/lenses/lenses_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7cedcbc3125ad3f156466d6f3aec24b7fe6954cdc54a426ea089b4a46cd84c1c",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12.jar",
                ],
                "licenses": ["notice"],
                "name": "com_trueaccord_lenses_lenses_2_12",
                "srcjar_sha256": "2eed83e6a00d9dbfdcb367a28ca4a7d2080b0adb1dbabfe4892bef79e8b39aef",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@com_trueaccord_scalapb_scalapb_runtime_2_12",
                "name": "jar/com/trueaccord/scalapb/scalapb_runtime_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@com_google_protobuf_protobuf_java",
                    "@com_lihaoyi_fastparse_2_12",
                    "@com_trueaccord_lenses_lenses_2_12",
                ],
                "jar_sha256": "7921c157a5d0c4852d6ee99c728cf77c148ce6d36280dfcb6b58d1fa90d17f8d",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "com_trueaccord_scalapb_scalapb_runtime_2_12",
                "srcjar_sha256": "ed9b75d56698da090ead2ee1f464157225a4c6117d4adb31d2947809fb1f4da8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@jline_jline",
                "name": "jar/jline/jline",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "cb489eb7caf57811f01b7ac9d1fb8175ee1d2086627cc69f524e7d68f5f67982",
                "jar_urls": [
                    "http://central.maven.org/maven2/jline/jline/2.14.4/jline-2.14.4.jar",
                ],
                "licenses": ["notice"],
                "name": "jline_jline",
                "srcjar_sha256": "521af91089abf9f6b154b42f32e99dca3d824fb8e22a844f78309f0fab5d1343",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/jline/jline/2.14.4/jline-2.14.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@net_java_dev_jna_jna_platform",
                "name": "jar/net/java/dev/jna/jna_platform",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "68ee6431c6c07dda48deaa2627c56beeea0dec5927fe7848983e06f7a6a76a08",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0.jar",
                ],
                "licenses": ["notice"],
                "name": "net_java_dev_jna_jna_platform",
                "srcjar_sha256": "c0d41cc08b93646f90495bf850105dc9af1116169868b93589366c689eb5ddee",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@net_java_dev_jna_jna",
                "name": "jar/net/java/dev/jna/jna",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "617a8d75f66a57296255a13654a99f10f72f0964336e352211247ed046da3e94",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna/4.5.0/jna-4.5.0.jar",
                ],
                "licenses": ["notice"],
                "name": "net_java_dev_jna_jna",
                "srcjar_sha256": "e4da62978d75a5f47641d6c3548a6859c193fad8c5d0bc95a5f049d8ec1a0f79",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna/4.5.0/jna-4.5.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_apache_logging_log4j_log4j_api",
                "name": "jar/org/apache/logging/log4j/log4j_api",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "1205ab764b1326f7d96d99baa4a4e12614599bf3d735790947748ee116511fa2",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.jar",
                ],
                "licenses": ["notice"],
                "name": "org_apache_logging_log4j_log4j_api",
                "srcjar_sha256": "453201e25c223bacfc58e47262390fa2879dfe095c6d883dc913667917665ceb",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_apache_logging_log4j_log4j_core",
                "name": "jar/org/apache/logging/log4j/log4j_core",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "815a73e20e90a413662eefe8594414684df3d5723edcd76070e1a5aee864616e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.jar",
                ],
                "licenses": ["notice"],
                "name": "org_apache_logging_log4j_log4j_core",
                "srcjar_sha256": "efb8bd06659beda231375b72fb38f44d884b7d086f34e050204ffc8efe0cf6c2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_lang_modules_scala_parser_combinators_2_11",
                "name": "jar/org/scala_lang/modules/scala_parser_combinators_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "e8d15ebde0ccad54b5c9c82501afef8f7506a12f9500f2526d9c7e76a6ec3618",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.11/1.0.6/scala-parser-combinators_2.11-1.0.6.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_modules_scala_parser_combinators_2_11",
                "srcjar_sha256": "63e29b5fb131f2c6e5bf1bd8e40181fb7fdc96a7481f033a69b18734313eeb09",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.11/1.0.6/scala-parser-combinators_2.11-1.0.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang.modules:scala-parser-combinators_2.12 promoted to 1.1.0
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 1.0.4
        # - org.specs2:specs2-common_2.12:4.0.3 wanted version 1.1.0
        {
            "bind_args": {
                "actual": "@org_scala_lang_modules_scala_parser_combinators_2_12",
                "name": "jar/org/scala_lang/modules/scala_parser_combinators_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "102f2a13efae9486cb4fc01aa4eb92c0543dbd8403f825041746c689f80556e3",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.1.0/scala-parser-combinators_2.12-1.1.0.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_modules_scala_parser_combinators_2_12",
                "srcjar_sha256": "08d173ec107691c45a2cddf698df21600dea1c720ef3b0dbeb84b42d133d7290",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.1.0/scala-parser-combinators_2.12-1.1.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_lang_modules_scala_xml_2_11",
                "name": "jar/org/scala_lang/modules/scala_xml_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "a3ec190294a15a26706123f140a087a8c0a5db8980e86755e5b8e8fc33ac8d3d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.11/1.0.6/scala-xml_2.11-1.0.6.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_modules_scala_xml_2_11",
                "srcjar_sha256": "02a63308c374fd82db89fba59739bd1f30ec160cf8e422f9d26fde07274da8b0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.11/1.0.6/scala-xml_2.11-1.0.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang.modules:scala-xml_2.12 fixed to 1.1.0
        # - org.scala-sbt:sbinary_2.12:0.4.4 wanted version 1.0.5
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 1.0.5
        # - org.specs2:specs2-common_2.12:4.0.3 wanted version 1.0.6
        {
            "bind_args": {
                "actual": "@org_scala_lang_modules_scala_xml_2_12",
                "name": "jar/org/scala_lang/modules/scala_xml_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@org_scala_lang_scala_library"],
                "jar_sha256": "cf300196dbc0e4706a94e189d2c99b0c292d3f7650f94ce7c16de81b2a262346",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.1.0/scala-xml_2.12-1.1.0.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_modules_scala_xml_2_12",
                "srcjar_sha256": "46a8f4be00c620b737b783a9f9107725d0d03c973e9b691c817e0336bc1f6192",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.1.0/scala-xml_2.12-1.1.0-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_scala_lang_scala_compiler",
                "name": "jar/org/scala_lang/scala_compiler",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "8b681302aac584f7234547eed04d2beeeb4a4f00032220e29d40943be6906a01",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_scala_compiler",
                "srcjar_sha256": "675d1e5e163f4db1f8bde9b20ed7b30d5e6e635e18855cb0e4f3b5e672a88512",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang:scala-library promoted to 2.12.4
        # - com.lihaoyi:utest_2.12:0.6.0 wanted version 2.12.3
        # - com.thesamet.scalapb:scalapb-runtime_2.12:0.7.4 wanted version 2.12.4
        # - org.scala-lang.modules:scala-xml_2.12:1.1.0 wanted version 2.12.4
        # - org.scala-sbt:zinc-persist_2.12:1.1.5 wanted version 2.12.4
        # - org.scalacheck:scalacheck_2.12:1.13.4 wanted version 2.12.0
        # - org.scalactic:scalactic_2.12:3.0.4 wanted version 2.12.3
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 2.12.3
        # - org.specs2:specs2-core_2.11:3.9.5 wanted version 2.11.11
        # - org.specs2:specs2-core_2.12:4.0.3 wanted version 2.12.3
        {
            "bind_args": {
                "actual": "@org_scala_lang_scala_library",
                "name": "jar/org/scala_lang/scala_library",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "17824fcee4d3f46cfaa4da84ebad4f58496426c2b9bc9e341f812ab23a667d5d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_scala_library",
                "srcjar_sha256": "b9c34cf968a0e348ecec32837797a794ffeade2fe016323474fe756cb7d74042",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang:scala-reflect promoted to 2.12.4
        # - com.lihaoyi:utest_2.12:0.6.0 wanted version 2.12.3
        # - org.scala-sbt:util-logging_2.12:1.1.3 wanted version 2.12.4
        # - org.scalactic:scalactic_2.12:3.0.4 wanted version 2.12.3
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 2.12.3
        # - org.specs2:specs2-common_2.11:3.9.5 wanted version 2.11.11
        # - org.specs2:specs2-common_2.12:4.0.3 wanted version 2.12.3
        {
            "bind_args": {
                "actual": "@org_scala_lang_scala_reflect",
                "name": "jar/org/scala_lang/scala_reflect",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "ea70fe0e550e24d23fc52a18963b2be9c3b24283f4cb18b98327eb72746567cc",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_scala_reflect",
                "srcjar_sha256": "7b4dc73dc3cb46ac9ac948a0c231ccd989bed6cefb137c302a8ec8d6811e8148",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_compiler_interface",
                "name": "jar/org/scala_sbt/compiler_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@org_scala_sbt_util_interface"],
                "jar_sha256": "e3ee5eca6cf7d5340fa8d95cf890b2cb4391e1fc3344bfada72191da05c19643",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/compiler-interface/1.1.5/compiler-interface-1.1.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_compiler_interface",
                "srcjar_sha256": "9fe103830a26e876f3eb0e85d1b91876af7881a0b958e87e78a48d1de1eb67bd",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/compiler-interface/1.1.5/compiler-interface-1.1.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_io_2_12",
                "name": "jar/org/scala_sbt/io_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@net_java_dev_jna_jna",
                    "@net_java_dev_jna_jna_platform",
                ],
                "jar_sha256": "f1f514b54b4126ad9d4a1b14769128c06e1e0e7d18643f457a499af171b7a87e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_io_2_12",
                "srcjar_sha256": "f7a5811cdf568a46952e29385493a90ff3d812661ebe0498b5e4be02c112d887",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_launcher_interface",
                "name": "jar/org/scala_sbt/launcher_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "11ab8f0e2c035c90f019e4f5780ee57de978b7018d34e8f020eb88aa8b14af25",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.0/launcher-interface-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_launcher_interface",
                "srcjar_sha256": "ca2de13465aee529ebed512ecc1a214e521f436e9a2219042777b32a3cfcf287",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.0/launcher-interface-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_sbinary_2_12",
                "name": "jar/org/scala_sbt/sbinary_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@org_scala_lang_modules_scala_xml_2_12"],
                "jar_sha256": "24a7a488a6992b6ab4d8e78b170f5fbc02ef13eadada88851fd41cb2ccfa802a",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_sbinary_2_12",
                "srcjar_sha256": "1bace3a75fa2d5d73c0ea7d3be8107eec76fddeedba301af91fc6c99c6a774c9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_test_interface",
                "name": "jar/org/scala_sbt/test_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "15f70b38bb95f3002fec9aea54030f19bb4ecfbad64c67424b5e5fea09cd749e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_test_interface",
                "srcjar_sha256": "c314491c9df4f0bd9dd125ef1d51228d70bd466ee57848df1cd1b96aea18a5ad",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_util_interface",
                "name": "jar/org/scala_sbt/util_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c671b55697207eb7ac680fea390c249f383fdf2e445b3e98f8cae4f6bc324860",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-interface/1.1.3/util-interface-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_util_interface",
                "srcjar_sha256": "2e194c784c8c9dd3d34603a4378bfa7193708c1decba0ddb9aafe5b1ceccb6ab",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-interface/1.1.3/util-interface-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_util_logging_2_12",
                "name": "jar/org/scala_sbt/util_logging_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@com_eed3si9n_sjson_new_core_2_12",
                    "@com_eed3si9n_sjson_new_scalajson_2_12",
                    "@com_lmax_disruptor",
                    "@jline_jline",
                    "@org_apache_logging_log4j_log4j_api",
                    "@org_apache_logging_log4j_log4j_core",
                    "@org_scala_lang_scala_reflect",
                ],
                "jar_sha256": "14ec8942b844658a7da7e04f60555751661ab1273f8b31b57cfd86b473be2653",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.1.3/util-logging_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_util_logging_2_12",
                "srcjar_sha256": "d0315dec95a9da6a2faefaf785f3d53953cda084e1e4b8e6bdc030c7d3f9917d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.1.3/util-logging_2.12-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_util_relation_2_12",
                "name": "jar/org/scala_sbt/util_relation_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "dff98263c5fd5fc374ac241221cb83619a6bcce328c060482589d810617c2287",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.1.3/util-relation_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_util_relation_2_12",
                "srcjar_sha256": "8a14088c870199b828ec3e87da6d9cbe39b0b766ce51c9cbf6ba294fe9fed3c0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.1.3/util-relation_2.12-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_zinc_apiinfo_2_12",
                "name": "jar/org/scala_sbt/zinc_apiinfo_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@org_scala_sbt_zinc_classfile_2_12"],
                "jar_sha256": "eeecbbe7a930c456b0df8a6f6f8cc7e0a9651ee29dae3285e44f9ecfceb2237f",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.1.5/zinc-apiinfo_2.12-1.1.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_zinc_apiinfo_2_12",
                "srcjar_sha256": "60b60681191abe00b5d05c05f3bcdfbe996568d9d07f987e957393ac9ff32fa3",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.1.5/zinc-apiinfo_2.12-1.1.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_zinc_classfile_2_12",
                "name": "jar/org/scala_sbt/zinc_classfile_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "23e0a2497465dfba428409c0e61635ef6c35c13876606036dd6beedf4dbac5c7",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.1.5/zinc-classfile_2.12-1.1.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_zinc_classfile_2_12",
                "srcjar_sha256": "adc8935f070e44ba20ba07f4035f1a995e38e5c32455e2e4c9bf50ccf6af7608",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.1.5/zinc-classfile_2.12-1.1.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_zinc_classpath_2_12",
                "name": "jar/org/scala_sbt/zinc_classpath_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_scala_compiler",
                    "@org_scala_sbt_launcher_interface",
                ],
                "jar_sha256": "e596521e95fcdbeb2563d6ff984295e9ec05039b1da6acda55efbb4914dea078",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.1.5/zinc-classpath_2.12-1.1.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_zinc_classpath_2_12",
                "srcjar_sha256": "1f9a563d477bc35981f00620ef1783e95ad062ac9d3308f5c6f81bfe3574761c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.1.5/zinc-classpath_2.12-1.1.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_zinc_core_2_12",
                "name": "jar/org/scala_sbt/zinc_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_sbt_compiler_interface",
                    "@org_scala_sbt_io_2_12",
                    "@org_scala_sbt_util_logging_2_12",
                    "@org_scala_sbt_util_relation_2_12",
                    "@org_scala_sbt_zinc_apiinfo_2_12",
                    "@org_scala_sbt_zinc_classpath_2_12",
                ],
                "jar_sha256": "b87d51c92fbe38010bb1948bbc9b75fc04a1e57d6405230ea4ae945e5ca4d537",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.1.5/zinc-core_2.12-1.1.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_zinc_core_2_12",
                "srcjar_sha256": "b03729232ca540df7769524238dec06b4e32d13dfa5e1216abcc7d25e02eeb74",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.1.5/zinc-core_2.12-1.1.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_sbt_zinc_persist_2_12",
                "name": "jar/org/scala_sbt/zinc_persist_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@com_trueaccord_scalapb_scalapb_runtime_2_12",
                    "@org_scala_lang_scala_library",
                    "@org_scala_sbt_sbinary_2_12",
                    "@org_scala_sbt_zinc_core_2_12",
                ],
                "jar_sha256": "c1e76a3278db183ab106798fdcdb88eb5fd9a35bdc37aa8721ccc9e46cba7be4",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.1.5/zinc-persist_2.12-1.1.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_sbt_zinc_persist_2_12",
                "srcjar_sha256": "16cf5ec29654802a90a1e58bc19b99819a9f2250b67b8630e69651cf097db223",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.1.5/zinc-persist_2.12-1.1.5-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_scalacheck_scalacheck_2_12",
                "name": "jar/org/scalacheck/scalacheck_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_scala_library",
                    "@org_scala_sbt_test_interface",
                ],
                "jar_sha256": "4526e6640fa10d9d790fa19df803dfcaaf7f13e3ed627c5bf727fd5efadf0187",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scalacheck_scalacheck_2_12",
                "srcjar_sha256": "eb895700dec4ad77155677750a9e91c108fd69d31f4a54af2ee7da7aa6e4e680",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_scalactic_scalactic_2_12",
                "name": "jar/org/scalactic/scalactic_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_scala_library",
                    "@org_scala_lang_scala_reflect",
                ],
                "jar_sha256": "9b28aa46faaa666a8a10a5173fb72975d59c363c31c3e5f6a27eacc2e654cdfa",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.4/scalactic_2.12-3.0.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scalactic_scalactic_2_12",
                "srcjar_sha256": "400ffb8b621cef428ea3a790c96d766c75c1cf18f5809ff8c90c14e2776b88f7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.4/scalactic_2.12-3.0.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_scalatest_scalatest_2_12",
                "name": "jar/org/scalatest/scalatest_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_modules_scala_parser_combinators_2_12",
                    "@org_scala_lang_modules_scala_xml_2_12",
                    "@org_scala_lang_scala_library",
                    "@org_scala_lang_scala_reflect",
                    "@org_scalactic_scalactic_2_12",
                ],
                "jar_sha256": "cf2a7999681567e0f0e0166756356ae4ab0cd6c83f3f1d70225d25bb87d26070",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.4/scalatest_2.12-3.0.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scalatest_scalatest_2_12",
                "srcjar_sha256": "e1031e8e04258a56de5543517839c97f31fe53a3c3529440358b5cfbff4e93f7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.4/scalatest_2.12-3.0.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_scalaz_scalaz_core_2_11",
                "name": "jar/org/scalaz/scalaz_core_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "4d30a7d41cacbec7bf926be1745b6b5bb76712af3f220fe8461942dfa626c924",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-core_2.11/7.2.12/scalaz-core_2.11-7.2.12.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scalaz_scalaz_core_2_11",
                "srcjar_sha256": "b8e321c0a2f22cb121bf2d55f364c8404d5b221ad2bff54800d04e091c2f8e98",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-core_2.11/7.2.12/scalaz-core_2.11-7.2.12-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scalaz_scalaz_effect_2_11",
                "name": "jar/org/scalaz/scalaz_effect_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "70fa494665f44a0af53b89cbe739739a76ddebcc4c9c49637d86c022de2ab3bf",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-effect_2.11/7.2.12/scalaz-effect_2.11-7.2.12.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scalaz_scalaz_effect_2_11",
                "srcjar_sha256": "7a7ad93f4f36c6bd46ac246eb42feef09665186a5f1296723aa826da7ddb7ca0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-effect_2.11/7.2.12/scalaz-effect_2.11-7.2.12-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_common_2_11",
                "name": "jar/org/specs2/specs2_common_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_modules_scala_parser_combinators_2_11",
                    "@org_scala_lang_modules_scala_xml_2_11",
                    "@org_scala_lang_scala_reflect",
                    "@org_scalaz_scalaz_core_2_11",
                    "@org_scalaz_scalaz_effect_2_11",
                ],
                "jar_sha256": "6c09027d91b464130df54716c0c144e14ae4c8507f857e409e2d0980a388b157",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-common_2.11/3.9.5/specs2-common_2.11-3.9.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_common_2_11",
                "srcjar_sha256": "2f75c93722f049235de6e5e3fa5b77c1c10a93aff7f25ddd5e6d5839c6913152",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-common_2.11/3.9.5/specs2-common_2.11-3.9.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_common_2_12",
                "name": "jar/org/specs2/specs2_common_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_modules_scala_parser_combinators_2_12",
                    "@org_scala_lang_modules_scala_xml_2_12",
                    "@org_scala_lang_scala_reflect",
                    "@org_specs2_specs2_fp_2_12",
                ],
                "jar_sha256": "c578382294efed2afa756aab4f678e7b2d7891348ce2232ccfca374941032afc",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-common_2.12/4.0.3/specs2-common_2.12-4.0.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_common_2_12",
                "srcjar_sha256": "23ce078b8584a04cbe2f58fd59d603d4d335a1c56c9ddcfbdd059bd54af69fe3",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-common_2.12/4.0.3/specs2-common_2.12-4.0.3-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_core_2_11",
                "name": "jar/org/specs2/specs2_core_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_scala_library",
                    "@org_specs2_specs2_matcher_2_11",
                ],
                "jar_sha256": "f5c9e5f77cb43925cbc06692bf2e88351de439bcafc354a80d1b93410ab34c46",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-core_2.11/3.9.5/specs2-core_2.11-3.9.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_core_2_11",
                "srcjar_sha256": "e2bf3ebe229ae835fb42706d94180c163186b54b8aa2a01a69f94c48b91347c4",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-core_2.11/3.9.5/specs2-core_2.11-3.9.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_core_2_12",
                "name": "jar/org/specs2/specs2_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@org_scala_lang_scala_library",
                    "@org_scala_sbt_test_interface",
                    "@org_specs2_specs2_matcher_2_12",
                ],
                "jar_sha256": "4dd794e893d0b6e2361e83f83142de9f2b51a4fde865d2dfdb65d59448ebfeda",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-core_2.12/4.0.3/specs2-core_2.12-4.0.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_core_2_12",
                "srcjar_sha256": "950fb30746ef13cdf09388b7f509d38be17bd2558c5f794f368ec8f3f4b1db9b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-core_2.12/4.0.3/specs2-core_2.12-4.0.3-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_fp_2_12",
                "name": "jar/org/specs2/specs2_fp_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "16109da4e0bdeda8bd39e53a71aed6f5b0bae2813e03cc62dd30eb96c862dee1",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-fp_2.12/4.0.3/specs2-fp_2.12-4.0.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_fp_2_12",
                "srcjar_sha256": "8386c472cab9430861c9242411bc077d3c06d243e3d8d02a8fc17350e0e2b375",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-fp_2.12/4.0.3/specs2-fp_2.12-4.0.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_matcher_2_11",
                "name": "jar/org/specs2/specs2_matcher_2_11",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@org_specs2_specs2_common_2_11"],
                "jar_sha256": "071cba2168a621d2355aceacdf6b59dd2cb83e41591864d1f3d827abf96c13a5",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-matcher_2.11/3.9.5/specs2-matcher_2.11-3.9.5.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_matcher_2_11",
                "srcjar_sha256": "526d5b0cfd941a67eebf83b436bc2dda5f85e11a7274ea0d89a8bedd7bf67959",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-matcher_2.11/3.9.5/specs2-matcher_2.11-3.9.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_specs2_specs2_matcher_2_12",
                "name": "jar/org/specs2/specs2_matcher_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@org_specs2_specs2_common_2_12"],
                "jar_sha256": "2831edbe7feefe1ec67f101a3491ca835adaeafd5cad32df63b816c821a97c3e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-matcher_2.12/4.0.3/specs2-matcher_2.12-4.0.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_specs2_specs2_matcher_2_12",
                "srcjar_sha256": "b05e4c5bcf19d4d321c2f579334013266a35f52ea56cd64f36ac0e01d203316f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/specs2/specs2-matcher_2.12/4.0.3/specs2-matcher_2.12-4.0.3-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@org_spire_math_jawn_parser_2_12",
                "name": "jar/org/spire_math/jawn_parser_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c617fdde8c5b7646b1bedc4f6f565e85aa83b157ea93977fcdc4056b823aadb2",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.10.4/jawn-parser_2.12-0.10.4.jar",
                ],
                "licenses": ["notice"],
                "name": "org_spire_math_jawn_parser_2_12",
                "srcjar_sha256": "7601c166db3328c7f63a6388f637ddaf567448b622df167666526b5daefb751c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.10.4/jawn-parser_2.12-0.10.4-sources.jar",
                ],
            },
            "lang": "java",
        },
    ]
