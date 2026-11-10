"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, vector<3xf32>)>, linkage = #llvm.linkage<external>, sym_name = "cl_unary_float", visibility_ = 0 : i64}> ({
  ^bb0(%arg13: f32, %arg14: vector<3xf32>):
    %15 = "llvm.intr.ceil"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %16 = "llvm.intr.cos"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %17 = "llvm.intr.exp"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %18 = "llvm.intr.exp2"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %19 = "llvm.intr.exp10"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %20 = "llvm.intr.fabs"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %21 = "llvm.intr.floor"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %22 = "llvm.intr.log"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %23 = "llvm.intr.log2"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %24 = "llvm.intr.log10"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %25 = "llvm.intr.rint"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %26 = "llvm.intr.round"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %27 = "llvm.intr.sin"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %28 = "llvm.intr.sinh"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %29 = "llvm.intr.cosh"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %30 = "llvm.intr.tan"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %31 = "llvm.intr.tanh"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %32 = "llvm.intr.asin"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %33 = "llvm.intr.acos"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %34 = "llvm.intr.atan"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %35 = "llvm.intr.sqrt"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %36 = "llvm.intr.trunc"(%arg13) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %37 = "llvm.intr.sin"(%arg14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "cl_binary_float", visibility_ = 0 : i64}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %9 = "llvm.intr.pow"(%arg11, %arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %10 = "llvm.intr.atan2"(%arg11, %arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %11 = "llvm.intr.maxnum"(%arg11, %arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %12 = "llvm.intr.minnum"(%arg11, %arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %13 = "llvm.intr.copysign"(%arg11, %arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %14 = "llvm.frem"(%arg11, %arg12) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "cl_fma", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
    %8 = "llvm.intr.fma"(%arg8, %arg9, %arg10) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "cl_integer", visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %4 = "llvm.intr.smax"(%arg6, %arg7) : (i32, i32) -> i32
    %5 = "llvm.intr.smin"(%arg6, %arg7) : (i32, i32) -> i32
    %6 = "llvm.intr.umax"(%arg6, %arg7) : (i32, i32) -> i32
    %7 = "llvm.intr.umin"(%arg6, %arg7) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, f32, f32)>, linkage = #llvm.linkage<external>, sym_name = "mix_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
    %2 = "llvm.fsub"(%arg4, %arg3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %3 = "llvm.intr.fma"(%arg5, %2, %arg3) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32, f32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xf32>, vector<4xf32>, vector<4xf32>)>, linkage = #llvm.linkage<external>, sym_name = "mix_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>):
    %0 = "llvm.fsub"(%arg1, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = "llvm.intr.fma"(%arg2, %0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

