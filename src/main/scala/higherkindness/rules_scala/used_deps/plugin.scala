package higherkindness.rules_scala
package used_deps

import scala.reflect.io.AbstractFile
import scala.reflect.io.NoAbstractFile
import scala.reflect.internal.SymbolTable
import scala.tools.nsc.Global
import scala.tools.nsc.Phase
import scala.tools.nsc.plugins.Plugin
import scala.tools.nsc.plugins.PluginComponent
import scala.util.matching.Regex

import java.io.File

final class UsedDepsPlugin(override val global: Global) extends Plugin {

  override val name: String = "used-deps"
  override val description: String = "tracks used dependencies"
  override val components: List[PluginComponent] = usedDeps :: Nil

  private object usedDeps extends PluginComponent {
    override val global: Global = UsedDepsPlugin.this.global
    override val phaseName: String = "unused-deps"
    override val runsAfter: List[String] = global.refChecks.phaseName :: Nil

    private[used_deps] var outputFile: Option[File] = None

    override def newPhase(prev: Phase): Phase =
      new StdPhase(prev) with UsedDepsPhase[global.type] {
        val global = usedDeps.this.global
      }
  }

  override val optionsHelp: Option[String] = Some(
    "  -P:unused-deps:out=<path> Path to write output file (default: stdout)"
  )

  private implicit final class RegexInterpolator(sc: StringContext) {
    def r = new Regex(sc.parts.mkString, sc.parts.tail.map(_ => "x"): _*)
  }

  override def init(options: List[String], error: String => Unit): Boolean = {
    options.foreach {
      case r"out=(.*)$out" =>
        usedDeps.outputFile = Some(new File(out))
      case arg =>
        error(s"Unexpected argument: $arg")
    }
    true
  }

  {
    hijackField(classOf[SymbolTable], "traceSymbolActivity", true)
  }

  if (global.traceSymbolActivity != true)
    sys.error("unable to force tracing of symbol activity")

  private[this] def hijackField[T](clazz: Class[_], name: String, newValue: T): T = {
    val field = clazz.getDeclaredField(name)
    field.setAccessible(true)
    val oldValue = field.get(global).asInstanceOf[T]
    field.set(global, newValue)
    oldValue
  }

}


trait UsedDepsPhase[G <: Global] {
  val global: G
  import global._

  def apply(unit: CompilationUnit): Unit = {
    val map = traceSymbols.allSymbols.values
      .filter(_.associatedFile != NoAbstractFile)
      .filter(_.associatedFile.file != null)
      .foldLeft(Map.empty[File, List[Symbol]]) { (acc, sym) =>
        val k = sym.associatedFile.file
        acc.get(k) match {
          case Some(vv) => acc + ((k, sym :: vv))
          case None => acc + ((k, sym :: Nil))
        }
      }

    map.foreach { case (k, v) =>
      println(k)
      v.foreach(sym => println(" " + sym))
    }

    ()
  }

}
