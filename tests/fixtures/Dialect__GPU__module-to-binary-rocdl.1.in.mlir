"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module1", targets = [#rocdl.target<chip = "gfx90a">]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg6: i32, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernel_module2", targets = [#rocdl.target<flags = {fast}>, #rocdl.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

