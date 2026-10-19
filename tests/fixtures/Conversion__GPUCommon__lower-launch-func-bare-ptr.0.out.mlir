module attributes {gpu.container_module} {
  gpu.module @kernels [#nvvm.target] {
    llvm.func @kernel_1(%arg0: f32, %arg1: !llvm.ptr<1>) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
  llvm.func @foo() {
    %0 = llvm.mlir.constant(8 : index) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %memref = gpu.alloc  () : memref<10xf32, 1>
    %2 = builtin.unrealized_conversion_cast %memref : memref<10xf32, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    gpu.launch_func  @kernels::@kernel_1 blocks in (%0, %0, %0) threads in (%0, %0, %0) : i64 args(%1 : f32, %3 : !llvm.ptr<1>)
    llvm.return
  }
}

