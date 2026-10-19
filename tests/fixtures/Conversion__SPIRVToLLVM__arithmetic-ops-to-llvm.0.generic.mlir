"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "iadd_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg48: i32, %arg49: i32):
    %25 = "llvm.add"(%arg48, %arg49) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi64>, vector<4xi64>)>, linkage = #llvm.linkage<external>, sym_name = "iadd_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg46: vector<4xi64>, %arg47: vector<4xi64>):
    %24 = "llvm.add"(%arg46, %arg47) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8, i8)>, linkage = #llvm.linkage<external>, sym_name = "isub_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg44: i8, %arg45: i8):
    %23 = "llvm.sub"(%arg44, %arg45) <{overflowFlags = 0 : i32}> : (i8, i8) -> i8
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi16>, vector<2xi16>)>, linkage = #llvm.linkage<external>, sym_name = "isub_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg42: vector<2xi16>, %arg43: vector<2xi16>):
    %22 = "llvm.sub"(%arg42, %arg43) <{overflowFlags = 0 : i32}> : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "imul_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg40: i32, %arg41: i32):
    %21 = "llvm.mul"(%arg40, %arg41) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "imul_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg38: vector<3xi32>, %arg39: vector<3xi32>):
    %20 = "llvm.mul"(%arg38, %arg39) <{overflowFlags = 0 : i32}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "fadd_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg36: f16, %arg37: f16):
    %19 = "llvm.fadd"(%arg36, %arg37) <{fastmathFlags = #llvm.fastmath<none>}> : (f16, f16) -> f16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fadd_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg34: vector<4xf32>, %arg35: vector<4xf32>):
    %18 = "llvm.fadd"(%arg34, %arg35) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fsub_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg32: f32, %arg33: f32):
    %17 = "llvm.fsub"(%arg32, %arg33) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fsub_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg30: vector<2xf32>, %arg31: vector<2xf32>):
    %16 = "llvm.fsub"(%arg30, %arg31) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fdiv_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg28: f32, %arg29: f32):
    %15 = "llvm.fdiv"(%arg28, %arg29) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf64>, vector<3xf64>)>, linkage = #llvm.linkage<external>, sym_name = "fdiv_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: vector<3xf64>, %arg27: vector<3xf64>):
    %14 = "llvm.fdiv"(%arg26, %arg27) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fmul_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: f32, %arg25: f32):
    %13 = "llvm.fmul"(%arg24, %arg25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fmul_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg22: vector<2xf32>, %arg23: vector<2xf32>):
    %12 = "llvm.fmul"(%arg22, %arg23) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "frem_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: f32, %arg21: f32):
    %11 = "llvm.frem"(%arg20, %arg21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf64>, vector<3xf64>)>, linkage = #llvm.linkage<external>, sym_name = "frem_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: vector<3xf64>, %arg19: vector<3xf64>):
    %10 = "llvm.frem"(%arg18, %arg19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64)>, linkage = #llvm.linkage<external>, sym_name = "fneg_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: f64):
    %9 = "llvm.fneg"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fneg_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: vector<2xf32>):
    %8 = "llvm.fneg"(%arg16) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "udiv_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: i32, %arg15: i32):
    %7 = "llvm.udiv"(%arg14, %arg15) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi64>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "udiv_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: vector<3xi64>, %arg13: vector<3xi64>):
    %6 = "llvm.udiv"(%arg12, %arg13) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "umod_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %5 = "llvm.urem"(%arg10, %arg11) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi64>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "umod_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: vector<3xi64>, %arg9: vector<3xi64>):
    %4 = "llvm.urem"(%arg8, %arg9) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, i16)>, linkage = #llvm.linkage<external>, sym_name = "sdiv_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i16, %arg7: i16):
    %3 = "llvm.sdiv"(%arg6, %arg7) : (i16, i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi64>, vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "sdiv_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: vector<2xi64>, %arg5: vector<2xi64>):
    %2 = "llvm.sdiv"(%arg4, %arg5) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "srem_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1 = "llvm.srem"(%arg2, %arg3) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi32>, vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "srem_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "llvm.srem"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

