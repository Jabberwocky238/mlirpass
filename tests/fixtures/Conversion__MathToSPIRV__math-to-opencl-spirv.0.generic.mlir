"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg12: f32):
    %36 = "spirv.CL.atan"(%arg12) : (f32) -> f32
    %37 = "spirv.CL.cos"(%arg12) : (f32) -> f32
    %38 = "spirv.CL.exp"(%arg12) : (f32) -> f32
    %39 = "spirv.CL.exp"(%arg12) : (f32) -> f32
    %40 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %41 = "spirv.FSub"(%39, %40) : (f32, f32) -> f32
    %42 = "spirv.CL.log"(%arg12) : (f32) -> f32
    %43 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %44 = "spirv.FAdd"(%43, %arg12) : (f32, f32) -> f32
    %45 = "spirv.CL.log"(%44) : (f32) -> f32
    %46 = "spirv.Constant"() <{value = 1.44269502 : f32}> : () -> f32
    %47 = "spirv.CL.log"(%arg12) : (f32) -> f32
    %48 = "spirv.FMul"(%47, %46) : (f32, f32) -> f32
    %49 = "spirv.Constant"() <{value = 0.434294492 : f32}> : () -> f32
    %50 = "spirv.CL.log"(%arg12) : (f32) -> f32
    %51 = "spirv.FMul"(%50, %49) : (f32, f32) -> f32
    %52 = "spirv.CL.rint"(%arg12) : (f32) -> f32
    %53 = "spirv.CL.rsqrt"(%arg12) : (f32) -> f32
    %54 = "spirv.CL.sqrt"(%arg12) : (f32) -> f32
    %55 = "spirv.CL.tanh"(%arg12) : (f32) -> f32
    %56 = "spirv.CL.sin"(%arg12) : (f32) -> f32
    %57 = "spirv.CL.fabs"(%arg12) : (f32) -> f32
    %58 = "spirv.CL.ceil"(%arg12) : (f32) -> f32
    %59 = "spirv.CL.floor"(%arg12) : (f32) -> f32
    %60 = "spirv.CL.erf"(%arg12) : (f32) -> f32
    %61 = "spirv.CL.round"(%arg12) : (f32) -> f32
    %62 = "spirv.CL.tan"(%arg12) : (f32) -> f32
    %63 = "spirv.CL.asin"(%arg12) : (f32) -> f32
    %64 = "spirv.CL.acos"(%arg12) : (f32) -> f32
    %65 = "spirv.CL.sinh"(%arg12) : (f32) -> f32
    %66 = "spirv.CL.cosh"(%arg12) : (f32) -> f32
    %67 = "spirv.CL.asinh"(%arg12) : (f32) -> f32
    %68 = "spirv.CL.acosh"(%arg12) : (f32) -> f32
    %69 = "spirv.CL.atanh"(%arg12) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg11: vector<3xf32>):
    %7 = "spirv.CL.atan"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %8 = "spirv.CL.cos"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %9 = "spirv.CL.exp"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %10 = "spirv.CL.exp"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %11 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %12 = "spirv.FSub"(%10, %11) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %13 = "spirv.CL.log"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %14 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %15 = "spirv.FAdd"(%14, %arg11) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %16 = "spirv.CL.log"(%15) : (vector<3xf32>) -> vector<3xf32>
    %17 = "spirv.Constant"() <{value = dense<1.44269502> : vector<3xf32>}> : () -> vector<3xf32>
    %18 = "spirv.CL.log"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %19 = "spirv.FMul"(%18, %17) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %20 = "spirv.Constant"() <{value = dense<0.434294492> : vector<3xf32>}> : () -> vector<3xf32>
    %21 = "spirv.CL.log"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %22 = "spirv.FMul"(%21, %20) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %23 = "spirv.CL.rint"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %24 = "spirv.CL.rsqrt"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %25 = "spirv.CL.sqrt"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %26 = "spirv.CL.tanh"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %27 = "spirv.CL.sin"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %28 = "spirv.CL.tan"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %29 = "spirv.CL.asin"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %30 = "spirv.CL.acos"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %31 = "spirv.CL.sinh"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %32 = "spirv.CL.cosh"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %33 = "spirv.CL.asinh"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %34 = "spirv.CL.acosh"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    %35 = "spirv.CL.atanh"(%arg11) : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg9: f32, %arg10: f32):
    %5 = "spirv.CL.atan2"(%arg9, %arg10) : (f32, f32) -> f32
    %6 = "spirv.CL.pow"(%arg9, %arg10) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_binary_vector"}> ({
  ^bb0(%arg7: vector<4xf32>, %arg8: vector<4xf32>):
    %3 = "spirv.CL.atan2"(%arg7, %arg8) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "spirv.CL.pow"(%arg7, %arg8) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
    %2 = "spirv.CL.fma"(%arg4, %arg5, %arg6) : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg1: vector<4xf32>, %arg2: vector<4xf32>, %arg3: vector<4xf32>):
    %1 = "spirv.CL.fma"(%arg1, %arg2, %arg3) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.CL.s_abs"(%arg0) : (i32) -> i32
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

