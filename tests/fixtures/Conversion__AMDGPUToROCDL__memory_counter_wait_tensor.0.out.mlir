module {
  func.func @memory_counter_wait_tensor() {
    rocdl.s.wait.tensorcnt 3
    return
  }
}

