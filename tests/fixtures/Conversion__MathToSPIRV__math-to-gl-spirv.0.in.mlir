"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg17: f32):
    %31 = "math.atan"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %32 = "math.cos"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %33 = "math.exp"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %34 = "math.expm1"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %35 = "math.log"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %36 = "math.log1p"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %37 = "math.log2"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %38 = "math.log10"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %39 = "math.roundeven"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %40 = "math.rsqrt"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %41 = "math.sqrt"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %42 = "math.tanh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %43 = "math.sin"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %44 = "math.absf"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %45 = "math.ceil"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %46 = "math.floor"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %47 = "math.tan"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %48 = "math.asin"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %49 = "math.acos"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %50 = "math.sinh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %51 = "math.cosh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %52 = "math.asinh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %53 = "math.acosh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %54 = "math.atanh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg16: vector<3xf32>):
    %10 = "math.atan"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %11 = "math.cos"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %12 = "math.exp"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %13 = "math.expm1"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %14 = "math.log"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %15 = "math.log1p"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %16 = "math.log2"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %17 = "math.log10"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %18 = "math.roundeven"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %19 = "math.rsqrt"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %20 = "math.sqrt"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %21 = "math.tanh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %22 = "math.sin"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %23 = "math.tan"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %24 = "math.asin"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %25 = "math.acos"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %26 = "math.sinh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %27 = "math.cosh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %28 = "math.asinh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %29 = "math.acosh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %30 = "math.atanh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg13: f32, %arg14: f32, %arg15: f32):
    %9 = "math.fma"(%arg13, %arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg10: vector<4xf32>, %arg11: vector<4xf32>, %arg12: vector<4xf32>):
    %8 = "math.fma"(%arg10, %arg11, %arg12) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg9: i32):
    %7 = "math.absi"(%arg9) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "ctlz_scalar"}> ({
  ^bb0(%arg8: i32):
    %6 = "math.ctlz"(%arg8) : (i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> vector<1xi32>, sym_name = "ctlz_vector1"}> ({
  ^bb0(%arg7: vector<1xi32>):
    %5 = "math.ctlz"(%arg7) : (vector<1xi32>) -> vector<1xi32>
    "func.return"(%5) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "ctlz_vector2"}> ({
  ^bb0(%arg6: vector<2xi32>):
    %4 = "math.ctlz"(%arg6) : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%4) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "powf_scalar"}> ({
  ^bb0(%arg4: f32, %arg5: f32):
    %3 = "math.powf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "powf_vector"}> ({
  ^bb0(%arg2: vector<4xf32>, %arg3: vector<4xf32>):
    %2 = "math.powf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "round_scalar"}> ({
  ^bb0(%arg1: f32):
    %1 = "math.round"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "round_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "math.round"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "ctlz_scalar"}> ({
  ^bb0(%arg1: i64):
    %1 = "math.ctlz"(%arg1) : (i64) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi16>) -> vector<2xi16>, sym_name = "ctlz_vector2"}> ({
  ^bb0(%arg0: vector<2xi16>):
    %0 = "math.ctlz"(%arg0) : (vector<2xi16>) -> vector<2xi16>
    "func.return"(%0) : (vector<2xi16>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int16], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> (), sym_name = "vector_2d"}> ({
  ^bb0(%arg1: vector<2x2xf32>):
    %7 = "math.atan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %8 = "math.cos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %9 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %10 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %11 = "math.ceil"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %12 = "math.floor"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    %13 = "math.powf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<2xf32>) -> (), sym_name = "tensor_1d"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %1 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %2 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %3 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %4 = "math.ceil"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %5 = "math.floor"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>) -> tensor<2xf32>
    %6 = "math.powf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

