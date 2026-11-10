"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg39: f32):
    %52 = "math.atan"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %53 = "math.cos"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %54 = "math.exp"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %55 = "math.exp2"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %56 = "math.expm1"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %57 = "math.log"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %58 = "math.log1p"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %59 = "math.log2"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %60 = "math.log10"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %61 = "math.roundeven"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %62 = "math.rsqrt"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %63 = "math.sqrt"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %64 = "math.tanh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %65 = "math.sin"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %66 = "math.absf"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %67 = "math.ceil"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %68 = "math.floor"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %69 = "math.tan"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %70 = "math.asin"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %71 = "math.acos"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %72 = "math.sinh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %73 = "math.cosh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %74 = "math.asinh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %75 = "math.acosh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %76 = "math.atanh"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %77 = "math.trunc"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg38: vector<3xf32>):
    %29 = "math.atan"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %30 = "math.cos"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %31 = "math.exp"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %32 = "math.exp2"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %33 = "math.expm1"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %34 = "math.log"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %35 = "math.log1p"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %36 = "math.log2"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %37 = "math.log10"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %38 = "math.roundeven"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %39 = "math.rsqrt"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %40 = "math.sqrt"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %41 = "math.tanh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %42 = "math.sin"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %43 = "math.tan"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %44 = "math.asin"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %45 = "math.acos"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %46 = "math.sinh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %47 = "math.cosh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %48 = "math.asinh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %49 = "math.acosh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %50 = "math.atanh"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %51 = "math.trunc"(%arg38) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg35: f32, %arg36: f32, %arg37: f32):
    %28 = "math.fma"(%arg35, %arg36, %arg37) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg32: vector<4xf32>, %arg33: vector<4xf32>, %arg34: vector<4xf32>):
    %27 = "math.fma"(%arg32, %arg33, %arg34) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg30: f32, %arg31: f32):
    %26 = "math.atan2"(%arg30, %arg31) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>, vector<3xf32>) -> (), sym_name = "float32_binary_vector"}> ({
  ^bb0(%arg28: vector<3xf32>, %arg29: vector<3xf32>):
    %25 = "math.atan2"(%arg28, %arg29) <{fastmath = #arith.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_clamp_scalar"}> ({
  ^bb0(%arg25: f32, %arg26: f32, %arg27: f32):
    %24 = "math.clampf"(%arg25, %arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_clamp_vector"}> ({
  ^bb0(%arg22: vector<4xf32>, %arg23: vector<4xf32>, %arg24: vector<4xf32>):
    %23 = "math.clampf"(%arg22, %arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg21: i32):
    %22 = "math.absi"(%arg21) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "ctlz_scalar"}> ({
  ^bb0(%arg20: i32):
    %21 = "math.ctlz"(%arg20) : (i32) -> i32
    "func.return"(%21) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> vector<1xi32>, sym_name = "ctlz_vector1"}> ({
  ^bb0(%arg19: vector<1xi32>):
    %20 = "math.ctlz"(%arg19) : (vector<1xi32>) -> vector<1xi32>
    "func.return"(%20) : (vector<1xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "ctlz_vector2"}> ({
  ^bb0(%arg18: vector<2xi32>):
    %19 = "math.ctlz"(%arg18) : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%19) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "cttz_scalar"}> ({
  ^bb0(%arg17: i32):
    %18 = "math.cttz"(%arg17) : (i32) -> i32
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "cttz_vector"}> ({
  ^bb0(%arg16: vector<2xi32>):
    %17 = "math.cttz"(%arg16) : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%17) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "powf_scalar"}> ({
  ^bb0(%arg14: f32, %arg15: f32):
    %16 = "math.powf"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%16) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "powf_vector"}> ({
  ^bb0(%arg12: vector<4xf32>, %arg13: vector<4xf32>):
    %15 = "math.powf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%15) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "powf_const_odd_int_exp"}> ({
  ^bb0(%arg11: f32):
    %13 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %14 = "math.powf"(%arg11, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "powf_const_even_int_exp"}> ({
  ^bb0(%arg10: f32):
    %11 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %12 = "math.powf"(%arg10, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%12) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "powf_const_frac_exp"}> ({
  ^bb0(%arg9: f32):
    %9 = "arith.constant"() <{value = 2.500000e+00 : f32}> : () -> f32
    %10 = "math.powf"(%arg9, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%10) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "powf_const_odd_int_exp_vector"}> ({
  ^bb0(%arg8: vector<4xf32>):
    %7 = "arith.constant"() <{value = dense<3.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %8 = "math.powf"(%arg8, %7) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%8) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "powf_const_mixed_int_exp_vector"}> ({
  ^bb0(%arg7: vector<4xf32>):
    %5 = "arith.constant"() <{value = dense<[3.000000e+00, 2.000000e+00, 5.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %6 = "math.powf"(%arg7, %5) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%6) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "fpowi_scalar"}> ({
  ^bb0(%arg5: f32, %arg6: i32):
    %4 = "math.fpowi"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xi32>) -> vector<4xf32>, sym_name = "fpowi_vector"}> ({
  ^bb0(%arg3: vector<4xf32>, %arg4: vector<4xi32>):
    %3 = "math.fpowi"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xi32>) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "round_scalar"}> ({
  ^bb0(%arg2: f32):
    %2 = "math.round"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "round_vector"}> ({
  ^bb0(%arg1: vector<4xf32>):
    %1 = "math.round"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1xf32>, sym_name = "round_vector_unit_dim"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "math.round"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<1xf32>) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
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
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

