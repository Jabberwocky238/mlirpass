module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @float32_unary_scalar(%arg0: f32) {
    %0 = spirv.GL.Atan %arg0 : f32
    %1 = spirv.GL.Cos %arg0 : f32
    %2 = spirv.GL.Exp %arg0 : f32
    %3 = spirv.GL.Exp2 %arg0 : f32
    %4 = spirv.GL.Exp %arg0 : f32
    %cst_f32 = spirv.Constant 1.000000e+00 : f32
    %5 = spirv.FSub %4, %cst_f32 : f32
    %6 = spirv.GL.Log %arg0 : f32
    %cst_f32_0 = spirv.Constant 1.000000e+00 : f32
    %7 = spirv.FAdd %cst_f32_0, %arg0 : f32
    %8 = spirv.GL.Log %7 : f32
    %9 = spirv.GL.Log2 %arg0 : f32
    %cst_f32_1 = spirv.Constant 0.434294492 : f32
    %10 = spirv.GL.Log %arg0 : f32
    %11 = spirv.FMul %10, %cst_f32_1 : f32
    %12 = spirv.GL.RoundEven %arg0 : f32
    %13 = spirv.GL.InverseSqrt %arg0 : f32
    %14 = spirv.GL.Sqrt %arg0 : f32
    %15 = spirv.GL.Tanh %arg0 : f32
    %16 = spirv.GL.Sin %arg0 : f32
    %17 = spirv.GL.FAbs %arg0 : f32
    %18 = spirv.GL.Ceil %arg0 : f32
    %19 = spirv.GL.Floor %arg0 : f32
    %20 = spirv.GL.Tan %arg0 : f32
    %21 = spirv.GL.Asin %arg0 : f32
    %22 = spirv.GL.Acos %arg0 : f32
    %23 = spirv.GL.Sinh %arg0 : f32
    %24 = spirv.GL.Cosh %arg0 : f32
    %25 = spirv.GL.Asinh %arg0 : f32
    %26 = spirv.GL.Acosh %arg0 : f32
    %27 = spirv.GL.Atanh %arg0 : f32
    %28 = spirv.GL.Trunc %arg0 : f32
    return
  }
  func.func @float32_unary_vector(%arg0: vector<3xf32>) {
    %0 = spirv.GL.Atan %arg0 : vector<3xf32>
    %1 = spirv.GL.Cos %arg0 : vector<3xf32>
    %2 = spirv.GL.Exp %arg0 : vector<3xf32>
    %3 = spirv.GL.Exp2 %arg0 : vector<3xf32>
    %4 = spirv.GL.Exp %arg0 : vector<3xf32>
    %cst_vec_3xf32 = spirv.Constant dense<1.000000e+00> : vector<3xf32>
    %5 = spirv.FSub %4, %cst_vec_3xf32 : vector<3xf32>
    %6 = spirv.GL.Log %arg0 : vector<3xf32>
    %cst_vec_3xf32_0 = spirv.Constant dense<1.000000e+00> : vector<3xf32>
    %7 = spirv.FAdd %cst_vec_3xf32_0, %arg0 : vector<3xf32>
    %8 = spirv.GL.Log %7 : vector<3xf32>
    %9 = spirv.GL.Log2 %arg0 : vector<3xf32>
    %cst_vec_3xf32_1 = spirv.Constant dense<0.434294492> : vector<3xf32>
    %10 = spirv.GL.Log %arg0 : vector<3xf32>
    %11 = spirv.FMul %10, %cst_vec_3xf32_1 : vector<3xf32>
    %12 = spirv.GL.RoundEven %arg0 : vector<3xf32>
    %13 = spirv.GL.InverseSqrt %arg0 : vector<3xf32>
    %14 = spirv.GL.Sqrt %arg0 : vector<3xf32>
    %15 = spirv.GL.Tanh %arg0 : vector<3xf32>
    %16 = spirv.GL.Sin %arg0 : vector<3xf32>
    %17 = spirv.GL.Tan %arg0 : vector<3xf32>
    %18 = spirv.GL.Asin %arg0 : vector<3xf32>
    %19 = spirv.GL.Acos %arg0 : vector<3xf32>
    %20 = spirv.GL.Sinh %arg0 : vector<3xf32>
    %21 = spirv.GL.Cosh %arg0 : vector<3xf32>
    %22 = spirv.GL.Asinh %arg0 : vector<3xf32>
    %23 = spirv.GL.Acosh %arg0 : vector<3xf32>
    %24 = spirv.GL.Atanh %arg0 : vector<3xf32>
    %25 = spirv.GL.Trunc %arg0 : vector<3xf32>
    return
  }
  func.func @float32_ternary_scalar(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = spirv.GL.Fma %arg0, %arg1, %arg2 : f32
    return
  }
  func.func @float32_ternary_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) {
    %0 = spirv.GL.Fma %arg0, %arg1, %arg2 : vector<4xf32>
    return
  }
  func.func @float32_binary_scalar(%arg0: f32, %arg1: f32) {
    %0 = spirv.GL.Atan2 %arg0, %arg1 : f32
    return
  }
  func.func @float32_binary_vector(%arg0: vector<3xf32>, %arg1: vector<3xf32>) {
    %0 = spirv.GL.Atan2 %arg0, %arg1 : vector<3xf32>
    return
  }
  func.func @float32_clamp_scalar(%arg0: f32, %arg1: f32, %arg2: f32) {
    %0 = spirv.GL.FClamp %arg0, %arg1, %arg2 : f32
    return
  }
  func.func @float32_clamp_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) {
    %0 = spirv.GL.FClamp %arg0, %arg1, %arg2 : vector<4xf32>
    return
  }
  func.func @int_unary(%arg0: i32) {
    %0 = spirv.GL.SAbs %arg0 : i32
    return
  }
  func.func @ctlz_scalar(%arg0: i32) -> i32 {
    %cst1_i32 = spirv.Constant 1 : i32
    %cst31_i32 = spirv.Constant 31 : i32
    %cst32_i32 = spirv.Constant 32 : i32
    %0 = spirv.GL.FindUMsb %arg0 : i32
    %1 = spirv.ISub %cst31_i32, %0 : i32
    %2 = spirv.ISub %cst32_i32, %arg0 : i32
    %3 = spirv.ULessThanEqual %arg0, %cst1_i32 : i32
    %4 = spirv.Select %3, %2, %1 : i1, i32
    return %4 : i32
  }
  func.func @ctlz_vector1(%arg0: vector<1xi32>) -> vector<1xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xi32> to i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst31_i32 = spirv.Constant 31 : i32
    %cst32_i32 = spirv.Constant 32 : i32
    %1 = spirv.GL.FindUMsb %0 : i32
    %2 = spirv.ISub %cst31_i32, %1 : i32
    %3 = spirv.ISub %cst32_i32, %0 : i32
    %4 = spirv.ULessThanEqual %0, %cst1_i32 : i32
    %5 = spirv.Select %4, %3, %2 : i1, i32
    %6 = builtin.unrealized_conversion_cast %5 : i32 to vector<1xi32>
    return %6 : vector<1xi32>
  }
  func.func @ctlz_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %cst_vec_2xi32 = spirv.Constant dense<1> : vector<2xi32>
    %cst_vec_2xi32_0 = spirv.Constant dense<31> : vector<2xi32>
    %cst_vec_2xi32_1 = spirv.Constant dense<32> : vector<2xi32>
    %0 = spirv.GL.FindUMsb %arg0 : vector<2xi32>
    %1 = spirv.ISub %cst_vec_2xi32_0, %0 : vector<2xi32>
    %2 = spirv.ISub %cst_vec_2xi32_1, %arg0 : vector<2xi32>
    %3 = spirv.ULessThanEqual %arg0, %cst_vec_2xi32 : vector<2xi32>
    %4 = spirv.Select %3, %2, %1 : vector<2xi1>, vector<2xi32>
    return %4 : vector<2xi32>
  }
  func.func @cttz_scalar(%arg0: i32) -> i32 {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst32_i32 = spirv.Constant 32 : i32
    %0 = spirv.GL.FindILsb %arg0 : i32
    %1 = spirv.IEqual %arg0, %cst0_i32 : i32
    %2 = spirv.Select %1, %cst32_i32, %0 : i1, i32
    return %2 : i32
  }
  func.func @cttz_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %cst_vec_2xi32 = spirv.Constant dense<0> : vector<2xi32>
    %cst_vec_2xi32_0 = spirv.Constant dense<32> : vector<2xi32>
    %0 = spirv.GL.FindILsb %arg0 : vector<2xi32>
    %1 = spirv.IEqual %arg0, %cst_vec_2xi32 : vector<2xi32>
    %2 = spirv.Select %1, %cst_vec_2xi32_0, %0 : vector<2xi1>, vector<2xi32>
    return %2 : vector<2xi32>
  }
  func.func @powf_scalar(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.GL.Log %arg0 : f32
    %1 = spirv.FMul %arg1, %0 : f32
    %2 = spirv.GL.Exp %1 : f32
    return %2 : f32
  }
  func.func @powf_vector(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = spirv.GL.Log %arg0 : vector<4xf32>
    %1 = spirv.FMul %arg1, %0 : vector<4xf32>
    %2 = spirv.GL.Exp %1 : vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @powf_const_odd_int_exp(%arg0: f32) -> f32 {
    %cst = arith.constant 3.000000e+00 : f32
    %0 = spirv.GL.FAbs %arg0 : f32
    %1 = spirv.GL.Pow %0, %cst : f32
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %2 = spirv.FOrdLessThan %arg0, %cst_f32 : f32
    %3 = spirv.FNegate %1 : f32
    %4 = spirv.Select %2, %3, %1 : i1, f32
    return %4 : f32
  }
  func.func @powf_const_even_int_exp(%arg0: f32) -> f32 {
    %cst = arith.constant 4.000000e+00 : f32
    %0 = spirv.GL.FAbs %arg0 : f32
    %1 = spirv.GL.Pow %0, %cst : f32
    return %1 : f32
  }
  func.func @powf_const_frac_exp(%arg0: f32) -> f32 {
    %cst = arith.constant 2.500000e+00 : f32
    %0 = spirv.GL.Log %arg0 : f32
    %1 = spirv.FMul %cst, %0 : f32
    %2 = spirv.GL.Exp %1 : f32
    return %2 : f32
  }
  func.func @powf_const_odd_int_exp_vector(%arg0: vector<4xf32>) -> vector<4xf32> {
    %cst = arith.constant dense<3.000000e+00> : vector<4xf32>
    %0 = spirv.GL.FAbs %arg0 : vector<4xf32>
    %1 = spirv.GL.Pow %0, %cst : vector<4xf32>
    %cst_vec_4xf32 = spirv.Constant dense<0.000000e+00> : vector<4xf32>
    %2 = spirv.FOrdLessThan %arg0, %cst_vec_4xf32 : vector<4xf32>
    %3 = spirv.FNegate %1 : vector<4xf32>
    %4 = spirv.Select %2, %3, %1 : vector<4xi1>, vector<4xf32>
    return %4 : vector<4xf32>
  }
  func.func @powf_const_mixed_int_exp_vector(%arg0: vector<4xf32>) -> vector<4xf32> {
    %cst = arith.constant dense<[3.000000e+00, 2.000000e+00, 5.000000e+00, 4.000000e+00]> : vector<4xf32>
    %0 = spirv.GL.FAbs %arg0 : vector<4xf32>
    %1 = spirv.GL.Pow %0, %cst : vector<4xf32>
    %cst_vec_4xf32 = spirv.Constant dense<0.000000e+00> : vector<4xf32>
    %2 = spirv.FOrdLessThan %arg0, %cst_vec_4xf32 : vector<4xf32>
    %3 = spirv.FNegate %1 : vector<4xf32>
    %cst_vec_4xi1 = spirv.Constant dense<[true, false, true, false]> : vector<4xi1>
    %4 = spirv.LogicalAnd %2, %cst_vec_4xi1 : vector<4xi1>
    %5 = spirv.Select %4, %3, %1 : vector<4xi1>, vector<4xf32>
    return %5 : vector<4xf32>
  }
  func.func @fpowi_scalar(%arg0: f32, %arg1: i32) -> f32 {
    %0 = spirv.ConvertSToF %arg1 : i32 to f32
    %1 = spirv.GL.FAbs %arg0 : f32
    %2 = spirv.GL.Pow %1, %0 : f32
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %3 = spirv.FOrdLessThan %arg0, %cst_f32 : f32
    %cst1_i32 = spirv.Constant 1 : i32
    %4 = spirv.BitwiseAnd %arg1, %cst1_i32 : i32
    %5 = spirv.IEqual %4, %cst1_i32 : i32
    %6 = spirv.LogicalAnd %3, %5 : i1
    %7 = spirv.FNegate %2 : f32
    %8 = spirv.Select %6, %7, %2 : i1, f32
    return %8 : f32
  }
  func.func @fpowi_vector(%arg0: vector<4xf32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = spirv.ConvertSToF %arg1 : vector<4xi32> to vector<4xf32>
    %1 = spirv.GL.FAbs %arg0 : vector<4xf32>
    %2 = spirv.GL.Pow %1, %0 : vector<4xf32>
    %cst_vec_4xf32 = spirv.Constant dense<0.000000e+00> : vector<4xf32>
    %3 = spirv.FOrdLessThan %arg0, %cst_vec_4xf32 : vector<4xf32>
    %cst_vec_4xi32 = spirv.Constant dense<1> : vector<4xi32>
    %4 = spirv.BitwiseAnd %arg1, %cst_vec_4xi32 : vector<4xi32>
    %5 = spirv.IEqual %4, %cst_vec_4xi32 : vector<4xi32>
    %6 = spirv.LogicalAnd %3, %5 : vector<4xi1>
    %7 = spirv.FNegate %2 : vector<4xf32>
    %8 = spirv.Select %6, %7, %2 : vector<4xi1>, vector<4xf32>
    return %8 : vector<4xf32>
  }
  func.func @round_scalar(%arg0: f32) -> f32 {
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst_f32_0 = spirv.Constant 1.000000e+00 : f32
    %cst_f32_1 = spirv.Constant 5.000000e-01 : f32
    %0 = spirv.GL.FAbs %arg0 : f32
    %1 = spirv.GL.Floor %0 : f32
    %2 = spirv.FSub %0, %1 : f32
    %3 = spirv.FOrdGreaterThanEqual %2, %cst_f32_1 : f32
    %4 = spirv.Select %3, %cst_f32_0, %cst_f32 : i1, f32
    %5 = spirv.FAdd %1, %4 : f32
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    %6 = spirv.Bitcast %5 : f32 to i32
    %7 = spirv.Bitcast %arg0 : f32 to i32
    %8 = spirv.BitwiseAnd %6, %cst2147483647_i32 : i32
    %9 = spirv.BitwiseAnd %7, %cst-2147483648_i32 : i32
    %10 = spirv.BitwiseOr %8, %9 : i32
    %11 = spirv.Bitcast %10 : i32 to f32
    return %11 : f32
  }
  func.func @round_vector(%arg0: vector<4xf32>) -> vector<4xf32> {
    %cst_vec_4xf32 = spirv.Constant dense<0.000000e+00> : vector<4xf32>
    %cst_vec_4xf32_0 = spirv.Constant dense<1.000000e+00> : vector<4xf32>
    %cst_vec_4xf32_1 = spirv.Constant dense<5.000000e-01> : vector<4xf32>
    %0 = spirv.GL.FAbs %arg0 : vector<4xf32>
    %1 = spirv.GL.Floor %0 : vector<4xf32>
    %2 = spirv.FSub %0, %1 : vector<4xf32>
    %3 = spirv.FOrdGreaterThanEqual %2, %cst_vec_4xf32_1 : vector<4xf32>
    %4 = spirv.Select %3, %cst_vec_4xf32_0, %cst_vec_4xf32 : vector<4xi1>, vector<4xf32>
    %5 = spirv.FAdd %1, %4 : vector<4xf32>
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    %6 = spirv.CompositeConstruct %cst-2147483648_i32, %cst-2147483648_i32, %cst-2147483648_i32, %cst-2147483648_i32 : (i32, i32, i32, i32) -> vector<4xi32>
    %7 = spirv.CompositeConstruct %cst2147483647_i32, %cst2147483647_i32, %cst2147483647_i32, %cst2147483647_i32 : (i32, i32, i32, i32) -> vector<4xi32>
    %8 = spirv.Bitcast %5 : vector<4xf32> to vector<4xi32>
    %9 = spirv.Bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %10 = spirv.BitwiseAnd %8, %7 : vector<4xi32>
    %11 = spirv.BitwiseAnd %9, %6 : vector<4xi32>
    %12 = spirv.BitwiseOr %10, %11 : vector<4xi32>
    %13 = spirv.Bitcast %12 : vector<4xi32> to vector<4xf32>
    return %13 : vector<4xf32>
  }
  func.func @round_vector_unit_dim(%arg0: vector<1xf32>) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst_f32_0 = spirv.Constant 1.000000e+00 : f32
    %cst_f32_1 = spirv.Constant 5.000000e-01 : f32
    %1 = spirv.GL.FAbs %0 : f32
    %2 = spirv.GL.Floor %1 : f32
    %3 = spirv.FSub %1, %2 : f32
    %4 = spirv.FOrdGreaterThanEqual %3, %cst_f32_1 : f32
    %5 = spirv.Select %4, %cst_f32_0, %cst_f32 : i1, f32
    %6 = spirv.FAdd %2, %5 : f32
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    %7 = spirv.Bitcast %6 : f32 to i32
    %8 = spirv.Bitcast %0 : f32 to i32
    %9 = spirv.BitwiseAnd %7, %cst2147483647_i32 : i32
    %10 = spirv.BitwiseAnd %8, %cst-2147483648_i32 : i32
    %11 = spirv.BitwiseOr %9, %10 : i32
    %12 = spirv.Bitcast %11 : i32 to f32
    %13 = builtin.unrealized_conversion_cast %12 : f32 to vector<1xf32>
    return %13 : vector<1xf32>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int16], []>, #spirv.resource_limits<>>} {
  func.func @ctlz_scalar(%arg0: i64) -> i64 {
    %0 = math.ctlz %arg0 : i64
    return %0 : i64
  }
  func.func @ctlz_vector2(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = math.ctlz %arg0 : vector<2xi16>
    return %0 : vector<2xi16>
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
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @sincos_scalar(%arg0: f32) {
    %0 = spirv.GL.Sin %arg0 : f32
    %1 = spirv.GL.Cos %arg0 : f32
    return
  }
  func.func @sincos_vector(%arg0: vector<3xf32>) {
    %0 = spirv.GL.Sin %arg0 : vector<3xf32>
    %1 = spirv.GL.Cos %arg0 : vector<3xf32>
    return
  }
}

