module {
  llvm.func @foo(i64)
  llvm.func @rand() -> i1
  llvm.func @large_merge_block(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %5, ^bb1(%1, %3, %4, %2 : i64, i64, i64, i64), ^bb1(%4, %2, %1, %3 : i64, i64, i64, i64)
  ^bb1(%6: i64, %7: i64, %8: i64, %9: i64):  // 2 preds: ^bb0, ^bb0
    %10 = llvm.call @rand() : () -> i1
    llvm.cond_br %10, ^bb2(%6 : i64), ^bb2(%9 : i64)
  ^bb2(%11: i64):  // 2 preds: ^bb1, ^bb1
    llvm.call @foo(%11) : (i64) -> ()
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %12 = llvm.call @rand() : () -> i1
    llvm.cond_br %12, ^bb4(%7 : i64), ^bb4(%8 : i64)
  ^bb4(%13: i64):  // 2 preds: ^bb3, ^bb3
    llvm.call @foo(%13) : (i64) -> ()
    llvm.br ^bb5
  ^bb5:  // pred: ^bb4
    llvm.br ^bb6
  ^bb6:  // pred: ^bb5
    llvm.return
  }
  llvm.func @redundant_args0(%arg0: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    llvm.cond_br %arg0, ^bb1(%0, %0 : i64, i64), ^bb1(%1, %2 : i64, i64)
  ^bb1(%3: i64, %4: i64):  // 2 preds: ^bb0, ^bb0
    llvm.call @foo(%3) : (i64) -> ()
    llvm.call @foo(%4) : (i64) -> ()
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @redundant_args1(%arg0: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    llvm.cond_br %arg0, ^bb1(%1, %2 : i64, i64), ^bb1(%0, %0 : i64, i64)
  ^bb1(%3: i64, %4: i64):  // 2 preds: ^bb0, ^bb0
    llvm.call @foo(%3) : (i64) -> ()
    llvm.call @foo(%4) : (i64) -> ()
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @redundant_args_complex(%arg0: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    llvm.cond_br %arg0, ^bb1(%2, %1, %3 : i64, i64, i64), ^bb1(%0, %3, %2 : i64, i64, i64)
  ^bb1(%4: i64, %5: i64, %6: i64):  // 2 preds: ^bb0, ^bb0
    llvm.call @foo(%4) : (i64) -> ()
    llvm.call @foo(%4) : (i64) -> ()
    llvm.call @foo(%5) : (i64) -> ()
    llvm.call @foo(%2) : (i64) -> ()
    llvm.call @foo(%6) : (i64) -> ()
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @blocks_with_args() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @rand() : () -> i1
    llvm.cond_br %3, ^bb1(%0 : i64), ^bb1(%1 : i64)
  ^bb1(%4: i64):  // 2 preds: ^bb0, ^bb0
    llvm.store %2, %2 : !llvm.ptr, !llvm.ptr
    llvm.cond_br %3, ^bb2, ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb1
    llvm.call @foo(%4) : (i64) -> ()
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return
  }
}

