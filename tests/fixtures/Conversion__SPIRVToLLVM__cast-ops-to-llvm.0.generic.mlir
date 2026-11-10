"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_float_to_integer_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg30: f32):
    %29 = "llvm.bitcast"(%arg30) : (f32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_float_to_integer_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg29: vector<3xf32>):
    %28 = "llvm.bitcast"(%arg29) : (vector<3xf32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_vector_to_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg28: vector<2xf32>):
    %27 = "llvm.bitcast"(%arg28) : (vector<2xf32>) -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_scalar_to_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg27: f64):
    %26 = "llvm.bitcast"(%arg27) : (f64) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_vector_to_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: vector<4xf32>):
    %25 = "llvm.bitcast"(%arg26) : (vector<4xf32>) -> vector<2xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "bitcast_pointer", visibility_ = 0 : i64}> ({
  ^bb0(%arg25: !llvm.ptr):
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_signed_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: f32):
    %24 = "llvm.fptosi"(%arg24) : (f32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_signed_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg23: vector<2xf32>):
    %23 = "llvm.fptosi"(%arg23) : (vector<2xf32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_unsigned_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg22: f32):
    %22 = "llvm.fptoui"(%arg22) : (f32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_float_to_unsigned_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: vector<2xf32>):
    %21 = "llvm.fptoui"(%arg21) : (vector<2xf32>) -> vector<2xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "convert_signed_to_float_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: i32):
    %20 = "llvm.sitofp"(%arg20) : (i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_signed_to_float_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: vector<3xi32>):
    %19 = "llvm.sitofp"(%arg19) : (vector<3xi32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "convert_unsigned_to_float_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: i32):
    %18 = "llvm.uitofp"(%arg18) : (i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "convert_unsigned_to_float_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: vector<3xi32>):
    %17 = "llvm.uitofp"(%arg17) : (vector<3xi32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f64)>, linkage = #llvm.linkage<external>, sym_name = "fconvert_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg15: f32, %arg16: f64):
    %15 = "llvm.fpext"(%arg15) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f64
    %16 = "llvm.fptrunc"(%arg16) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>, vector<2xf64>)>, linkage = #llvm.linkage<external>, sym_name = "fconvert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: vector<2xf32>, %arg14: vector<2xf64>):
    %13 = "llvm.fpext"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>) -> vector<2xf64>
    %14 = "llvm.fptrunc"(%arg14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf64>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i64)>, linkage = #llvm.linkage<external>, sym_name = "sconvert_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: i32, %arg12: i64):
    %11 = "llvm.sext"(%arg11) : (i32) -> i64
    %12 = "llvm.trunc"(%arg12) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "sconvert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: vector<3xi32>, %arg10: vector<3xi64>):
    %9 = "llvm.sext"(%arg9) : (vector<3xi32>) -> vector<3xi64>
    %10 = "llvm.trunc"(%arg10) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i64)>, linkage = #llvm.linkage<external>, sym_name = "uconvert_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg7: i32, %arg8: i64):
    %7 = "llvm.zext"(%arg7) : (i32) -> i64
    %8 = "llvm.trunc"(%arg8) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "uconvert_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: vector<3xi32>, %arg6: vector<3xi64>):
    %5 = "llvm.zext"(%arg5) : (vector<3xi32>) -> vector<3xi64>
    %6 = "llvm.trunc"(%arg6) <{overflowFlags = 0 : i32}> : (vector<3xi64>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "convert_ptr_to_u", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: !llvm.ptr):
    %4 = "llvm.ptrtoint"(%arg4) : (!llvm.ptr) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "convert_u_to_ptr", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i32):
    %3 = "llvm.inttoptr"(%arg3) : (i32) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "ptr_cast_to_generic", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: !llvm.ptr):
    %2 = "llvm.addrspacecast"(%arg2) : (!llvm.ptr) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "generic_cast_to_ptr", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: !llvm.ptr):
    %1 = "llvm.addrspacecast"(%arg1) : (!llvm.ptr) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "generic_cast_to_ptr_explicit", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.addrspacecast"(%arg0) : (!llvm.ptr) -> !llvm.ptr
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

