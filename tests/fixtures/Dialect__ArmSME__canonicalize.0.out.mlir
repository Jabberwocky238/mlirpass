module {
  func.func @unused_ssa_tile_is_removed_from_blocks(%arg0: memref<?x?xi32>) {
    %c10 = arith.constant 10 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c10 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %2 = arith.addi %0, %c1 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    return
  }
}

