"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.noalias}], function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "func_with_noalias_attr", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "func_without_any_attr", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

