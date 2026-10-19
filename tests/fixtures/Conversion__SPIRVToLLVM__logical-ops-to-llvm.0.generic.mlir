"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_equal_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: i1, %arg17: i1):
    %11 = "llvm.icmp"(%arg16, %arg17) <{predicate = 0 : i64}> : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_equal_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: vector<4xi1>, %arg15: vector<4xi1>):
    %10 = "llvm.icmp"(%arg14, %arg15) <{predicate = 0 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_equal_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i1, %arg13: i1):
    %9 = "llvm.icmp"(%arg12, %arg13) <{predicate = 1 : i64}> : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_equal_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: vector<4xi1>, %arg11: vector<4xi1>):
    %8 = "llvm.icmp"(%arg10, %arg11) <{predicate = 1 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: i1):
    %6 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %7 = "llvm.xor"(%arg9, %6) : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_not_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: vector<4xi1>):
    %4 = "llvm.mlir.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %5 = "llvm.xor"(%arg8, %4) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_and_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i1, %arg7: i1):
    %3 = "llvm.and"(%arg6, %arg7) : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_and_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<4xi1>, %arg5: vector<4xi1>):
    %2 = "llvm.and"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "logical_or_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i1, %arg3: i1):
    %1 = "llvm.or"(%arg2, %arg3) : (i1, i1) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi1>, vector<4xi1>)>, linkage = #llvm.linkage<external>, sym_name = "logical_or_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xi1>, %arg1: vector<4xi1>):
    %0 = "llvm.or"(%arg0, %arg1) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

