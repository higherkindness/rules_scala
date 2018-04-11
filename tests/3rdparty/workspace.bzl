# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.

def declare_maven(hash):
    native.maven_jar(
        name = hash["name"],
        artifact = hash["artifact"],
        sha1 = hash["sha1"],
        repository = hash["repository"],
    )
    native.bind(
        name = hash["bind"],
        actual = hash["actual"],
    )

def maven_dependencies(callback = declare_maven):
    callback({"artifact": "com.lihaoyi:utest_2.12:0.6.0", "lang": "scala", "sha1": "85298cdef85af13edd24f4c6a08af593023af4de", "repository": "http://central.maven.org/maven2/", "name": "com_lihaoyi_utest_2_12", "actual": "@com_lihaoyi_utest_2_12//jar:file", "bind": "jar/com/lihaoyi/utest_2_12"})
    callback({"artifact": "org.scala-lang.modules:scala-parser-combinators_2.12:1.0.4", "lang": "java", "sha1": "7c5f25a2d40ea7651452f0f0d1d4c12dabffcb8b", "repository": "http://central.maven.org/maven2/", "name": "org_scala_lang_modules_scala_parser_combinators_2_12", "actual": "@org_scala_lang_modules_scala_parser_combinators_2_12//jar", "bind": "jar/org/scala_lang/modules/scala_parser_combinators_2_12"})
    callback({"artifact": "org.scala-lang.modules:scala-xml_2.12:1.0.5", "lang": "java", "sha1": "a2b2afbeea86818a911b05851bb11d7d4840bb75", "repository": "http://central.maven.org/maven2/", "name": "org_scala_lang_modules_scala_xml_2_12", "actual": "@org_scala_lang_modules_scala_xml_2_12//jar", "bind": "jar/org/scala_lang/modules/scala_xml_2_12"})

    # duplicates in org.scala-lang:scala-library promoted to 2.12.3
    # - org.scalatest:scalatest_2.12:3.0.4 wanted version 2.12.3
    # - com.lihaoyi:utest_2.12:0.6.0 wanted version 2.12.3
    # - org.scalacheck:scalacheck_2.12:1.13.4 wanted version 2.12.0
    callback({"artifact": "org.scala-lang:scala-library:2.12.3", "lang": "java", "sha1": "f2e496f21af2d80b48e0a61773f84c3a76a0d06f", "repository": "http://central.maven.org/maven2/", "name": "org_scala_lang_scala_library", "actual": "@org_scala_lang_scala_library//jar", "bind": "jar/org/scala_lang/scala_library"})
    callback({"artifact": "org.scala-lang:scala-reflect:2.12.3", "lang": "java", "sha1": "a017f8f606e5f433df4f8d5efc20ce39c2fe8330", "repository": "http://central.maven.org/maven2/", "name": "org_scala_lang_scala_reflect", "actual": "@org_scala_lang_scala_reflect//jar", "bind": "jar/org/scala_lang/scala_reflect"})
    callback({"artifact": "org.scala-sbt:test-interface:1.0", "lang": "java", "sha1": "0a3f14d010c4cb32071f863d97291df31603b521", "repository": "http://central.maven.org/maven2/", "name": "org_scala_sbt_test_interface", "actual": "@org_scala_sbt_test_interface//jar", "bind": "jar/org/scala_sbt/test_interface"})
    callback({"artifact": "org.scalacheck:scalacheck_2.12:1.13.4", "lang": "scala", "sha1": "1982eef19118794a31b178022fb80257a5bb985e", "repository": "http://central.maven.org/maven2/", "name": "org_scalacheck_scalacheck_2_12", "actual": "@org_scalacheck_scalacheck_2_12//jar:file", "bind": "jar/org/scalacheck/scalacheck_2_12"})
    callback({"artifact": "org.scalactic:scalactic_2.12:3.0.4", "lang": "java", "sha1": "e75f0f9c77aa391e01797cfc42fb82fd7c7d59a5", "repository": "http://central.maven.org/maven2/", "name": "org_scalactic_scalactic_2_12", "actual": "@org_scalactic_scalactic_2_12//jar", "bind": "jar/org/scalactic/scalactic_2_12"})
    callback({"artifact": "org.scalatest:scalatest_2.12:3.0.4", "lang": "scala", "sha1": "87d68f3d06dbf698fd0084c0a8b8996864d15465", "repository": "http://central.maven.org/maven2/", "name": "org_scalatest_scalatest_2_12", "actual": "@org_scalatest_scalatest_2_12//jar:file", "bind": "jar/org/scalatest/scalatest_2_12"})
