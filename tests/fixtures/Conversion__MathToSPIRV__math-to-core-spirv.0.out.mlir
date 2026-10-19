module {
  func.func @copy_sign_scalar(%arg0: f32, %arg1: f32) -> f32 {
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    %0 = spirv.Bitcast %arg0 : f32 to i32
    %1 = spirv.Bitcast %arg1 : f32 to i32
    %2 = spirv.BitwiseAnd %0, %cst2147483647_i32 : i32
    %3 = spirv.BitwiseAnd %1, %cst-2147483648_i32 : i32
    %4 = spirv.BitwiseOr %2, %3 : i32
    %5 = spirv.Bitcast %4 : i32 to f32
    return %5 : f32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Int16], []>, #spirv.resource_limits<>>} {
  func.func @copy_sign_vector(%arg0: vector<3xf16>, %arg1: vector<3xf16>) -> vector<3xf16> {
    %cst-32768_i16 = spirv.Constant -32768 : i16
    %cst32767_i16 = spirv.Constant 32767 : i16
    %0 = spirv.CompositeConstruct %cst-32768_i16, %cst-32768_i16, %cst-32768_i16 : (i16, i16, i16) -> vector<3xi16>
    %1 = spirv.CompositeConstruct %cst32767_i16, %cst32767_i16, %cst32767_i16 : (i16, i16, i16) -> vector<3xi16>
    %2 = spirv.Bitcast %arg0 : vector<3xf16> to vector<3xi16>
    %3 = spirv.Bitcast %arg1 : vector<3xf16> to vector<3xi16>
    %4 = spirv.BitwiseAnd %2, %1 : vector<3xi16>
    %5 = spirv.BitwiseAnd %3, %0 : vector<3xi16>
    %6 = spirv.BitwiseOr %4, %5 : vector<3xi16>
    %7 = spirv.Bitcast %6 : vector<3xi16> to vector<3xf16>
    return %7 : vector<3xf16>
  }
}

// -----
module {
  func.func @copy_sign_2d_vector(%arg0: vector<3x3xf32>, %arg1: vector<3x3xf32>) -> vector<3x3xf32> {
    %0 = math.copysign %arg0, %arg1 : vector<3x3xf32>
    return %0 : vector<3x3xf32>
  }
}

// -----
module {
  func.func @copy_sign_tensor(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>) -> tensor<3x3xf32> {
    %0 = math.copysign %arg0, %arg1 : tensor<3x3xf32>
    return %0 : tensor<3x3xf32>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Int16], []>, #spirv.resource_limits<>>} {
  func.func @copy_sign_vector_0D(%arg0: vector<1xf16>, %arg1: vector<1xf16>) -> vector<1xf16> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xf16> to f16
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xf16> to f16
    %cst-32768_i16 = spirv.Constant -32768 : i16
    %cst32767_i16 = spirv.Constant 32767 : i16
    %2 = spirv.Bitcast %1 : f16 to i16
    %3 = spirv.Bitcast %0 : f16 to i16
    %4 = spirv.BitwiseAnd %2, %cst32767_i16 : i16
    %5 = spirv.BitwiseAnd %3, %cst-32768_i16 : i16
    %6 = spirv.BitwiseOr %4, %5 : i16
    %7 = spirv.Bitcast %6 : i16 to f16
    %8 = builtin.unrealized_conversion_cast %7 : f16 to vector<1xf16>
    return %8 : vector<1xf16>
  }
}

