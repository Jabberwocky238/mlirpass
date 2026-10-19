module {
  func.func @b0() {
    call @b0() : () -> ()
    call @b1() : () -> ()
    call @b0() : () -> ()
    call @b1() : () -> ()
    call @b0() : () -> ()
    return
  }
  func.func @b1() {
    call @b1() : () -> ()
    call @b1() : () -> ()
    return
  }
}

