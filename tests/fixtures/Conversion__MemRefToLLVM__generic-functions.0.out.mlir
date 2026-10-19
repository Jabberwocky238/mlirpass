module {
  llvm.func @_mlir_memref_to_llvm_alloc(i64) -> !llvm.ptr
  func.func @zero_d_alloc() -> memref<f32> {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.call @_mlir_memref_to_llvm_alloc(%3) : (i64) -> !llvm.ptr
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<(ptr, ptr, i64)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr, ptr, i64)> 
    %10 = builtin.unrealized_conversion_cast %9 : !llvm.struct<(ptr, ptr, i64)> to memref<f32>
    return %10 : memref<f32>
  }
}

// -----
module {
  llvm.func @_mlir_memref_to_llvm_free(!llvm.ptr)
  func.func @dealloc(%arg0: memref<f32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32> to !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.call @_mlir_memref_to_llvm_free(%1) : (!llvm.ptr) -> ()
    return
  }
}

