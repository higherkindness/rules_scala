# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
load("//rules/bazel:jvm_external.bzl", "java_import_external")
load("//rules:external.bzl", "scala_import_external")

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
                    "@scala_annex_io_github_soc_directories",
                    "@scala_annex_io_methvin_directory_watcher_better_files_2_12",
                    "@scala_annex_io_monix_monix_2_12",
                    "@scala_annex_org_scala_lang_scala_library",
                    "@scala_annex_org_scala_sbt_librarymanagement_ivy_2_12",
                    "@scala_annex_org_scala_sbt_test_agent",
                    "@scala_annex_org_scala_sbt_test_interface",
                ],
                "jar_sha256": "f1ddfd9a8688cce1ac65adf5afc870345ddbfb1882a62c653ba59073dd9be1fa",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-backend_2.12/1.0.0-M9/bloop-backend_2.12-1.0.0-M9.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bloop_backend_2_12",
                "srcjar_sha256": "603f19c397d63a2f1a2027ce01662460a89891802d76fbfc40a0a7d3463dd156",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-backend_2.12/1.0.0-M9/bloop-backend_2.12-1.0.0-M9-sources.jar",
                ],
            },
            "lang": "scala",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_ch_epfl_scala_bloop_config_2_12",
                "name": "jar/scala_annex_ch/epfl/scala/bloop_config_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_geirsson_metaconfig_core_2_12",
                    "@scala_annex_com_geirsson_metaconfig_docs_2_12",
                    "@scala_annex_com_geirsson_metaconfig_typesafe_config_2_12",
                    "@scala_annex_com_typesafe_config",
                    "@scala_annex_io_circe_circe_derivation_2_12",
                    "@scala_annex_org_scala_lang_scala_library",
                ],
                "jar_sha256": "3641d9ced747f914b295ef7ec24f5725b2e5ef51591944e042a45854e38e58d0",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-config_2.12/1.0.0-M9/bloop-config_2.12-1.0.0-M9.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bloop_config_2_12",
                "srcjar_sha256": "748cef18cb61cb7b604dda5e6c6c2e91cd27eaac30c077db5e4b3232b34753f0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-config_2.12/1.0.0-M9/bloop-config_2.12-1.0.0-M9-sources.jar",
                ],
            },
            "lang": "scala",
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
                    "@scala_annex_com_github_alexarchambault_case_app_2_12",
                    "@scala_annex_io_monix_monix_2_12",
                    "@scala_annex_org_scala_lang_scala_library",
                ],
                "jar_sha256": "d4c9de1e47dbcbbc801fe49349220244b91ffd6585e4ff02f073082e021fd98e",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-frontend_2.12/1.0.0-M9/bloop-frontend_2.12-1.0.0-M9.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bloop_frontend_2_12",
                "srcjar_sha256": "5c3e92f7f85f930c02c954e9117297ebdaaaafdb83d9c7058673e62e12e88e87",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bloop-frontend_2.12/1.0.0-M9/bloop-frontend_2.12-1.0.0-M9-sources.jar",
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
                    "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                    "@scala_annex_io_github_scalapb_json_scalapb_circe_2_12",
                    "@scala_annex_org_scalameta_lsp4s_2_12",
                ],
                "jar_sha256": "5802b2d779e83e761fdc82e4f0f4730890ad8d40d40793079eda73997af9aa3d",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bsp_2.12/03e9b72d/bsp_2.12-03e9b72d.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_bsp_2_12",
                "srcjar_sha256": "f8e7f49ab1b5f88d17cd01d917bc2a2e7abcdef0787a17ec3b0bf0585012ea0a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/bsp_2.12/03e9b72d/bsp_2.12-03e9b72d-sources.jar",
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
                "jar_sha256": "a571f53e002aac712b6edc572e2d2dbd2eba432816c9172e6cbc716ac0050f91",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/compiler-interface/1.1.1+49-1c290cbb/compiler-interface-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_compiler_interface",
                "srcjar_sha256": "254010c1eb38020f0a0462c628007a3f51b464a5a5bf9ff6eda996e86d62d997",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/compiler-interface/1.1.1+49-1c290cbb/compiler-interface-1.1.1+49-1c290cbb-sources.jar",
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
                "deps": [
                    "@scala_annex_net_java_dev_jna_jna",
                    "@scala_annex_net_java_dev_jna_jna_platform",
                ],
                "jar_sha256": "f933a203d983992d986aa9c24a1e0839fd8972995d14b9456b5a8889db3563f8",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/nailgun-server/51ddd0d9/nailgun-server-51ddd0d9.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_nailgun_server",
                "srcjar_sha256": "8f8b48b2457968cd9c5c695a72cec61b1cfb254088a9e606f9df9dbe742a2e41",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/nailgun-server/51ddd0d9/nailgun-server-51ddd0d9-sources.jar",
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
                "jar_sha256": "c1727ad90be2180eef3cd9b4cc8d14ecb23c67a42bfb18b561cb6a709d5c9297",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-apiinfo_2.12/1.1.1+49-1c290cbb/zinc-apiinfo_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_apiinfo_2_12",
                "srcjar_sha256": "65d940d5bca97a8cefa7b5ec29287c4369f75e83fe1c4a1ae9b9ba4d56851d02",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-apiinfo_2.12/1.1.1+49-1c290cbb/zinc-apiinfo_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "e1887d254e6715212d5661a31fcb57cce9cd193f4dd1be4bb57edc265c3eb1d6",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classfile_2.12/1.1.1+49-1c290cbb/zinc-classfile_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_classfile_2_12",
                "srcjar_sha256": "fadbbebe13a5c853c19212dc45f53ca2a1cc982c4e150ae62607ca23c9c0a5ff",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classfile_2.12/1.1.1+49-1c290cbb/zinc-classfile_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "b12c1c347a0ab218268530ab338c25329446b270d2ac12d0918147d31e9b655e",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classpath_2.12/1.1.1+49-1c290cbb/zinc-classpath_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_classpath_2_12",
                "srcjar_sha256": "09e89b38f630d52687bf186b62a247c6bba9d1f75ac0a990c417c396bdcd5e91",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-classpath_2.12/1.1.1+49-1c290cbb/zinc-classpath_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "697455c1805b108e2bd2925d1b6e9d990a4585af411695e9f6e1d289b94b0f3d",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-compile-core_2.12/1.1.1+49-1c290cbb/zinc-compile-core_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_compile_core_2_12",
                "srcjar_sha256": "3f035a0ed4022c45843d45917d9fd035fe374e9ee33ad3c27693bf6bcd5fe690",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-compile-core_2.12/1.1.1+49-1c290cbb/zinc-compile-core_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "9129366e58034b613162a98b8c70c1c082f9966cb9fa7b14595701ab918fb221",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-core_2.12/1.1.1+49-1c290cbb/zinc-core_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_core_2_12",
                "srcjar_sha256": "afa2306607c03722d56a44fc77cfdce4f2a3550d515e9ebf2a7d6ad9fb46043f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-core_2.12/1.1.1+49-1c290cbb/zinc-core_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "25839c54ed27f8c1bc4aa37cc0b4ab28bafff04a3228aeefa0e5d65554da3e6c",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-ivy-integration_2.12/1.1.1+49-1c290cbb/zinc-ivy-integration_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_ivy_integration_2_12",
                "srcjar_sha256": "0243da0ccefa4731a7ea087e8478d18e46da27c6ae4102cd940fccd3578b790a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-ivy-integration_2.12/1.1.1+49-1c290cbb/zinc-ivy-integration_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "dc4eb300babf225e947f52d4cfbb92ef25790cdab3ca8683888b378381bff6f6",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-persist_2.12/1.1.1+49-1c290cbb/zinc-persist_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_persist_2_12",
                "srcjar_sha256": "a67de98e39ba135d784a6c4ac0ca0160e40f21fc68c27a75dfb2a12642e26b42",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc-persist_2.12/1.1.1+49-1c290cbb/zinc-persist_2.12-1.1.1+49-1c290cbb-sources.jar",
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
                "jar_sha256": "b183eeb5d719df3c213dadbfaa06024dbfec6b8e748b2cacff5c8ff8ddc0bcfb",
                "jar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc_2.12/1.1.1+49-1c290cbb/zinc_2.12-1.1.1+49-1c290cbb.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_ch_epfl_scala_zinc_2_12",
                "srcjar_sha256": "77d3b48e396d380b6f99c8c0930bff1ed305546676fd1265a1e5f896554da1f9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/ch/epfl/scala/zinc_2.12/1.1.1+49-1c290cbb/zinc_2.12-1.1.1+49-1c290cbb-sources.jar",
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
        # - org.scala-sbt:util-logging_2.12:1.1.3 wanted version 0.8.2
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
                "actual": "@scala_annex_com_geirsson_metaconfig_core_2_12",
                "name": "jar/scala_annex_com/geirsson/metaconfig_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_lihaoyi_pprint_2_12",
                    "@scala_annex_org_scalameta_inputs_2_12",
                    "@scala_annex_org_typelevel_paiges_core_2_12",
                ],
                "jar_sha256": "9033b2bf857fccc70fa4b613a1276fc957263ba784a2ffead753fd386c7153ac",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-core_2.12/0.6.0/metaconfig-core_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_geirsson_metaconfig_core_2_12",
                "srcjar_sha256": "034a66211fa88884328c3c3e033c68dc887880b1ec4b7a7da0eb4c7b1a66db4f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-core_2.12/0.6.0/metaconfig-core_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_geirsson_metaconfig_docs_2_12",
                "name": "jar/scala_annex_com/geirsson/metaconfig_docs_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": ["@scala_annex_com_lihaoyi_scalatags_2_12"],
                "jar_sha256": "5ab5b2cba87511ed6a5b4869550935c58490d7699eb8199e15e67b187f15f814",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-docs_2.12/0.6.0/metaconfig-docs_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_geirsson_metaconfig_docs_2_12",
                "srcjar_sha256": "6e047754641bba12c0c8a971e726a52e0d622d3a3d1cd9e9969ee558a70f63f9",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-docs_2.12/0.6.0/metaconfig-docs_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_geirsson_metaconfig_typesafe_config_2_12",
                "name": "jar/scala_annex_com/geirsson/metaconfig_typesafe_config_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "171ebd45710bd962adac86c7d8f29b3d08b2714858317be4d27f05a00c598da7",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-typesafe-config_2.12/0.6.0/metaconfig-typesafe-config_2.12-0.6.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_geirsson_metaconfig_typesafe_config_2_12",
                "srcjar_sha256": "268030b8f634ee5dc5b6295c217bf325224fff4f685457b2e9f91899505dbab0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/geirsson/metaconfig-typesafe-config_2.12/0.6.0/metaconfig-typesafe-config_2.12-0.6.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_github_alexarchambault_case_app_annotations_2_12",
                "name": "jar/scala_annex_com/github/alexarchambault/case_app_annotations_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "f11466c855f9db55f334fcce032731090c464777a2d145d78ddbbd2bb35fbd8e",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/github/alexarchambault/case-app-annotations_2.12/1.2.0/case-app-annotations_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_github_alexarchambault_case_app_annotations_2_12",
                "srcjar_sha256": "1344cffe820527e31814235aa7e68191b2b56f695836a1965c20bfd76cb1722e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/github/alexarchambault/case-app-annotations_2.12/1.2.0/case-app-annotations_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_github_alexarchambault_case_app_util_2_12",
                "name": "jar/scala_annex_com/github/alexarchambault/case_app_util_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_chuusai_shapeless_2_12",
                    "@scala_annex_org_typelevel_macro_compat_2_12",
                ],
                "jar_sha256": "65ae3c037fd533fa02433970ce686d45e17ab9cad6a895fff65e3b7cfcec625a",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/github/alexarchambault/case-app-util_2.12/1.2.0/case-app-util_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_github_alexarchambault_case_app_util_2_12",
                "srcjar_sha256": "b4b54eeb98073392757b9b4e0656beb5fe3a51ab0b0fd749f4dcbc4e8e1d7bbf",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/github/alexarchambault/case-app-util_2.12/1.2.0/case-app-util_2.12-1.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_com_github_alexarchambault_case_app_2_12",
                "name": "jar/scala_annex_com/github/alexarchambault/case_app_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_github_alexarchambault_case_app_annotations_2_12",
                    "@scala_annex_com_github_alexarchambault_case_app_util_2_12",
                ],
                "jar_sha256": "b3326b400394700ca92e5eaaa3389a9b713568ec80eaf6daec58c4f4828ec343",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/github/alexarchambault/case-app_2.12/1.2.0/case-app_2.12-1.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_github_alexarchambault_case_app_2_12",
                "srcjar_sha256": "6f8f1f7703c0a9c30fdd45610c77763339b0e2a49e68d2df7729d1a6e77447c5",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/github/alexarchambault/case-app_2.12/1.2.0/case-app_2.12-1.2.0-sources.jar",
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
                "jar_sha256": "ac691b8fea3fcb01bf57cc396b7f55d61fbd9c22c00971fda3c1cabfcdd471a2",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/github/pathikrit/better-files_2.12/3.2.0/better-files_2.12-3.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_github_pathikrit_better_files_2_12",
                "srcjar_sha256": "b2c84728ab879a63007c3d226bc45e529a9934fd4d9a09bb821b64777eb20cd3",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/github/pathikrit/better-files_2.12/3.2.0/better-files_2.12-3.2.0-sources.jar",
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
                "jar_sha256": "dce7e66b32456a1b1198da0caff3a8acb71548658391e798c79369241e6490a4",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_google_protobuf_protobuf_java",
                "srcjar_sha256": "07a55d5d34d2b47d2d1d9092be1dbf1b1d99fffcea19b7eafba508de8daae2cd",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0-sources.jar",
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
                "jar_sha256": "02f59c0c856511ff20a6f9ce875097e3cec990618c354ffb75e4d7bbdf5be7da",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.4/fastparse-utils_2.12-0.4.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_fastparse_utils_2_12",
                "srcjar_sha256": "4415d71dd6dea0ab0a62d5c2ff861cc4666d861f96ed53734d51acb14a76ee45",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.4/fastparse-utils_2.12-0.4.4-sources.jar",
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
                "deps": ["@scala_annex_com_lihaoyi_fastparse_utils_2_12"],
                "jar_sha256": "7bc2a3131204e737f020f94e19b1e62a1bf5359f5741c35dff9351ef36d7a80e",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.4/fastparse_2.12-0.4.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_fastparse_2_12",
                "srcjar_sha256": "d969946c31d521e7afbe9b126bc18ad7e62f293665fb50c7050fad982ad66904",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.4/fastparse_2.12-0.4.4-sources.jar",
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
        {
            "bind_args": {
                "actual": "@scala_annex_com_lihaoyi_scalatags_2_12",
                "name": "jar/scala_annex_com/lihaoyi/scalatags_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "a63871de40fce5dc15f9186032ef562211e43d52fa2b0b68a5a52945fa676113",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/scalatags_2.12/0.6.7/scalatags_2.12-0.6.7.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_lihaoyi_scalatags_2_12",
                "srcjar_sha256": "9b45a3efca18bbbdbeabd07ce1419d6a822f6c6b629b03878ef9f44f266140da",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/lihaoyi/scalatags_2.12/0.6.7/scalatags_2.12-0.6.7-sources.jar",
                ],
            },
            "lang": "java",
        },
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
                    "@scala_annex_org_scala_lang_scala_library",
                    "@scala_annex_org_scala_lang_scala_reflect",
                    "@scala_annex_org_scala_sbt_test_interface",
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
        # duplicates in com.trueaccord.scalapb:scalapb-runtime_2.12 promoted to 0.6.6
        # - ch.epfl.scala:bsp_2.12:03e9b72d wanted version 0.6.6
        # - ch.epfl.scala:zinc-persist_2.12:1.1.1+49-1c290cbb wanted version 0.6.0
        # - org.scala-sbt:zinc-persist_2.12:1.1.3 wanted version 0.6.0
        # - org.scalameta:langmeta_2.12:2.0.0-M3 wanted version 0.6.2
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
                "jar_sha256": "80307c8cef7d27adcd87eeefdd13ab0a809b5bc1d8e02240f1d1777f34bb4a47",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.6/scalapb-runtime_2.12-0.6.6.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                "srcjar_sha256": "0f222e77533a74e9b976d5b82c81d778cb31f2ac6c09b154b9b6468d33b50596",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.6/scalapb-runtime_2.12-0.6.6-sources.jar",
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
        # duplicates in com.typesafe:config promoted to 1.3.2
        # - ch.epfl.scala:bloop-config_2.12:1.0.0-M9 wanted version 1.3.2
        # - com.typesafe:ssl-config-core_2.12:0.2.2 wanted version 1.2.0
        {
            "bind_args": {
                "actual": "@scala_annex_com_typesafe_config",
                "name": "jar/scala_annex_com/typesafe/config",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "6563d1723f3300bf596f41e40bc03e54986108b5c45d0ac34ebc66d48c2e25a3",
                "jar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/config/1.3.2/config-1.3.2.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_com_typesafe_config",
                "srcjar_sha256": "65995abd56d6aa99ee7f46e7cdaaaac2968554b16b26d38bf67e13706a12ca82",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/com/typesafe/config/1.3.2/config-1.3.2-sources.jar",
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
                "actual": "@scala_annex_io_circe_circe_core_2_12",
                "name": "jar/scala_annex_io/circe/circe_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_io_circe_circe_numbers_2_12",
                    "@scala_annex_org_typelevel_cats_core_2_12",
                ],
                "jar_sha256": "256527a2ce81b91db1d3cc27f44dc920a8cb33ff32c1d6e6d9813799df774e20",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-core_2.12/0.9.3/circe-core_2.12-0.9.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_core_2_12",
                "srcjar_sha256": "a84c0f7651d1a1ef2c4fb7df802965b572680f88e6128f09f137be19759e9e78",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-core_2.12/0.9.3/circe-core_2.12-0.9.3-sources.jar",
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
                "deps": ["@scala_annex_io_circe_circe_core_2_12"],
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
                "jar_sha256": "f2e2a482e3f6ad50c8a71ff2f3478c64409aeefa0f092737d7d6c37a623c1e5b",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-jawn_2.12/0.9.0/circe-jawn_2.12-0.9.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_jawn_2_12",
                "srcjar_sha256": "d9d2a299879edd001fe9ee410fe2cd027287c1006da2ad791e4f450d63865277",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-jawn_2.12/0.9.0/circe-jawn_2.12-0.9.0-sources.jar",
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
                "jar_sha256": "49cd74886f74659b239b6a85f3ba8e24f212a9e6b299fb9a793e092905bc8fa3",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-numbers_2.12/0.9.3/circe-numbers_2.12-0.9.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_numbers_2_12",
                "srcjar_sha256": "562f7bc8dab9917b5e903cd8931a52cfce22d6a2fa53df1919ad5088580b8eb2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-numbers_2.12/0.9.3/circe-numbers_2.12-0.9.3-sources.jar",
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
                "jar_sha256": "b919770a22956cd39326dcd5f23500ffd15a3dc7fee46f1e291a5ae35afd8b86",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-parser_2.12/0.9.0/circe-parser_2.12-0.9.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_circe_circe_parser_2_12",
                "srcjar_sha256": "c3c2a42825422c5a59786f22b7cc3750d494d251760e2066eea55318612b32f1",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/circe/circe-parser_2.12/0.9.0/circe-parser_2.12-0.9.0-sources.jar",
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
                "deps": ["@scala_annex_org_scalaz_scalaz_concurrent_2_12"],
                "jar_sha256": "a0f4f23f60c6acad3e778769a741a15ce62173549291775488028e228a42e1b6",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier-cache_2.12/1.0.0-RC8/coursier-cache_2.12-1.0.0-RC8.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_get_coursier_coursier_cache_2_12",
                "srcjar_sha256": "3c0fc30551c6b9830a8fd04a0a0419279f902762d20f8f2d5d540be53217b19e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier-cache_2.12/1.0.0-RC8/coursier-cache_2.12-1.0.0-RC8-sources.jar",
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
                    "@scala_annex_org_scalaz_scalaz_core_2_12",
                ],
                "jar_sha256": "437d53c55fe4beb48574d886876956cf9320ecda85b4a1c30cfe42f64c3c455c",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier_2.12/1.0.0-RC8/coursier_2.12-1.0.0-RC8.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_get_coursier_coursier_2_12",
                "srcjar_sha256": "336bb9ab5874770230aa1200b14c92985afb9c91337cea0f7ae4e7f441010da2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/get-coursier/coursier_2.12/1.0.0-RC8/coursier_2.12-1.0.0-RC8-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_github_scalapb_json_scalapb_circe_2_12",
                "name": "jar/scala_annex_io/github/scalapb_json/scalapb_circe_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_io_circe_circe_parser_2_12",
                    "@scala_annex_io_github_scalapb_json_scalapb_json_common_2_12",
                ],
                "jar_sha256": "69160c32d4d61f861c542701bb9b054d36cdc5d393182d3a7c7b0cdb4b3a9c00",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/github/scalapb-json/scalapb-circe_2.12/0.1.1/scalapb-circe_2.12-0.1.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_github_scalapb_json_scalapb_circe_2_12",
                "srcjar_sha256": "8b73f9af30e0ddf23e11d200995cbe960a65b2ee6e085338825b610256aa9932",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/github/scalapb-json/scalapb-circe_2.12/0.1.1/scalapb-circe_2.12-0.1.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_github_scalapb_json_scalapb_json_common_2_12",
                "name": "jar/scala_annex_io/github/scalapb_json/scalapb_json_common_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "62ad356f48b1dcb0cee6bf10f62dcad5cea1207b49a6d33941d2a929139bd5bd",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/github/scalapb-json/scalapb-json-common_2.12/0.1.1/scalapb-json-common_2.12-0.1.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_github_scalapb_json_scalapb_json_common_2_12",
                "srcjar_sha256": "4a0b927d5c14a9d0e801d79de7e5d9f3fe77df79dcf6d092669c29e57fb4fd0e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/github/scalapb-json/scalapb-json-common_2.12/0.1.1/scalapb-json-common_2.12-0.1.1-sources.jar",
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
                "deps": ["@scala_annex_org_junit_jupiter_junit_jupiter_api"],
                "jar_sha256": "a86b5db50849431609585bc23883dba78cadbe0ba407a3522b0531a63b75fbcd",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/github/soc/directories/5/directories-5.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_github_soc_directories",
                "srcjar_sha256": "c1dde43ee3ef3d5bd77fb939d4e838d190dc798f746917ad400c7e6ba4e2aa29",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/github/soc/directories/5/directories-5-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_methvin_directory_watcher_better_files_2_12",
                "name": "jar/scala_annex_io/methvin/directory_watcher_better_files_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_github_pathikrit_better_files_2_12",
                    "@scala_annex_io_methvin_directory_watcher",
                ],
                "jar_sha256": "89f294c5bea870ece5810d410e52939b9bdf70282a41dfa007facc1d54f040e8",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/methvin/directory-watcher-better-files_2.12/0.4.0/directory-watcher-better-files_2.12-0.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_methvin_directory_watcher_better_files_2_12",
                "srcjar_sha256": "1d5a144368d97fa0f4067f629c226198dce11cb7b6bb73b8b00928e451a6de9f",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/methvin/directory-watcher-better-files_2.12/0.4.0/directory-watcher-better-files_2.12-0.4.0-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_io_methvin_directory_watcher",
                "name": "jar/scala_annex_io/methvin/directory_watcher",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_google_guava_guava",
                    "@scala_annex_org_slf4j_slf4j_api",
                ],
                "jar_sha256": "3106b9d72894704ea72b7880b3fdb1a686f14fe8ffdf74b1bb381e77fd781d1b",
                "jar_urls": [
                    "http://central.maven.org/maven2/io/methvin/directory-watcher/0.4.0/directory-watcher-0.4.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_io_methvin_directory_watcher",
                "srcjar_sha256": "1f3a9f1673bac9eae199b59846e34ce507e10cb5581dfd07bcf3c12f5ac6b16a",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/io/methvin/directory-watcher/0.4.0/directory-watcher-0.4.0-sources.jar",
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
        # duplicates in net.java.dev.jna:jna-platform promoted to 4.5.0
        # - ch.epfl.scala:nailgun-server:51ddd0d9 wanted version 4.4.0
        # - org.scala-sbt:io_2.12:1.1.4 wanted version 4.5.0
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
        # duplicates in net.java.dev.jna:jna promoted to 4.5.0
        # - ch.epfl.scala:nailgun-server:51ddd0d9 wanted version 4.4.0
        # - org.scala-sbt:io_2.12:1.1.4 wanted version 4.5.0
        {
            "bind_args": {
                "actual": "@scala_annex_net_java_dev_jna_jna",
                "name": "jar/scala_annex_net/java/dev/jna/jna",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "617a8d75f66a57296255a13654a99f10f72f0964336e352211247ed046da3e94",
                "jar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna/4.5.0/jna-4.5.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_net_java_dev_jna_jna",
                "srcjar_sha256": "e4da62978d75a5f47641d6c3548a6859c193fad8c5d0bc95a5f049d8ec1a0f79",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/net/java/dev/jna/jna/4.5.0/jna-4.5.0-sources.jar",
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
                "actual": "@scala_annex_org_junit_jupiter_junit_jupiter_api",
                "name": "jar/scala_annex_org/junit/jupiter/junit_jupiter_api",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_junit_platform_junit_platform_commons",
                    "@scala_annex_org_opentest4j_opentest4j",
                ],
                "jar_sha256": "05f092a3e1a6dfe42ad38e7ec43e6abe4d4f56d5975124d9f8025b526d14ee05",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/junit/jupiter/junit-jupiter-api/5.0.1/junit-jupiter-api-5.0.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_junit_jupiter_junit_jupiter_api",
                "srcjar_sha256": "d8188657c627244548a19d01d411ebf4a435b00693952953fef6c8309da78e10",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/junit/jupiter/junit-jupiter-api/5.0.1/junit-jupiter-api-5.0.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_junit_platform_junit_platform_commons",
                "name": "jar/scala_annex_org/junit/platform/junit_platform_commons",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "dcaef05f575bc09d0adb87462dfffe090c5c1d8d446301baae5d4843ebc8099d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/junit/platform/junit-platform-commons/1.0.1/junit-platform-commons-1.0.1.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_junit_platform_junit_platform_commons",
                "srcjar_sha256": "b32201324b4b4c8930b4b482347075b9e61fba4b5adc5aa02da4e83fb5712572",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/junit/platform/junit-platform-commons/1.0.1/junit-platform-commons-1.0.1-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_opentest4j_opentest4j",
                "name": "jar/scala_annex_org/opentest4j/opentest4j",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "6a05b14e8764a1fa51551ccef29e7271681d65fa907a8136136b94de92a0b862",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/opentest4j/opentest4j/1.0.0/opentest4j-1.0.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_opentest4j_opentest4j",
                "srcjar_sha256": "68e5bbe7dbe3b8cfe2b98976a3271830a366ac5c5f5a450ed301c6b4f08bb822",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/opentest4j/opentest4j/1.0.0/opentest4j-1.0.0-sources.jar",
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
        # - ch.epfl.scala:zinc-compile-core_2.12:1.1.1+49-1c290cbb wanted version 1.0.5
        # - org.scala-sbt:zinc-compile-core_2.12:1.1.3 wanted version 1.0.5
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
        # - io.get-coursier:coursier_2.12:1.0.0-RC8 wanted version 1.0.6
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
                "jar_sha256": "8b681302aac584f7234547eed04d2beeeb4a4f00032220e29d40943be6906a01",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_lang_scala_compiler",
                "srcjar_sha256": "675d1e5e163f4db1f8bde9b20ed7b30d5e6e635e18855cb0e4f3b5e672a88512",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-lang:scala-library promoted to 2.12.4
        # - ch.epfl.scala:bloop-backend_2.12:1.0.0-M9 wanted version 2.12.4
        # - ch.epfl.scala:bloop-config_2.12:1.0.0-M9 wanted version 2.12.4
        # - ch.epfl.scala:bloop-frontend_2.12:1.0.0-M9 wanted version 2.12.4
        # - com.lihaoyi:utest_2.12:0.6.0 wanted version 2.12.3
        # - org.scala-sbt:zinc_2.12:1.1.3 wanted version 2.12.4
        # - org.scalacheck:scalacheck_2.12:1.13.4 wanted version 2.12.0
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 2.12.3
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_lang_scala_library",
                "name": "jar/scala_annex_org/scala_lang/scala_library",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "17824fcee4d3f46cfaa4da84ebad4f58496426c2b9bc9e341f812ab23a667d5d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_lang_scala_library",
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
        # - org.scalatest:scalatest_2.12:3.0.4 wanted version 2.12.3
        # - org.typelevel:machinist_2.12:0.6.2 wanted version 2.12.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_lang_scala_reflect",
                "name": "jar/scala_annex_org/scala_lang/scala_reflect",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "ea70fe0e550e24d23fc52a18963b2be9c3b24283f4cb18b98327eb72746567cc",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_lang_scala_reflect",
                "srcjar_sha256": "7b4dc73dc3cb46ac9ac948a0c231ccd989bed6cefb137c302a8ec8d6811e8148",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4-sources.jar",
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
                "jar_sha256": "b4bf33b112d572752ca673ce7652f0419b87c838a07bb0eccb8667bec58bffb6",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/compiler-interface/1.1.3/compiler-interface-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_compiler_interface",
                "srcjar_sha256": "f5353e51b78fa621c2c2de5e48b8717c53165dff8b539e96494de12856c37818",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/compiler-interface/1.1.3/compiler-interface-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:io_2.12 promoted to 1.1.4
        # - ch.epfl.scala:zinc-core_2.12:1.1.1+49-1c290cbb wanted version 1.1.3
        # - org.scala-sbt:zinc-core_2.12:1.1.3 wanted version 1.1.4
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_io_2_12",
                "name": "jar/scala_annex_org/scala_sbt/io_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_net_java_dev_jna_jna",
                    "@scala_annex_net_java_dev_jna_jna_platform",
                ],
                "jar_sha256": "f1f514b54b4126ad9d4a1b14769128c06e1e0e7d18643f457a499af171b7a87e",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_io_2_12",
                "srcjar_sha256": "f7a5811cdf568a46952e29385493a90ff3d812661ebe0498b5e4be02c112d887",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4-sources.jar",
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
        # duplicates in org.scala-sbt:librarymanagement-core_2.12 promoted to 1.1.4
        # - org.scala-sbt:librarymanagement-ivy_2.12:1.0.0 wanted version 1.0.0
        # - org.scala-sbt:zinc-ivy-integration_2.12:1.1.3 wanted version 1.1.4
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
                "jar_sha256": "6e00c7670de3403eb0c5382d67e123ddbaf8fd1619a340ef97f6fd702ad32cb6",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.1.4/librarymanagement-core_2.12-1.1.4.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_librarymanagement_core_2_12",
                "srcjar_sha256": "a7250bc2d145cf143499d8ec9e4e1eb5b17570e08d88a80d88ac6b1dc6473fab",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.1.4/librarymanagement-core_2.12-1.1.4-sources.jar",
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
                "jar_sha256": "3f69c0056db6a2bedd6b48fb5b5c69fa8260826bb2ec1fb0ffd4dfd7c2c7c66f",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.1.3/util-cache_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_cache_2_12",
                "srcjar_sha256": "8c9e9cfaa958e01bc6c4db5eb174003cd0983bcf7a6825fe2d47d4845d7b1995",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.1.3/util-cache_2.12-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-control_2.12 promoted to 1.1.3
        # - ch.epfl.scala:zinc-compile-core_2.12:1.1.1+49-1c290cbb wanted version 1.1.2
        # - org.scala-sbt:zinc-compile-core_2.12:1.1.3 wanted version 1.1.3
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_control_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_control_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "7a291f8a3080d7843620b087ab5c797c0ee5f43460a1e4f3ce4422afb73ae799",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-control_2.12/1.1.3/util-control_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_control_2_12",
                "srcjar_sha256": "988b1faeaa4fcb1d3ac3c7e8647b67f9325828021246b516a0eec3d3d9abcd53",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-control_2.12/1.1.3/util-control_2.12-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-interface promoted to 1.1.3
        # - ch.epfl.scala:compiler-interface:1.1.1+49-1c290cbb wanted version 1.1.2
        # - org.scala-sbt:compiler-interface:1.1.3 wanted version 1.1.3
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_interface",
                "name": "jar/scala_annex_org/scala_sbt/util_interface",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "c671b55697207eb7ac680fea390c249f383fdf2e445b3e98f8cae4f6bc324860",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-interface/1.1.3/util-interface-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_interface",
                "srcjar_sha256": "2e194c784c8c9dd3d34603a4378bfa7193708c1decba0ddb9aafe5b1ceccb6ab",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-interface/1.1.3/util-interface-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-logging_2.12 promoted to 1.1.3
        # - ch.epfl.scala:zinc-core_2.12:1.1.1+49-1c290cbb wanted version 1.1.2
        # - org.scala-sbt:zinc-core_2.12:1.1.3 wanted version 1.1.3
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
                    "@scala_annex_org_scala_lang_scala_reflect",
                ],
                "jar_sha256": "14ec8942b844658a7da7e04f60555751661ab1273f8b31b57cfd86b473be2653",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.1.3/util-logging_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_logging_2_12",
                "srcjar_sha256": "d0315dec95a9da6a2faefaf785f3d53953cda084e1e4b8e6bdc030c7d3f9917d",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.1.3/util-logging_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "20fd912315e925f7f122aced8ae9aca3f099ae1ce6f1b00a201e1fcff1cdd360",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-position_2.12/1.1.3/util-position_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_position_2_12",
                "srcjar_sha256": "7b0a5c848212de1ccda400d242074666423ddb47534af8100c0d4b474b6cf6be",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-position_2.12/1.1.3/util-position_2.12-1.1.3-sources.jar",
                ],
            },
            "lang": "java",
        },
        # duplicates in org.scala-sbt:util-relation_2.12 promoted to 1.1.3
        # - ch.epfl.scala:zinc-core_2.12:1.1.1+49-1c290cbb wanted version 1.1.2
        # - org.scala-sbt:zinc-core_2.12:1.1.3 wanted version 1.1.3
        {
            "bind_args": {
                "actual": "@scala_annex_org_scala_sbt_util_relation_2_12",
                "name": "jar/scala_annex_org/scala_sbt/util_relation_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "dff98263c5fd5fc374ac241221cb83619a6bcce328c060482589d810617c2287",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.1.3/util-relation_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_util_relation_2_12",
                "srcjar_sha256": "8a14088c870199b828ec3e87da6d9cbe39b0b766ce51c9cbf6ba294fe9fed3c0",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.1.3/util-relation_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "3e9070ce4a2f69646c0f64a334908827d90074448b3d0cb95b9141887b3d5f0c",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.1.3/zinc-apiinfo_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_apiinfo_2_12",
                "srcjar_sha256": "e5dd905304cbf60b47a5ce1ebf698488b9834cb4d906675f4415b5e50dacaf63",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.1.3/zinc-apiinfo_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "3c0df927855cfbfbde8fc7a1cdbf6c5ed18130bd353a05b2c5c4fca4214025c4",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.1.3/zinc-classfile_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_classfile_2_12",
                "srcjar_sha256": "4dafe6057d5f707d6dee543e6b49fef4708b1e74b2ace302c56546c9ac584218",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.1.3/zinc-classfile_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "23195dafd114d78f1be351734d51fc1142b2bff33cdd7542a4d4a7eedf641be2",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.1.3/zinc-classpath_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_classpath_2_12",
                "srcjar_sha256": "cc4850663022a20a64af2f24074c25d453c7e43aa24ecad05a1a54fdabac1d4e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.1.3/zinc-classpath_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "faa85dd75e6fee87f526c1d432ff3ab4a1b7c89526cc838b20d88d836877c098",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.1.3/zinc-compile-core_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_compile_core_2_12",
                "srcjar_sha256": "f154d2d9e24c74c94fb4d69d31d33bc6882ba34a96596b88a531202ef077ef58",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.1.3/zinc-compile-core_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "4f340bdf61d72d2373665f7c601ec931e44a3a28bfe2cf6b3450a0979d2cc27b",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.1.3/zinc-core_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_core_2_12",
                "srcjar_sha256": "0032a7d5428916df25fbe0f1471ae3d9d1cb9453b3d11514690e2178a2126637",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.1.3/zinc-core_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "079c8ff8fe7459d877092dc78856a60d28344d255c088127316550b40e77c449",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.1.3/zinc-ivy-integration_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_ivy_integration_2_12",
                "srcjar_sha256": "23bf3f13bcdda9b7096737a365a99e9ff4502b1a6175324bc3c5555178b72d24",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.1.3/zinc-ivy-integration_2.12-1.1.3-sources.jar",
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
                "jar_sha256": "16ddeef691c3f1da7f562016e542e15ad600a9e857770364582059d9d4900d2d",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.1.3/zinc-persist_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_persist_2_12",
                "srcjar_sha256": "c3cdda91c2a733bd6d358f48522135b43801d3525ea760b3bf4b78c2a041c996",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.1.3/zinc-persist_2.12-1.1.3-sources.jar",
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
                    "@scala_annex_org_scala_lang_scala_library",
                    "@scala_annex_org_scala_sbt_zinc_classfile_2_12",
                    "@scala_annex_org_scala_sbt_zinc_compile_core_2_12",
                    "@scala_annex_org_scala_sbt_zinc_core_2_12",
                    "@scala_annex_org_scala_sbt_zinc_ivy_integration_2_12",
                    "@scala_annex_org_scala_sbt_zinc_persist_2_12",
                ],
                "jar_sha256": "af1f9507af3f2898c94be71710e1c33ef00600ba2780b38d22148ce2ed326d03",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc_2.12/1.1.3/zinc_2.12-1.1.3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scala_sbt_zinc_2_12",
                "srcjar_sha256": "681d01345428352c46c54b0f7e8bf44b642558c8e239557254d96971f5f54ae2",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scala-sbt/zinc_2.12/1.1.3/zinc_2.12-1.1.3-sources.jar",
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
                    "@scala_annex_org_scala_lang_scala_library",
                    "@scala_annex_org_scala_sbt_test_interface",
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
                "actual": "@scala_annex_org_scalameta_common_2_12",
                "name": "jar/scala_annex_org/scalameta/common_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "142cf1e5cd81542db650ff1709323f2f4fc31b9efbb6b665b6f48f0e1d1b7521",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/common_2.12/2.0.0-M3/common_2.12-2.0.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_common_2_12",
                "srcjar_sha256": "eeed92845577d5a4aedaba92476c42b33ee46c254ea7f13d66fc4ba59d648fbd",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/common_2.12/2.0.0-M3/common_2.12-2.0.0-M3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalameta_inputs_2_12",
                "name": "jar/scala_annex_org/scalameta/inputs_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_org_scalameta_common_2_12",
                    "@scala_annex_org_scalameta_io_2_12",
                    "@scala_annex_org_scalameta_langmeta_2_12",
                ],
                "jar_sha256": "2a1b7d93e28b7c92ec02e9bc873d28f58d97e43e116b39fd0d22f6472663a17c",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/inputs_2.12/2.0.0-M3/inputs_2.12-2.0.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_inputs_2_12",
                "srcjar_sha256": "9577cb773530e7bbb36b2aef5d7cfe0d65b3d83d61ec9ed063e2c68100955e96",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/inputs_2.12/2.0.0-M3/inputs_2.12-2.0.0-M3-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalameta_io_2_12",
                "name": "jar/scala_annex_org/scalameta/io_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "ea945c2323215023ccce63a6839715ee902b7640e8389d96cbff40c5f4e77bcb",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/io_2.12/2.0.0-M3/io_2.12-2.0.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_io_2_12",
                "srcjar_sha256": "da4a3cf952a521a4a34c86eb926a10fa5b7aa8bde7928a4cd2030f0a85a60d2c",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/io_2.12/2.0.0-M3/io_2.12-2.0.0-M3-sources.jar",
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
                    "@scala_annex_com_typesafe_scala_logging_scala_logging_2_12",
                    "@scala_annex_io_circe_circe_generic_2_12",
                    "@scala_annex_io_circe_circe_generic_extras_2_12",
                    "@scala_annex_org_codehaus_groovy_groovy",
                ],
                "jar_sha256": "add2d315c20c4943a339f8528d33584f859932f5911ca69e493a0db311dd733b",
                "jar_urls": [
                    "https://dl.bintray.com/scalameta/maven/org/scalameta/jsonrpc_2.12/4d51e1ae/jsonrpc_2.12-4d51e1ae.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_jsonrpc_2_12",
                "srcjar_sha256": "22bc3aa77b286493407857e284e4861b786c2491ad0a6ecce9dd9af7cfee82b6",
                "srcjar_urls": [
                    "https://dl.bintray.com/scalameta/maven/org/scalameta/jsonrpc_2.12/4d51e1ae/jsonrpc_2.12-4d51e1ae-sources.jar",
                ],
            },
            "lang": "java",
        },
        {
            "bind_args": {
                "actual": "@scala_annex_org_scalameta_langmeta_2_12",
                "name": "jar/scala_annex_org/scalameta/langmeta_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "deps": [
                    "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
                ],
                "jar_sha256": "336471bdc61b4a6334e3fb62d593dc35d992d002d5229fca28ebf7cb9e9e3115",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/langmeta_2.12/2.0.0-M3/langmeta_2.12-2.0.0-M3.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_langmeta_2_12",
                "srcjar_sha256": "9e6be8ef7dabf21c9ca0ab315262be7417cfa306b4f5a129926c017ce504bbe7",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalameta/langmeta_2.12/2.0.0-M3/langmeta_2.12-2.0.0-M3-sources.jar",
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
                "jar_sha256": "1cdc378f5b6859c592988e067fdd83a17616608e2c4161265051bac7b6e89322",
                "jar_urls": [
                    "https://dl.bintray.com/scalameta/maven/org/scalameta/lsp4s_2.12/4d51e1ae/lsp4s_2.12-4d51e1ae.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalameta_lsp4s_2_12",
                "srcjar_sha256": "0975d3d685fef1979a6e605a5ea88a687d79e41f8a628bff8ac54329215cf62e",
                "srcjar_urls": [
                    "https://dl.bintray.com/scalameta/maven/org/scalameta/lsp4s_2.12/4d51e1ae/lsp4s_2.12-4d51e1ae-sources.jar",
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
                    "@scala_annex_org_scala_lang_scala_library",
                    "@scala_annex_org_scala_lang_scala_reflect",
                    "@scala_annex_org_scalactic_scalactic_2_12",
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
                "jar_sha256": "8b830657946d467b63324671d04dedae4e011447127cebed5d4de40afb684749",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-concurrent_2.12/7.2.13/scalaz-concurrent_2.12-7.2.13.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalaz_scalaz_concurrent_2_12",
                "srcjar_sha256": "2d236c7b2435c78abcd079056e5d13ce2149b4e2c6e25f428231a3672770f826",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-concurrent_2.12/7.2.13/scalaz-concurrent_2.12-7.2.13-sources.jar",
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
                "jar_sha256": "effcb6b3fa771e453043411bffb1aaf7acbc7c4b4119ac4472af01b626806006",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-core_2.12/7.2.13/scalaz-core_2.12-7.2.13.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalaz_scalaz_core_2_12",
                "srcjar_sha256": "0065982795ea83fbb0f89eecbe6de912bbfe1ce12c5801721c876f48ec20ee2b",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-core_2.12/7.2.13/scalaz-core_2.12-7.2.13-sources.jar",
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
                "jar_sha256": "ba5770e9bee58a159de0bbaa507742847b41f0b903791c5300b7c3a756397946",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-effect_2.12/7.2.13/scalaz-effect_2.12-7.2.13.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_scalaz_scalaz_effect_2_12",
                "srcjar_sha256": "196c6993ed84e4948632f0e6ae7077edc53180258322fd415cc1fa360afe4f4e",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/scalaz/scalaz-effect_2.12/7.2.13/scalaz-effect_2.12-7.2.13-sources.jar",
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
        # duplicates in org.spire-math:jawn-parser_2.12 promoted to 0.11.0
        # - com.eed3si9n:sjson-new-scalajson_2.12:0.8.2 wanted version 0.10.4
        # - io.circe:circe-jawn_2.12:0.9.0 wanted version 0.11.0
        {
            "bind_args": {
                "actual": "@scala_annex_org_spire_math_jawn_parser_2_12",
                "name": "jar/scala_annex_org/spire_math/jawn_parser_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "aea382b1d1df92da2a07a83d153f4c5178ba1f43a51a208f5ffa842a66ed2d43",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.11.0/jawn-parser_2.12-0.11.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_spire_math_jawn_parser_2_12",
                "srcjar_sha256": "2627bf5180f9e63ba34993e51b23e28b2e81fe17b3412ca023344302a32c2038",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.11.0/jawn-parser_2.12-0.11.0-sources.jar",
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
                "deps": ["@scala_annex_org_scala_lang_scala_reflect"],
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
        {
            "bind_args": {
                "actual": "@scala_annex_org_typelevel_paiges_core_2_12",
                "name": "jar/scala_annex_org/typelevel/paiges_core_2_12",
            },
            "import_args": {
                "default_visibility": ["//visibility:public"],
                "jar_sha256": "0051e89bfcb1efd0498c6a95cb1583bc1d097230da9627da76de0b416692e703",
                "jar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/paiges-core_2.12/0.2.0/paiges-core_2.12-0.2.0.jar",
                ],
                "licenses": ["notice"],
                "name": "scala_annex_org_typelevel_paiges_core_2_12",
                "srcjar_sha256": "8df865fe550d2f55996e9c19ac008cb2c8e53571643c7ed88cbafffc7e38f036",
                "srcjar_urls": [
                    "http://central.maven.org/maven2/org/typelevel/paiges-core_2.12/0.2.0/paiges-core_2.12-0.2.0-sources.jar",
                ],
            },
            "lang": "java",
        },
    ]

def maven_dependencies(callback = declare_maven):
    for hash in list_dependencies():
        callback(hash)
