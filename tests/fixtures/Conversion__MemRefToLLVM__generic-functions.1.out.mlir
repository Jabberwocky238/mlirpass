module {
  llvm.func @_mlir_memref_to_llvm_aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @zero_d_alloc() -> memref<f32> {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.mlir.constant(16 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.sub %4, %5 : i64
    %7 = llvm.add %3, %6 : i64
    %8 = llvm.urem %7, %4 : i64
    %9 = llvm.sub %7, %8 : i64
    %10 = llvm.call @_mlir_memref_to_llvm_aligned_alloc(%4, %9) : (i64, i64) -> !llvm.ptr
    %11 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(ptr, ptr, i64)> 
    %13 = llvm.insertvalue %10, %12[1] : !llvm.struct<(ptr, ptr, i64)> 
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.insertvalue %14, %13[2] : !llvm.struct<(ptr, ptr, i64)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i64)> to memref<f32>
    return %16 : memref<f32>
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

