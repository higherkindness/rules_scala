package anx

import scala.annotation.tailrec

import scala.tools.nsc.{Global ⇒ NscGlobal}
import scala.tools.nsc.plugins.{Plugin => NscPlugin, PluginComponent => NscPluginComponent}
import scala.reflect.internal.Mode

import scala.reflect.io.NoAbstractFile
import scala.tools.nsc.io.AbstractFile

import java.io.File

final class MacroSpoorPlugin(val global: NscGlobal) extends NscPlugin {
  import global._
  import analyzer.{MacroPlugin => NscMacroPlugin, _}

  override val name: String = "anx-macro-spoor"
  override val description: String = "tracks which dependencies are needed to expand macros"
  override val components: List[NscPluginComponent] = Nil

  analyzer.addMacroPlugin(MacroPlugin)

  private[this] object MacroPlugin extends NscMacroPlugin {
    override def pluginsMacroRuntime(expandee: Tree): Option[MacroRuntime] = {
      val macroDef = expandee.symbol
      if (!fastTrack.contains(macroDef)) {
        val file = classFile(macroDef.owner)
        println("macro used file: " + file)
      }
      None
    }
  }

  // copied from xsbt.LocateClassFile.classFile
  @tailrec private[this] def classFile(sym: Symbol): Option[AbstractFile] = {
    if (sym hasFlag scala.tools.nsc.symtab.Flags.PACKAGE) None
    else {
      val file = sym.associatedFile
      if (file == NoAbstractFile) {
        if (isTopLevelModule(sym)) {
          val linked = sym.companionClass
          if (linked == NoSymbol) None
          else classFile(linked)
        } else None
      } else Some(file)
    }
  }

  // copied from xsbt.ClassName.flatName
  private[this] def flatname(s: Symbol, separator: Char) =
    enteringPhase(currentRun.flattenPhase.next) { s fullName separator }

  // copied from xsbt.ClassName.isTopLevelModule
  private[this] def isTopLevelModule(sym: Symbol): Boolean =
    enteringPhase(currentRun.picklerPhase.next) {
      sym.isModuleClass && !sym.isImplClass && !sym.isNestedClass
    }
}
