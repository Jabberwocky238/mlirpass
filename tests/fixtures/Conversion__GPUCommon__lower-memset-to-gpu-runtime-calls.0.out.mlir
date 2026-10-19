module {
  module attributes {gpu.container_module} {
    llvm.func @foo(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: f32) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
      %7 = llvm.mlir.constant(7 : index) : i64
      %8 = llvm.bitcast %arg5 : f32 to i32
      %9 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.addrspacecast %9 : !llvm.ptr<1> to !llvm.ptr
      llvm.call @mgpuMemset32(%10, %8, %7, %6) : (!llvm.ptr, i32, i64, !llvm.ptr) -> ()
      llvm.call @mgpuStreamSynchronize(%6) : (!llvm.ptr) -> ()
      llvm.call @mgpuStreamDestroy(%6) : (!llvm.ptr) -> ()
      llvm.return
    }
    llvm.func @mgpuStreamCreate() -> !llvm.ptr
    llvm.func @mgpuMemset32(!llvm.ptr, i32, i64, !llvm.ptr)
    llvm.func @mgpuStreamSynchronize(!llvm.ptr)
    llvm.func @mgpuStreamDestroy(!llvm.ptr)
  }
  module attributes {gpu.container_module} {
    llvm.func @foo16(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: f16) {
      %0 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %6 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
      %7 = llvm.mlir.constant(7 : index) : i64
      %8 = llvm.bitcast %arg5 : f16 to i16
      %9 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.addrspacecast %9 : !llvm.ptr<1> to !llvm.ptr
      llvm.call @mgpuMemset16(%10, %8, %7, %6) : (!llvm.ptr, i16, i64, !llvm.ptr) -> ()
      llvm.call @mgpuStreamSynchronize(%6) : (!llvm.ptr) -> ()
      llvm.call @mgpuStreamDestroy(%6) : (!llvm.ptr) -> ()
      llvm.return
    }
    llvm.func @mgpuStreamCreate() -> !llvm.ptr
    llvm.func @mgpuMemset16(!llvm.ptr, i16, i64, !llvm.ptr)
    llvm.func @mgpuStreamSynchronize(!llvm.ptr)
    llvm.func @mgpuStreamDestroy(!llvm.ptr)
  }
}

