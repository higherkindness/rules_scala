import scala.language.experimental.macros

object MacroOnly {
  def printf(format: String, params: Any*): Unit = macro Macro.printf_impl
}
