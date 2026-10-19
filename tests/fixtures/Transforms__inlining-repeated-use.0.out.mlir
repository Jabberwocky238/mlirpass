module {
  func.func @A() {
    call @fabsf() : () -> ()
    return
  }
  func.func @B() {
    call @fabsf() : () -> ()
    return
  }
  func.func @C() {
    call @fabsf() : () -> ()
    return
  }
  func.func @E() {
    call @fabsf() : () -> ()
    return
  }
  func.func private @fabsf()
}

