"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{dialect.a = true, dialect.b = 4 : i64}], function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "check_attributes", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: i64):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{}, {}, {}, {}, {}, {}, {}], function_type = !llvm.func<void (ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "check_memref", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, arg_attrs = [{first.arg = true}, {second.arg = 42 : i32}], function_type = !llvm.func<void (f32, i64)>, linkage = #llvm.linkage<external>, sym_name = "check_multiple", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32, %arg1: i64):
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

