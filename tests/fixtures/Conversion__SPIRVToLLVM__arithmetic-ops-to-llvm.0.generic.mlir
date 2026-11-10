"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "iadd_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg50: i32, %arg51: i32):
    %29 = "llvm.add"(%arg50, %arg51) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi64>, vector<4xi64>)>, linkage = #llvm.linkage<external>, sym_name = "iadd_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg48: vector<4xi64>, %arg49: vector<4xi64>):
    %28 = "llvm.add"(%arg48, %arg49) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8, i8)>, linkage = #llvm.linkage<external>, sym_name = "isub_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg46: i8, %arg47: i8):
    %27 = "llvm.sub"(%arg46, %arg47) <{overflowFlags = 0 : i32}> : (i8, i8) -> i8
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi16>, vector<2xi16>)>, linkage = #llvm.linkage<external>, sym_name = "isub_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg44: vector<2xi16>, %arg45: vector<2xi16>):
    %26 = "llvm.sub"(%arg44, %arg45) <{overflowFlags = 0 : i32}> : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "imul_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg42: i32, %arg43: i32):
    %25 = "llvm.mul"(%arg42, %arg43) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi32>, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "imul_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg40: vector<3xi32>, %arg41: vector<3xi32>):
    %24 = "llvm.mul"(%arg40, %arg41) <{overflowFlags = 0 : i32}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16, f16)>, linkage = #llvm.linkage<external>, sym_name = "fadd_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg38: f16, %arg39: f16):
    %23 = "llvm.fadd"(%arg38, %arg39) <{fastmathFlags = #llvm.fastmath<none>}> : (f16, f16) -> f16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fadd_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg36: vector<4xf32>, %arg37: vector<4xf32>):
    %22 = "llvm.fadd"(%arg36, %arg37) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fsub_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg34: f32, %arg35: f32):
    %21 = "llvm.fsub"(%arg34, %arg35) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fsub_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg32: vector<2xf32>, %arg33: vector<2xf32>):
    %20 = "llvm.fsub"(%arg32, %arg33) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fdiv_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg30: f32, %arg31: f32):
    %19 = "llvm.fdiv"(%arg30, %arg31) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf64>, vector<3xf64>)>, linkage = #llvm.linkage<external>, sym_name = "fdiv_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg28: vector<3xf64>, %arg29: vector<3xf64>):
    %18 = "llvm.fdiv"(%arg28, %arg29) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fmul_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg26: f32, %arg27: f32):
    %17 = "llvm.fmul"(%arg26, %arg27) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>, vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fmul_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg24: vector<2xf32>, %arg25: vector<2xf32>):
    %16 = "llvm.fmul"(%arg24, %arg25) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "frem_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg22: f32, %arg23: f32):
    %15 = "llvm.frem"(%arg22, %arg23) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xf64>, vector<3xf64>)>, linkage = #llvm.linkage<external>, sym_name = "frem_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: vector<3xf64>, %arg21: vector<3xf64>):
    %14 = "llvm.frem"(%arg20, %arg21) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64)>, linkage = #llvm.linkage<external>, sym_name = "fneg_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: f64):
    %13 = "llvm.fneg"(%arg19) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f64
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fneg_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg18: vector<2xf32>):
    %12 = "llvm.fneg"(%arg18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "udiv_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    %11 = "llvm.udiv"(%arg16, %arg17) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi64>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "udiv_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: vector<3xi64>, %arg15: vector<3xi64>):
    %10 = "llvm.udiv"(%arg14, %arg15) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "umod_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i32, %arg13: i32):
    %9 = "llvm.urem"(%arg12, %arg13) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<3xi64>, vector<3xi64>)>, linkage = #llvm.linkage<external>, sym_name = "umod_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: vector<3xi64>, %arg11: vector<3xi64>):
    %8 = "llvm.urem"(%arg10, %arg11) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, i16)>, linkage = #llvm.linkage<external>, sym_name = "sdiv_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i16, %arg9: i16):
    %7 = "llvm.sdiv"(%arg8, %arg9) : (i16, i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<2xi64>, vector<2xi64>)>, linkage = #llvm.linkage<external>, sym_name = "sdiv_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: vector<2xi64>, %arg7: vector<2xi64>):
    %6 = "llvm.sdiv"(%arg6, %arg7) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "srem_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %5 = "llvm.srem"(%arg4, %arg5) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi32>, vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "srem_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: vector<4xi32>, %arg3: vector<4xi32>):
    %4 = "llvm.srem"(%arg2, %arg3) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "snegate_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i32):
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.sub"(%2, %arg1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "snegate_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "llvm.mlir.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "llvm.sub"(%0, %arg0) <{overflowFlags = 0 : i32}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

