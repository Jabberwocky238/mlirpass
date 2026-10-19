"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.readonly}, {llvm.readonly}, {}], function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_func_readonly", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.writeonly}, {llvm.writeonly}, {}], function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_func_writeonly", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.readonly}], function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "test_func_readonly_ptr", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.nonnull}, {llvm.nonnull}, {}], function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_func_nonnull", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.dereferenceable = 4 : i64}, {llvm.dereferenceable = 4 : i64}, {}], function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_func_dereferenceable", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.dereferenceable_or_null = 4 : i64}, {llvm.dereferenceable_or_null = 4 : i64}, {}], function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_func_dereferenceable_or_null", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{llvm.noundef}, {llvm.noundef}, {llvm.noundef}], function_type = !llvm.func<void (ptr, ptr, i64)>, linkage = #llvm.linkage<external>, sym_name = "test_func_noundef", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64):
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

