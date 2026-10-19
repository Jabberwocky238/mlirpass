module {
  module attributes {gpu.container_module} {
    llvm.func @foo(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg5, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg6, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg7, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg8, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg9, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %7 = llvm.insertvalue %arg0, %6[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %8 = llvm.insertvalue %arg1, %7[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.insertvalue %arg2, %8[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.insertvalue %arg3, %9[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.insertvalue %arg4, %10[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %12 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
      %13 = llvm.mlir.constant(7 : index) : i64
      %14 = llvm.mlir.zero : !llvm.ptr
      %15 = llvm.getelementptr %14[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      %16 = llvm.ptrtoint %15 : !llvm.ptr to i64
      %17 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %18 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %19 = llvm.addrspacecast %18 : !llvm.ptr<1> to !llvm.ptr
      llvm.call @mgpuMemcpy(%19, %17, %16, %12) : (!llvm.ptr, !llvm.ptr, i64, !llvm.ptr) -> ()
      llvm.call @mgpuStreamSynchronize(%12) : (!llvm.ptr) -> ()
      llvm.call @mgpuStreamDestroy(%12) : (!llvm.ptr) -> ()
      llvm.return
    }
    llvm.func @mgpuStreamCreate() -> !llvm.ptr
    llvm.func @mgpuMemcpy(!llvm.ptr, !llvm.ptr, i64, !llvm.ptr)
    llvm.func @mgpuStreamSynchronize(!llvm.ptr)
    llvm.func @mgpuStreamDestroy(!llvm.ptr)
  }
  module attributes {gpu.container_module} {
    llvm.func @dynamic(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %1 = llvm.insertvalue %arg7, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %2 = llvm.insertvalue %arg8, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %3 = llvm.insertvalue %arg9, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %4 = llvm.insertvalue %arg10, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %5 = llvm.insertvalue %arg12, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %6 = llvm.insertvalue %arg11, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.insertvalue %arg13, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %9 = llvm.insertvalue %arg0, %8[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.insertvalue %arg1, %9[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %arg2, %10[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %arg3, %11[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %arg5, %12[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %arg4, %13[3, 1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.insertvalue %arg6, %14[4, 1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
      %17 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = llvm.extractvalue %7[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %19 = llvm.mul %17, %18 : i64
      %20 = llvm.mlir.zero : !llvm.ptr
      %21 = llvm.getelementptr %20[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      %22 = llvm.ptrtoint %21 : !llvm.ptr to i64
      %23 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %24 = llvm.extractvalue %15[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
      %25 = llvm.addrspacecast %24 : !llvm.ptr<1> to !llvm.ptr
      llvm.call @mgpuMemcpy(%25, %23, %22, %16) : (!llvm.ptr, !llvm.ptr, i64, !llvm.ptr) -> ()
      llvm.return
    }
    llvm.func @mgpuStreamCreate() -> !llvm.ptr
    llvm.func @mgpuMemcpy(!llvm.ptr, !llvm.ptr, i64, !llvm.ptr)
  }
}

