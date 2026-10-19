module {
  module {
    llvm.func @branch_without_arguments() {
      llvm.br ^bb1
    ^bb1:  // pred: ^bb0
      llvm.return
    }
    llvm.func @branch_with_arguments() {
      %0 = llvm.mlir.constant(0 : i32) : i32
      %1 = llvm.mlir.constant(true) : i1
      llvm.br ^bb1(%0, %1 : i32, i1)
    ^bb1(%2: i32, %3: i1):  // pred: ^bb0
      llvm.return
    }
  }
}

// -----
module {
  module {
    llvm.func @cond_branch_without_arguments() {
      %0 = llvm.mlir.constant(true) : i1
      llvm.cond_br %0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      llvm.return
    ^bb2:  // pred: ^bb0
      llvm.return
    }
    llvm.func @cond_branch_with_arguments_nested() {
      %0 = llvm.mlir.constant(true) : i1
      %1 = llvm.mlir.constant(0 : i32) : i32
      %2 = llvm.mlir.constant(false) : i1
      llvm.cond_br %0, ^bb1(%1, %2 : i32, i1), ^bb2
    ^bb1(%3: i32, %4: i1):  // pred: ^bb0
      llvm.cond_br %4, ^bb3, ^bb4(%3, %3 : i32, i32)
    ^bb2:  // pred: ^bb0
      llvm.return
    ^bb3:  // pred: ^bb1
      llvm.return
    ^bb4(%5: i32, %6: i32):  // pred: ^bb1
      llvm.return
    }
    llvm.func @cond_branch_with_weights(%arg0: i1) {
      llvm.cond_br %arg0 weights([1, 2]), ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      llvm.return
    ^bb2:  // pred: ^bb0
      llvm.return
    }
  }
}

// -----
module {
  module {
    llvm.func @empty_loop() {
      llvm.return
    }
    llvm.func @infinite_loop(%arg0: i32) {
      llvm.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %0 = llvm.mlir.constant(true) : i1
      llvm.cond_br %0, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      llvm.br ^bb1
    ^bb4:  // pred: ^bb1
      llvm.br ^bb5
    ^bb5:  // pred: ^bb4
      llvm.return
    }
  }
}

// -----
module {
  module {
    llvm.func @selection_empty() {
      llvm.return
    }
    llvm.func @selection_with_merge_block_only() {
      %0 = llvm.mlir.constant(true) : i1
      llvm.return
    }
    llvm.func @selection_with_true_block_only() {
      %0 = llvm.mlir.constant(true) : i1
      llvm.cond_br %0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      llvm.br ^bb2
    ^bb2:  // 2 preds: ^bb0, ^bb1
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      llvm.return
    }
    llvm.func @selection_with_both_true_and_false_block() {
      %0 = llvm.mlir.constant(true) : i1
      llvm.cond_br %0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      llvm.br ^bb3
    ^bb2:  // pred: ^bb0
      llvm.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llvm.br ^bb4
    ^bb4:  // pred: ^bb3
      llvm.return
    }
    llvm.func @selection_with_early_return(%arg0: i1) -> i32 {
      %0 = llvm.mlir.constant(0 : i32) : i32
      llvm.cond_br %arg0, ^bb1(%0 : i32), ^bb2
    ^bb1(%1: i32):  // pred: ^bb0
      llvm.return %1 : i32
    ^bb2:  // pred: ^bb0
      llvm.br ^bb3
    ^bb3:  // pred: ^bb2
      %2 = llvm.mlir.constant(1 : i32) : i32
      llvm.return %2 : i32
    }
  }
}

