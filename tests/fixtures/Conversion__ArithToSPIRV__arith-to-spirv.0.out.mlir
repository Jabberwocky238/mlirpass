module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} {
  func.func @int32_scalar(%arg0: i32, %arg1: i32) {
    %0 = spirv.IAdd %arg0, %arg1 : i32
    %1 = spirv.ISub %arg0, %arg1 : i32
    %2 = spirv.IMul %arg0, %arg1 : i32
    %3 = spirv.SDiv %arg0, %arg1 : i32
    %4 = spirv.UDiv %arg0, %arg1 : i32
    %5 = spirv.UMod %arg0, %arg1 : i32
    return
  }
  func.func @int32_scalar_srem(%arg0: i32, %arg1: i32) {
    %0 = spirv.GL.SAbs %arg0 : i32
    %1 = spirv.GL.SAbs %arg1 : i32
    %2 = spirv.UMod %0, %1 : i32
    %3 = spirv.IEqual %arg0, %0 : i32
    %4 = spirv.SNegate %2 : i32
    %5 = spirv.Select %3, %2, %4 : i1, i32
    return
  }
  func.func @index_scalar(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.IAdd %1, %0 : i32
    %3 = spirv.ISub %1, %0 : i32
    %4 = spirv.IMul %1, %0 : i32
    %5 = spirv.SDiv %1, %0 : i32
    %6 = spirv.UDiv %1, %0 : i32
    %7 = spirv.UMod %1, %0 : i32
    return
  }
  func.func @index_scalar_srem(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.GL.SAbs %1 : i32
    %3 = spirv.GL.SAbs %0 : i32
    %4 = spirv.UMod %2, %3 : i32
    %5 = spirv.IEqual %1, %2 : i32
    %6 = spirv.SNegate %4 : i32
    %7 = spirv.Select %5, %4, %6 : i1, i32
    return
  }
  func.func @int32_scalar_addui_extended(%arg0: i32, %arg1: i32) -> (i32, i1) {
    %0 = spirv.IAddCarry %arg0, %arg1 : !spirv.struct<(i32, i32)>
    %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(i32, i32)>
    %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(i32, i32)>
    %cst1_i32 = spirv.Constant 1 : i32
    %3 = spirv.IEqual %2, %cst1_i32 : i32
    return %1, %3 : i32, i1
  }
  func.func @int32_vector_addui_extended(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> (vector<4xi32>, vector<4xi1>) {
    %0 = spirv.IAddCarry %arg0, %arg1 : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %cst_vec_4xi32 = spirv.Constant dense<1> : vector<4xi32>
    %3 = spirv.IEqual %2, %cst_vec_4xi32 : vector<4xi32>
    return %1, %3 : vector<4xi32>, vector<4xi1>
  }
  func.func @int32_scalar_mulsi_extended(%arg0: i32, %arg1: i32) -> (i32, i32) {
    %0 = spirv.SMulExtended %arg0, %arg1 : !spirv.struct<(i32, i32)>
    %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(i32, i32)>
    %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(i32, i32)>
    return %1, %2 : i32, i32
  }
  func.func @int32_vector_mulsi_extended(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> (vector<4xi32>, vector<4xi32>) {
    %0 = spirv.SMulExtended %arg0, %arg1 : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    return %1, %2 : vector<4xi32>, vector<4xi32>
  }
  func.func @int32_scalar_mului_extended(%arg0: i32, %arg1: i32) -> (i32, i32) {
    %0 = spirv.UMulExtended %arg0, %arg1 : !spirv.struct<(i32, i32)>
    %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(i32, i32)>
    %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(i32, i32)>
    return %1, %2 : i32, i32
  }
  func.func @int32_vector_mului_extended(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> (vector<4xi32>, vector<4xi32>) {
    %0 = spirv.UMulExtended %arg0, %arg1 : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(vector<4xi32>, vector<4xi32>)>
    return %1, %2 : vector<4xi32>, vector<4xi32>
  }
  func.func @float32_unary_scalar(%arg0: f32) {
    %0 = spirv.FNegate %arg0 : f32
    return
  }
  func.func @float32_binary_scalar(%arg0: f32, %arg1: f32) {
    %0 = spirv.FAdd %arg0, %arg1 : f32
    %1 = spirv.FSub %arg0, %arg1 : f32
    %2 = spirv.FMul %arg0, %arg1 : f32
    %3 = spirv.FDiv %arg0, %arg1 : f32
    %4 = spirv.FRem %arg0, %arg1 : f32
    return
  }
  func.func @int_vector234(%arg0: vector<2xi8>, %arg1: vector<4xi64>) {
    %0 = spirv.SDiv %arg0, %arg0 : vector<2xi8>
    %1 = spirv.UDiv %arg1, %arg1 : vector<4xi64>
    return
  }
  func.func @index_vector(%arg0: vector<4xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xindex> to vector<4xi32>
    %1 = spirv.UMod %0, %0 : vector<4xi32>
    return
  }
  func.func @vector_srem(%arg0: vector<3xi16>, %arg1: vector<3xi16>) {
    %0 = spirv.GL.SAbs %arg0 : vector<3xi16>
    %1 = spirv.GL.SAbs %arg1 : vector<3xi16>
    %2 = spirv.UMod %0, %1 : vector<3xi16>
    %3 = spirv.IEqual %arg0, %0 : vector<3xi16>
    %4 = spirv.SNegate %2 : vector<3xi16>
    %5 = spirv.Select %3, %2, %4 : vector<3xi1>, vector<3xi16>
    return
  }
  func.func @float_vector234(%arg0: vector<2xf16>, %arg1: vector<3xf64>) {
    %0 = spirv.FAdd %arg0, %arg0 : vector<2xf16>
    %1 = spirv.FMul %arg1, %arg1 : vector<3xf64>
    return
  }
  func.func @one_elem_vector(%arg0: vector<1xi32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xi32> to i32
    %1 = spirv.IAdd %0, %0 : i32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @bitwise_scalar(%arg0: i32, %arg1: i32) {
    %0 = spirv.BitwiseAnd %arg0, %arg1 : i32
    %1 = spirv.BitwiseOr %arg0, %arg1 : i32
    %2 = spirv.BitwiseXor %arg0, %arg1 : i32
    return
  }
  func.func @bitwise_vector(%arg0: vector<4xi32>, %arg1: vector<4xi32>) {
    %0 = spirv.BitwiseAnd %arg0, %arg1 : vector<4xi32>
    %1 = spirv.BitwiseOr %arg0, %arg1 : vector<4xi32>
    %2 = spirv.BitwiseXor %arg0, %arg1 : vector<4xi32>
    return
  }
  func.func @logical_scalar(%arg0: i1, %arg1: i1) {
    %0 = spirv.LogicalAnd %arg0, %arg1 : i1
    %1 = spirv.LogicalOr %arg0, %arg1 : i1
    %2 = spirv.LogicalNotEqual %arg0, %arg1 : i1
    return
  }
  func.func @logical_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) {
    %0 = spirv.LogicalAnd %arg0, %arg1 : vector<4xi1>
    %1 = spirv.LogicalOr %arg0, %arg1 : vector<4xi1>
    %2 = spirv.LogicalNotEqual %arg0, %arg1 : vector<4xi1>
    return
  }
  func.func @shift_scalar(%arg0: i32, %arg1: i32) {
    %0 = spirv.ShiftLeftLogical %arg0, %arg1 : i32, i32
    %1 = spirv.ShiftRightArithmetic %arg0, %arg1 : i32, i32
    %2 = spirv.ShiftRightLogical %arg0, %arg1 : i32, i32
    return
  }
  func.func @shift_vector(%arg0: vector<4xi32>, %arg1: vector<4xi32>) {
    %0 = spirv.ShiftLeftLogical %arg0, %arg1 : vector<4xi32>, vector<4xi32>
    %1 = spirv.ShiftRightArithmetic %arg0, %arg1 : vector<4xi32>, vector<4xi32>
    %2 = spirv.ShiftRightLogical %arg0, %arg1 : vector<4xi32>, vector<4xi32>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @cmpf(%arg0: f32, %arg1: f32) {
    %0 = spirv.FOrdEqual %arg0, %arg1 : f32
    %1 = spirv.FOrdGreaterThan %arg0, %arg1 : f32
    %2 = spirv.FOrdGreaterThanEqual %arg0, %arg1 : f32
    %3 = spirv.FOrdLessThan %arg0, %arg1 : f32
    %4 = spirv.FOrdLessThanEqual %arg0, %arg1 : f32
    %5 = spirv.FOrdNotEqual %arg0, %arg1 : f32
    %6 = spirv.FUnordEqual %arg0, %arg1 : f32
    %7 = spirv.FUnordGreaterThan %arg0, %arg1 : f32
    %8 = spirv.FUnordGreaterThanEqual %arg0, %arg1 : f32
    %9 = spirv.FUnordLessThan %arg0, %arg1 : f32
    %10 = spirv.FUnordLessThanEqual %arg0, %arg1 : f32
    %11 = spirv.FUnordNotEqual %arg0, %arg1 : f32
    return
  }
  func.func @vec1cmpf(%arg0: vector<1xf32>, %arg1: vector<1xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xf32> to f32
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %2 = spirv.FOrdGreaterThan %1, %0 : f32
    %3 = spirv.FUnordLessThan %1, %0 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} {
  func.func @cmpf(%arg0: f32, %arg1: f32) {
    %0 = spirv.Ordered %arg0, %arg1 : f32
    %1 = spirv.Unordered %arg0, %arg1 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @cmpf(%arg0: f32, %arg1: f32) {
    %0 = spirv.IsNan %arg0 : f32
    %1 = spirv.IsNan %arg1 : f32
    %2 = spirv.LogicalOr %0, %1 : i1
    %3 = spirv.LogicalNot %2 : i1
    %4 = spirv.IsNan %arg0 : f32
    %5 = spirv.IsNan %arg1 : f32
    %6 = spirv.LogicalOr %4, %5 : i1
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @cmpi(%arg0: i32, %arg1: i32) {
    %0 = spirv.IEqual %arg0, %arg1 : i32
    %1 = spirv.INotEqual %arg0, %arg1 : i32
    %2 = spirv.SLessThan %arg0, %arg1 : i32
    %3 = spirv.SLessThanEqual %arg0, %arg1 : i32
    %4 = spirv.SGreaterThan %arg0, %arg1 : i32
    %5 = spirv.SGreaterThanEqual %arg0, %arg1 : i32
    %6 = spirv.ULessThan %arg0, %arg1 : i32
    %7 = spirv.ULessThanEqual %arg0, %arg1 : i32
    %8 = spirv.UGreaterThan %arg0, %arg1 : i32
    %9 = spirv.UGreaterThanEqual %arg0, %arg1 : i32
    return
  }
  func.func @indexcmpi(%arg0: index, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.IEqual %1, %0 : i32
    %3 = spirv.INotEqual %1, %0 : i32
    %4 = spirv.SLessThan %1, %0 : i32
    %5 = spirv.SLessThanEqual %1, %0 : i32
    %6 = spirv.SGreaterThan %1, %0 : i32
    %7 = spirv.SGreaterThanEqual %1, %0 : i32
    %8 = spirv.ULessThan %1, %0 : i32
    %9 = spirv.ULessThanEqual %1, %0 : i32
    %10 = spirv.UGreaterThan %1, %0 : i32
    %11 = spirv.UGreaterThanEqual %1, %0 : i32
    return
  }
  func.func @vec1cmpi(%arg0: vector<1xi32>, %arg1: vector<1xi32>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xi32> to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xi32> to i32
    %2 = spirv.ULessThan %1, %0 : i32
    %3 = spirv.SGreaterThan %1, %0 : i32
    return
  }
  func.func @boolcmpi_equality(%arg0: i1, %arg1: i1) {
    %0 = spirv.LogicalEqual %arg0, %arg1 : i1
    %1 = spirv.LogicalNotEqual %arg0, %arg1 : i1
    return
  }
  func.func @boolcmpi_unsigned(%arg0: i1, %arg1: i1) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %0 = spirv.Select %arg0, %cst1_i32, %cst0_i32 : i1, i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32_1 = spirv.Constant 1 : i32
    %1 = spirv.Select %arg1, %cst1_i32_1, %cst0_i32_0 : i1, i32
    %2 = spirv.UGreaterThanEqual %0, %1 : i32
    %cst0_i32_2 = spirv.Constant 0 : i32
    %cst1_i32_3 = spirv.Constant 1 : i32
    %3 = spirv.Select %arg0, %cst1_i32_3, %cst0_i32_2 : i1, i32
    %cst0_i32_4 = spirv.Constant 0 : i32
    %cst1_i32_5 = spirv.Constant 1 : i32
    %4 = spirv.Select %arg1, %cst1_i32_5, %cst0_i32_4 : i1, i32
    %5 = spirv.ULessThan %3, %4 : i32
    return
  }
  func.func @vec1boolcmpi_equality(%arg0: vector<1xi1>, %arg1: vector<1xi1>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xi1> to i1
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xi1> to i1
    %2 = spirv.LogicalEqual %1, %0 : i1
    %3 = spirv.LogicalNotEqual %1, %0 : i1
    return
  }
  func.func @vec1boolcmpi_unsigned(%arg0: vector<1xi1>, %arg1: vector<1xi1>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xi1> to i1
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xi1> to i1
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.Select %1, %cst1_i32, %cst0_i32 : i1, i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32_1 = spirv.Constant 1 : i32
    %3 = spirv.Select %0, %cst1_i32_1, %cst0_i32_0 : i1, i32
    %4 = spirv.UGreaterThanEqual %2, %3 : i32
    %cst0_i32_2 = spirv.Constant 0 : i32
    %cst1_i32_3 = spirv.Constant 1 : i32
    %5 = spirv.Select %1, %cst1_i32_3, %cst0_i32_2 : i1, i32
    %cst0_i32_4 = spirv.Constant 0 : i32
    %cst1_i32_5 = spirv.Constant 1 : i32
    %6 = spirv.Select %0, %cst1_i32_5, %cst0_i32_4 : i1, i32
    %7 = spirv.ULessThan %5, %6 : i32
    return
  }
  func.func @vecboolcmpi_equality(%arg0: vector<4xi1>, %arg1: vector<4xi1>) {
    %0 = spirv.LogicalEqual %arg0, %arg1 : vector<4xi1>
    %1 = spirv.LogicalNotEqual %arg0, %arg1 : vector<4xi1>
    return
  }
  func.func @vecboolcmpi_unsigned(%arg0: vector<3xi1>, %arg1: vector<3xi1>) {
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<1> : vector<3xi32>
    %0 = spirv.Select %arg0, %cst_vec_3xi32_0, %cst_vec_3xi32 : vector<3xi1>, vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<0> : vector<3xi32>
    %cst_vec_3xi32_2 = spirv.Constant dense<1> : vector<3xi32>
    %1 = spirv.Select %arg1, %cst_vec_3xi32_2, %cst_vec_3xi32_1 : vector<3xi1>, vector<3xi32>
    %2 = spirv.UGreaterThanEqual %0, %1 : vector<3xi32>
    %cst_vec_3xi32_3 = spirv.Constant dense<0> : vector<3xi32>
    %cst_vec_3xi32_4 = spirv.Constant dense<1> : vector<3xi32>
    %3 = spirv.Select %arg0, %cst_vec_3xi32_4, %cst_vec_3xi32_3 : vector<3xi1>, vector<3xi32>
    %cst_vec_3xi32_5 = spirv.Constant dense<0> : vector<3xi32>
    %cst_vec_3xi32_6 = spirv.Constant dense<1> : vector<3xi32>
    %4 = spirv.Select %arg1, %cst_vec_3xi32_6, %cst_vec_3xi32_5 : vector<3xi1>, vector<3xi32>
    %5 = spirv.ULessThan %3, %4 : vector<3xi32>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} {
  func.func @constant() {
    %true = spirv.Constant true
    %cst42_i32 = spirv.Constant 42 : i32
    %cst_f32 = spirv.Constant 5.000000e-01 : f32
    %cst_vec_2xi32 = spirv.Constant dense<[2, 3]> : vector<2xi32>
    %cst1_i32 = spirv.Constant 1 : i32
    %cst = spirv.Constant dense<1> : tensor<6xi32> : !spirv.array<6 x i32>
    %cst_0 = spirv.Constant dense<1.000000e+00> : tensor<6xf32> : !spirv.array<6 x f32>
    %cst_1 = spirv.Constant dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00, 5.000000e+00, 6.000000e+00]> : tensor<6xf32> : !spirv.array<6 x f32>
    %cst_2 = spirv.Constant dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32> : !spirv.array<6 x i32>
    %cst_3 = spirv.Constant dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32> : !spirv.array<6 x i32>
    %cst_4 = spirv.Constant dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32> : !spirv.array<6 x i32>
    return
  }
  func.func @constant_8bit_float() {
    %cst56_i8 = spirv.Constant 56 : i8
    %cst56_i8_0 = spirv.Constant 56 : i8
    %cst_vec_4xi8 = spirv.Constant dense<56> : vector<4xi8>
    %cst_vec_4xi8_1 = spirv.Constant dense<56> : vector<4xi8>
    %cst = spirv.Constant dense<60> : tensor<4xi8> : !spirv.array<4 x i8>
    %cst_2 = spirv.Constant dense<60> : tensor<4xi8> : !spirv.array<4 x i8>
    return
  }
  func.func @constant_16bit() {
    %cst4_i16 = spirv.Constant 4 : i16
    %cst_f16 = spirv.Constant 5.000000e+00 : f16
    %cst_vec_2xi16 = spirv.Constant dense<[2, 3]> : vector<2xi16>
    %cst = spirv.Constant dense<4.000000e+00> : tensor<5xf16> : !spirv.array<5 x f16>
    return
  }
  func.func @constant_64bit() {
    %cst4_i64 = spirv.Constant 4 : i64
    %cst_f64 = spirv.Constant 5.000000e+00 : f64
    %cst_vec_2xi64 = spirv.Constant dense<[2, 3]> : vector<2xi64>
    %cst = spirv.Constant dense<4.000000e+00> : tensor<5xf64> : !spirv.array<5 x f64>
    return
  }
  func.func @constant_size1() {
    %true = spirv.Constant true
    %cst4_i64 = spirv.Constant 4 : i64
    %cst_f64 = spirv.Constant 5.000000e+00 : f64
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @constant_16bit() {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst_f32 = spirv.Constant 5.000000e+00 : f32
    %cst_vec_2xi32 = spirv.Constant dense<[2, 3]> : vector<2xi32>
    %cst = spirv.Constant dense<4.000000e+00> : tensor<5xf32> : !spirv.array<5 x f32>
    %cst_0 = spirv.Constant dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : tensor<4xf32> : !spirv.array<4 x f32>
    return
  }
  func.func @constant_size1() {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst_f32 = spirv.Constant 5.000000e+00 : f32
    return
  }
  func.func @corner_cases() {
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst-2_i32 = spirv.Constant -2 : i32
    %cst-1_i32_0 = spirv.Constant -1 : i32
    %cst-2_i32_1 = spirv.Constant -2 : i32
    %false = spirv.Constant false
    %true = spirv.Constant true
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} {
  func.func @index_cast1(%arg0: i16) {
    %0 = spirv.SConvert %arg0 : i16 to i32
    return
  }
  func.func @index_cast2(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %1 = spirv.SConvert %0 : i32 to i16
    return
  }
  func.func @index_cast3(%arg0: i32) {
    return
  }
  func.func @index_cast4(%arg0: index) {
    return
  }
  func.func @index_castui1(%arg0: i16) {
    %0 = spirv.UConvert %arg0 : i16 to i32
    return
  }
  func.func @index_castui2(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %1 = spirv.UConvert %0 : i32 to i16
    return
  }
  func.func @index_castui3(%arg0: i32) {
    return
  }
  func.func @index_castui4(%arg0: index) {
    return
  }
  func.func @index_castindexi1_1(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.INotEqual %cst0_i32, %0 : i32
    return
  }
  func.func @index_castindexi1_2(%arg0: vector<1xindex>) -> vector<1xi1> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xindex> to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.INotEqual %cst0_i32, %0 : i32
    %2 = builtin.unrealized_conversion_cast %1 : i1 to vector<1xi1>
    return %2 : vector<1xi1>
  }
  func.func @index_castindexi1_3(%arg0: vector<3xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3xindex> to vector<3xi32>
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    %1 = spirv.INotEqual %cst_vec_3xi32, %0 : vector<3xi32>
    return
  }
  func.func @index_casti1index_1(%arg0: i1) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %0 = spirv.Select %arg0, %cst1_i32, %cst0_i32 : i1, i32
    return
  }
  func.func @index_casti1index_2(%arg0: vector<1xi1>) -> vector<1xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xi1> to i1
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %1 = spirv.Select %0, %cst1_i32, %cst0_i32 : i1, i32
    %2 = builtin.unrealized_conversion_cast %1 : i32 to vector<1xindex>
    return %2 : vector<1xindex>
  }
  func.func @index_casti1index_3(%arg0: vector<3xi1>) {
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<1> : vector<3xi32>
    %0 = spirv.Select %arg0, %cst_vec_3xi32_0, %cst_vec_3xi32 : vector<3xi1>, vector<3xi32>
    return
  }
  func.func @bit_cast(%arg0: vector<2xf32>, %arg1: i64) {
    %0 = spirv.Bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %1 = spirv.Bitcast %arg1 : i64 to f64
    return
  }
  func.func @fpext1(%arg0: f16) -> f64 {
    %0 = spirv.FConvert %arg0 : f16 to f64
    return %0 : f64
  }
  func.func @fpext2(%arg0: f32) -> f64 {
    %0 = spirv.FConvert %arg0 : f32 to f64
    return %0 : f64
  }
  func.func @fptrunc1(%arg0: f64) -> f16 {
    %0 = spirv.FConvert %arg0 : f64 to f16
    return %0 : f16
  }
  func.func @fptrunc2(%arg0: f32) -> f16 {
    %0 = spirv.FConvert %arg0 : f32 to f16
    return %0 : f16
  }
  func.func @experimental_constrained_fptrunc(%arg0: f64) {
    %0 = spirv.FConvert %arg0 {fp_rounding_mode = #spirv.fp_rounding_mode<RTE>} : f64 to f32
    %1 = spirv.FConvert %arg0 {fp_rounding_mode = #spirv.fp_rounding_mode<RTN>} : f64 to f32
    %2 = spirv.FConvert %arg0 {fp_rounding_mode = #spirv.fp_rounding_mode<RTP>} : f64 to f32
    %3 = spirv.FConvert %arg0 {fp_rounding_mode = #spirv.fp_rounding_mode<RTZ>} : f64 to f32
    return
  }
  func.func @sitofp1(%arg0: i32) -> f32 {
    %0 = spirv.ConvertSToF %arg0 : i32 to f32
    return %0 : f32
  }
  func.func @sitofp2(%arg0: i64) -> f64 {
    %0 = spirv.ConvertSToF %arg0 : i64 to f64
    return %0 : f64
  }
  func.func @uitofp_i16_f32(%arg0: i16) -> f32 {
    %0 = spirv.ConvertUToF %arg0 : i16 to f32
    return %0 : f32
  }
  func.func @uitofp_i32_f32(%arg0: i32) -> f32 {
    %0 = spirv.ConvertUToF %arg0 : i32 to f32
    return %0 : f32
  }
  func.func @uitofp_i1_f32(%arg0: i1) -> f32 {
    %cst_f32 = spirv.Constant 0.000000e+00 : f32
    %cst_f32_0 = spirv.Constant 1.000000e+00 : f32
    %0 = spirv.Select %arg0, %cst_f32_0, %cst_f32 : i1, f32
    return %0 : f32
  }
  func.func @uitofp_i1_f64(%arg0: i1) -> f64 {
    %cst_f64 = spirv.Constant 0.000000e+00 : f64
    %cst_f64_0 = spirv.Constant 1.000000e+00 : f64
    %0 = spirv.Select %arg0, %cst_f64_0, %cst_f64 : i1, f64
    return %0 : f64
  }
  func.func @uitofp_vec_i1_f32(%arg0: vector<4xi1>) -> vector<4xf32> {
    %cst_vec_4xf32 = spirv.Constant dense<0.000000e+00> : vector<4xf32>
    %cst_vec_4xf32_0 = spirv.Constant dense<1.000000e+00> : vector<4xf32>
    %0 = spirv.Select %arg0, %cst_vec_4xf32_0, %cst_vec_4xf32 : vector<4xi1>, vector<4xf32>
    return %0 : vector<4xf32>
  }
  spirv.func @uitofp_vec_i1_f64(%arg0: vector<4xi1>) -> vector<4xf64> "None" {
    %cst_vec_4xf64 = spirv.Constant dense<0.000000e+00> : vector<4xf64>
    %cst_vec_4xf64_0 = spirv.Constant dense<1.000000e+00> : vector<4xf64>
    %0 = spirv.Select %arg0, %cst_vec_4xf64_0, %cst_vec_4xf64 : vector<4xi1>, vector<4xf64>
    spirv.ReturnValue %0 : vector<4xf64>
  }
  func.func @sexti1(%arg0: i16) -> i64 {
    %0 = spirv.SConvert %arg0 : i16 to i64
    return %0 : i64
  }
  func.func @sexti2(%arg0: i32) -> i64 {
    %0 = spirv.SConvert %arg0 : i32 to i64
    return %0 : i64
  }
  func.func @sext_bool_scalar(%arg0: i1) -> i32 {
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.Select %arg0, %cst-1_i32, %cst0_i32 : i1, i32
    return %0 : i32
  }
  func.func @sext_bool_vector(%arg0: vector<3xi1>) -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<-1> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<0> : vector<3xi32>
    %0 = spirv.Select %arg0, %cst_vec_3xi32, %cst_vec_3xi32_0 : vector<3xi1>, vector<3xi32>
    return %0 : vector<3xi32>
  }
  func.func @zexti1(%arg0: i16) -> i64 {
    %0 = spirv.UConvert %arg0 : i16 to i64
    return %0 : i64
  }
  func.func @zexti2(%arg0: i32) -> i64 {
    %0 = spirv.UConvert %arg0 : i32 to i64
    return %0 : i64
  }
  func.func @zexti3(%arg0: i1) -> i32 {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %0 = spirv.Select %arg0, %cst1_i32, %cst0_i32 : i1, i32
    return %0 : i32
  }
  func.func @zexti4(%arg0: vector<4xi1>) -> vector<4xi32> {
    %cst_vec_4xi32 = spirv.Constant dense<0> : vector<4xi32>
    %cst_vec_4xi32_0 = spirv.Constant dense<1> : vector<4xi32>
    %0 = spirv.Select %arg0, %cst_vec_4xi32_0, %cst_vec_4xi32 : vector<4xi1>, vector<4xi32>
    return %0 : vector<4xi32>
  }
  func.func @zexti5(%arg0: vector<4xi1>) -> vector<4xi64> {
    %cst_vec_4xi64 = spirv.Constant dense<0> : vector<4xi64>
    %cst_vec_4xi64_0 = spirv.Constant dense<1> : vector<4xi64>
    %0 = spirv.Select %arg0, %cst_vec_4xi64_0, %cst_vec_4xi64 : vector<4xi1>, vector<4xi64>
    return %0 : vector<4xi64>
  }
  func.func @trunci1(%arg0: i64) -> i16 {
    %0 = spirv.SConvert %arg0 : i64 to i16
    return %0 : i16
  }
  func.func @trunci2(%arg0: i32) -> i16 {
    %0 = spirv.SConvert %arg0 : i32 to i16
    return %0 : i16
  }
  func.func @trunc_to_i1(%arg0: i32) -> i1 {
    %cst1_i32 = spirv.Constant 1 : i32
    %0 = spirv.BitwiseAnd %arg0, %cst1_i32 : i32
    %1 = spirv.IEqual %0, %cst1_i32 : i32
    %false = spirv.Constant false
    %true = spirv.Constant true
    %2 = spirv.Select %1, %true, %false : i1, i1
    return %2 : i1
  }
  func.func @trunc_to_veci1(%arg0: vector<4xi32>) -> vector<4xi1> {
    %cst_vec_4xi32 = spirv.Constant dense<1> : vector<4xi32>
    %0 = spirv.BitwiseAnd %arg0, %cst_vec_4xi32 : vector<4xi32>
    %1 = spirv.IEqual %0, %cst_vec_4xi32 : vector<4xi32>
    %cst_vec_4xi1 = spirv.Constant dense<false> : vector<4xi1>
    %cst_vec_4xi1_0 = spirv.Constant dense<true> : vector<4xi1>
    %2 = spirv.Select %1, %cst_vec_4xi1_0, %cst_vec_4xi1 : vector<4xi1>, vector<4xi1>
    return %2 : vector<4xi1>
  }
  func.func @fptoui1(%arg0: f32) -> i32 {
    %0 = spirv.ConvertFToU %arg0 : f32 to i32
    return %0 : i32
  }
  func.func @fptoui2(%arg0: f16) -> i16 {
    %0 = spirv.ConvertFToU %arg0 : f16 to i16
    return %0 : i16
  }
  func.func @fptosi1(%arg0: f32) -> i32 {
    %0 = spirv.ConvertFToS %arg0 : f32 to i32
    return %0 : i32
  }
  func.func @fptosi2(%arg0: f16) -> i16 {
    %0 = spirv.ConvertFToS %arg0 : f16 to i16
    return %0 : i16
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float64], []>, #spirv.resource_limits<>>} {
  func.func @fpext1(%arg0: f16) -> f64 {
    %0 = builtin.unrealized_conversion_cast %arg0 : f16 to f32
    %1 = spirv.FConvert %0 : f32 to f64
    return %1 : f64
  }
  func.func @fpext2(%arg0: f32) -> f64 {
    %0 = spirv.FConvert %arg0 : f32 to f64
    return %0 : f64
  }
  func.func @trunci4_scalar(%arg0: i32) -> i4 {
    %cst15_i32 = spirv.Constant 15 : i32
    %0 = spirv.BitwiseAnd %arg0, %cst15_i32 : i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to i4
    return %1 : i4
  }
  func.func @trunci4_vector(%arg0: vector<2xi32>) -> vector<2xi4> {
    %cst_vec_2xi32 = spirv.Constant dense<15> : vector<2xi32>
    %0 = spirv.BitwiseAnd %arg0, %cst_vec_2xi32 : vector<2xi32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<2xi32> to vector<2xi4>
    return %1 : vector<2xi4>
  }
  func.func @zexti4_scalar(%arg0: i4) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : i4 to i32
    %cst15_i32 = spirv.Constant 15 : i32
    %1 = spirv.BitwiseAnd %0, %cst15_i32 : i32
    return %1 : i32
  }
  func.func @zexti4_vector(%arg0: vector<3xi4>) -> vector<3xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3xi4> to vector<3xi32>
    %cst_vec_3xi32 = spirv.Constant dense<15> : vector<3xi32>
    %1 = spirv.BitwiseAnd %0, %cst_vec_3xi32 : vector<3xi32>
    return %1 : vector<3xi32>
  }
  func.func @sexti4_scalar(%arg0: i4) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : i4 to i32
    %cst28_i32 = spirv.Constant 28 : i32
    %1 = spirv.ShiftLeftLogical %0, %cst28_i32 : i32, i32
    %2 = spirv.ShiftRightArithmetic %1, %cst28_i32 : i32, i32
    return %2 : i32
  }
  func.func @sexti4_vector(%arg0: vector<4xi4>) -> vector<4xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xi4> to vector<4xi32>
    %cst_vec_4xi32 = spirv.Constant dense<28> : vector<4xi32>
    %1 = spirv.ShiftLeftLogical %0, %cst_vec_4xi32 : vector<4xi32>, vector<4xi32>
    %2 = spirv.ShiftRightArithmetic %1, %cst_vec_4xi32 : vector<4xi32>, vector<4xi32>
    return %2 : vector<4xi32>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16], []>, #spirv.resource_limits<>>} {
  func.func @fptrunc1(%arg0: f32) -> f16 {
    %0 = spirv.FConvert %arg0 : f32 to f16
    return %0 : f16
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int16, Kernel], []>, #spirv.resource_limits<>>} {
  func.func @int32_scalar(%arg0: i32, %arg1: i32) {
    %0 = spirv.IAdd %arg0, %arg1 : i32
    %1 = spirv.ISub %arg0, %arg1 : i32
    %2 = spirv.IMul %arg0, %arg1 : i32
    %3 = spirv.SDiv %arg0, %arg1 : i32
    %4 = spirv.UDiv %arg0, %arg1 : i32
    %5 = spirv.UMod %arg0, %arg1 : i32
    %6 = spirv.CL.s_max %arg0, %arg1 : i32
    %7 = spirv.CL.u_max %arg0, %arg1 : i32
    %8 = spirv.CL.s_min %arg0, %arg1 : i32
    %9 = spirv.CL.u_min %arg0, %arg1 : i32
    return
  }
  func.func @float32_binary_scalar(%arg0: f32, %arg1: f32) {
    %0 = spirv.FAdd %arg0, %arg1 : f32
    %1 = spirv.FSub %arg0, %arg1 : f32
    %2 = spirv.FMul %arg0, %arg1 : f32
    %3 = spirv.FDiv %arg0, %arg1 : f32
    %4 = spirv.FRem %arg0, %arg1 : f32
    return
  }
  func.func @float32_minimumf_scalar(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.CL.fmin %arg0, %arg1 : f32
    %1 = spirv.IsNan %arg0 : f32
    %2 = spirv.IsNan %arg1 : f32
    %3 = spirv.Select %1, %arg0, %0 : i1, f32
    %4 = spirv.Select %2, %arg1, %3 : i1, f32
    return %4 : f32
  }
  func.func @float32_minnumf_scalar(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.CL.fmin %arg0, %arg1 : f32
    return %0 : f32
  }
  func.func @float32_maximumf_scalar(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = spirv.CL.fmax %arg0, %arg1 : vector<2xf32>
    %1 = spirv.IsNan %arg0 : vector<2xf32>
    %2 = spirv.IsNan %arg1 : vector<2xf32>
    %3 = spirv.Select %1, %arg0, %0 : vector<2xi1>, vector<2xf32>
    %4 = spirv.Select %2, %arg1, %3 : vector<2xi1>, vector<2xf32>
    return %4 : vector<2xf32>
  }
  func.func @float32_maxnumf_scalar(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = spirv.CL.fmax %arg0, %arg1 : vector<2xf32>
    return %0 : vector<2xf32>
  }
  func.func @scalar_srem(%arg0: i32, %arg1: i32) {
    %0 = spirv.CL.s_abs %arg0 : i32
    %1 = spirv.CL.s_abs %arg1 : i32
    %2 = spirv.UMod %0, %1 : i32
    %3 = spirv.IEqual %arg0, %0 : i32
    %4 = spirv.SNegate %2 : i32
    %5 = spirv.Select %3, %2, %4 : i1, i32
    return
  }
  func.func @vector_srem(%arg0: vector<3xi16>, %arg1: vector<3xi16>) {
    %0 = spirv.CL.s_abs %arg0 : vector<3xi16>
    %1 = spirv.CL.s_abs %arg1 : vector<3xi16>
    %2 = spirv.UMod %0, %1 : vector<3xi16>
    %3 = spirv.IEqual %arg0, %0 : vector<3xi16>
    %4 = spirv.SNegate %2 : vector<3xi16>
    %5 = spirv.Select %3, %2, %4 : vector<3xi1>, vector<3xi16>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int8, Int16, Int64, Float16, Float64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @select(%arg0: i32, %arg1: i32) {
    %0 = spirv.SLessThanEqual %arg0, %arg1 : i32
    %1 = spirv.Select %0, %arg0, %arg1 : i1, i32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} {
  func.func @int32_scalar(%arg0: i32, %arg1: i32) {
    %0 = spirv.IAdd %arg0, %arg1 : i32
    %1 = spirv.ISub %arg0, %arg1 : i32
    %2 = spirv.IMul %arg0, %arg1 : i32
    %3 = spirv.SDiv %arg0, %arg1 : i32
    %4 = spirv.UDiv %arg0, %arg1 : i32
    %5 = spirv.UMod %arg0, %arg1 : i32
    %6 = spirv.GL.SMax %arg0, %arg1 : i32
    %7 = spirv.GL.UMax %arg0, %arg1 : i32
    %8 = spirv.GL.SMin %arg0, %arg1 : i32
    %9 = spirv.GL.UMin %arg0, %arg1 : i32
    return
  }
  func.func @scalar_srem(%arg0: i32, %arg1: i32) {
    %0 = spirv.GL.SAbs %arg0 : i32
    %1 = spirv.GL.SAbs %arg1 : i32
    %2 = spirv.UMod %0, %1 : i32
    %3 = spirv.IEqual %arg0, %0 : i32
    %4 = spirv.SNegate %2 : i32
    %5 = spirv.Select %3, %2, %4 : i1, i32
    return
  }
  func.func @float32_unary_scalar(%arg0: f32) {
    %0 = spirv.FNegate %arg0 : f32
    return
  }
  func.func @float32_binary_scalar(%arg0: f32, %arg1: f32) {
    %0 = spirv.FAdd %arg0, %arg1 : f32
    %1 = spirv.FSub %arg0, %arg1 : f32
    %2 = spirv.FMul %arg0, %arg1 : f32
    %3 = spirv.FDiv %arg0, %arg1 : f32
    %4 = spirv.FRem %arg0, %arg1 : f32
    return
  }
  func.func @float32_minimumf_scalar(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.GL.FMin %arg0, %arg1 : f32
    %1 = spirv.IsNan %arg0 : f32
    %2 = spirv.IsNan %arg1 : f32
    %3 = spirv.Select %1, %arg0, %0 : i1, f32
    %4 = spirv.Select %2, %arg1, %3 : i1, f32
    return %4 : f32
  }
  func.func @float32_minnumf_scalar(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.GL.FMin %arg0, %arg1 : f32
    %1 = spirv.IsNan %arg0 : f32
    %2 = spirv.IsNan %arg1 : f32
    %3 = spirv.Select %1, %arg1, %0 : i1, f32
    %4 = spirv.Select %2, %arg0, %3 : i1, f32
    return %4 : f32
  }
  func.func @float32_maximumf_scalar(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = spirv.GL.FMax %arg0, %arg1 : vector<2xf32>
    %1 = spirv.IsNan %arg0 : vector<2xf32>
    %2 = spirv.IsNan %arg1 : vector<2xf32>
    %3 = spirv.Select %1, %arg0, %0 : vector<2xi1>, vector<2xf32>
    %4 = spirv.Select %2, %arg1, %3 : vector<2xi1>, vector<2xf32>
    return %4 : vector<2xf32>
  }
  func.func @float32_maxnumf_scalar(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = spirv.GL.FMax %arg0, %arg1 : vector<2xf32>
    %1 = spirv.IsNan %arg0 : vector<2xf32>
    %2 = spirv.IsNan %arg1 : vector<2xf32>
    %3 = spirv.Select %1, %arg1, %0 : vector<2xi1>, vector<2xf32>
    %4 = spirv.Select %2, %arg0, %3 : vector<2xi1>, vector<2xf32>
    return %4 : vector<2xf32>
  }
  func.func @int_vector234(%arg0: vector<2xi8>, %arg1: vector<4xi64>) {
    %0 = spirv.SDiv %arg0, %arg0 : vector<2xi8>
    %1 = spirv.UDiv %arg1, %arg1 : vector<4xi64>
    return
  }
  func.func @vector_srem(%arg0: vector<3xi16>, %arg1: vector<3xi16>) {
    %0 = spirv.GL.SAbs %arg0 : vector<3xi16>
    %1 = spirv.GL.SAbs %arg1 : vector<3xi16>
    %2 = spirv.UMod %0, %1 : vector<3xi16>
    %3 = spirv.IEqual %arg0, %0 : vector<3xi16>
    %4 = spirv.SNegate %2 : vector<3xi16>
    %5 = spirv.Select %3, %2, %4 : vector<3xi1>, vector<3xi16>
    return
  }
  func.func @float_vector234(%arg0: vector<2xf16>, %arg1: vector<3xf64>) {
    %0 = spirv.FAdd %arg0, %arg0 : vector<2xf16>
    %1 = spirv.FMul %arg1, %arg1 : vector<3xf64>
    return
  }
  func.func @one_elem_vector(%arg0: vector<1xi32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xi32> to i32
    %1 = spirv.IAdd %0, %0 : i32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @int_vector23(%arg0: vector<2xi8>, %arg1: vector<3xi16>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<3xi16> to vector<3xi32>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<2xi8> to vector<2xi32>
    %2 = spirv.SDiv %1, %1 : vector<2xi32>
    %3 = spirv.SDiv %0, %0 : vector<3xi32>
    return
  }
  func.func @float_scalar(%arg0: f16) {
    %0 = builtin.unrealized_conversion_cast %arg0 : f16 to f32
    %1 = spirv.FAdd %0, %0 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Kernel], [SPV_KHR_no_integer_wrap_decoration]>, #spirv.resource_limits<>>} {
  func.func @ops_flags(%arg0: i64, %arg1: i64) {
    %0 = spirv.IAdd %arg0, %arg1 {no_signed_wrap} : i64
    %1 = spirv.ISub %arg0, %arg1 {no_unsigned_wrap} : i64
    %2 = spirv.IMul %arg0, %arg1 {no_signed_wrap, no_unsigned_wrap} : i64
    %3 = spirv.ShiftLeftLogical %arg0, %arg1 {no_signed_wrap, no_unsigned_wrap} : i64, i64
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} {
  func.func @ops_flags(%arg0: i64, %arg1: i64) {
    %0 = spirv.IAdd %arg0, %arg1 : i64
    %1 = spirv.ISub %arg0, %arg1 : i64
    %2 = spirv.IMul %arg0, %arg1 : i64
    %3 = spirv.IMul %arg0, %arg1 : i64
    return
  }
}

