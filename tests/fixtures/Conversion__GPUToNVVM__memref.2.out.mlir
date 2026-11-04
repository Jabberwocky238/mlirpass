module {
  gpu.module @memref_conversions {
    llvm.func @kern(%arg0: !llvm.ptr) attributes {gpu.kernel, nvvm.kernel} {
      llvm.return
    }
  }
}

