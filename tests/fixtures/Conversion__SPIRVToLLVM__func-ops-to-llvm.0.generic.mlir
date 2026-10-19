"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "return", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "return_value", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: i32):
    "llvm.return"(%arg17) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "none", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, always_inline, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "inline", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, no_inline, sym_name = "dont_inline", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, passthrough = ["readonly"], sym_name = "pure", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, passthrough = ["readnone"], sym_name = "const", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i1, f64, f32)>, linkage = #llvm.linkage<external>, sym_name = "scalar_types", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: i32, %arg14: i1, %arg15: f64, %arg16: f32):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<2xi64> (vector<2xi64>, vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "vector_types", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: vector<2xi64>, %arg12: vector<2xi64>):
    %2 = "llvm.add"(%arg11, %arg12) <{overflowFlags = 0 : i32}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i1, f64, vector<2xi64>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "function_calls", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i32, %arg7: i1, %arg8: f64, %arg9: vector<2xi64>, %arg10: vector<2xf32>):
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @void_1, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.call"(%arg9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @void_2, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<2xi64>) -> ()
    %0 = "llvm.call"(%arg6, %arg7, %arg8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @value_scalar, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i32, i1, f64) -> i32
    %1 = "llvm.call"(%arg9, %arg10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @value_vector, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (vector<2xi64>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "void_1", visibility_ = 0 : i64}> ({
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "void_2", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: vector<2xi64>):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i1, f64)>, linkage = #llvm.linkage<external>, sym_name = "value_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i32, %arg3: i1, %arg4: f64):
    "llvm.return"(%arg2) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<2xf32> (vector<2xi64>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "value_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<2xi64>, %arg1: vector<2xf32>):
    "llvm.return"(%arg1) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

