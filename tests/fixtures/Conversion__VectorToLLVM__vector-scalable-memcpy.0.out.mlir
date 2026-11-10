module {
  func.func @vector_scalable_memcopy(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = arith.muli %3, %c4 : index
    scf.for %arg3 = %c0 to %arg2 step %4 {
      %5 = builtin.unrealized_conversion_cast %arg3 : index to i64
      %6 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %7 = llvm.getelementptr %6[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<[4]xf32>
      %9 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.getelementptr %9[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      llvm.store %8, %10 {alignment = 4 : i64} : vector<[4]xf32>, !llvm.ptr
    }
    return
  }
}

