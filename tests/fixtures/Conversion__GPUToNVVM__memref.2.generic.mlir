"builtin.module"() ({
  "gpu.module"() <{sym_name = "memref_conversions"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "kern", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
}) : () -> ()

