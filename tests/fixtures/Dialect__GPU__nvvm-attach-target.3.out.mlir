module attributes {gpu.container_module} {
  gpu.module @kernel_module1 [#nvvm.target<flags = {"collect-compiler-diagnostics"}>] {
    llvm.func @kernel(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64) attributes {gpu.kernel} {
      llvm.return
    }
  }
}

