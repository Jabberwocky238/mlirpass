"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "float32_unary_scalar"}> ({
  ^bb0(%arg17: f32):
    %38 = "spirv.CL.atan"(%arg17) : (f32) -> f32
    %39 = "spirv.CL.cos"(%arg17) : (f32) -> f32
    %40 = "spirv.CL.exp"(%arg17) : (f32) -> f32
    %41 = "spirv.CL.exp"(%arg17) : (f32) -> f32
    %42 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %43 = "spirv.FSub"(%41, %42) : (f32, f32) -> f32
    %44 = "spirv.CL.log"(%arg17) : (f32) -> f32
    %45 = "spirv.Constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %46 = "spirv.FAdd"(%45, %arg17) : (f32, f32) -> f32
    %47 = "spirv.CL.log"(%46) : (f32) -> f32
    %48 = "spirv.CL.log2"(%arg17) : (f32) -> f32
    %49 = "spirv.CL.log10"(%arg17) : (f32) -> f32
    %50 = "spirv.CL.exp2"(%arg17) : (f32) -> f32
    %51 = "spirv.CL.rint"(%arg17) : (f32) -> f32
    %52 = "spirv.CL.rsqrt"(%arg17) : (f32) -> f32
    %53 = "spirv.CL.sqrt"(%arg17) : (f32) -> f32
    %54 = "spirv.CL.tanh"(%arg17) : (f32) -> f32
    %55 = "spirv.CL.sin"(%arg17) : (f32) -> f32
    %56 = "spirv.CL.fabs"(%arg17) : (f32) -> f32
    %57 = "spirv.CL.ceil"(%arg17) : (f32) -> f32
    %58 = "spirv.CL.floor"(%arg17) : (f32) -> f32
    %59 = "spirv.CL.erf"(%arg17) : (f32) -> f32
    %60 = "spirv.CL.erfc"(%arg17) : (f32) -> f32
    %61 = "spirv.CL.round"(%arg17) : (f32) -> f32
    %62 = "spirv.CL.tan"(%arg17) : (f32) -> f32
    %63 = "spirv.CL.asin"(%arg17) : (f32) -> f32
    %64 = "spirv.CL.acos"(%arg17) : (f32) -> f32
    %65 = "spirv.CL.sinh"(%arg17) : (f32) -> f32
    %66 = "spirv.CL.cosh"(%arg17) : (f32) -> f32
    %67 = "spirv.CL.asinh"(%arg17) : (f32) -> f32
    %68 = "spirv.CL.acosh"(%arg17) : (f32) -> f32
    %69 = "spirv.CL.atanh"(%arg17) : (f32) -> f32
    %70 = "spirv.CL.trunc"(%arg17) : (f32) -> f32
    %71 = "spirv.CL.cbrt"(%arg17) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "float32_unary_vector"}> ({
  ^bb0(%arg16: vector<3xf32>):
    %11 = "spirv.CL.atan"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %12 = "spirv.CL.cos"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %13 = "spirv.CL.exp"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %14 = "spirv.CL.exp"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %15 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %16 = "spirv.FSub"(%14, %15) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %17 = "spirv.CL.log"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %18 = "spirv.Constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %19 = "spirv.FAdd"(%18, %arg16) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %20 = "spirv.CL.log"(%19) : (vector<3xf32>) -> vector<3xf32>
    %21 = "spirv.CL.log2"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %22 = "spirv.CL.log10"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %23 = "spirv.CL.exp2"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %24 = "spirv.CL.rint"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %25 = "spirv.CL.rsqrt"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %26 = "spirv.CL.sqrt"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %27 = "spirv.CL.tanh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %28 = "spirv.CL.sin"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %29 = "spirv.CL.tan"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %30 = "spirv.CL.asin"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %31 = "spirv.CL.acos"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %32 = "spirv.CL.sinh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %33 = "spirv.CL.cosh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %34 = "spirv.CL.asinh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %35 = "spirv.CL.acosh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %36 = "spirv.CL.atanh"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    %37 = "spirv.CL.trunc"(%arg16) : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "float32_binary_scalar"}> ({
  ^bb0(%arg14: f32, %arg15: f32):
    %9 = "spirv.CL.atan2"(%arg14, %arg15) : (f32, f32) -> f32
    %10 = "spirv.CL.pow"(%arg14, %arg15) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_binary_vector"}> ({
  ^bb0(%arg12: vector<4xf32>, %arg13: vector<4xf32>):
    %7 = "spirv.CL.atan2"(%arg12, %arg13) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %8 = "spirv.CL.pow"(%arg12, %arg13) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "fpowi_scalar"}> ({
  ^bb0(%arg10: f32, %arg11: i32):
    %6 = "spirv.CL.pown"(%arg10, %arg11) : (f32, i32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xi32>) -> vector<4xf32>, sym_name = "fpowi_vector"}> ({
  ^bb0(%arg8: vector<4xf32>, %arg9: vector<4xi32>):
    %5 = "spirv.CL.pown"(%arg8, %arg9) : (vector<4xf32>, vector<4xi32>) -> vector<4xf32>
    "func.return"(%5) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "float32_ternary_scalar"}> ({
  ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
    %4 = "spirv.CL.fma"(%arg5, %arg6, %arg7) : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "float32_ternary_vector"}> ({
  ^bb0(%arg2: vector<4xf32>, %arg3: vector<4xf32>, %arg4: vector<4xf32>):
    %3 = "spirv.CL.fma"(%arg2, %arg3, %arg4) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "int_unary"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.CL.s_abs"(%arg1) : (i32) -> i32
    %2 = "spirv.CL.clz"(%arg1) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> (), sym_name = "int_unary_vector"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "spirv.CL.clz"(%arg0) : (vector<2xi32>) -> vector<2xi32>
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
    %2 = "spirv.CL.sin"(%arg1) : (f32) -> f32
    %3 = "spirv.CL.cos"(%arg1) : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf32>) -> (), sym_name = "sincos_vector"}> ({
  ^bb0(%arg0: vector<3xf32>):
    %0 = "spirv.CL.sin"(%arg0) : (vector<3xf32>) -> vector<3xf32>
    %1 = "spirv.CL.cos"(%arg0) : (vector<3xf32>) -> vector<3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

