module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} {
  func.func @float32_unary_scalar(%arg0: f32) {
    %0 = spirv.CL.atan %arg0 : f32
    %1 = spirv.CL.cos %arg0 : f32
    %2 = spirv.CL.exp %arg0 : f32
    %3 = spirv.CL.exp %arg0 : f32
    %cst_f32 = spirv.Constant 1.000000e+00 : f32
    %4 = spirv.FSub %3, %cst_f32 : f32
    %5 = spirv.CL.log %arg0 : f32
    %cst_f32_0 = spirv.Constant 1.000000e+00 : f32
    %6 = spirv.FAdd %cst_f32_0, %arg0 : f32
    %7 = spirv.CL.log %6 : f32
    %8 = spirv.CL.log2 %arg0 : f32
    %9 = spirv.CL.log10 %arg0 : f32
    %10 = spirv.CL.exp2 %arg0 : f32
    %11 = spirv.CL.rint %arg0 : f32
    %12 = spirv.CL.rsqrt %arg0 : f32
    %13 = spirv.CL.sqrt %arg0 : f32
    %14 = spirv.CL.tanh %arg0 : f32
    %15 = spirv.CL.sin %arg0 : f32
    %16 = spirv.CL.fabs %arg0 : f32
    %17 = spirv.CL.ceil %arg0 : f32
    %18 = spirv.CL.floor %arg0 : f32
    %19 = spirv.CL.erf %arg0 : f32
    %20 = spirv.CL.erfc %arg0 : f32
    %21 = spirv.CL.round %arg0 : f32
    %22 = spirv.CL.tan %arg0 : f32
    %23 = spirv.CL.asin %arg0 : f32
    %24 = spirv.CL.acos %arg0 : f32
    %25 = spirv.CL.sinh %arg0 : f32
    %26 = spirv.CL.cosh %arg0 : f32
    %27 = spirv.CL.asinh %arg0 : f32
    %28 = spirv.CL.acosh %arg0 : f32
    %29 = spirv.CL.atanh %arg0 : f32
    %30 = spirv.CL.trunc %arg0 : f32
    %31 = spirv.CL.cbrt %arg0 : f32
    return
  }
  func.func @float32_unary_vector(%arg0: vector<3xf32>) {
    %0 = spirv.CL.atan %arg0 : vector<3xf32>
    %1 = spirv.CL.cos %arg0 : vector<3xf32>
    %2 = spirv.CL.exp %arg0 : vector<3xf32>
    %3 = spirv.CL.exp %arg0 : vector<3xf32>
    %cst_vec_3xf32 = spirv.Constant dense<1.000000e+00> : vector<3xf32>
    %4 = spirv.FSub %3, %cst_vec_3xf32 : vector<3xf32>
    %5 = spirv.CL.log %arg0 : vector<3xf32>
    %cst_vec_3xf32_0 = spirv.Constant dense<1.000000e+00> : vector<3xf32>
    %6 = spirv.FAdd %cst_vec_3xf32_0, %arg0 : vector<3xf32>
    %7 = spirv.CL.log %6 : vector<3xf32>
    %8 = spirv.CL.log2 %arg0 : vector<3xf32>
    %9 = spirv.CL.log10 %arg0 : vector<3xf32>
    %10 = spirv.CL.exp2 %arg0 : vector<3xf32>
    %11 = spirv.CL.rint %arg0 : vector<3xf32>
    %12 = spirv.CL.rsqrt %arg0 : vector<3xf32>
    %13 = spirv.CL.sqrt %arg0 : vector<3xf32>
    %14 = spirv.CL.tanh %arg0 : vector<3xf32>
    %15 = spirv.CL.sin %arg0 : vector<3xf32>
    %16 = spirv.CL.tan %arg0 : vector<3xf32>
    %17 = spirv.CL.asin %arg0 : vector<3xf32>
    %18 = spirv.CL.acos %arg0 : vector<3xf32>
    %19 = spirv.CL.sinh %arg0 : vector<3xf32>
    %20 = spirv.CL.cosh %arg0 : vector<3xf32>
    %21 = spirv.CL.asinh %arg0 : vector<3xf32>
    %22 = spirv.CL.acosh %arg0 : vector<3xf32>
    %23 = spirv.CL.atanh %arg0 : vector<3xf32>
    %24 = spirv.CL.trunc %arg0 : vector<3xf32>
    return
  }
  func.func @float32_binary_scalar(%arg0: f32, %arg1: f32) {
    %0 = spirv.CL.atan2 %arg0, %arg1 : f32
    %1 = spirv.CL.pow %arg0, %arg1 : f32
    return
  }
  func.func @float32_binary_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>) {
    %0 = spirv.CL.atan2 %arg0, %arg1 : vector<4xf32>
    %1 = spirv.CL.pow %arg0, %arg1 : vector<4xf32>
    return
  }
  func.func @fpowi_scalar(%arg0: f32, %arg1: i32) -> f32 {
    %0 = spirv.CL.pown %arg0, %arg1 : f32, i32 -> f32
    return %0 : f32
  }
  func.func @fpowi_vector(%arg0: vector<4xf32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = spirv.CL.pown %arg0, %arg1 : vector<4xf32>, vector<4xi32> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @float32_ternary_scalar(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = spirv.CL.fma %arg0, %arg1, %arg2 : f32
    return
  }
  func.func @float32_ternary_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) {
    %0 = spirv.CL.fma %arg0, %arg1, %arg2 : vector<4xf32>
    return
  }
  func.func @int_unary(%arg0: i32) {
    %0 = spirv.CL.s_abs %arg0 : i32
    %1 = spirv.CL.clz %arg0 : i32
    return
  }
  func.func @int_unary_vector(%arg0: vector<2xi32>) {
    %0 = spirv.CL.clz %arg0 : vector<2xi32>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @vector_2d(%arg0: vector<2x2xf32>) {
    %0 = math.atan %arg0 : vector<2x2xf32>
    %1 = math.cos %arg0 : vector<2x2xf32>
    %2 = math.exp %arg0 : vector<2x2xf32>
    %3 = math.absf %arg0 : vector<2x2xf32>
    %4 = math.ceil %arg0 : vector<2x2xf32>
    %5 = math.floor %arg0 : vector<2x2xf32>
    %6 = math.powf %arg0, %arg0 : vector<2x2xf32>
    return
  }
  func.func @tensor_1d(%arg0: tensor<2xf32>) {
    %0 = math.atan %arg0 : tensor<2xf32>
    %1 = math.cos %arg0 : tensor<2xf32>
    %2 = math.exp %arg0 : tensor<2xf32>
    %3 = math.absf %arg0 : tensor<2xf32>
    %4 = math.ceil %arg0 : tensor<2xf32>
    %5 = math.floor %arg0 : tensor<2xf32>
    %6 = math.powf %arg0, %arg0 : tensor<2xf32>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} {
  func.func @sincos_scalar(%arg0: f32) {
    %0 = spirv.CL.sin %arg0 : f32
    %1 = spirv.CL.cos %arg0 : f32
    return
  }
  func.func @sincos_vector(%arg0: vector<3xf32>) {
    %0 = spirv.CL.sin %arg0 : vector<3xf32>
    %1 = spirv.CL.cos %arg0 : vector<3xf32>
    return
  }
}

