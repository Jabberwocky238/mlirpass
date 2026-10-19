module {
  func.func @collapse_to_single() {
    %c6 = arith.constant 6 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c18 = arith.constant 18 : index
    scf.parallel (%arg0) = (%c0) to (%c18) step (%c1) {
      %0 = arith.remsi %arg0, %c6 : index
      %1 = arith.divsi %arg0, %c6 : index
      %2 = affine.apply affine_map<(d0) -> (d0 * 4 + 7)>(%0)
      %3 = affine.apply affine_map<(d0) -> (d0 * 3 + 3)>(%1)
      %4 = "magic.op"(%3, %2) : (index, index) -> index
      scf.reduce 
    }
    return
  }
}
