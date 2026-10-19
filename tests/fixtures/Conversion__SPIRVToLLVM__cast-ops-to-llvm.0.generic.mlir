"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_float_to_integer_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg25: f32):
    %24 = "llvm.bitcast"(%arg25) : (f32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_float_to_integer_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: vector<3xf32>):
    %23 = "llvm.bitcast"(%arg24) : (vector<3xf32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_vector_to_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg23: vector<2xf32>):
    %22 = "llvm.bitcast"(%arg23) : (vector<2xf32>) -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_scalar_to_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg22: f64):
    %21 = "llvm.bitcast"(%arg22) : (f64) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_vector_to_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: vector<4xf32>):
    %20 = "llvm.bitcast"(%arg21) : (vector<4xf32>) -> vector<2xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_pointer", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: !llvm.ptr):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_signed_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: f32):
    %19 = "llvm.fptosi"(%arg19) : (f32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_signed_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: vector<2xf32>):
    %18 = "llvm.fptosi"(%arg18) : (vector<2xf32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_unsigned_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: f32):
    %17 = "llvm.fptoui"(%arg17) : (f32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_unsigned_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: vector<2xf32>):
    %16 = "llvm.fptoui"(%arg16) : (vector<2xf32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "convert_signed_to_float_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg15: i32):
    %15 = "llvm.sitofp"(%arg15) : (i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_signed_to_float_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: vector<3xi32>):
    %14 = "llvm.sitofp"(%arg14) : (vector<3xi32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "convert_unsigned_to_float_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: i32):
    %13 = "llvm.uitofp"(%arg13) : (i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_unsigned_to_float_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: vector<3xi32>):
    %12 = "llvm.uitofp"(%arg12) : (vector<3xi32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "fconvert_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: f32, %arg11: f64):
    %10 = "llvm.fpext"(%arg10) : (f32) -> f64
    %11 = "llvm.fptrunc"(%arg11) : (f64) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>, vector<2xf64>)>, linkage = #llvm.linkage<external>, sym_name = "fconvert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: vector<2xf32>, %arg9: vector<2xf64>):
    %8 = "llvm.fpext"(%arg8) : (vector<2xf32>) -> vector<2xf64>
    %9 = "llvm.fptrunc"(%arg9) : (vector<2xf64>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i64)>, linkage = #llvm.linkage<external>, sym_name = "sconvert_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i32, %arg7: i64):
    %6 = "llvm.sext"(%arg6) : (i32) -> i64
    %7 = "llvm.trunc"(%arg7) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "sconvert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<3xi32>, %arg5: vector<3xi64>):
    %4 = "llvm.sext"(%arg4) : (vector<3xi32>) -> vector<3xi64>
    %5 = "llvm.trunc"(%arg5) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i64)>, linkage = #llvm.linkage<external>, sym_name = "uconvert_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i32, %arg3: i64):
    %2 = "llvm.zext"(%arg2) : (i32) -> i64
    %3 = "llvm.trunc"(%arg3) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "uconvert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: vector<3xi64>):
    %0 = "llvm.zext"(%arg0) : (vector<3xi32>) -> vector<3xi64>
    %1 = "llvm.trunc"(%arg1) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

