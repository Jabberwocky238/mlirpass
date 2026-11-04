module {
  func.func @memory_counter_wait() {
    rocdl.s.waitcnt 53119
    rocdl.s.waitcnt 3952
    rocdl.s.waitcnt 3952
    rocdl.s.waitcnt 53007
    rocdl.s.waitcnt 49279
    return
  }
}

