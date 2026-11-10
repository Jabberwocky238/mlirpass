module attributes {gpu.container_module} {
  llvm.func @yield_launch_token(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(1 : index) : i64
    %token, %bodyResults = async.execute -> !async.value<!llvm.ptr> {
      %7 = llvm.call @mgpuStreamCreate() : () -> !llvm.ptr
      %8 = llvm.extractvalue %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %9 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %10 = llvm.extractvalue %5[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %11 = llvm.extractvalue %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      %12 = llvm.extractvalue %5[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
      gpu.launch_func <%7 : !llvm.ptr> @kmod::@kernel blocks in (%6, %6, %6) threads in (%6, %6, %6) : i64 args(%8 : !llvm.ptr, %9 : !llvm.ptr, %10 : i64, %11 : i64, %12 : i64)
      %13 = llvm.call @mgpuEventCreate() : () -> !llvm.ptr
      llvm.call @mgpuEventRecord(%13, %7) : (!llvm.ptr, !llvm.ptr) -> ()
      llvm.call @mgpuStreamDestroy(%7) : (!llvm.ptr) -> ()
      async.yield %13 : !llvm.ptr
    }
    llvm.return
  }
  gpu.module @kmod [#nvvm.target] {
    llvm.func @kernel(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
  llvm.func @mgpuStreamCreate() -> !llvm.ptr
  llvm.func @mgpuEventCreate() -> !llvm.ptr
  llvm.func @mgpuEventRecord(!llvm.ptr, !llvm.ptr)
  llvm.func @mgpuStreamDestroy(!llvm.ptr)
}

