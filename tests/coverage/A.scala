object A {
  def methodA(flag: Boolean): B.type =
    if (flag) B
    else sys.error("oh noes")
}
