module {
  func.func @memory_counter_wait() {
    rocdl.s.waitcnt 65527
    rocdl.s.waitcnt 1015
    rocdl.s.waitcnt 1015
    rocdl.s.waitcnt 65520
    rocdl.s.waitcnt 64519
    return
  }
}

