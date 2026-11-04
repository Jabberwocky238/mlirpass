module {
  gpu.module @memref_conversions {
    llvm.func @kern(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
}

