package higherkindness.rules_scala
package common.sbt_testing

import java.io.{PrintWriter, StringWriter}
import sbt.testing.{Event, Status, TestSelector}
import Status.{Canceled, Error, Failure, Ignored, Pending, Skipped}
import scala.collection.mutable.ListBuffer
import scala.xml.{Elem, Utility, XML}

class JUnitXmlReporter(tasksAndEvents: ListBuffer[(String, ListBuffer[Event])]) {
  private def escape(info: String): String = info match {
    case str: String => Utility.escape(str)
    case _           => ""
  }

  def result: Elem =
    XML.loadString(s"""<testsuites>
      ${(for ((name, events) <- tasksAndEvents)
      yield s"""<testsuite
        hostname=""
        name="${escape(name)}"
        tests="${events.size.toString}"
        errors="${events.count(_.status == Error).toString}"
        failures="${events.count(_.status == Failure).toString}"
        skipped="${events
        .count(e => e.status == Ignored || e.status == Skipped || e.status == Pending || e.status == Canceled)
        .toString}"
        time="${(events.map(_.duration).sum / 1000d).toString}">
          ${(for (e <- events)
        yield s"""<testcase
            classname="${escape(name)}"
            name="${e.selector match {
          case selector: TestSelector => escape(selector.testName.split('.').last)
          case _                      => "Error occurred outside of a test case."
        }}"
            time="${(e.duration / 1000d).toString}">
            ${
          val stringWriter = new StringWriter()
          if (e.throwable.isDefined) {
            val writer = new PrintWriter(stringWriter)
            e.throwable.get.printStackTrace(writer)
            writer.flush()
          }
          val trace: String = stringWriter.toString
          e.status match {
            case Status.Error if e.throwable.isDefined =>
              val t = e.throwable.get
              s"""<error message="${escape(t.getMessage)}" type="${escape(t.getClass.getName)}">${escape(trace)}</error>"""
            case Status.Error =>
              s"""<error message="No Exception or message provided"/>"""
            case Status.Failure if e.throwable.isDefined =>
              val t = e.throwable.get
              s"""<failure message="${escape(t.getMessage)}" type="${escape(t.getClass.getName)}">${escape(trace)}</failure>"""
            case Status.Failure =>
              s"""<failure message="No Exception or message provided"/>"""
            case Status.Canceled if e.throwable.isDefined =>
              val t = e.throwable.get
              s"""<skipped message="${escape(t.getMessage)}" type="${escape(t.getClass.getName)}">${escape(trace)}</skipped>"""
            case Status.Canceled =>
              s"""<skipped message="No Exception or message provided"/>"""
            case Status.Ignored | Status.Skipped | Status.Pending =>
              "<skipped/>"
            case _ =>
          }
        }
          </testcase>""").mkString("")}
        <system-out><![CDATA[]]></system-out>
        <system-err><![CDATA[]]></system-err>
      </testsuite>""").mkString("")}
    </testsuites>""")

  def write = {
    Option(System.getenv.get("XML_OUTPUT_FILE"))
      .foreach { filespec =>
        XML.save(filespec, result, "UTF-8", true, null)
      }
  }
}
