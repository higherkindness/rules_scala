# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
load("@rules_scala_annex//rules/bazel:jvm_external.bzl", "java_import_external")
load("@rules_scala_annex//rules:external.bzl", "scala_import_external")

def declare_maven(hash):
    lang = hash.pop("lang")
    import_args = hash["import_args"]

    if lang == "java":
        java_import_external(**import_args)
    elif lang.startswith("scala"):
        # TODO: What attributes does scala_import support? Include only those here.
        if "srcjar_sha256" in import_args:
            import_args.pop("srcjar_sha256")
        if "srcjar_urls" in import_args:
            import_args.pop("srcjar_urls")
        if "testonly_" in import_args:
            import_args.pop("testonly_")
        if "neverlink" in import_args:
            import_args.pop("neverlink")
        if "srcjar_urls" in import_args:
            import_args.pop("srcjar_urls")

        scala_import_external(**import_args)

    native.bind(**hash["bind_args"])

def list_dependencies():
    return [
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
        # duplicates in org.scala-lang.modules:scala-xml_2.12 promoted to 1.0.6
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 1.0.5
        # - org.specs2:specs2-common_2.12:4.0.3 wanted version 1.0.6
        {
            "bind_args": {
                "actual": "@org_scala_lang_modules_scala_xml_2_12",
                "name": "jar/org/scala_lang/modules/scala_xml_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7cc3b6ceb56e879cb977e8e043f4bfe2e062f78795efd7efa09f85003cb3230a",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_modules_scala_xml_2_12",
                "srcjar_sha256": "a7e8aac79394df396afda98b35537791809d815ce15ab2224f7d31e50c753922",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang:scala-library promoted to 2.12.3
        # - com.lihaoyi:utest_2.12:0.6.0 wanted version 2.12.3
        # - org.scalacheck:scalacheck_2.12:1.13.4 wanted version 2.12.0
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 2.12.3
        # - org.specs2:specs2-core_2.12:4.0.3 wanted version 2.12.3
        {
            "bind_args": {
                "actual": "@org_scala_lang_scala_library",
                "name": "jar/org/scala_lang/scala_library",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "a8dd181a996dcc53a8c0bbb554bef7a1a9017ca09a377603167cf15444a85404",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.3/scala-library-2.12.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_scala_library",
                "srcjar_sha256": "625126c241e93801cd2f293aafa60670b196cf93dc740e18ab324af18b3de5c7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.3/scala-library-2.12.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@org_scala_lang_scala_reflect",
                "name": "jar/org/scala_lang/scala_reflect",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "93db412846912a1c212dd83c36dd51aa0adb9f39bfa6c4c3d65682afc94366c4",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-reflect/2.12.3/scala-reflect-2.12.3.jar",
                ],
                "licenses": ["notice"],
                "name": "org_scala_lang_scala_reflect",
                "srcjar_sha256": "91080d2a59586b4d6322c99808321aed31f76d1b6f04d1966ddeb5d912825605",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-reflect/2.12.3/scala-reflect-2.12.3-sources.jar",
                ],
            },
            "lang": "java",
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
            "lang": "java",
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
            "lang": "java",
        },
    ]

def maven_dependencies(callback = declare_maven):
    for hash in list_dependencies():
        callback(hash)
