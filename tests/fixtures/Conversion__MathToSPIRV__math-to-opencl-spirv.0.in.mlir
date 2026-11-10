"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg17: f32):
    %34 = "math.atan"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %35 = "math.cos"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %36 = "math.exp"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %37 = "math.expm1"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %38 = "math.log"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %39 = "math.log1p"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %40 = "math.log2"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %41 = "math.log10"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %42 = "math.exp2"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %43 = "math.roundeven"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %44 = "math.rsqrt"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %45 = "math.sqrt"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %46 = "math.tanh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %47 = "math.sin"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %48 = "math.absf"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %49 = "math.ceil"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %50 = "math.floor"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %51 = "math.erf"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %52 = "math.erfc"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %53 = "math.round"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %54 = "math.tan"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %55 = "math.asin"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %56 = "math.acos"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %57 = "math.sinh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %58 = "math.cosh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %59 = "math.asinh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %60 = "math.acosh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %61 = "math.atanh"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %62 = "math.trunc"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %63 = "math.cbrt"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg16: vector<3xf32>):
    %11 = "math.atan"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %12 = "math.cos"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %13 = "math.exp"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %14 = "math.expm1"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %15 = "math.log"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %16 = "math.log1p"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %17 = "math.log2"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %18 = "math.log10"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %19 = "math.exp2"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %20 = "math.roundeven"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %21 = "math.rsqrt"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %22 = "math.sqrt"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %23 = "math.tanh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %24 = "math.sin"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %25 = "math.tan"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %26 = "math.asin"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %27 = "math.acos"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %28 = "math.sinh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %29 = "math.cosh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %30 = "math.asinh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %31 = "math.acosh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %32 = "math.atanh"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %33 = "math.trunc"(%arg16) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg14: f32, %arg15: f32):
    %9 = "math.atan2"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "math.powf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_binary_vector"}> ({
  ^bb0(%arg12: vector<4xf32>, %arg13: vector<4xf32>):
    %7 = "math.atan2"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %8 = "math.powf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "fpowi_scalar"}> ({
  ^bb0(%arg10: f32, %arg11: i32):
    %6 = "math.fpowi"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xi32>) -> vector<4xf32>, sym_name = "fpowi_vector"}> ({
  ^bb0(%arg8: vector<4xf32>, %arg9: vector<4xi32>):
    %5 = "math.fpowi"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xi32>) -> vector<4xf32>
    "func.return"(%5) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
    %4 = "math.fma"(%arg5, %arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg2: vector<4xf32>, %arg3: vector<4xf32>, %arg4: vector<4xf32>):
    %3 = "math.fma"(%arg2, %arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg1: i32):
    %1 = "math.absi"(%arg1) : (i32) -> i32
    %2 = "math.ctlz"(%arg1) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> (), sym_name = "int_unary_vector"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "math.ctlz"(%arg0) : (vector<2xi32>) -> vector<2xi32>
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

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "sincos_scalar"}> ({
  ^bb0(%arg1: f32):
    %1:2 = "math.sincos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> (f32, f32)
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "sincos_vector"}> ({
  ^bb0(%arg0: vector<3xf32>):
    %0:2 = "math.sincos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> (vector<3xf32>, vector<3xf32>)
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

