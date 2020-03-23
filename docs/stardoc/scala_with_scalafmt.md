<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#scala_binary"></a>

## scala_binary

<pre>
scala_binary(<a href="#scala_binary-name">name</a>, <a href="#scala_binary-config">config</a>, <a href="#scala_binary-data">data</a>, <a href="#scala_binary-deps">deps</a>, <a href="#scala_binary-deps_unused_whitelist">deps_unused_whitelist</a>, <a href="#scala_binary-deps_used_whitelist">deps_used_whitelist</a>, <a href="#scala_binary-format">format</a>, <a href="#scala_binary-javacopts">javacopts</a>, <a href="#scala_binary-jvm_flags">jvm_flags</a>, <a href="#scala_binary-main_class">main_class</a>, <a href="#scala_binary-plugins">plugins</a>, <a href="#scala_binary-resource_jars">resource_jars</a>, <a href="#scala_binary-resource_strip_prefix">resource_strip_prefix</a>, <a href="#scala_binary-resources">resources</a>, <a href="#scala_binary-runtime_deps">runtime_deps</a>, <a href="#scala_binary-scala">scala</a>, <a href="#scala_binary-scalacopts">scalacopts</a>, <a href="#scala_binary-srcs">srcs</a>)
</pre>


Compiles and links a Scala JVM executable.

Produces the following implicit outputs:

  - `<name>_deploy.jar`: a single jar that contains all the necessary information to run the program
  - `<name>.jar`: a jar file that contains the class files produced from the sources
  - `<name>-bin`: the script that's used to run the program in conjunction with the generated runfiles

To run the program: `bazel run <target>`


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="scala_binary-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-config">
      <td><code>config</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The Scalafmt configuration file.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-data">
      <td><code>data</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-deps">
      <td><code>deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-deps_unused_whitelist">
      <td><code>deps_unused_whitelist</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies to always consider unused for `scala_deps_direct` checks.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-format">
      <td><code>format</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="scala_binary-javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
        <p>
          The JVM runtime flags.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-main_class">
      <td><code>main_class</code></td>
      <td>
        String; optional
        <p>
          The main class. If not provided, it will be inferred by its type signature.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-plugins">
      <td><code>plugins</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-resources">
      <td><code>resources</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-scala">
      <td><code>scala</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The `ScalaConfiguration`. Among other things, this specifies which scala version to use.
 Defaults to the default_scala target specified in the WORKSPACE file.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
    <tr id="scala_binary-srcs">
      <td><code>srcs</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_library"></a>

## scala_library

<pre>
scala_library(<a href="#scala_library-name">name</a>, <a href="#scala_library-config">config</a>, <a href="#scala_library-data">data</a>, <a href="#scala_library-deps">deps</a>, <a href="#scala_library-deps_unused_whitelist">deps_unused_whitelist</a>, <a href="#scala_library-deps_used_whitelist">deps_used_whitelist</a>, <a href="#scala_library-exports">exports</a>, <a href="#scala_library-format">format</a>, <a href="#scala_library-javacopts">javacopts</a>, <a href="#scala_library-macro">macro</a>, <a href="#scala_library-neverlink">neverlink</a>, <a href="#scala_library-plugins">plugins</a>, <a href="#scala_library-resource_jars">resource_jars</a>, <a href="#scala_library-resource_strip_prefix">resource_strip_prefix</a>, <a href="#scala_library-resources">resources</a>, <a href="#scala_library-runtime_deps">runtime_deps</a>, <a href="#scala_library-scala">scala</a>, <a href="#scala_library-scalacopts">scalacopts</a>, <a href="#scala_library-srcs">srcs</a>)
</pre>

Compiles a Scala JVM library.

### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="scala_library-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="scala_library-config">
      <td><code>config</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The Scalafmt configuration file.
        </p>
      </td>
    </tr>
    <tr id="scala_library-data">
      <td><code>data</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="scala_library-deps">
      <td><code>deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="scala_library-deps_unused_whitelist">
      <td><code>deps_unused_whitelist</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies to always consider unused for `scala_deps_direct` checks.
        </p>
      </td>
    </tr>
    <tr id="scala_library-deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="scala_library-exports">
      <td><code>exports</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM libraries to add as dependencies to any libraries dependent on this one.
        </p>
      </td>
    </tr>
    <tr id="scala_library-format">
      <td><code>format</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="scala_library-javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="scala_library-macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="scala_library-neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library should be excluded at runtime.
        </p>
      </td>
    </tr>
    <tr id="scala_library-plugins">
      <td><code>plugins</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="scala_library-resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="scala_library-resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="scala_library-resources">
      <td><code>resources</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="scala_library-runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="scala_library-scala">
      <td><code>scala</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The `ScalaConfiguration`. Among other things, this specifies which scala version to use.
 Defaults to the default_scala target specified in the WORKSPACE file.
        </p>
      </td>
    </tr>
    <tr id="scala_library-scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
    <tr id="scala_library-srcs">
      <td><code>srcs</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_test"></a>

## scala_test

<pre>
scala_test(<a href="#scala_test-name">name</a>, <a href="#scala_test-config">config</a>, <a href="#scala_test-data">data</a>, <a href="#scala_test-deps">deps</a>, <a href="#scala_test-deps_unused_whitelist">deps_unused_whitelist</a>, <a href="#scala_test-deps_used_whitelist">deps_used_whitelist</a>, <a href="#scala_test-format">format</a>, <a href="#scala_test-frameworks">frameworks</a>, <a href="#scala_test-isolation">isolation</a>, <a href="#scala_test-javacopts">javacopts</a>, <a href="#scala_test-jvm_flags">jvm_flags</a>, <a href="#scala_test-plugins">plugins</a>, <a href="#scala_test-resource_jars">resource_jars</a>, <a href="#scala_test-resource_strip_prefix">resource_strip_prefix</a>, <a href="#scala_test-resources">resources</a>, <a href="#scala_test-runner">runner</a>, <a href="#scala_test-runtime_deps">runtime_deps</a>, <a href="#scala_test-scala">scala</a>, <a href="#scala_test-scalacopts">scalacopts</a>, <a href="#scala_test-shared_deps">shared_deps</a>, <a href="#scala_test-srcs">srcs</a>, <a href="#scala_test-subprocess_runner">subprocess_runner</a>)
</pre>


Compiles and links a collection of Scala tests.

To buid and run all tests: `bazel test <target>`

To build and run a specific test: `bazel test <target> --test_filter=<filter_expression>`
<br>(Note: the syntax of the `<filter_expression>` varies by test framework, and not all test frameworks support the `test_filter` option at this time.)

[More Info](/docs/scala.md#tests)


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="scala_test-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="scala_test-config">
      <td><code>config</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The Scalafmt configuration file.
        </p>
      </td>
    </tr>
    <tr id="scala_test-data">
      <td><code>data</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="scala_test-deps">
      <td><code>deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="scala_test-deps_unused_whitelist">
      <td><code>deps_unused_whitelist</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies to always consider unused for `scala_deps_direct` checks.
        </p>
      </td>
    </tr>
    <tr id="scala_test-deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="scala_test-format">
      <td><code>format</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="scala_test-frameworks">
      <td><code>frameworks</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="scala_test-isolation">
      <td><code>isolation</code></td>
      <td>
        String; optional
        <p>
          The isolation level to apply
        </p>
      </td>
    </tr>
    <tr id="scala_test-javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="scala_test-jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
        <p>
          The JVM runtime flags.
        </p>
      </td>
    </tr>
    <tr id="scala_test-plugins">
      <td><code>plugins</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="scala_test-resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="scala_test-resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="scala_test-resources">
      <td><code>resources</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="scala_test-runner">
      <td><code>runner</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
      </td>
    </tr>
    <tr id="scala_test-runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="scala_test-scala">
      <td><code>scala</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The `ScalaConfiguration`. Among other things, this specifies which scala version to use.
 Defaults to the default_scala target specified in the WORKSPACE file.
        </p>
      </td>
    </tr>
    <tr id="scala_test-scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="scala_test-shared_deps">
      <td><code>shared_deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          If isolation is "classloader", the list of deps to keep loaded between tests
        </p>
      </td>
    </tr>
    <tr id="scala_test-srcs">
      <td><code>srcs</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
    <tr id="scala_test-subprocess_runner">
      <td><code>subprocess_runner</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
      </td>
    </tr>
  </tbody>
</table>


