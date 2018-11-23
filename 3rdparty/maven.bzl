# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def list_dependencies():
    return [
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_bloop_backend_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/bloop_backend_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_ch_epfl_scala_nailgun_server",
                    "@scala_annex_ch_epfl_scala_zinc_2_12",
                    "@scala_annex_com_lihaoyi_sourcecode_2_12",
                    "@scala_annex_io_get_coursier_coursier_2_12",
                    "@scala_annex_io_get_coursier_coursier_cache_2_12",
                    "@scala_annex_io_get_coursier_coursier_scalaz_interop_2_12",
                    "@scala_annex_io_github_soc_directories",
                    "@scala_annex_me_vican_jorge_directory_watcher_better_files_2_12",
                    "@scala_annex_org_scala_sbt_librarymanagement_ivy_2_12",
                    "@scala_annex_org_scala_sbt_test_agent",
                    "@scala_annex_org_scala_sbt_test_interface",
                    "@scala_annex_org_scalaz_scalaz_concurrent_2_12",
                ],
                "jar_sha256": "62778a25e6d62ccb9efde50621d0469810dc957a01715a988c1da5939a2c6fe5",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-backend_2.12/1.0.0/bloop-backend_2.12-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bloop_backend_2_12",
                "srcjar_sha256": "456446e45fec886ca848fc1ef0e36a0d9bf1260464d1ed98369df9bfcf6c4bbe",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-backend_2.12/1.0.0/bloop-backend_2.12-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_bloop_config_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/bloop_config_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_io_circe_circe_derivation_2_12",
                    "@scala_annex_io_circe_circe_parser_2_12",
                ],
                "jar_sha256": "1f9b0639dd36e74bc18cdeac3d6a1e815a7919d2f025d2729fe6ffca4a137bd0",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-config_2.12/1.0.0/bloop-config_2.12-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bloop_config_2_12",
                "srcjar_sha256": "1252c13b68159ac36d643bc3f7a7e0f4bce9dea7871975eaeac706df37b52491",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-config_2.12/1.0.0/bloop-config_2.12-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_bloop_frontend_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/bloop_frontend_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_ch_epfl_scala_bloop_backend_2_12",
                    "@scala_annex_ch_epfl_scala_bloop_config_2_12",
                    "@scala_annex_ch_epfl_scala_bsp_2_12",
                    "@scala_annex_ch_epfl_scala_case_app_2_12",
                    "@scala_annex_com_zaxxer_nuprocess",
                    "@scala_annex_io_monix_monix_2_12",
                    "@scala_annex_org_scalaz_scalaz_core_2_12",
                    "@scala_annex_scala_2_12_scala_library//jar",
                ],
                "jar_sha256": "8dccc92d2d0eb772cb78bec87578aeccc41da9b1d8289431a895d7e77d3daa29",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-frontend_2.12/1.0.0/bloop-frontend_2.12-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bloop_frontend_2_12",
                "srcjar_sha256": "c713a426b6213aa947c869269d77be2e20e415ed85021251e02274899a2d7ea7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-frontend_2.12/1.0.0/bloop-frontend_2.12-1.0.0-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_bsp_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/bsp_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_io_circe_circe_core_2_12",
                    "@scala_annex_org_scalameta_lsp4s_2_12",
                ],
                "jar_sha256": "37d4fc75c72b7fabaf6fca8f1dc43e5fe1953f95f6631a0f34159fc75f2615a1",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bsp_2.12/1.0.0-M4/bsp_2.12-1.0.0-M4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bsp_2_12",
                "srcjar_sha256": "e9ca095842a243bd880f2396dbb852b1f06eda081c36afc31e2839832a2c19c7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bsp_2.12/1.0.0-M4/bsp_2.12-1.0.0-M4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_case_app_annotations_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/case_app_annotations_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "6918a8e756486c4ab6d8fd037898c9b727e03ab16cc36edf95f3fd97519a6403",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/case-app-annotations_2.12/1.2.0-faster-compile-time/case-app-annotations_2.12-1.2.0-faster-compile-time.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_case_app_annotations_2_12",
                "srcjar_sha256": "d9d3da4572c4278663212b34833629ba8616b887eb55477a4a71ea540258a610",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/case-app-annotations_2.12/1.2.0-faster-compile-time/case-app-annotations_2.12-1.2.0-faster-compile-time-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_case_app_util_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/case_app_util_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_chuusai_shapeless_2_12",
                    "@scala_annex_org_typelevel_macro_compat_2_12",
                ],
                "jar_sha256": "17cab6c45c702e01af1ebefe8415117eb4ca0813be76d08e1cc18f85fe5d7c5b",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/case-app-util_2.12/1.2.0-faster-compile-time/case-app-util_2.12-1.2.0-faster-compile-time.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_case_app_util_2_12",
                "srcjar_sha256": "2e4e1cead6a42006d661dd3bf7dbbd19468d427f04a93e6517c6900dc4ce69ed",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/case-app-util_2.12/1.2.0-faster-compile-time/case-app-util_2.12-1.2.0-faster-compile-time-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_case_app_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/case_app_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_ch_epfl_scala_case_app_annotations_2_12",
                    "@scala_annex_ch_epfl_scala_case_app_util_2_12",
                ],
                "jar_sha256": "316631204e37ba90c6e5457bd31a54e1497f00ceaa5d70cc9a902096dd663e2e",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/case-app_2.12/1.2.0-faster-compile-time/case-app_2.12-1.2.0-faster-compile-time.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_case_app_2_12",
                "srcjar_sha256": "9fc615f1bd1419db048e7de32f6631c3373f3a421538e983334cd6b2f19a9885",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/case-app_2.12/1.2.0-faster-compile-time/case-app_2.12-1.2.0-faster-compile-time-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_compiler_interface",
                "name": "jar/scala_annex_ch/epfl/scala/compiler_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_scala_sbt_util_interface"],
                "jar_sha256": "468d515a1a23d2ffb5635d38addac8f0da7937e54f91ed278a9b1884947bc284",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/compiler-interface/1.1.7+62-0f4ad9d5/compiler-interface-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_compiler_interface",
                "srcjar_sha256": "779b0dba1398d8fe90b8f89a4702929eb240e3677b50ba9751519e353277235a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/compiler-interface/1.1.7+62-0f4ad9d5/compiler-interface-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_nailgun_server",
                "name": "jar/scala_annex_ch/epfl/scala/nailgun_server",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_net_java_dev_jna_jna_platform"],
                "jar_sha256": "b5fbb84441e55c7e91540ee00d0808c8b656b0bfc2fc67907e754d3518ea66ea",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/nailgun-server/0c8b937b/nailgun-server-0c8b937b.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_nailgun_server",
                "srcjar_sha256": "c4bb657ec224b8ea19def64627ab8c9c76c9b6cc9dddc2572e8fc767055ebb2c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/nailgun-server/0c8b937b/nailgun-server-0c8b937b-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_apiinfo_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_apiinfo_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "1b041dd66c3d50ec17a80a1e1b8c0e3dc16ca8308495661a0b48abe84f09f327",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-apiinfo_2.12/1.1.7+62-0f4ad9d5/zinc-apiinfo_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_apiinfo_2_12",
                "srcjar_sha256": "54e686ca61511cdcbb46b6b45cbf4804588ad6cfbf2c4f31c80ffacb47676436",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-apiinfo_2.12/1.1.7+62-0f4ad9d5/zinc-apiinfo_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_classfile_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_classfile_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "298716ee438261d00757821e69d6849ece59f14d11a78c0c13d8ebce4ef74411",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classfile_2.12/1.1.7+62-0f4ad9d5/zinc-classfile_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_classfile_2_12",
                "srcjar_sha256": "6514d2aa547d31b2f52a0398e4471b5978d585f91edcb9bca48e2ba1eebbdcf2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classfile_2.12/1.1.7+62-0f4ad9d5/zinc-classfile_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_classpath_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_classpath_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "ef6b0fa2b0e84b17f31775afc032e1e6fe79248dbb2b63e81e72e416ae6baee1",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classpath_2.12/1.1.7+62-0f4ad9d5/zinc-classpath_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_classpath_2_12",
                "srcjar_sha256": "facbecb4a0f2a87ef15881fcb3f98884b31c29a3a03440ebf102b38eb5e2bc1c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classpath_2.12/1.1.7+62-0f4ad9d5/zinc-classpath_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_compile_core_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_compile_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_lang_modules_scala_parser_combinators_2_12",
                    "@scala_annex_org_scala_sbt_launcher_interface",
                    "@scala_annex_org_scala_sbt_util_control_2_12",
                ],
                "jar_sha256": "28364add18a0602b87321d5fb41b2d1c62539369cb897a57261013fa9be07022",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-compile-core_2.12/1.1.7+62-0f4ad9d5/zinc-compile-core_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_compile_core_2_12",
                "srcjar_sha256": "de3ce5cabd5c2e85a0859c98a7b3cb1b91d09bcd74b5142afc83629f0240a5b8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-compile-core_2.12/1.1.7+62-0f4ad9d5/zinc-compile-core_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_core_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_ch_epfl_scala_compiler_interface",
                    "@scala_annex_ch_epfl_scala_zinc_apiinfo_2_12",
                    "@scala_annex_ch_epfl_scala_zinc_classpath_2_12",
                    "@scala_annex_org_scala_sbt_io_2_12",
                    "@scala_annex_org_scala_sbt_util_logging_2_12",
                    "@scala_annex_org_scala_sbt_util_relation_2_12",
                ],
                "jar_sha256": "cb9d022abc169847c3a383f2e804b6f4452eaedac8771e4601863cc4da564006",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-core_2.12/1.1.7+62-0f4ad9d5/zinc-core_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_core_2_12",
                "srcjar_sha256": "144e22ce486a6b540a59ebb33525de795eb1150353c02a54597cc0ac8bb5301d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-core_2.12/1.1.7+62-0f4ad9d5/zinc-core_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_ivy_integration_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_ivy_integration_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "90925274b812fcbdc703f335cbeba0341579d1569894e32fccdaa921e73e2329",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-ivy-integration_2.12/1.1.7+62-0f4ad9d5/zinc-ivy-integration_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_ivy_integration_2_12",
                "srcjar_sha256": "16c4c2b77eeaea0e9bb6f2c3b9008ba9e6415e38ed991fb43e9e461ea63fa046",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-ivy-integration_2.12/1.1.7+62-0f4ad9d5/zinc-ivy-integration_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_persist_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_persist_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                    "@scala_annex_org_scala_sbt_sbinary_2_12",
                ],
                "jar_sha256": "e0a98ad11934b56c4357c11b866dbd6ba79c18deaeb7e38ed8ff9cd8ee52abde",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-persist_2.12/1.1.7+62-0f4ad9d5/zinc-persist_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_persist_2_12",
                "srcjar_sha256": "4d84c7442a724b7eb0f53deba8fbbd6e614a3688402d1f1f8c3030320892ceb8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-persist_2.12/1.1.7+62-0f4ad9d5/zinc-persist_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_zinc_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/zinc_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_ch_epfl_scala_zinc_classfile_2_12",
                    "@scala_annex_ch_epfl_scala_zinc_compile_core_2_12",
                    "@scala_annex_ch_epfl_scala_zinc_core_2_12",
                    "@scala_annex_ch_epfl_scala_zinc_ivy_integration_2_12",
                    "@scala_annex_ch_epfl_scala_zinc_persist_2_12",
                ],
                "jar_sha256": "7d39dcd05773e4c61e5498cf38385e18479a9031a5052410bdbf6414c637ca18",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc_2.12/1.1.7+62-0f4ad9d5/zinc_2.12-1.1.7+62-0f4ad9d5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_2_12",
                "srcjar_sha256": "d2e4de73c039433c9ebb35e0c05bb835ba84fada8acd1b47a47f5bb116b10bb4",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc_2.12/1.1.7+62-0f4ad9d5/zinc_2.12-1.1.7+62-0f4ad9d5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_qos_logback_logback_classic",
                "name": "jar/scala_annex_ch/qos/logback/logback_classic",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_ch_qos_logback_logback_core"],
                "jar_sha256": "fb53f8539e7fcb8f093a56e138112056ec1dc809ebb020b59d8a36a5ebac37e0",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_qos_logback_logback_classic",
                "srcjar_sha256": "480cb5e99519271c9256716d4be1a27054047435ff72078d9deae5c6a19f63eb",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_qos_logback_logback_core",
                "name": "jar/scala_annex_ch/qos/logback/logback_core",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "5946d837fe6f960c02a53eda7a6926ecc3c758bbdd69aa453ee429f858217f22",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_qos_logback_logback_core",
                "srcjar_sha256": "1f69b6b638ec551d26b10feeade5a2b77abe347f9759da95022f0da9a63a9971",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_beachape_enumeratum_circe_2_12",
                "name": "jar/scala_annex_com/beachape/enumeratum_circe_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "3f9379c7881d7ba6fc69b947f1761211819010880f5d833a99f2b266b2aa13ef",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/beachape/enumeratum-circe_2.12/1.5.15/enumeratum-circe_2.12-1.5.15.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_beachape_enumeratum_circe_2_12",
                "srcjar_sha256": "70edbb264a2c53d9b43bc02fc4a18c4b39b1f56c8c756e0aa020210db5deb6b9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/beachape/enumeratum-circe_2.12/1.5.15/enumeratum-circe_2.12-1.5.15-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_beachape_enumeratum_macros_2_12",
                "name": "jar/scala_annex_com/beachape/enumeratum_macros_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "e7ef82aa1ab73d52cccfe78fa09d8491d021df153415cae6f5e60295a90ee187",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/beachape/enumeratum-macros_2.12/1.5.9/enumeratum-macros_2.12-1.5.9.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_beachape_enumeratum_macros_2_12",
                "srcjar_sha256": "8ce1a95fffb8d0a5eff3d4f30ec4cd653a4ad43ecbc28fa0caac9ab30ec47f61",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/beachape/enumeratum-macros_2.12/1.5.9/enumeratum-macros_2.12-1.5.9-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_beachape_enumeratum_2_12",
                "name": "jar/scala_annex_com/beachape/enumeratum_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_com_beachape_enumeratum_macros_2_12"],
                "jar_sha256": "5f71174cf860e4b5f832371084859e074bc318fd59110adb05e6c8fcafb3f7fc",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/beachape/enumeratum_2.12/1.5.12/enumeratum_2.12-1.5.12.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_beachape_enumeratum_2_12",
                "srcjar_sha256": "b268236a8dcebddf109f24e825a98e2bc75742c48693e16f482618bdb3b29ed7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/beachape/enumeratum_2.12/1.5.12/enumeratum_2.12-1.5.12-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_chuusai_shapeless_2_12",
                "name": "jar/scala_annex_com/chuusai/shapeless_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "75926d9dd4688710ca16d852b58746dcfc013a2a1a58d1e817a27f95b2d42303",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/chuusai/shapeless_2.12/2.3.2/shapeless_2.12-2.3.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_chuusai_shapeless_2_12",
                "srcjar_sha256": "6c00f4454ee1250fb2385e01e02d5751bdf6594e847befab5dbe417c95dbd2b9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/chuusai/shapeless_2.12/2.3.2/shapeless_2.12-2.3.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_eed3si9n_gigahorse_core_2_12",
                "name": "jar/scala_annex_com/eed3si9n/gigahorse_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_typesafe_ssl_config_core_2_12",
                    "@scala_annex_org_reactivestreams_reactive_streams",
                    "@scala_annex_org_slf4j_slf4j_api",
                ],
                "jar_sha256": "9f198e77608a915797e9d4b5c91eedae621cecc3f25f2a551a3fa5d6bc678aa4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/gigahorse-core_2.12/0.3.0/gigahorse-core_2.12-0.3.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_eed3si9n_gigahorse_core_2_12",
                "srcjar_sha256": "31a6c5d8599e7bd4a9c1d38e56764c80695970ba045d2e9040dc98929b22f52a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/gigahorse-core_2.12/0.3.0/gigahorse-core_2.12-0.3.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_eed3si9n_gigahorse_okhttp_2_12",
                "name": "jar/scala_annex_com/eed3si9n/gigahorse_okhttp_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_eed3si9n_gigahorse_core_2_12",
                    "@scala_annex_com_squareup_okhttp3_okhttp",
                ],
                "jar_sha256": "5cf8e8bb9d90a08aa851ac066f378f83710af7823d788f837dc64f22cebcbbdf",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/gigahorse-okhttp_2.12/0.3.0/gigahorse-okhttp_2.12-0.3.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_eed3si9n_gigahorse_okhttp_2_12",
                "srcjar_sha256": "e991af1bb7150ee6341d4fbf0305b173cf6e0af81076cbccb010a6581019ea09",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/gigahorse-okhttp_2.12/0.3.0/gigahorse-okhttp_2.12-0.3.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_eed3si9n_shaded_scalajson_2_12",
                "name": "jar/scala_annex_com/eed3si9n/shaded_scalajson_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "264051c330fca00fe57d4b4cb767c1f6b359a5603f79f63562832125c7055a40",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_eed3si9n_shaded_scalajson_2_12",
                "srcjar_sha256": "73400e3c769019b0ea5f5f5f94e61a1ebbc3d9b6667c455524b15967a0f4e550",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in com.eed3si9n:sjson-new-core_2.12 promoted to 0.8.2
        # - org.scala-sbt:librarymanagement-ivy_2.12:1.0.0 wanted version 0.8.0
        # - org.scala-sbt:util-logging_2.12:1.2.0 wanted version 0.8.2
        {
            "bind_args": {
                "actual": "@scala_annex_com_eed3si9n_sjson_new_core_2_12",
                "name": "jar/scala_annex_com/eed3si9n/sjson_new_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "0c67aa883ff2e703559d723dbab04e6510f0f541f5629426bf199c4719295830",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_eed3si9n_sjson_new_core_2_12",
                "srcjar_sha256": "985acefd13801f50d51e3d45c999c8eab4e4cc32a371deb733e884da20ff9225",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_eed3si9n_sjson_new_murmurhash_2_12",
                "name": "jar/scala_annex_com/eed3si9n/sjson_new_murmurhash_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c8e622c56b1c48b384d95e8ebabaff80e1bed48aef50251a4abe613238593b93",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-murmurhash_2.12/0.8.2/sjson-new-murmurhash_2.12-0.8.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_eed3si9n_sjson_new_murmurhash_2_12",
                "srcjar_sha256": "19adc4fb08a1a59151a928eea65e4417f222618f33248295eaacb1677a906295",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-murmurhash_2.12/0.8.2/sjson-new-murmurhash_2.12-0.8.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_eed3si9n_sjson_new_scalajson_2_12",
                "name": "jar/scala_annex_com/eed3si9n/sjson_new_scalajson_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_eed3si9n_shaded_scalajson_2_12",
                    "@scala_annex_org_spire_math_jawn_parser_2_12",
                ],
                "jar_sha256": "a72ea3b3331d689e5aff14edab9b33319d3d0140e9512b87568e6311786c849d",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_eed3si9n_sjson_new_scalajson_2_12",
                "srcjar_sha256": "820565cc1911a8e1d88789344229f92fe3dcfd747793f18fcf6e120fbe15dfd3",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_github_pathikrit_better_files_2_12",
                "name": "jar/scala_annex_com/github/pathikrit/better_files_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "79b49bc134f06a6a091a962ec10ce3f1810403bccec7d99bf9928b7eb02e85c4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/github/pathikrit/better-files_2.12/3.4.0/better-files_2.12-3.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_github_pathikrit_better_files_2_12",
                "srcjar_sha256": "819911f7306162bdf9617f3ec0c218ebf7eec855e7120585e44f1b2a8d4852ec",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/github/pathikrit/better-files_2.12/3.4.0/better-files_2.12-3.4.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_google_code_findbugs_jsr305",
                "name": "jar/scala_annex_com/google/code/findbugs/jsr305",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "905721a0eea90a81534abb7ee6ef4ea2e5e645fa1def0a5cd88402df1b46c9ed",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/code/findbugs/jsr305/1.3.9/jsr305-1.3.9.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_google_code_findbugs_jsr305",
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_google_errorprone_error_prone_annotations",
                "name": "jar/scala_annex_com/google/errorprone/error_prone_annotations",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "cb4cfad870bf563a07199f3ebea5763f0dec440fcda0b318640b1feaa788656b",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.0.18/error_prone_annotations-2.0.18.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_google_errorprone_error_prone_annotations",
                "srcjar_sha256": "dbe7b49dd0584704d5c306b4ac7273556353ea3c0c6c3e50adeeca8df47047be",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.0.18/error_prone_annotations-2.0.18-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_google_guava_guava",
                "name": "jar/scala_annex_com/google/guava/guava",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_google_code_findbugs_jsr305",
                    "@scala_annex_com_google_errorprone_error_prone_annotations",
                    "@scala_annex_com_google_j2objc_j2objc_annotations",
                    "@scala_annex_org_codehaus_mojo_animal_sniffer_annotations",
                ],
                "jar_sha256": "7baa80df284117e5b945b19b98d367a85ea7b7801bd358ff657946c3bd1b6596",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/guava/guava/23.0/guava-23.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_google_guava_guava",
                "srcjar_sha256": "37fe8ba804fb3898c3c8f0cbac319cc9daa58400e5f0226a380ac94fb2c3ca14",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/guava/guava/23.0/guava-23.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_google_j2objc_j2objc_annotations",
                "name": "jar/scala_annex_com/google/j2objc/j2objc_annotations",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_google_j2objc_j2objc_annotations",
                "srcjar_sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_google_protobuf_protobuf_java",
                "name": "jar/scala_annex_com/google/protobuf/protobuf_java",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "90b82eeb94e7aba6f5053cc3d42f73da3ed188f4c6bc73a412d6fb3a12d97444",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.3.1/protobuf-java-3.3.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_google_protobuf_protobuf_java",
                "srcjar_sha256": "a5f40b040e76982c8ce70758acdabd063be8803f879a2a0b8a86f2a57feb8d3a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.3.1/protobuf-java-3.3.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_jcraft_jsch",
                "name": "jar/scala_annex_com/jcraft/jsch",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "92eb273a3316762478fdd4fe03a0ce1842c56f496c9c12fe1235db80450e1fdb",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_jcraft_jsch",
                "srcjar_sha256": "49d021dd58f6b455046a07331a68a5e647df354d7f6961b73df298203c43f44a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_fansi_2_12",
                "name": "jar/scala_annex_com/lihaoyi/fansi_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7d752240ec724e7370903c25b69088922fa3fb6831365db845cd72498f826eca",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fansi_2.12/0.2.5/fansi_2.12-0.2.5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_fansi_2_12",
                "srcjar_sha256": "15ba86e9c7bb83bddab0470a48a349c0f1b90bb2cd1c7d16f09cee6ba40ca95f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fansi_2.12/0.2.5/fansi_2.12-0.2.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_fastparse_utils_2_12",
                "name": "jar/scala_annex_com/lihaoyi/fastparse_utils_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "0da40d3c89d3f7009ac2f6e32b11d8cdd379b40a2f09ce08669b4695f558e101",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_fastparse_utils_2_12",
                "srcjar_sha256": "1eb227bc9659ce84b40d2d258c9ea3e8b8246f362241f43422266e05cabc902d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_fastparse_2_12",
                "name": "jar/scala_annex_com/lihaoyi/fastparse_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_lihaoyi_fastparse_utils_2_12",
                    "@scala_annex_com_lihaoyi_sourcecode_2_12",
                ],
                "jar_sha256": "43f57787179e902137167ba107e665272a0764f1addb3f452136f15bad5b21a8",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_fastparse_2_12",
                "srcjar_sha256": "8e242feb1704b8483969c726056c46e5ba2bb659c943d336ae3948b3a507707d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_pprint_2_12",
                "name": "jar/scala_annex_com/lihaoyi/pprint_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_lihaoyi_fansi_2_12",
                    "@scala_annex_com_lihaoyi_sourcecode_2_12",
                ],
                "jar_sha256": "2e18aa0884870537bf5c562255fc759d4ebe360882b5cb2141b30eda4034c71d",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/pprint_2.12/0.5.3/pprint_2.12-0.5.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_pprint_2_12",
                "srcjar_sha256": "41898c25987f7023fe1dafed7639eebd1653f1bf82ba4f4381bc7ef6c50e6084",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/pprint_2.12/0.5.3/pprint_2.12-0.5.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in com.lihaoyi:sourcecode_2.12 promoted to 0.1.4
        # - ch.epfl.scala:bloop-backend_2.12:1.0.0 wanted version 0.1.4
        # - com.lihaoyi:fastparse_2.12:0.4.2 wanted version 0.1.3
        # - com.lihaoyi:pprint_2.12:0.5.3 wanted version 0.1.4
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_sourcecode_2_12",
                "name": "jar/scala_annex_com/lihaoyi/sourcecode_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "9a3134484e596205d0acdcccd260e0854346f266cb4d24e1b8a31be54fbaf6d9",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.4/sourcecode_2.12-0.1.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_sourcecode_2_12",
                "srcjar_sha256": "c5c53ba31a9f891988f9e21595e8728956be22d9ab9442e140840d0a73be8261",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.4/sourcecode_2.12-0.1.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_utest_2_12",
                "name": "jar/scala_annex_com/lihaoyi/utest_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_sbt_test_interface",
                    "@scala_annex_scala_2_12_scala_compiler//jar",
                    "@scala_annex_scala_2_12_scala_library//jar",
                ],
                "jar_sha256": "1bc91780bf810e0a86343a899095ba8afe3dee3c422695ca2b6f9f5299c2879a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/utest_2.12/0.6.0/utest_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_utest_2_12",
                "srcjar_sha256": "0fa42f3133a6a1931f6bc53823fc3621b045638ae1b7d78df929be2b11dcfb0a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/utest_2.12/0.6.0/utest_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_lmax_disruptor",
                "name": "jar/scala_annex_com/lmax/disruptor",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "8c5df12a17f614464ccacc9b7c4935e5f16e694b7788e714cde4b7587d5dd266",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lmax/disruptor/3.3.6/disruptor-3.3.6.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lmax_disruptor",
                "srcjar_sha256": "4b0640f3a400e434419ed772339eb8f0578a571132f1cda7bbe3eb910356e1a0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lmax/disruptor/3.3.6/disruptor-3.3.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_squareup_okhttp3_okhttp_urlconnection",
                "name": "jar/scala_annex_com/squareup/okhttp3/okhttp_urlconnection",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "4631582b6818b6c8bdb0bca13b3ba126d2787969d33693d0f3912f1225fde3ec",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_squareup_okhttp3_okhttp_urlconnection",
                "srcjar_sha256": "f9526df9ab982e83fd184ad55d3c1b46a027d840108de9c55811d973c33013dc",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_squareup_okhttp3_okhttp",
                "name": "jar/scala_annex_com/squareup/okhttp3/okhttp",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_com_squareup_okio_okio"],
                "jar_sha256": "f55abda036da75e1af45bd43b9dfa79b2a3d90905be9cb38687c6621597a8165",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/squareup/okhttp3/okhttp/3.7.0/okhttp-3.7.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_squareup_okhttp3_okhttp",
                "srcjar_sha256": "a05aec7722b6b96354a49b8a225be6bb7c86609ff3c358c45d3a5a8e4805c544",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/squareup/okhttp3/okhttp/3.7.0/okhttp-3.7.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_squareup_okio_okio",
                "name": "jar/scala_annex_com/squareup/okio/okio",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "bfe7dfe483c37137966a1690f0c7d0b448ba217902c1fed202aaffdbba3291ae",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/squareup/okio/okio/1.12.0/okio-1.12.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_squareup_okio_okio",
                "srcjar_sha256": "6b7aca5e64927cea1a51b7200b1b5378b15fb1067330b628f987febef25c21c9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/squareup/okio/okio/1.12.0/okio-1.12.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_swoval_apple_file_events",
                "name": "jar/scala_annex_com/swoval/apple_file_events",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7700198d313795f79a2f3ebece8ab85596d028fd8c454be4f85bab1c9d07be8a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/swoval/apple-file-events/1.3.2/apple-file-events-1.3.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_swoval_apple_file_events",
                "srcjar_sha256": "aabecf2ca251c1c1d39d001a008547d809d910ebac9ccb1d9337e5a092d89cd7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/swoval/apple-file-events/1.3.2/apple-file-events-1.3.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_trueaccord_lenses_lenses_2_12",
                "name": "jar/scala_annex_com/trueaccord/lenses/lenses_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7cedcbc3125ad3f156466d6f3aec24b7fe6954cdc54a426ea089b4a46cd84c1c",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_trueaccord_lenses_lenses_2_12",
                "srcjar_sha256": "2eed83e6a00d9dbfdcb367a28ca4a7d2080b0adb1dbabfe4892bef79e8b39aef",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                "name": "jar/scala_annex_com/trueaccord/scalapb/scalapb_runtime_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_google_protobuf_protobuf_java",
                    "@scala_annex_com_lihaoyi_fastparse_2_12",
                    "@scala_annex_com_trueaccord_lenses_lenses_2_12",
                ],
                "jar_sha256": "7921c157a5d0c4852d6ee99c728cf77c148ce6d36280dfcb6b58d1fa90d17f8d",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                "srcjar_sha256": "ed9b75d56698da090ead2ee1f464157225a4c6117d4adb31d2947809fb1f4da8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_typesafe_scala_logging_scala_logging_2_12",
                "name": "jar/scala_annex_com/typesafe/scala_logging/scala_logging_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "8baac084969b1421a54880147abe79265eba76b06a75afe0aa05781efc7bedf4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.7.2/scala-logging_2.12-3.7.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_typesafe_scala_logging_scala_logging_2_12",
                "srcjar_sha256": "4096fc9a85ddc1dc556f34c22100d24b032408776140f8ec70bb359dc6f7579b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.7.2/scala-logging_2.12-3.7.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_typesafe_config",
                "name": "jar/scala_annex_com/typesafe/config",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "56f2c2e8acb95fb1e358b1e3faef2d565782c2a528747b01af8dd8e8bd87bd60",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/config/1.2.0/config-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_typesafe_config",
                "srcjar_sha256": "1acf655899a53e9acc577cb9d47e466095d83532cdfd1b17dd8e6f5c1c02642c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/config/1.2.0/config-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_typesafe_ssl_config_core_2_12",
                "name": "jar/scala_annex_com/typesafe/ssl_config_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_com_typesafe_config"],
                "jar_sha256": "cf144ec0adeb7f97da59542910ef18471f03fde2e174148e711b7f071155c7e4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/ssl-config-core_2.12/0.2.2/ssl-config-core_2.12-0.2.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_typesafe_ssl_config_core_2_12",
                "srcjar_sha256": "6b8b6f4135e7bcce10a8507b7b9f8a70982e71f34926b9f2118706f82793b410",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/ssl-config-core_2.12/0.2.2/ssl-config-core_2.12-0.2.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_zaxxer_nuprocess",
                "name": "jar/scala_annex_com/zaxxer/nuprocess",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_net_java_dev_jna_jna"],
                "jar_sha256": "1e56122ff6dba06f58dc97829fd1cbd2c5e82c99e0e1bc66214bfc3159838dd9",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/zaxxer/nuprocess/1.2.4/nuprocess-1.2.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_zaxxer_nuprocess",
                "srcjar_sha256": "e9d60ef0f35ea1fde6f19d57679ea8a82306ccfa07cde23c7de1fac986d5a4e0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/zaxxer/nuprocess/1.2.4/nuprocess-1.2.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_core_2_12",
                "name": "jar/scala_annex_io/circe/circe_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_io_circe_circe_numbers_2_12",
                    "@scala_annex_org_typelevel_cats_core_2_12",
                ],
                "jar_sha256": "ca627285dfa4a0f4a30ab2dbf48df2f0194129b80ad090c6e03b4474892dabee",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-core_2.12/0.9.0/circe-core_2.12-0.9.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_core_2_12",
                "srcjar_sha256": "455c4efe5da2459f95cb85d2944fc168155ce19c8af5e4674ac1d45233f0fb70",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-core_2.12/0.9.0/circe-core_2.12-0.9.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_derivation_2_12",
                "name": "jar/scala_annex_io/circe/circe_derivation_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "055edaacc4f4b4e8e3c49523b23cb313a24f11db64d7ab7bd210e14c6fc5d89f",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-derivation_2.12/0.9.0-M3/circe-derivation_2.12-0.9.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_derivation_2_12",
                "srcjar_sha256": "a144bf1b9ab92965db68d53f4020c001961989a79f98e05db47fdfd8afc1061b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-derivation_2.12/0.9.0-M3/circe-derivation_2.12-0.9.0-M3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_generic_extras_2_12",
                "name": "jar/scala_annex_io/circe/circe_generic_extras_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "710782ae44245c9f6bc79bd4038d7c2ec4f44222852ad9dfd7811b121316c1a4",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-generic-extras_2.12/0.9.0/circe-generic-extras_2.12-0.9.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_generic_extras_2_12",
                "srcjar_sha256": "309c311ddb3b2f022df9c46faef4487fdf85c12497d300dfc416ecc9c001ed7c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-generic-extras_2.12/0.9.0/circe-generic-extras_2.12-0.9.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_generic_2_12",
                "name": "jar/scala_annex_io/circe/circe_generic_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c9edca65268e37c08253a0a458d25356eab4c438cd283f73b0d8c7539d79dd95",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-generic_2.12/0.9.0/circe-generic_2.12-0.9.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_generic_2_12",
                "srcjar_sha256": "fd52e3bf0c2f1a7f3e9319fefe71ef4dacacee6eed78dab26d55503352522f29",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-generic_2.12/0.9.0/circe-generic_2.12-0.9.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_jawn_2_12",
                "name": "jar/scala_annex_io/circe/circe_jawn_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_spire_math_jawn_parser_2_12"],
                "jar_sha256": "0f3b99235b0180482a1a00dcfc2fe7604a42c027923dc4c1b5e99f7ffc507d9d",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-jawn_2.12/0.9.3/circe-jawn_2.12-0.9.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_jawn_2_12",
                "srcjar_sha256": "a2f0e0fb26bb000426af13fa0e6389642f06feb9f1b4e9620aa8c6e584ccdfd8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-jawn_2.12/0.9.3/circe-jawn_2.12-0.9.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_numbers_2_12",
                "name": "jar/scala_annex_io/circe/circe_numbers_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "ce8e089b833c6f38156ad257badc57298c75c3d08a160779f28f89c6531c5504",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-numbers_2.12/0.9.0/circe-numbers_2.12-0.9.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_numbers_2_12",
                "srcjar_sha256": "3bf078d3d82998a8968a0142c7cfff9c4846d17e277ba70d7a14cad77f144971",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-numbers_2.12/0.9.0/circe-numbers_2.12-0.9.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_circe_circe_parser_2_12",
                "name": "jar/scala_annex_io/circe/circe_parser_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_io_circe_circe_jawn_2_12"],
                "jar_sha256": "35613794c8881186487beaf5a620cd0f6f128cffd4e7a2c777ef034cb4bd1f75",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-parser_2.12/0.9.3/circe-parser_2.12-0.9.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_parser_2_12",
                "srcjar_sha256": "08e1cdf76c77951b8771f2485756f6e9137de6473bfbaaabd86c9f568827b0a1",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-parser_2.12/0.9.3/circe-parser_2.12-0.9.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_get_coursier_coursier_cache_2_12",
                "name": "jar/scala_annex_io/get_coursier/coursier_cache_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "aaa00acfe8b99f986c42d6efcef5d67ff3b562a5c24da008c2348562127bff73",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier-cache_2.12/1.1.0-M3/coursier-cache_2.12-1.1.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_get_coursier_coursier_cache_2_12",
                "srcjar_sha256": "ce5baf5872f2ede7f4cd6698c0e36f5bd4a40025b69f879706ec3a03dc9bb45f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier-cache_2.12/1.1.0-M3/coursier-cache_2.12-1.1.0-M3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_get_coursier_coursier_scalaz_interop_2_12",
                "name": "jar/scala_annex_io/get_coursier/coursier_scalaz_interop_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "108365bbad931ad21d858ac252256c1ee789761e15706647f624881b32b6832a",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier-scalaz-interop_2.12/1.1.0-M3/coursier-scalaz-interop_2.12-1.1.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_get_coursier_coursier_scalaz_interop_2_12",
                "srcjar_sha256": "aca9bedbd3eb226e5318aa9a90993dcc4f801e751cc6db2de01779d52d310be0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier-scalaz-interop_2.12/1.1.0-M3/coursier-scalaz-interop_2.12-1.1.0-M3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_get_coursier_coursier_2_12",
                "name": "jar/scala_annex_io/get_coursier/coursier_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_lang_modules_scala_xml_2_12",
                ],
                "jar_sha256": "a4fc2994a83779d92413057128498620f99baf9772cc161ebdb865fc637ae370",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier_2.12/1.1.0-M3/coursier_2.12-1.1.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_get_coursier_coursier_2_12",
                "srcjar_sha256": "6ddc5d5050751617b1f4d6279b3adf71d4cc7083a431fae0344839aaa5a08dc5",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier_2.12/1.1.0-M3/coursier_2.12-1.1.0-M3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_github_soc_directories",
                "name": "jar/scala_annex_io/github/soc/directories",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "28bed4b1f8cc99a2fbf078213e52f7778a231a59614aab5ba2b9ca9c12617bf2",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/github/soc/directories/10/directories-10.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_github_soc_directories",
                "srcjar_sha256": "2bc1c4f7d3b6e96468dbb3bc542cd70155fb573a0ab1e51210a7e616b5fe9fbc",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/github/soc/directories/10/directories-10-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_monix_monix_eval_2_12",
                "name": "jar/scala_annex_io/monix/monix_eval_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "19f5a7e9e715783fc258b4eb995849baf59e67d4381a448b552fba08df0ea99f",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-eval_2.12/2.3.3/monix-eval_2.12-2.3.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_monix_monix_eval_2_12",
                "srcjar_sha256": "0d2059f4496f6b0aae5d39a312eab35ef0289e9bcef4cd2d31f195d647576602",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-eval_2.12/2.3.3/monix-eval_2.12-2.3.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_monix_monix_execution_2_12",
                "name": "jar/scala_annex_io/monix/monix_execution_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_reactivestreams_reactive_streams"],
                "jar_sha256": "6ecbe76c795c70d6b4815522ff9101ece055a57ea854eadf5a4628e398182bf2",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-execution_2.12/2.3.3/monix-execution_2.12-2.3.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_monix_monix_execution_2_12",
                "srcjar_sha256": "570e213e6d934a9cfcde2c650aa7abf25f66af943820e531706b8cb671800faf",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-execution_2.12/2.3.3/monix-execution_2.12-2.3.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_monix_monix_reactive_2_12",
                "name": "jar/scala_annex_io/monix/monix_reactive_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_jctools_jctools_core"],
                "jar_sha256": "eadbfaaa79c9e6660f06b639159160f97db69d59ccd220002c1b7e71d32dc030",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-reactive_2.12/2.3.3/monix-reactive_2.12-2.3.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_monix_monix_reactive_2_12",
                "srcjar_sha256": "e3f67876d11218f9bf6e623bcc5e057c29845867d053e91457bed2d96f862e8f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-reactive_2.12/2.3.3/monix-reactive_2.12-2.3.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_monix_monix_types_2_12",
                "name": "jar/scala_annex_io/monix/monix_types_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "619624432339bc30999a5faef08eecbd0bb85759bd4971451d587e667e0b7a0b",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-types_2.12/2.3.3/monix-types_2.12-2.3.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_monix_monix_types_2_12",
                "srcjar_sha256": "d9b362d3860fa5c8ce2ba76ce6228a7ec950616c61fab32191003c10362ff602",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix-types_2.12/2.3.3/monix-types_2.12-2.3.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_monix_monix_2_12",
                "name": "jar/scala_annex_io/monix/monix_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_io_monix_monix_eval_2_12",
                    "@scala_annex_io_monix_monix_execution_2_12",
                    "@scala_annex_io_monix_monix_reactive_2_12",
                    "@scala_annex_io_monix_monix_types_2_12",
                ],
                "jar_sha256": "0c335a9728ca46899c2efbde95660ad12d726b012a3b0a2965368197cc297fc0",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix_2.12/2.3.3/monix_2.12-2.3.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_monix_monix_2_12",
                "srcjar_sha256": "d0d501ae72f5241e5c84e0ed9ed860646d38966666bf8bd39e619cd3ad2355ef",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/monix/monix_2.12/2.3.3/monix_2.12-2.3.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_jline_jline",
                "name": "jar/scala_annex_jline/jline",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "cb489eb7caf57811f01b7ac9d1fb8175ee1d2086627cc69f524e7d68f5f67982",
                "jar_urls": [
                    "http://central.maven.org/maven2/jline/jline/2.14.4/jline-2.14.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_jline_jline",
                "srcjar_sha256": "521af91089abf9f6b154b42f32e99dca3d824fb8e22a844f78309f0fab5d1343",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/jline/jline/2.14.4/jline-2.14.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_me_vican_jorge_directory_watcher_better_files_2_12",
                "name": "jar/scala_annex_me/vican/jorge/directory_watcher_better_files_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_github_pathikrit_better_files_2_12",
                    "@scala_annex_me_vican_jorge_directory_watcher",
                ],
                "jar_sha256": "985576364f8c341592d1b24dabe1385d225df0480b6949cf1e12c13692912af3",
                "jar_urls": [
                    "http://central.maven.org/maven2/me/vican/jorge/directory-watcher-better-files_2.12/0.5.2-a1c0e21c/directory-watcher-better-files_2.12-0.5.2-a1c0e21c.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_me_vican_jorge_directory_watcher_better_files_2_12",
                "srcjar_sha256": "29379d5c34e8d577fed2664b13eacec20ed92418ef1c3e074941dddab21fabf3",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/me/vican/jorge/directory-watcher-better-files_2.12/0.5.2-a1c0e21c/directory-watcher-better-files_2.12-0.5.2-a1c0e21c-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_me_vican_jorge_directory_watcher",
                "name": "jar/scala_annex_me/vican/jorge/directory_watcher",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_google_guava_guava",
                    "@scala_annex_org_slf4j_slf4j_api",
                ],
                "jar_sha256": "011474987f98c35cf0344fd9151f5141aaf1d1f3bbc2995ee8c26ec53fbe95d5",
                "jar_urls": [
                    "http://central.maven.org/maven2/me/vican/jorge/directory-watcher/0.5.2-a1c0e21c/directory-watcher-0.5.2-a1c0e21c.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_me_vican_jorge_directory_watcher",
                "srcjar_sha256": "1bda4438176b5674488fd752fc12178653e26993a57d33b70206ef6bbb0a3e08",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/me/vican/jorge/directory-watcher/0.5.2-a1c0e21c/directory-watcher-0.5.2-a1c0e21c-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in net.java.dev.jna:jna-platform promoted to 4.5.0
        # - ch.epfl.scala:nailgun-server:0c8b937b wanted version 4.4.0
        # - org.scala-sbt:io_2.12:1.2.0 wanted version 4.5.0
        {
            "bind_args": {
                "actual": "@scala_annex_net_java_dev_jna_jna_platform",
                "name": "jar/scala_annex_net/java/dev/jna/jna_platform",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "68ee6431c6c07dda48deaa2627c56beeea0dec5927fe7848983e06f7a6a76a08",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_net_java_dev_jna_jna_platform",
                "srcjar_sha256": "c0d41cc08b93646f90495bf850105dc9af1116169868b93589366c689eb5ddee",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in net.java.dev.jna:jna promoted to 4.5.1
        # - com.zaxxer:nuprocess:1.2.4 wanted version 4.5.1
        # - org.scala-sbt:io_2.12:1.2.0 wanted version 4.5.0
        {
            "bind_args": {
                "actual": "@scala_annex_net_java_dev_jna_jna",
                "name": "jar/scala_annex_net/java/dev/jna/jna",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "fbc9de96a0cc193a125b4008dbc348e9ed54e5e13fc67b8ed40e645d303cc51b",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna/4.5.1/jna-4.5.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_net_java_dev_jna_jna",
                "srcjar_sha256": "74145556f7b10be10303b76e9bfb12a7d0d43934c60788ed006a7a8aed5517f4",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna/4.5.1/jna-4.5.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_net_sourceforge_argparse4j_argparse4j",
                "name": "jar/scala_annex_net/sourceforge/argparse4j/argparse4j",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "98cb5468cac609f3bc07856f2e34088f50dc114181237c48d20ca69c3265d044",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/sourceforge/argparse4j/argparse4j/0.8.1/argparse4j-0.8.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_net_sourceforge_argparse4j_argparse4j",
                "srcjar_sha256": "6baf8893d69bf3b8cac582de8b6407ebfeac992b1694b11897a9a614fb4b892f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/sourceforge/argparse4j/argparse4j/0.8.1/argparse4j-0.8.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_apache_logging_log4j_log4j_api",
                "name": "jar/scala_annex_org/apache/logging/log4j/log4j_api",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "1205ab764b1326f7d96d99baa4a4e12614599bf3d735790947748ee116511fa2",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_apache_logging_log4j_log4j_api",
                "srcjar_sha256": "453201e25c223bacfc58e47262390fa2879dfe095c6d883dc913667917665ceb",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_apache_logging_log4j_log4j_core",
                "name": "jar/scala_annex_org/apache/logging/log4j/log4j_core",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "815a73e20e90a413662eefe8594414684df3d5723edcd76070e1a5aee864616e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_apache_logging_log4j_log4j_core",
                "srcjar_sha256": "efb8bd06659beda231375b72fb38f44d884b7d086f34e050204ffc8efe0cf6c2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_codehaus_groovy_groovy",
                "name": "jar/scala_annex_org/codehaus/groovy/groovy",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "81689da0b150893d509d17c523c5becba97e3d7667e98f965d735505e25ad294",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/codehaus/groovy/groovy/2.4.0/groovy-2.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_codehaus_groovy_groovy",
                "srcjar_sha256": "0a8193f9bdc5bf579275677afe00fcabf62fda96341a289dac592f140cd5d229",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/codehaus/groovy/groovy/2.4.0/groovy-2.4.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_codehaus_mojo_animal_sniffer_annotations",
                "name": "jar/scala_annex_org/codehaus/mojo/animal_sniffer_annotations",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "2068320bd6bad744c3673ab048f67e30bef8f518996fa380033556600669905d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.14/animal-sniffer-annotations-1.14.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_codehaus_mojo_animal_sniffer_annotations",
                "srcjar_sha256": "d821ae1f706db2c1b9c88d4b7b0746b01039dac63762745ef3fe5579967dd16b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.14/animal-sniffer-annotations-1.14-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_jctools_jctools_core",
                "name": "jar/scala_annex_org/jctools/jctools_core",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "5fba472768fcff372783fad4f8a0b4ffec6a9b632b95885e26f509ba00093b07",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/jctools/jctools-core/2.0.1/jctools-core-2.0.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_jctools_jctools_core",
                "srcjar_sha256": "2865cf812ec2bff6fba558034de0d419475096c1884f3be59a87b2f03277ed6a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/jctools/jctools-core/2.0.1/jctools-core-2.0.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_reactivestreams_reactive_streams",
                "name": "jar/scala_annex_org/reactivestreams/reactive_streams",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "ef867702a614b96eb6c64fb65a8f5e14bdfcabbc1ae056f78a1643f7b79ca0eb",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/reactivestreams/reactive-streams/1.0.0/reactive-streams-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_reactivestreams_reactive_streams",
                "srcjar_sha256": "7e673b0c8b0ac51bdef8655cacf7804fb9791c47e71161a36c94738d55eefea8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/reactivestreams/reactive-streams/1.0.0/reactive-streams-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang.modules:scala-parser-combinators_2.12 promoted to 1.0.5
        # - ch.epfl.scala:zinc-compile-core_2.12:1.1.7+62-0f4ad9d5 wanted version 1.0.5
        # - org.scala-sbt:zinc-compile-core_2.12:1.2.1 wanted version 1.0.5
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 1.0.4
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_lang_modules_scala_parser_combinators_2_12",
                "name": "jar/scala_annex_org/scala_lang/modules/scala_parser_combinators_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "f1f2f43cfd8042eb8a5d3021dc7ac3fff08ed6565311b6c145f8efe882a58a75",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.5/scala-parser-combinators_2.12-1.0.5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_lang_modules_scala_parser_combinators_2_12",
                "srcjar_sha256": "3c13525e5b80f12cd3def37c2edf1d3ade43d42af0aac59495fbe24339450475",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.5/scala-parser-combinators_2.12-1.0.5-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang.modules:scala-xml_2.12 promoted to 1.0.6
        # - io.get-coursier:coursier_2.12:1.1.0-M3 wanted version 1.0.6
        # - org.scala-sbt:sbinary_2.12:0.4.4 wanted version 1.0.5
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 1.0.5
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_lang_modules_scala_xml_2_12",
                "name": "jar/scala_annex_org/scala_lang/modules/scala_xml_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7cc3b6ceb56e879cb977e8e043f4bfe2e062f78795efd7efa09f85003cb3230a",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_lang_modules_scala_xml_2_12",
                "srcjar_sha256": "a7e8aac79394df396afda98b35537791809d815ce15ab2224f7d31e50c753922",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_lang_scala_compiler",
                "name": "jar/scala_annex_org/scala_lang/scala_compiler",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "3023b07cc02f2b0217b2c04f8e636b396130b3a8544a8dfad498a19c3e57a863",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-compiler/2.12.6/scala-compiler-2.12.6.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_lang_scala_compiler",
                "srcjar_sha256": "d3e9d7cc7b50c89676481959cebbf231275863c9f74102de28250dc92ffd4a6f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-compiler/2.12.6/scala-compiler-2.12.6-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_ivy_ivy",
                "name": "jar/scala_annex_org/scala_sbt/ivy/ivy",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c48309f41f30b322704984dd851346bd1717568c4ff2a15bba164939764be4d1",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/ivy/ivy/2.3.0-sbt-a3314352b638afbf0dca19f127e8263ed6f898bd/ivy-2.3.0-sbt-a3314352b638afbf0dca19f127e8263ed6f898bd.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_ivy_ivy",
                "srcjar_sha256": "00253bb52115873f4fb51dc44af396222f8648378632206abfd69cf1fb03564b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/ivy/ivy/2.3.0-sbt-a3314352b638afbf0dca19f127e8263ed6f898bd/ivy-2.3.0-sbt-a3314352b638afbf0dca19f127e8263ed6f898bd-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_compiler_interface",
                "name": "jar/scala_annex_org/scala_sbt/compiler_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_scala_sbt_util_interface"],
                "jar_sha256": "25c7fd6171a58775caa1b80170d0a2256ab57b2eb65022123ebcfc4ea564d961",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/compiler-interface/1.2.1/compiler-interface-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_compiler_interface",
                "srcjar_sha256": "bd4153820e556420eda1415df90236ee69662a7490849c0bbaf99019b360c79e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/compiler-interface/1.2.1/compiler-interface-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:io_2.12 promoted to 1.2.0
        # - ch.epfl.scala:zinc-core_2.12:1.1.7+62-0f4ad9d5 wanted version 1.1.4
        # - org.scala-sbt:zinc-core_2.12:1.2.1 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_io_2_12",
                "name": "jar/scala_annex_org/scala_sbt/io_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_swoval_apple_file_events",
                    "@scala_annex_net_java_dev_jna_jna",
                    "@scala_annex_net_java_dev_jna_jna_platform",
                ],
                "jar_sha256": "270b67412cf3e5a81f036bfe26bf098434d68f9ac427414996479847ce50fc31",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/io_2.12/1.2.0/io_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_io_2_12",
                "srcjar_sha256": "411f890c43658fcd770680a48f084cc4de6a9a98a31381fc5ca8041936459de6",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/io_2.12/1.2.0/io_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_launcher_interface",
                "name": "jar/scala_annex_org/scala_sbt/launcher_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "11ab8f0e2c035c90f019e4f5780ee57de978b7018d34e8f020eb88aa8b14af25",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.0/launcher-interface-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_launcher_interface",
                "srcjar_sha256": "ca2de13465aee529ebed512ecc1a214e521f436e9a2219042777b32a3cfcf287",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.0/launcher-interface-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:librarymanagement-core_2.12 promoted to 1.2.0
        # - org.scala-sbt:librarymanagement-ivy_2.12:1.0.0 wanted version 1.0.0
        # - org.scala-sbt:zinc-ivy-integration_2.12:1.2.1 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_librarymanagement_core_2_12",
                "name": "jar/scala_annex_org/scala_sbt/librarymanagement_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_eed3si9n_gigahorse_okhttp_2_12",
                    "@scala_annex_com_jcraft_jsch",
                    "@scala_annex_com_squareup_okhttp3_okhttp_urlconnection",
                    "@scala_annex_org_scala_sbt_util_cache_2_12",
                    "@scala_annex_org_scala_sbt_util_position_2_12",
                ],
                "jar_sha256": "c0b5fc0d7a32063a4eb61b9d80c3bf8b60490b620c5aed984d0e041563a13947",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.2.0/librarymanagement-core_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_librarymanagement_core_2_12",
                "srcjar_sha256": "76257c211485653f4e3b5d59867b8aec5cd7af347b35b176e1d926d127831a62",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.2.0/librarymanagement-core_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_librarymanagement_ivy_2_12",
                "name": "jar/scala_annex_org/scala_sbt/librarymanagement_ivy_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_eed3si9n_sjson_new_core_2_12",
                    "@scala_annex_org_scala_sbt_ivy_ivy",
                    "@scala_annex_org_scala_sbt_librarymanagement_core_2_12",
                ],
                "jar_sha256": "0e37e9a4b695b07aacad9e4dcabe725a2511962901dd15b8fa68184af11fab3f",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/librarymanagement-ivy_2.12/1.0.0/librarymanagement-ivy_2.12-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_librarymanagement_ivy_2_12",
                "srcjar_sha256": "16179441e8ca6d0f25ede41c872b795dc7b74616f0da4d0c04225053e2f20d92",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/librarymanagement-ivy_2.12/1.0.0/librarymanagement-ivy_2.12-1.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_sbinary_2_12",
                "name": "jar/scala_annex_org/scala_sbt/sbinary_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_lang_modules_scala_xml_2_12",
                ],
                "jar_sha256": "24a7a488a6992b6ab4d8e78b170f5fbc02ef13eadada88851fd41cb2ccfa802a",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_sbinary_2_12",
                "srcjar_sha256": "1bace3a75fa2d5d73c0ea7d3be8107eec76fddeedba301af91fc6c99c6a774c9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_test_agent",
                "name": "jar/scala_annex_org/scala_sbt/test_agent",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "3c2685c110db34c5611222b62a4e33e039803e8f9a126513616bab62a7cc0041",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/test-agent/1.0.4/test-agent-1.0.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_test_agent",
                "srcjar_sha256": "b5bcaef40972e6aead9dba0b3a6ffa4a22259f7297e300091802bfa0b4763ed2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/test-agent/1.0.4/test-agent-1.0.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_test_interface",
                "name": "jar/scala_annex_org/scala_sbt/test_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "15f70b38bb95f3002fec9aea54030f19bb4ecfbad64c67424b5e5fea09cd749e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_test_interface",
                "srcjar_sha256": "c314491c9df4f0bd9dd125ef1d51228d70bd466ee57848df1cd1b96aea18a5ad",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_cache_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_cache_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_eed3si9n_sjson_new_murmurhash_2_12",
                ],
                "jar_sha256": "622fd806450b232442172b32ff76bc547f015ae8935950c90d336f8920dae07f",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.2.0/util-cache_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_cache_2_12",
                "srcjar_sha256": "dbb00a2a92d17d5c01e5eaf0e57bdfedf58d7f5b67a974641e6a026b38d14408",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.2.0/util-cache_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-control_2.12 promoted to 1.2.0
        # - ch.epfl.scala:zinc-compile-core_2.12:1.1.7+62-0f4ad9d5 wanted version 1.1.3
        # - org.scala-sbt:zinc-compile-core_2.12:1.2.1 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_control_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_control_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "87f8f8decb351e50415b5fabb7aa11a110e29bf0a31a4ba0e8662987cb9be580",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-control_2.12/1.2.0/util-control_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_control_2_12",
                "srcjar_sha256": "220fc66fb3e7c5c18237e9d308fd3c2f3e988230ee2c4994a46ca09e2cab9597",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-control_2.12/1.2.0/util-control_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-interface promoted to 1.2.0
        # - ch.epfl.scala:compiler-interface:1.1.7+62-0f4ad9d5 wanted version 1.1.3
        # - org.scala-sbt:compiler-interface:1.2.1 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_interface",
                "name": "jar/scala_annex_org/scala_sbt/util_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "444bc23ec31e30ed76a34cd7e142c1a7e4fa84b9d838945b46c8f6f780a798c6",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-interface/1.2.0/util-interface-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_interface",
                "srcjar_sha256": "94aa85d25647d83e83b31fb55494be70927989542d025608d6eb5650529c738a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-interface/1.2.0/util-interface-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-logging_2.12 promoted to 1.2.0
        # - ch.epfl.scala:zinc-core_2.12:1.1.7+62-0f4ad9d5 wanted version 1.1.3
        # - org.scala-sbt:zinc-core_2.12:1.2.1 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_logging_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_logging_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_eed3si9n_sjson_new_core_2_12",
                    "@scala_annex_com_eed3si9n_sjson_new_scalajson_2_12",
                    "@scala_annex_com_lmax_disruptor",
                    "@scala_annex_jline_jline",
                    "@scala_annex_org_apache_logging_log4j_log4j_api",
                    "@scala_annex_org_apache_logging_log4j_log4j_core",
                    "@scala_annex_scala_2_12_scala_compiler//jar",
                ],
                "jar_sha256": "d3eddf8ab0ed3cfa4065b0f2148babbe763141c034a443cdaeddc62d294a5b92",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.2.0/util-logging_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_logging_2_12",
                "srcjar_sha256": "369ce35ccf5dbcb8c24fc097144bb7292c0a7716250b327376a9b291dad8e992",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.2.0/util-logging_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_position_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_position_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "1197b8993602f157b6aea90027b6e579ed7fd5d98ce8a16c089709ed705cf747",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-position_2.12/1.2.0/util-position_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_position_2_12",
                "srcjar_sha256": "8170807414a6fa87f557455ac223d650bf5cf0d672c2c028acd0f42f08ebb702",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-position_2.12/1.2.0/util-position_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-relation_2.12 promoted to 1.2.0
        # - ch.epfl.scala:zinc-core_2.12:1.1.7+62-0f4ad9d5 wanted version 1.1.3
        # - org.scala-sbt:zinc-core_2.12:1.2.1 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_relation_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_relation_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "dd7c1bd57e69032f30c16c4efbd4adcb9cb76374200e37bc39f6b4748cfd6235",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.2.0/util-relation_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_relation_2_12",
                "srcjar_sha256": "920f15393ef0869645846b571ebddfc3173b399aa4c45cd528298e886e52222b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.2.0/util-relation_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_apiinfo_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_apiinfo_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "4248a9ce6ea0f7d217a05fe18407fad4bcbcda5c433cc0c328b9aa46e24e81b2",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.2.1/zinc-apiinfo_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_apiinfo_2_12",
                "srcjar_sha256": "9388d0ef0257a2d78acddac5ed43faf1950612fb7f4cbecce6d4b4045d6e5521",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.2.1/zinc-apiinfo_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_classfile_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_classfile_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "f15787066975b9da2bdca2b57b2c98c93a01e2d760f35ce040f61e5172b9ad3b",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.2.1/zinc-classfile_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_classfile_2_12",
                "srcjar_sha256": "e34d26f7f2f3300eb05402030b165ab50c29bb3a90fd7ec7c2e6b5782319c2cf",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.2.1/zinc-classfile_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_classpath_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_classpath_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_scala_lang_scala_compiler"],
                "jar_sha256": "f955666b8b579bd0ab4c4c9810a25574aaf376976d3365c8810bac448a2f3e59",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.2.1/zinc-classpath_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_classpath_2_12",
                "srcjar_sha256": "c46f07e58e646914d8aa9cfdb185aca6b6eaf325c8eaffbd6bf779b92589eff7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.2.1/zinc-classpath_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_compile_core_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_compile_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_lang_modules_scala_parser_combinators_2_12",
                    "@scala_annex_org_scala_sbt_launcher_interface",
                    "@scala_annex_org_scala_sbt_util_control_2_12",
                ],
                "jar_sha256": "05c9f2b23350420de4f9cf08f36c98fdd1521a03776d32bb585160980a89de07",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.2.1/zinc-compile-core_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_compile_core_2_12",
                "srcjar_sha256": "32aca2964bf88deaa74a0c5301c63229775057636029d0c30b6755c5cf649678",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.2.1/zinc-compile-core_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_core_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_sbt_compiler_interface",
                    "@scala_annex_org_scala_sbt_io_2_12",
                    "@scala_annex_org_scala_sbt_util_logging_2_12",
                    "@scala_annex_org_scala_sbt_util_relation_2_12",
                    "@scala_annex_org_scala_sbt_zinc_apiinfo_2_12",
                    "@scala_annex_org_scala_sbt_zinc_classpath_2_12",
                ],
                "jar_sha256": "503c2a362be203769eb117d25be022f83a9f1160644b8db3b43c05b40f829eea",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.2.1/zinc-core_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_core_2_12",
                "srcjar_sha256": "14fe32caa6e5dc0f5128cc9a525807015f45c9535ed3d11fd090cccc0c0f5ae4",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.2.1/zinc-core_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_ivy_integration_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_ivy_integration_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_sbt_librarymanagement_core_2_12",
                ],
                "jar_sha256": "3f3d4997b0f3ffe0cc6e8b775135fefeb5ec3a3c03d1157c80f629ae2149c695",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.2.1/zinc-ivy-integration_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_ivy_integration_2_12",
                "srcjar_sha256": "e15b18819da5f9e920b257ee8771d3ea4fcc2e90af26b8254f9708799ce1b69c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.2.1/zinc-ivy-integration_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_persist_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_persist_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                    "@scala_annex_org_scala_sbt_sbinary_2_12",
                ],
                "jar_sha256": "6526d2d544da9228b5626cef766b70d9d1f365e671213e214d68b6b831818fbc",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.2.1/zinc-persist_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_persist_2_12",
                "srcjar_sha256": "8a2f0a6fb84cb0da520559f6f550026d8546e0b6e3b807bbebcb0ce811ff8019",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.2.1/zinc-persist_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_zinc_2_12",
                "name": "jar/scala_annex_org/scala_sbt/zinc_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_sbt_zinc_classfile_2_12",
                    "@scala_annex_org_scala_sbt_zinc_compile_core_2_12",
                    "@scala_annex_org_scala_sbt_zinc_core_2_12",
                    "@scala_annex_org_scala_sbt_zinc_ivy_integration_2_12",
                    "@scala_annex_org_scala_sbt_zinc_persist_2_12",
                    "@scala_annex_scala_2_12_scala_library//jar",
                ],
                "jar_sha256": "6c6351556cc459f6ee59853de74cac37b0482b37bedb5e8189b6f48095e7c23d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc_2.12/1.2.1/zinc_2.12-1.2.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_2_12",
                "srcjar_sha256": "7a176f1d0eb05810a8b450b93dbf81165e63a2b4de92a4a195e24d59196376c2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc_2.12/1.2.1/zinc_2.12-1.2.1-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalacheck_scalacheck_2_12",
                "name": "jar/scala_annex_org/scalacheck/scalacheck_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_sbt_test_interface",
                    "@scala_annex_scala_2_12_scala_library//jar",
                ],
                "jar_sha256": "4526e6640fa10d9d790fa19df803dfcaaf7f13e3ed627c5bf727fd5efadf0187",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalacheck_scalacheck_2_12",
                "srcjar_sha256": "eb895700dec4ad77155677750a9e91c108fd69d31f4a54af2ee7da7aa6e4e680",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalactic_scalactic_2_12",
                "name": "jar/scala_annex_org/scalactic/scalactic_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "9b28aa46faaa666a8a10a5173fb72975d59c363c31c3e5f6a27eacc2e654cdfa",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.4/scalactic_2.12-3.0.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalactic_scalactic_2_12",
                "srcjar_sha256": "400ffb8b621cef428ea3a790c96d766c75c1cf18f5809ff8c90c14e2776b88f7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.4/scalactic_2.12-3.0.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalameta_jsonrpc_2_12",
                "name": "jar/scala_annex_org/scalameta/jsonrpc_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_ch_qos_logback_logback_classic",
                    "@scala_annex_com_beachape_enumeratum_2_12",
                    "@scala_annex_com_beachape_enumeratum_circe_2_12",
                    "@scala_annex_com_lihaoyi_pprint_2_12",
                    "@scala_annex_com_typesafe_scala_logging_scala_logging_2_12",
                    "@scala_annex_io_circe_circe_generic_2_12",
                    "@scala_annex_io_circe_circe_generic_extras_2_12",
                    "@scala_annex_org_codehaus_groovy_groovy",
                ],
                "jar_sha256": "50c9aba9db630e174ccb522700cb163da5f96d8eb430d9776bf7bdcbe59a1879",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/jsonrpc_2.12/0.1.0/jsonrpc_2.12-0.1.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_jsonrpc_2_12",
                "srcjar_sha256": "69e82914de579a9c67a9fa2f41a9c4f5dd8c152fc14b18fe40be17d03f46d4cc",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/jsonrpc_2.12/0.1.0/jsonrpc_2.12-0.1.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalameta_lsp4s_2_12",
                "name": "jar/scala_annex_org/scalameta/lsp4s_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_scalameta_jsonrpc_2_12"],
                "jar_sha256": "51244a5ba585f438ba6cca0336e87faa7e4d85ff68725edba06cee780ed01b8e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/lsp4s_2.12/0.1.0/lsp4s_2.12-0.1.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_lsp4s_2_12",
                "srcjar_sha256": "50eec572818c2644a1c5d953ec1dcb9bbb61df678755eae1c39404206188a5c1",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/lsp4s_2.12/0.1.0/lsp4s_2.12-0.1.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalameta_semanticdb_scalac_2_12_7",
                "name": "jar/scala_annex_org/scalameta/semanticdb_scalac_2_12_7",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_lihaoyi_pprint_2_12",
                    "@scala_annex_scala_2_12_scala_library//jar",
                ],
                "jar_sha256": "62be6eb517912026e8824f95533a1ed4ae7c886bab5d266ee39ca98dd416a4dc",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/semanticdb-scalac_2.12.7/4.0.0/semanticdb-scalac_2.12.7-4.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_semanticdb_scalac_2_12_7",
                "srcjar_sha256": "91970337ec5b6cc5ad0ae0162c452f1bb4a77bf1880644235dc8e62fa3dfd694",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/semanticdb-scalac_2.12.7/4.0.0/semanticdb-scalac_2.12.7-4.0.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalatest_scalatest_2_12",
                "name": "jar/scala_annex_org/scalatest/scalatest_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scala_lang_modules_scala_parser_combinators_2_12",
                    "@scala_annex_org_scala_lang_modules_scala_xml_2_12",
                    "@scala_annex_org_scalactic_scalactic_2_12",
                    "@scala_annex_scala_2_12_scala_compiler//jar",
                    "@scala_annex_scala_2_12_scala_library//jar",
                ],
                "jar_sha256": "cf2a7999681567e0f0e0166756356ae4ab0cd6c83f3f1d70225d25bb87d26070",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.4/scalatest_2.12-3.0.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalatest_scalatest_2_12",
                "srcjar_sha256": "e1031e8e04258a56de5543517839c97f31fe53a3c3529440358b5cfbff4e93f7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.4/scalatest_2.12-3.0.4-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalaz_scalaz_concurrent_2_12",
                "name": "jar/scala_annex_org/scalaz/scalaz_concurrent_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_org_scalaz_scalaz_effect_2_12"],
                "jar_sha256": "d046209a58e42b74f2545473671ecc71c14c874615c7bd2f816ea3d5e91564a6",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-concurrent_2.12/7.2.20/scalaz-concurrent_2.12-7.2.20.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalaz_scalaz_concurrent_2_12",
                "srcjar_sha256": "282d22a104a9b82b91d0f4a3307192a773574472125728d7806f3e79b4e579d9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-concurrent_2.12/7.2.20/scalaz-concurrent_2.12-7.2.20-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalaz_scalaz_core_2_12",
                "name": "jar/scala_annex_org/scalaz/scalaz_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "5e69ee5c989b26c176534168c4beba1f0c9c0f0e7469c86bc9ef771245fc6867",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-core_2.12/7.2.20/scalaz-core_2.12-7.2.20.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalaz_scalaz_core_2_12",
                "srcjar_sha256": "d5fb01a52285a96f437461bd8ffbaa37bbcec45ac954032e0aeba5900191d12e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-core_2.12/7.2.20/scalaz-core_2.12-7.2.20-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalaz_scalaz_effect_2_12",
                "name": "jar/scala_annex_org/scalaz/scalaz_effect_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c74e7ff8228125566fd6080a8abbda49ca50d40d15773a93a9ab973a07f2d4a4",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-effect_2.12/7.2.20/scalaz-effect_2.12-7.2.20.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalaz_scalaz_effect_2_12",
                "srcjar_sha256": "26df8bb9234332a334178096338ed09d8522e2246380f9170a34fbb65f99fc1b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-effect_2.12/7.2.20/scalaz-effect_2.12-7.2.20-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_slf4j_slf4j_api",
                "name": "jar/scala_annex_org/slf4j/slf4j_api",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_slf4j_slf4j_api",
                "srcjar_sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.spire-math:jawn-parser_2.12 promoted to 0.11.1
        # - com.eed3si9n:sjson-new-scalajson_2.12:0.8.2 wanted version 0.10.4
        # - io.circe:circe-jawn_2.12:0.9.3 wanted version 0.11.1
        {
            "bind_args": {
                "actual": "@scala_annex_org_spire_math_jawn_parser_2_12",
                "name": "jar/scala_annex_org/spire_math/jawn_parser_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "a442dc3a1f399a0c1d5245e5b09ac292b01c5794ee303443efa3c8a625cbd6c4",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.11.1/jawn-parser_2.12-0.11.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_spire_math_jawn_parser_2_12",
                "srcjar_sha256": "7541d3cbde1c37f0bc75971608d717a9223bb8dd879c96fc0256718eed4220dd",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.11.1/jawn-parser_2.12-0.11.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_typelevel_cats_core_2_12",
                "name": "jar/scala_annex_org/typelevel/cats_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_typelevel_cats_kernel_2_12",
                    "@scala_annex_org_typelevel_cats_macros_2_12",
                    "@scala_annex_org_typelevel_machinist_2_12",
                ],
                "jar_sha256": "9e1d264f3366f6090b17ebdf4fab7488c9491a7c82bc400b1f6ec05f39755b63",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/cats-core_2.12/1.0.1/cats-core_2.12-1.0.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_typelevel_cats_core_2_12",
                "srcjar_sha256": "343630226130389da2a040c1ee16fc1e0c4be625b19b2591763e0d20236a3b9f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/cats-core_2.12/1.0.1/cats-core_2.12-1.0.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_typelevel_cats_kernel_2_12",
                "name": "jar/scala_annex_org/typelevel/cats_kernel_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "d87025b6fb7f403d767f6fa726c1626c9c713927bdc6b2a58ac07a32fec7490d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/cats-kernel_2.12/1.0.1/cats-kernel_2.12-1.0.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_typelevel_cats_kernel_2_12",
                "srcjar_sha256": "4cfb3519fc4c7c6da339c614704cee1a9fa89357821ad9626b662dc7b5b963b9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/cats-kernel_2.12/1.0.1/cats-kernel_2.12-1.0.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_typelevel_cats_macros_2_12",
                "name": "jar/scala_annex_org/typelevel/cats_macros_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c17a5625d9a203fa4676cb80ba22f65e68d18497945d24370bac9123ddc3da28",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/cats-macros_2.12/1.0.1/cats-macros_2.12-1.0.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_typelevel_cats_macros_2_12",
                "srcjar_sha256": "456b745024e4836a78967f9edb9e5db09a7af352ad161b44188960be90d22702",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/cats-macros_2.12/1.0.1/cats-macros_2.12-1.0.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_typelevel_machinist_2_12",
                "name": "jar/scala_annex_org/typelevel/machinist_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "b7e97638fa25ba02414b9b8387e9ecc2ea2fce4c9d9068ac3108ee5718b477a9",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/machinist_2.12/0.6.2/machinist_2.12-0.6.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_typelevel_machinist_2_12",
                "srcjar_sha256": "739d6899f54e3c958d853622aec7e5198a719a2906faa50199189b0289ebef83",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/machinist_2.12/0.6.2/machinist_2.12-0.6.2-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_typelevel_macro_compat_2_12",
                "name": "jar/scala_annex_org/typelevel/macro_compat_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "8b1514ec99ac9c7eded284367b6c9f8f17a097198a44e6f24488706d66bbd2b8",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/macro-compat_2.12/1.1.1/macro-compat_2.12-1.1.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_typelevel_macro_compat_2_12",
                "srcjar_sha256": "c748cbcda2e8828dd25e788617a4c559abf92960ef0f92f9f5d3ea67774c34c8",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/macro-compat_2.12/1.1.1/macro-compat_2.12-1.1.1-sources.jar",
                ],
            },
            "lang": "java",
        },
    ]
