"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "ceil", visibility_ = 0 : i64}> ({
  ^bb0(%arg76: f32, %arg77: vector<3xf16>):
    %86 = "llvm.intr.ceil"(%arg76) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %87 = "llvm.intr.ceil"(%arg77) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "cos", visibility_ = 0 : i64}> ({
  ^bb0(%arg74: f32, %arg75: vector<3xf16>):
    %84 = "llvm.intr.cos"(%arg74) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %85 = "llvm.intr.cos"(%arg75) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "exp", visibility_ = 0 : i64}> ({
  ^bb0(%arg72: f32, %arg73: vector<3xf16>):
    %82 = "llvm.intr.exp"(%arg72) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %83 = "llvm.intr.exp"(%arg73) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fabs", visibility_ = 0 : i64}> ({
  ^bb0(%arg70: f32, %arg71: vector<3xf16>):
    %80 = "llvm.intr.fabs"(%arg70) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %81 = "llvm.intr.fabs"(%arg71) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "floor", visibility_ = 0 : i64}> ({
  ^bb0(%arg68: f32, %arg69: vector<3xf16>):
    %78 = "llvm.intr.floor"(%arg68) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %79 = "llvm.intr.floor"(%arg69) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fmax", visibility_ = 0 : i64}> ({
  ^bb0(%arg66: f32, %arg67: vector<3xf16>):
    %76 = "llvm.intr.maxnum"(%arg66, %arg66) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %77 = "llvm.intr.maxnum"(%arg67, %arg67) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fmin", visibility_ = 0 : i64}> ({
  ^bb0(%arg64: f32, %arg65: vector<3xf16>):
    %74 = "llvm.intr.minnum"(%arg64, %arg64) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %75 = "llvm.intr.minnum"(%arg65, %arg65) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fclamp", visibility_ = 0 : i64}> ({
  ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
    %72 = "llvm.intr.maxnum"(%arg61, %arg62) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %73 = "llvm.intr.minnum"(%72, %arg63) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "nmax", visibility_ = 0 : i64}> ({
  ^bb0(%arg59: f32, %arg60: vector<3xf16>):
    %70 = "llvm.intr.maxnum"(%arg59, %arg59) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %71 = "llvm.intr.maxnum"(%arg60, %arg60) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "nmin", visibility_ = 0 : i64}> ({
  ^bb0(%arg57: f32, %arg58: vector<3xf16>):
    %68 = "llvm.intr.minnum"(%arg57, %arg57) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %69 = "llvm.intr.minnum"(%arg58, %arg58) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "log", visibility_ = 0 : i64}> ({
  ^bb0(%arg55: f32, %arg56: vector<3xf16>):
    %66 = "llvm.intr.log"(%arg55) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %67 = "llvm.intr.log"(%arg56) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "sin", visibility_ = 0 : i64}> ({
  ^bb0(%arg53: f32, %arg54: vector<3xf16>):
    %64 = "llvm.intr.sin"(%arg53) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %65 = "llvm.intr.sin"(%arg54) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "pow", visibility_ = 0 : i64}> ({
  ^bb0(%arg51: f32, %arg52: vector<3xf16>):
    %62 = "llvm.intr.pow"(%arg51, %arg51) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %63 = "llvm.intr.pow"(%arg52, %arg52) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fma", visibility_ = 0 : i64}> ({
  ^bb0(%arg49: f32, %arg50: vector<3xf16>):
    %60 = "llvm.intr.fma"(%arg49, %arg49, %arg49) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32, f32) -> f32
    %61 = "llvm.intr.fma"(%arg50, %arg50, %arg50) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "sabs", visibility_ = 0 : i64}> ({
  ^bb0(%arg47: i16, %arg48: vector<3xi32>):
    %58 = "llvm.intr.abs"(%arg47) <{is_int_min_poison = false}> : (i16) -> i16
    %59 = "llvm.intr.abs"(%arg48) <{is_int_min_poison = false}> : (vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "smax", visibility_ = 0 : i64}> ({
  ^bb0(%arg45: i16, %arg46: vector<3xi32>):
    %56 = "llvm.intr.smax"(%arg45, %arg45) : (i16, i16) -> i16
    %57 = "llvm.intr.smax"(%arg46, %arg46) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "smin", visibility_ = 0 : i64}> ({
  ^bb0(%arg43: i16, %arg44: vector<3xi32>):
    %54 = "llvm.intr.smin"(%arg43, %arg43) : (i16, i16) -> i16
    %55 = "llvm.intr.smin"(%arg44, %arg44) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "umax", visibility_ = 0 : i64}> ({
  ^bb0(%arg41: i16, %arg42: vector<3xi32>):
    %52 = "llvm.intr.umax"(%arg41, %arg41) : (i16, i16) -> i16
    %53 = "llvm.intr.umax"(%arg42, %arg42) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, vector<3xi32>)>, linkage = #llvm.linkage<external>, sym_name = "umin", visibility_ = 0 : i64}> ({
  ^bb0(%arg39: i16, %arg40: vector<3xi32>):
    %50 = "llvm.intr.umin"(%arg39, %arg39) : (i16, i16) -> i16
    %51 = "llvm.intr.umin"(%arg40, %arg40) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16, i16, i16)>, linkage = #llvm.linkage<external>, sym_name = "sclamp", visibility_ = 0 : i64}> ({
  ^bb0(%arg36: i16, %arg37: i16, %arg38: i16):
    %48 = "llvm.intr.smax"(%arg36, %arg37) : (i16, i16) -> i16
    %49 = "llvm.intr.smin"(%48, %arg38) : (i16, i16) -> i16
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "uclamp", visibility_ = 0 : i64}> ({
  ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
    %46 = "llvm.intr.umax"(%arg33, %arg34) : (i32, i32) -> i32
    %47 = "llvm.intr.umin"(%46, %arg35) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "sqrt", visibility_ = 0 : i64}> ({
  ^bb0(%arg31: f32, %arg32: vector<3xf16>):
    %44 = "llvm.intr.sqrt"(%arg31) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %45 = "llvm.intr.sqrt"(%arg32) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "tan", visibility_ = 0 : i64}> ({
  ^bb0(%arg30: f32):
    %43 = "llvm.intr.tan"(%arg30) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "tanh", visibility_ = 0 : i64}> ({
  ^bb0(%arg29: f32):
    %42 = "llvm.intr.tanh"(%arg29) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "exp2", visibility_ = 0 : i64}> ({
  ^bb0(%arg27: f32, %arg28: vector<3xf16>):
    %40 = "llvm.intr.exp2"(%arg27) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %41 = "llvm.intr.exp2"(%arg28) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "log2", visibility_ = 0 : i64}> ({
  ^bb0(%arg25: f32, %arg26: vector<3xf16>):
    %38 = "llvm.intr.log2"(%arg25) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %39 = "llvm.intr.log2"(%arg26) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "round", visibility_ = 0 : i64}> ({
  ^bb0(%arg23: f32, %arg24: vector<3xf16>):
    %36 = "llvm.intr.round"(%arg23) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %37 = "llvm.intr.round"(%arg24) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "round_even", visibility_ = 0 : i64}> ({
  ^bb0(%arg21: f32, %arg22: vector<3xf16>):
    %34 = "llvm.intr.roundeven"(%arg21) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %35 = "llvm.intr.roundeven"(%arg22) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "sinh", visibility_ = 0 : i64}> ({
  ^bb0(%arg19: f32, %arg20: vector<3xf16>):
    %32 = "llvm.intr.sinh"(%arg19) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %33 = "llvm.intr.sinh"(%arg20) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "cosh", visibility_ = 0 : i64}> ({
  ^bb0(%arg17: f32, %arg18: vector<3xf16>):
    %30 = "llvm.intr.cosh"(%arg17) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %31 = "llvm.intr.cosh"(%arg18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "inverse_sqrt", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: f32):
    %27 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %28 = "llvm.intr.sqrt"(%arg16) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %29 = "llvm.fdiv"(%27, %28) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf32>)>, linkage = #llvm.linkage<external>, sym_name = "radians", visibility_ = 0 : i64}> ({
  ^bb0(%arg14: f32, %arg15: vector<3xf32>):
    %23 = "llvm.mlir.constant"() <{value = 0.0174532924 : f32}> : () -> f32
    %24 = "llvm.fmul"(%arg14, %23) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %25 = "llvm.mlir.constant"() <{value = dense<0.0174532924> : vector<3xf32>}> : () -> vector<3xf32>
    %26 = "llvm.fmul"(%arg15, %25) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf32>)>, linkage = #llvm.linkage<external>, sym_name = "degrees", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: f32, %arg13: vector<3xf32>):
    %19 = "llvm.mlir.constant"() <{value = 57.2957802 : f32}> : () -> f32
    %20 = "llvm.fmul"(%arg12, %19) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %21 = "llvm.mlir.constant"() <{value = dense<57.2957802> : vector<3xf32>}> : () -> vector<3xf32>
    %22 = "llvm.fmul"(%arg13, %21) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "trunc", visibility_ = 0 : i64}> ({
  ^bb0(%arg10: f32, %arg11: vector<3xf16>):
    %17 = "llvm.intr.trunc"(%arg10) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %18 = "llvm.intr.trunc"(%arg11) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "asin_acos_atan", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: f32, %arg9: vector<3xf16>):
    %14 = "llvm.intr.asin"(%arg8) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %15 = "llvm.intr.acos"(%arg9) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    %16 = "llvm.intr.atan"(%arg8) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf16>)>, linkage = #llvm.linkage<external>, sym_name = "fract", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: f32, %arg7: vector<3xf16>):
    %10 = "llvm.intr.floor"(%arg6) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %11 = "llvm.fsub"(%arg6, %10) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %12 = "llvm.intr.floor"(%arg7) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>) -> vector<3xf16>
    %13 = "llvm.fsub"(%arg7, %12) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "fmix_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
    %5 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "llvm.fsub"(%5, %arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %7 = "llvm.fmul"(%arg3, %6) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %8 = "llvm.fmul"(%arg4, %arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %9 = "llvm.fadd"(%7, %8) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>, vector<4xf32>, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "fmix_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "llvm.fsub"(%0, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.fmul"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.fmul"(%arg1, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "llvm.fadd"(%2, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

