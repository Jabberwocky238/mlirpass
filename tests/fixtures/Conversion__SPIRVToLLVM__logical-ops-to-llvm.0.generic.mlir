"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_equal_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: i1, %arg25: i1):
    %15 = "llvm.icmp"(%arg24, %arg25) <{predicate = 0 : i64}> : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_equal_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg22: vector<4xi1>, %arg23: vector<4xi1>):
    %14 = "llvm.icmp"(%arg22, %arg23) <{predicate = 0 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_equal_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: i1, %arg21: i1):
    %13 = "llvm.icmp"(%arg20, %arg21) <{predicate = 1 : i64}> : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_equal_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: vector<4xi1>, %arg19: vector<4xi1>):
    %12 = "llvm.icmp"(%arg18, %arg19) <{predicate = 1 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: i1):
    %10 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %11 = "llvm.xor"(%arg17, %10) : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: vector<4xi1>):
    %8 = "llvm.mlir.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %9 = "llvm.xor"(%arg16, %8) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_and_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: i1, %arg15: i1):
    %7 = "llvm.and"(%arg14, %arg15) : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_and_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: vector<4xi1>, %arg13: vector<4xi1>):
    %6 = "llvm.and"(%arg12, %arg13) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_or_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i1, %arg11: i1):
    %5 = "llvm.or"(%arg10, %arg11) : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_or_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: vector<4xi1>, %arg9: vector<4xi1>):
    %4 = "llvm.or"(%arg8, %arg9) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "ordered_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: f32, %arg7: f32):
    %3 = "llvm.fcmp"(%arg6, %arg7) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "ordered_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<4xf32>, %arg5: vector<4xf32>):
    %2 = "llvm.fcmp"(%arg4, %arg5) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "unordered_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "llvm.fcmp"(%arg2, %arg3) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "unordered_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

