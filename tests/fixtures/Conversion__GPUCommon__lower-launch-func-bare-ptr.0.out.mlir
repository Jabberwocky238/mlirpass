module attributes {gpu.container_module} {
  gpu.module @kernels [#nvvm.target] {
    llvm.func @kernel_1(%arg0: f32, %arg1: !llvm.ptr<1>) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
  llvm.func @foo() {
    %0 = llvm.mlir.constant(8 : index) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(10 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i8) : i8
    %9 = llvm.call @mgpuMemAlloc(%6, %7, %8) : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %10 = llvm.addrspacecast %9 : !llvm.ptr to !llvm.ptr<1>
    %11 = llvm.mlir.poison : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %10, %12[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.insertvalue %14, %13[2] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %2, %15[3, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %3, %16[4, 0] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.extractvalue %17[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    gpu.launch_func  @kernels::@kernel_1 blocks in (%0, %0, %0) threads in (%0, %0, %0) : i64 args(%1 : f32, %18 : !llvm.ptr<1>)
    llvm.return
  }
  llvm.func @mgpuMemAlloc(i64, !llvm.ptr, i8) -> !llvm.ptr
}

