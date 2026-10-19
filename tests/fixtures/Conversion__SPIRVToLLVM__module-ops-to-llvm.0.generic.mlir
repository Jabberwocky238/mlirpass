"builtin.module"() ({
  "builtin.module"() ({
  ^bb0:
  }) : () -> ()
  "builtin.module"() <{sym_name = "foo"}> ({
  ^bb0:
  }) : () -> ()
  "builtin.module"() ({
  ^bb0:
  }) : () -> ()
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "empty", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

