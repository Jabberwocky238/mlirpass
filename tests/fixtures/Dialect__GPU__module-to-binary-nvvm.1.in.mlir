"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module1", targets = [#nvvm.target<chip = "sm_70">]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg12: i32, %arg13: !llvm.ptr, %arg14: !llvm.ptr, %arg15: i64, %arg16: i64, %arg17: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernel_module2", targets = [#nvvm.target<flags = {fast}>, #nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg6: i32, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{offloadingHandler = #gpu.select_object<1 : i64>, sym_name = "kernel_module3", targets = [#nvvm.target<chip = "sm_70">, #nvvm.target<chip = "sm_80">]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

