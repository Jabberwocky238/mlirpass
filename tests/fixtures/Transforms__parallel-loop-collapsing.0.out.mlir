module {
  func.func @parallel_many_dims() {
    %c3 = arith.constant 3 : index
    %c6 = arith.constant 6 : index
    %c12 = arith.constant 12 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg0) = (%c0) to (%c4) step (%c1) {
      %0 = arith.remsi %arg0, %c2 : index
      %1 = arith.divsi %arg0, %c2 : index
      %2 = affine.apply affine_map<(d0) -> (d0 * 10 + 9)>(%0)
      %3 = "magic.op"(%1, %c3, %c6, %2, %c12) : (index, index, index, index, index) -> index
      scf.reduce 
    }
    return
  }
}
