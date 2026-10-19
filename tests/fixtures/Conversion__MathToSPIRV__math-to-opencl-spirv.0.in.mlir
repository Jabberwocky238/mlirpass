"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg12: f32):
    %28 = "math.atan"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %29 = "math.cos"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %30 = "math.exp"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %31 = "math.expm1"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %32 = "math.log"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %33 = "math.log1p"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %34 = "math.log2"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %35 = "math.log10"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %36 = "math.roundeven"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %37 = "math.rsqrt"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %38 = "math.sqrt"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %39 = "math.tanh"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %40 = "math.sin"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %41 = "math.absf"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %42 = "math.ceil"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %43 = "math.floor"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %44 = "math.erf"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %45 = "math.round"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %46 = "math.tan"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %47 = "math.asin"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %48 = "math.acos"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %49 = "math.sinh"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %50 = "math.cosh"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %51 = "math.asinh"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %52 = "math.acosh"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %53 = "math.atanh"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg11: vector<3xf32>):
    %7 = "math.atan"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %8 = "math.cos"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %9 = "math.exp"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %10 = "math.expm1"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %11 = "math.log"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %12 = "math.log1p"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %13 = "math.log2"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %14 = "math.log10"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %15 = "math.roundeven"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %16 = "math.rsqrt"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %17 = "math.sqrt"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %18 = "math.tanh"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %19 = "math.sin"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %20 = "math.tan"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %21 = "math.asin"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %22 = "math.acos"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %23 = "math.sinh"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %24 = "math.cosh"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %25 = "math.asinh"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %26 = "math.acosh"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %27 = "math.atanh"(%arg11) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg9: f32, %arg10: f32):
    %5 = "math.atan2"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "math.powf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_binary_vector"}> ({
  ^bb0(%arg7: vector<4xf32>, %arg8: vector<4xf32>):
    %3 = "math.atan2"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "math.powf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
    %2 = "math.fma"(%arg4, %arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg1: vector<4xf32>, %arg2: vector<4xf32>, %arg3: vector<4xf32>):
    %1 = "math.fma"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg0: i32):
    %0 = "math.absi"(%arg0) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

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

