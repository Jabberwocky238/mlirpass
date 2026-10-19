module {
  func.func @too_few_iters(%arg0: index, %arg1: index, %arg2: index) {
    scf.parallel (%arg3) = (%arg0) to (%arg1) step (%arg2) {
      scf.reduce 
    }
    return
  }
  func.func @too_many_iters(%arg0: index, %arg1: index, %arg2: index) {
    scf.parallel (%arg3, %arg4, %arg5) = (%arg0, %arg0, %arg0) to (%arg1, %arg1, %arg1) step (%arg2, %arg2, %arg2) {
      scf.reduce 
    }
    return
  }
}

