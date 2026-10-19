module attributes {gpu.container_module} {
  gpu.module @kernel_module [#nvvm.target] {
    llvm.func @kernel(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64) attributes {gpu.kernel} {
      llvm.return
    }
  }
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(8 : index) : i64
    %7 = llvm.mlir.constant(32 : i32) : i32
    %8 = llvm.mlir.constant(256 : i32) : i32
    %9 = llvm.extractvalue %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.extractvalue %5[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.extractvalue %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.extractvalue %5[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    gpu.launch_func  @kernel_module::@kernel blocks in (%6, %6, %6) threads in (%6, %6, %6) : i64 dynamic_shared_memory_size %8 args(%7 : i32, %9 : !llvm.ptr, %10 : !llvm.ptr, %11 : i64, %12 : i64, %13 : i64)
    llvm.return
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @kernel_module [#nvvm.target] {
    llvm.func @kernel(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64) attributes {gpu.kernel} {
      llvm.return
    }
  }
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(8 : index) : i64
    %7 = llvm.mlir.constant(32 : i32) : i32
    %8 = llvm.mlir.constant(256 : i32) : i32
    %9 = llvm.mlir.constant(2 : index) : i64
    %10 = llvm.extractvalue %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.extractvalue %5[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.extractvalue %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.extractvalue %5[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    gpu.launch_func  @kernel_module::@kernel clusters in (%9, %9, %9) blocks in (%6, %6, %6) threads in (%6, %6, %6) : i64 dynamic_shared_memory_size %8 args(%7 : i32, %10 : !llvm.ptr, %11 : !llvm.ptr, %12 : i64, %13 : i64, %14 : i64)
    llvm.return
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.binary @kernel_module  [#gpu.object<#rocdl.target, "blob">]
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(8 : index) : i64
    %7 = llvm.mlir.constant(32 : i32) : i32
    %8 = llvm.mlir.constant(256 : i32) : i32
    %9 = llvm.mlir.constant(2 : index) : i64
    %10 = llvm.extractvalue %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.extractvalue %5[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.extractvalue %5[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.extractvalue %5[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    gpu.launch_func  @kernel_module::@kernel clusters in (%9, %9, %9) blocks in (%6, %6, %6) threads in (%6, %6, %6) : i64 dynamic_shared_memory_size %8 args(%7 : i32, %10 : !llvm.ptr, %11 : !llvm.ptr, %12 : i64, %13 : i64, %14 : i64)
    llvm.return
  }
}

