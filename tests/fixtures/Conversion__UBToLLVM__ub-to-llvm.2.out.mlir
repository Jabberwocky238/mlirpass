module {
  func.func @check_poison() {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.poison : f64
    %3 = llvm.mlir.poison : !llvm.ptr
    return
  }
  func.func @check_unrechable() {
    llvm.unreachable
  }
}

