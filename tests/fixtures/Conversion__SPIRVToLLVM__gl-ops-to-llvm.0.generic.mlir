"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "ceil", visibility_ = 0 : i64}> ({
  ^bb0(%arg25: f32, %arg26: vector<3xf16>):
    %27 = "llvm.intr.ceil"(%arg25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %28 = "llvm.intr.ceil"(%arg26) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "cos", visibility_ = 0 : i64}> ({
  ^bb0(%arg23: f32, %arg24: vector<3xf16>):
    %25 = "llvm.intr.cos"(%arg23) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %26 = "llvm.intr.cos"(%arg24) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "exp", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: f32, %arg22: vector<3xf16>):
    %23 = "llvm.intr.exp"(%arg21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %24 = "llvm.intr.exp"(%arg22) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fabs", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: f32, %arg20: vector<3xf16>):
    %21 = "llvm.intr.fabs"(%arg19) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %22 = "llvm.intr.fabs"(%arg20) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "floor", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: f32, %arg18: vector<3xf16>):
    %19 = "llvm.intr.floor"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %20 = "llvm.intr.floor"(%arg18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fmax", visibility_ = 0 : i64}> ({
  ^bb0(%arg15: f32, %arg16: vector<3xf16>):
    %17 = "llvm.intr.maxnum"(%arg15, %arg15) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %18 = "llvm.intr.maxnum"(%arg16, %arg16) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fmin", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: f32, %arg14: vector<3xf16>):
    %15 = "llvm.intr.minnum"(%arg13, %arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %16 = "llvm.intr.minnum"(%arg14, %arg14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "log", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: f32, %arg12: vector<3xf16>):
    %13 = "llvm.intr.log"(%arg11) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %14 = "llvm.intr.log"(%arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "sin", visibility_ = 0 : i64}> ({
  ^bb0(%arg9: f32, %arg10: vector<3xf16>):
    %11 = "llvm.intr.sin"(%arg9) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %12 = "llvm.intr.sin"(%arg10) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "smax", visibility_ = 0 : i64}> ({
  ^bb0(%arg7: i16, %arg8: vector<3xi32>):
    %9 = "llvm.intr.smax"(%arg7, %arg7) : (i16, i16) -> i16
    %10 = "llvm.intr.smax"(%arg8, %arg8) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "smin", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i16, %arg6: vector<3xi32>):
    %7 = "llvm.intr.smin"(%arg5, %arg5) : (i16, i16) -> i16
    %8 = "llvm.intr.smin"(%arg6, %arg6) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "sqrt", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: f32, %arg4: vector<3xf16>):
    %5 = "llvm.intr.sqrt"(%arg3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %6 = "llvm.intr.sqrt"(%arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "tan", visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f32):
    %4 = "llvm.intr.tan"(%arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "tanh", visibility_ = 0 : i64}> ({
  ^bb0(%arg1: f32):
    %3 = "llvm.intr.tanh"(%arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "inverse_sqrt", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

