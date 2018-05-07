# Do not edit. bazel-deps autogenerates this file from rules/scala_proto/dependencies.yaml.
def list_dependencies():
    return [
        {
            "bind_args": {
                "actual": "@scala_proto_com_github_os72_protoc_jar",
                "name": "jar/scala_proto_com/github/os72/protoc_jar",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "03f47faf3c48791fed5904c08f33ae535e11ca244d97f80e3a97962a125fde5d",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/github/os72/protoc-jar/3.5.1.1/protoc-jar-3.5.1.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_proto_com_github_os72_protoc_jar",
                "srcjar_sha256": "9d05e5c70e218e2a359f3ce067b7ef3844be4fc19f6ff5337be40f15ce467fcc",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/github/os72/protoc-jar/3.5.1.1/protoc-jar-3.5.1.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_proto_com_google_protobuf_protobuf_java",
                "name": "jar/scala_proto_com/google/protobuf/protobuf_java",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "b5e2d91812d183c9f053ffeebcbcda034d4de6679521940a19064714966c2cd4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_proto_com_google_protobuf_protobuf_java",
                "srcjar_sha256": "3be3115498d543851443bfa725c0c5b28140e363b3b7dec97f4028cd17040fa4",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_proto_com_thesamet_scalapb_compilerplugin_2_12",
                "name": "jar/scala_proto_com/thesamet/scalapb/compilerplugin_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_proto_com_google_protobuf_protobuf_java",
                    "@scala_proto_com_thesamet_scalapb_protoc_bridge_2_12",
                    "@scala_proto_org_scala_lang_scala_library",
                ],
                "jar_sha256": "2dfddbe1a0a5ac18e04f5b59de19d7a011913204afedd5bda4ba20bb984c4363",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/compilerplugin_2.12/0.7.4/compilerplugin_2.12-0.7.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_proto_com_thesamet_scalapb_compilerplugin_2_12",
                "srcjar_sha256": "9f3acf7d36e3c10b2bb6c3d96e098c61cdcaaf50c70a22ba892d313e5333f2aa",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/compilerplugin_2.12/0.7.4/compilerplugin_2.12-0.7.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_proto_com_thesamet_scalapb_protoc_bridge_2_12",
                "name": "jar/scala_proto_com/thesamet/scalapb/protoc_bridge_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_proto_org_scala_lang_scala_library"],
                "jar_sha256": "6b83ac0be522bf868fcbab27c2b64286912924f1cdbc17e0e12e092abff8bdc5",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/protoc-bridge_2.12/0.7.3/protoc-bridge_2.12-0.7.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_proto_com_thesamet_scalapb_protoc_bridge_2_12",
                "srcjar_sha256": "357b24d9476e52c645ac4d9c9b2052ef38bea0dc46ebc57b4bfac28ba4bd1160",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/thesamet/scalapb/protoc-bridge_2.12/0.7.3/protoc-bridge_2.12-0.7.3-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_proto_org_scala_lang_scala_library",
                "name": "jar/scala_proto_org/scala_lang/scala_library",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "17824fcee4d3f46cfaa4da84ebad4f58496426c2b9bc9e341f812ab23a667d5d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_proto_org_scala_lang_scala_library",
                "srcjar_sha256": "b9c34cf968a0e348ecec32837797a794ffeade2fe016323474fe756cb7d74042",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4-sources.jar",
                ],
            },
            "lang": "java",
        },
    ]
