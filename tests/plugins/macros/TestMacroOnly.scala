object TestMacroOnly extends App {
  Macro.printf("hello %s!\n", "world")
  MacroOnly.printf("world %s!\n", "hello")
}
