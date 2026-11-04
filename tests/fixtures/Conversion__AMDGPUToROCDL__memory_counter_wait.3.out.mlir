module {
  func.func @memory_counter_wait() {
    rocdl.s.wait.loadcnt 0
    rocdl.s.wait.storecnt 0
    rocdl.s.wait.expcnt 0
    rocdl.s.wait.dscnt 0
    return
  }
}

