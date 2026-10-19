module {
  llvm.func @warp_extract(%arg0: i64, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: vector<1xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : i64 to index
    %1 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = llvm.insertvalue %arg1, %1[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg6, %5[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg5, %6[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.insertvalue %arg7, %7[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.constant(0 : index) : i64
    gpu.warp_execute_on_lane_0(%0)[32] {
      %10 = llvm.extractvalue %8[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.mlir.constant(1024 : index) : i64
      %12 = llvm.mul %9, %11 : i64
      %13 = llvm.add %12, %9 : i64
      %14 = llvm.getelementptr %10[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      llvm.store %arg8, %14 {alignment = 4 : i64} : vector<1xf32>, !llvm.ptr
    }
    llvm.return
  }
}

