module {
  func.func @memory_counter_wait() {
    rocdl.s.waitcnt 65407
    rocdl.s.waitcnt 16240
    rocdl.s.waitcnt 16240
    rocdl.s.waitcnt 65295
    rocdl.s.waitcnt 49279
    return
  }
}

