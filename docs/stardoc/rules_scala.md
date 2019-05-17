<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#emulate_rules_scala_repository"></a>

## emulate_rules_scala_repository

<pre>
emulate_rules_scala_repository(<a href="#emulate_rules_scala_repository-name">name</a>, <a href="#emulate_rules_scala_repository-extra_deps">extra_deps</a>)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="emulate_rules_scala_repository-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this repository.
        </p>
      </td>
    </tr>
    <tr id="emulate_rules_scala_repository-extra_deps">
      <td><code>extra_deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#emulate_rules_scala"></a>

## emulate_rules_scala

<pre>
emulate_rules_scala(<a href="#emulate_rules_scala-scala">scala</a>, <a href="#emulate_rules_scala-scalatest">scalatest</a>, <a href="#emulate_rules_scala-extra_deps">extra_deps</a>)
</pre>



### Parameters

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="emulate_rules_scala-scala">
      <td><code>scala</code></td>
      <td>
        required.
      </td>
    </tr>
    <tr id="emulate_rules_scala-scalatest">
      <td><code>scalatest</code></td>
      <td>
        required.
      </td>
    </tr>
    <tr id="emulate_rules_scala-extra_deps">
      <td><code>extra_deps</code></td>
      <td>
        optional. default is <code>[]</code>
      </td>
    </tr>
  </tbody>
</table>


