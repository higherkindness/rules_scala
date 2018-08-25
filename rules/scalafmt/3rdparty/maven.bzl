# Do not edit. bazel-deps autogenerates this file from rules/scalafmt/dependencies.yaml.
def list_dependencies():
    return [
        {
            "bind_args": {
                "actual": "@scalafmt_com_geirsson_metaconfig_core_2_12",
                "name": "jar/scalafmt_com/geirsson/metaconfig_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_org_scalameta_inputs_2_12"],
                "jar_sha256": "6bd25189a12b1edbf1511c44783e611a9edd738841901b9243803ff9c696c78a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-core_2.12/0.4.0/metaconfig-core_2.12-0.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_geirsson_metaconfig_core_2_12",
                "srcjar_sha256": "f9ca3ea8723afe3e9213a5664cf8bc3b212d3e7cf861f1d0a96621d89270d532",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-core_2.12/0.4.0/metaconfig-core_2.12-0.4.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_geirsson_metaconfig_typesafe_config_2_12",
                "name": "jar/scalafmt_com/geirsson/metaconfig_typesafe_config_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_com_typesafe_config"],
                "jar_sha256": "e8f6f38738a96c4c09dbf5e5c687000556a0920b63e8e4fc19bb6cbc6d8dcfbd",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-typesafe-config_2.12/0.4.0/metaconfig-typesafe-config_2.12-0.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_geirsson_metaconfig_typesafe_config_2_12",
                "srcjar_sha256": "3c0bf468508f0f0f6b82c0ce72c996235eb7568f996fb1d1b1253c548e018170",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-typesafe-config_2.12/0.4.0/metaconfig-typesafe-config_2.12-0.4.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_geirsson_scalafmt_core_2_12",
                "name": "jar/scalafmt_com/geirsson/scalafmt_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scalafmt_com_geirsson_metaconfig_core_2_12",
                    "@scalafmt_com_geirsson_metaconfig_typesafe_config_2_12",
                    "@scalafmt_org_scala_lang_scala_library",
                    "@scalafmt_org_scalameta_scalameta_2_12",
                ],
                "jar_sha256": "808649767cdba809b8e239e3c0f7195f09e04de06dd6281f3471e90a8ca79f55",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/scalafmt-core_2.12/1.5.1/scalafmt-core_2.12-1.5.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_geirsson_scalafmt_core_2_12",
                "srcjar_sha256": "0a996288cf2b0955e74a8ec6aef6714b4b468b42cef717d2c922f59482822b7c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/scalafmt-core_2.12/1.5.1/scalafmt-core_2.12-1.5.1-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_google_protobuf_protobuf_java",
                "name": "jar/scalafmt_com/google/protobuf/protobuf_java",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "b1c2d420d2833429d11e405a58251e13bd7e3f22c266b49227c41e4d21361286",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.2.0/protobuf-java-3.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_google_protobuf_protobuf_java",
                "srcjar_sha256": "81c4cb6fa8c90119b99c9c0fede8c3d114bb1a5bc8577ba7bc9c98ce95562f57",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.2.0/protobuf-java-3.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_lihaoyi_fastparse_utils_2_12",
                "name": "jar/scalafmt_com/lihaoyi/fastparse_utils_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "0da40d3c89d3f7009ac2f6e32b11d8cdd379b40a2f09ce08669b4695f558e101",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_lihaoyi_fastparse_utils_2_12",
                "srcjar_sha256": "1eb227bc9659ce84b40d2d258c9ea3e8b8246f362241f43422266e05cabc902d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_lihaoyi_fastparse_2_12",
                "name": "jar/scalafmt_com/lihaoyi/fastparse_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_com_lihaoyi_fastparse_utils_2_12"],
                "jar_sha256": "43f57787179e902137167ba107e665272a0764f1addb3f452136f15bad5b21a8",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_lihaoyi_fastparse_2_12",
                "srcjar_sha256": "8e242feb1704b8483969c726056c46e5ba2bb659c943d336ae3948b3a507707d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_lihaoyi_scalaparse_2_12",
                "name": "jar/scalafmt_com/lihaoyi/scalaparse_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_com_lihaoyi_fastparse_2_12"],
                "jar_sha256": "148c9ea912639404faef7c8e607260787384ae9a2973120c71e440f78c3b5082",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/scalaparse_2.12/0.4.2/scalaparse_2.12-0.4.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_lihaoyi_scalaparse_2_12",
                "srcjar_sha256": "faeabf3ef43474e8eb45a704a2490e1aa1fb7dfc49cfb8e458d1f51318a55bb9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/scalaparse_2.12/0.4.2/scalaparse_2.12-0.4.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_lihaoyi_sourcecode_2_12",
                "name": "jar/scalafmt_com/lihaoyi/sourcecode_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "3ba3aca0d46496a3304798db8c8d79eedbdf29846b988a0a65207cc13408deca",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.3/sourcecode_2.12-0.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_lihaoyi_sourcecode_2_12",
                "srcjar_sha256": "5e20864291d9ef92841282606d99434b7af938619689218180717cb72851f7da",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.3/sourcecode_2.12-0.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_trueaccord_lenses_lenses_2_12",
                "name": "jar/scalafmt_com/trueaccord/lenses/lenses_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "2c4d6218d81eb682927ddccb386c8c3577e4cdf098130fc25bae4c9f9d312e16",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.10/lenses_2.12-0.4.10.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_trueaccord_lenses_lenses_2_12",
                "srcjar_sha256": "ee3896f145d5ac5ea9966a702fe30641caa1670bf6a5f74376ba75fd2273c558",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.10/lenses_2.12-0.4.10-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_trueaccord_scalapb_scalapb_runtime_2_12",
                "name": "jar/scalafmt_com/trueaccord/scalapb/scalapb_runtime_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scalafmt_com_google_protobuf_protobuf_java",
                    "@scalafmt_com_trueaccord_lenses_lenses_2_12",
                ],
                "jar_sha256": "07bc456f05bb654db0cae9361bd6240d5892f3066534fd5e46b6922f2cbdb1c7",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0-pre2/scalapb-runtime_2.12-0.6.0-pre2.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_trueaccord_scalapb_scalapb_runtime_2_12",
                "srcjar_sha256": "d14e202e4583e9c5b8808e090284a7bf362feab80918846f039b744d169a7ecc",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0-pre2/scalapb-runtime_2.12-0.6.0-pre2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_com_typesafe_config",
                "name": "jar/scalafmt_com/typesafe/config",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c160fbd78f51a0c2375a794e435ce2112524a6871f64d0331895e9e26ee8b9ee",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/config/1.2.1/config-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_com_typesafe_config",
                "srcjar_sha256": "78a8a2728fd5236b24a9bed7c253729887848ff5d3af5f9ef02e85be5fc43bba",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/config/1.2.1/config-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_net_sourceforge_argparse4j_argparse4j",
                "name": "jar/scalafmt_net/sourceforge/argparse4j/argparse4j",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "98cb5468cac609f3bc07856f2e34088f50dc114181237c48d20ca69c3265d044",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/sourceforge/argparse4j/argparse4j/0.8.1/argparse4j-0.8.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_net_sourceforge_argparse4j_argparse4j",
                "srcjar_sha256": "6baf8893d69bf3b8cac582de8b6407ebfeac992b1694b11897a9a614fb4b892f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/sourceforge/argparse4j/argparse4j/0.8.1/argparse4j-0.8.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scala_lang_scala_library",
                "name": "jar/scalafmt_org/scala_lang/scala_library",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "dd668b609002b3578f2db83a1a684d706155bba2fc801cd411359fdd48218d00",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.2/scala-library-2.12.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scala_lang_scala_library",
                "srcjar_sha256": "261c3f59e93ec851a40ca5d793e2487deb36453ec1ae506925565a204f483f5b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.2/scala-library-2.12.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_common_2_12",
                "name": "jar/scalafmt_org/scalameta/common_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_com_lihaoyi_sourcecode_2_12"],
                "jar_sha256": "87445943f1dff51a063b95660ed0bf5b3f2d28a9260aa7c38cfec7d1b684e826",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/common_2.12/1.7.0/common_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_common_2_12",
                "srcjar_sha256": "c8137b4a06ad56c736a00b605447dd19849b84185f93f824d7ee8d729a44b193",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/common_2.12/1.7.0/common_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_dialects_2_12",
                "name": "jar/scalafmt_org/scalameta/dialects_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "14cb63ebdae50463ef00dd4c3c07dfcb1b5aa7a30b3fc744046010a568f023e8",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/dialects_2.12/1.7.0/dialects_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_dialects_2_12",
                "srcjar_sha256": "405bede88f1ab3bc57d2740508e5a1975d0d578959919a21f37c38c185219a13",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/dialects_2.12/1.7.0/dialects_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_inline_2_12",
                "name": "jar/scalafmt_org/scalameta/inline_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "34af09bc3946dc00a276b54f790ffa2ba6ce40fc695dfa3cac74af2ea4416788",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/inline_2.12/1.7.0/inline_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_inline_2_12",
                "srcjar_sha256": "d4b82276c7c2c865bbac98212b872d76865692a08353542a05b6bdfd17dce51b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/inline_2.12/1.7.0/inline_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_inputs_2_12",
                "name": "jar/scalafmt_org/scalameta/inputs_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_org_scalameta_io_2_12"],
                "jar_sha256": "2f8582bba795c8997ea44210fb9c32b97e8e617336f10f01a3f85d206af2efe6",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/inputs_2.12/1.7.0/inputs_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_inputs_2_12",
                "srcjar_sha256": "00876d6018a9e6d4ebe04452f8359ccd1404ffae614013b4f91a545a0509f2da",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/inputs_2.12/1.7.0/inputs_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_io_2_12",
                "name": "jar/scalafmt_org/scalameta/io_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7884cf043a6ad61b36352e42a4c6b4c9eace83ebaed54d8072725710009ddc58",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/io_2.12/1.7.0/io_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_io_2_12",
                "srcjar_sha256": "e503cd739e2f496a499899e43490c5924bb32f64242b281c48f1e563f2c9efcf",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/io_2.12/1.7.0/io_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_parsers_2_12",
                "name": "jar/scalafmt_org/scalameta/parsers_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_org_scalameta_tokens_2_12"],
                "jar_sha256": "fc1625dfe09ec108fda13d39f681a6499876f55f4763ddb124d3275e7084d340",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/parsers_2.12/1.7.0/parsers_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_parsers_2_12",
                "srcjar_sha256": "35513d8a11716937a0e43ab805984491ebef58a873019b451a027c942fa8d720",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/parsers_2.12/1.7.0/parsers_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_quasiquotes_2_12",
                "name": "jar/scalafmt_org/scalameta/quasiquotes_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "d3a7144f273dfdeaa21afdfaf437739fd3622855d82d0eead37c3236be25b8fc",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/quasiquotes_2.12/1.7.0/quasiquotes_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_quasiquotes_2_12",
                "srcjar_sha256": "48f8b9630aafb13e16f67ffc937db012036a334911528b95ebcab59f66e584fa",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/quasiquotes_2.12/1.7.0/quasiquotes_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_scalameta_2_12",
                "name": "jar/scalafmt_org/scalameta/scalameta_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scalafmt_org_scalameta_common_2_12",
                    "@scalafmt_org_scalameta_dialects_2_12",
                    "@scalafmt_org_scalameta_inline_2_12",
                    "@scalafmt_org_scalameta_parsers_2_12",
                    "@scalafmt_org_scalameta_quasiquotes_2_12",
                    "@scalafmt_org_scalameta_semantic_2_12",
                    "@scalafmt_org_scalameta_tokenizers_2_12",
                    "@scalafmt_org_scalameta_transversers_2_12",
                    "@scalafmt_org_scalameta_trees_2_12",
                ],
                "jar_sha256": "a981b3a6180912bd33f1ec92bb3a880c452f1eb491f9e456e80d4ac527a7f7c2",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/scalameta_2.12/1.7.0/scalameta_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_scalameta_2_12",
                "srcjar_sha256": "6c8205a7f415a28d3cb047dd22a2fcfc037331a9ebd7d44691aac7f3a0d15128",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/scalameta_2.12/1.7.0/scalameta_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_semantic_2_12",
                "name": "jar/scalafmt_org/scalameta/semantic_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scalafmt_com_trueaccord_scalapb_scalapb_runtime_2_12",
                ],
                "jar_sha256": "475788dca2cb7f3b53391c65b23885b8bbb8c3c8c932bce178e8e185ba4d012a",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/semantic_2.12/1.7.0/semantic_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_semantic_2_12",
                "srcjar_sha256": "f8ec633ab3a6bea4dc5075b5fd27eece0f773e33d77b06241fb88ff444f507c2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/semantic_2.12/1.7.0/semantic_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_tokenizers_2_12",
                "name": "jar/scalafmt_org/scalameta/tokenizers_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scalafmt_com_lihaoyi_scalaparse_2_12"],
                "jar_sha256": "5057840f62c90eb4cba66b97f6b8815a8f757ba214481668cbc3998b01b0cb7a",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/tokenizers_2.12/1.7.0/tokenizers_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_tokenizers_2_12",
                "srcjar_sha256": "8e051f7627820d3dd39b290209202dac3b558dd0dc6dcd50d936683fc6e05701",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/tokenizers_2.12/1.7.0/tokenizers_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_tokens_2_12",
                "name": "jar/scalafmt_org/scalameta/tokens_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "8dc25ef61eb7ef76e5ecf25f897e8d835f10d6451c33a0fe3b2fd2b31c7d7bf8",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/tokens_2.12/1.7.0/tokens_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_tokens_2_12",
                "srcjar_sha256": "c7facec3faa933e583bd8db27262ac4b8efaba33795c9b8528f51efa3c37bc1f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/tokens_2.12/1.7.0/tokens_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_transversers_2_12",
                "name": "jar/scalafmt_org/scalameta/transversers_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "b45fe5f0284ec77737778831685f43d5b434121a88c488ff1ec6e82e53eb5536",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/transversers_2.12/1.7.0/transversers_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_transversers_2_12",
                "srcjar_sha256": "f1b75119ecb65bc29989370b8b82da4945112dfd1c216ead5e4c7253638f8539",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/transversers_2.12/1.7.0/transversers_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scalafmt_org_scalameta_trees_2_12",
                "name": "jar/scalafmt_org/scalameta/trees_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "68e115214da0ff306e5bd7e1333680dddb51f72fd5783fe8a686c829208ef84c",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/trees_2.12/1.7.0/trees_2.12-1.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scalafmt_org_scalameta_trees_2_12",
                "srcjar_sha256": "c76f8f57ec044ac22be27dc76063ce836d2358cb011e913b5e1f36efb2bdc792",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/trees_2.12/1.7.0/trees_2.12-1.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
    ]
