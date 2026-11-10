module attributes {gpu.container_module} {
  gpu.module @kernel_module {
    llvm.func @constant_load(%arg0: !llvm.ptr<4>, %arg1: !llvm.ptr<4>, %arg2: i64, %arg3: i64, %arg4: i64) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
    llvm.func @constant_multidim(%arg0: !llvm.ptr<4>, %arg1: !llvm.ptr<4>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
}

