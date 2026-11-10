"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<4>, ptr<4>, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "constant_load", visibility_ = 0 : i64}> ({
    ^bb0(%arg7: !llvm.ptr<4>, %arg8: !llvm.ptr<4>, %arg9: i64, %arg10: i64, %arg11: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<4>, ptr<4>, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "constant_multidim", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<4>, %arg1: !llvm.ptr<4>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

