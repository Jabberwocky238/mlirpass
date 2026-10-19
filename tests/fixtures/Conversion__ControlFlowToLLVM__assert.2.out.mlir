module {
  llvm.func @abort()
  llvm.func @puts(!llvm.ptr)
  llvm.mlir.global private constant @assert_msg(dense<[97, 115, 115, 101, 114, 116, 105, 111, 110, 32, 102, 111, 111, 0]> : tensor<14xi8>) {addr_space = 0 : i32} : !llvm.array<14 x i8>
  func.func @main() {
    %false = arith.constant false
    llvm.cond_br %false, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return
  ^bb2:  // pred: ^bb0
    %0 = llvm.mlir.addressof @assert_msg : !llvm.ptr
    %1 = llvm.getelementptr %0[0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<14 x i8>
    llvm.call @puts(%1) : (!llvm.ptr) -> ()
    llvm.call @abort() : () -> ()
    llvm.unreachable
  }
}

