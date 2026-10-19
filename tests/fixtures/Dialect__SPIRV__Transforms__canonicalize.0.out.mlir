module {
  func.func @combine_full_access_chain() -> f32 {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32, i32, i32 -> !spirv.ptr<f32, Function>
    %2 = spirv.Load "Function" %1 : f32
    spirv.ReturnValue %2 : f32
  }
}

// -----
module {
  func.func @combine_access_chain_multi_use() -> !spirv.array<4 x f32> {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32, i32 -> !spirv.ptr<!spirv.array<4 x f32>, Function>
    %2 = spirv.AccessChain %0[%cst0_i32, %cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32, i32, i32 -> !spirv.ptr<f32, Function>
    %3 = spirv.Load "Function" %1 : !spirv.array<4 x f32>
    %4 = spirv.Load "Function" %2 : f32
    spirv.ReturnValue %3 : !spirv.array<4 x f32>
  }
}

// -----
module {
  func.func @dont_combine_access_chain_without_common_base() -> !spirv.array<4 x i32> {
    %cst1_i32 = spirv.Constant 1 : i32
    %0 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %1 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>
    %2 = spirv.AccessChain %0[%cst1_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32 -> !spirv.ptr<!spirv.array<4 x i32>, Function>
    %3 = spirv.AccessChain %1[%cst1_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x !spirv.array<4 x f32>>, !spirv.array<4 x i32>)>, Function>, i32 -> !spirv.ptr<!spirv.array<4 x i32>, Function>
    %4 = spirv.Load "Function" %2 : !spirv.array<4 x i32>
    %5 = spirv.Load "Function" %3 : !spirv.array<4 x i32>
    spirv.ReturnValue %4 : !spirv.array<4 x i32>
  }
}

// -----
module {
  func.func @convert_bitcast_full(%arg0: vector<2xf32>) -> f64 {
    %0 = spirv.Bitcast %arg0 : vector<2xf32> to f64
    spirv.ReturnValue %0 : f64
  }
}

// -----
module {
  func.func @convert_bitcast_multi_use(%arg0: vector<2xf32>, %arg1: !spirv.ptr<i64, Uniform>) -> f64 {
    %0 = spirv.Bitcast %arg0 : vector<2xf32> to i64
    %1 = spirv.Bitcast %arg0 : vector<2xf32> to f64
    spirv.Store "Uniform" %arg1, %0 : i64
    spirv.ReturnValue %1 : f64
  }
}

// -----
module {
  func.func @convert_bitcast_roundtip(%arg0: i64) -> i64 {
    spirv.ReturnValue %arg0 : i64
  }
}

// -----
module {
  func.func @convert_bitcast_chained_roundtip(%arg0: i64) -> i64 {
    spirv.ReturnValue %arg0 : i64
  }
}

// -----
module {
  func.func @extract_vector() -> (i32, i32, i32) {
    %cst42_i32 = spirv.Constant 42 : i32
    %cst-33_i32 = spirv.Constant -33 : i32
    %cst6_i32 = spirv.Constant 6 : i32
    return %cst42_i32, %cst-33_i32, %cst6_i32 : i32, i32, i32
  }
}

// -----
module {
  func.func @extract_array_final() -> (i32, i32) {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst-5_i32 = spirv.Constant -5 : i32
    return %cst4_i32, %cst-5_i32 : i32, i32
  }
}

// -----
module {
  func.func @extract_array_interm() -> vector<2xi32> {
    %cst_vec_2xi32 = spirv.Constant dense<[4, -5]> : vector<2xi32>
    return %cst_vec_2xi32 : vector<2xi32>
  }
}

// -----
module {
  func.func @extract_from_not_constant() -> i32 {
    %0 = spirv.Variable : !spirv.ptr<vector<3xi32>, Function>
    %1 = spirv.Load "Function" %0 : vector<3xi32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<3xi32>
    spirv.ReturnValue %2 : i32
  }
}

// -----
module {
  func.func @extract_insert(%arg0: !spirv.array<1 x vector<2xf32>>, %arg1: f32) -> (f32, f32) {
    %0 = spirv.CompositeInsert %arg1, %arg0[0 : i32, 1 : i32] : f32 into !spirv.array<1 x vector<2xf32>>
    %1 = spirv.CompositeExtract %0[0 : i32, 0 : i32] : !spirv.array<1 x vector<2xf32>>
    return %1, %arg1 : f32, f32
  }
}

// -----
module {
  func.func @extract_construct(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> (vector<2xf32>, vector<2xf32>) {
    return %arg0, %arg1 : vector<2xf32>, vector<2xf32>
  }
}

// -----
module {
  func.func @fold_composite_op(%arg0: !spirv.struct<(f32, f32)>, %arg1: f32, %arg2: f32) -> f32 {
    return %arg1 : f32
  }
}

// -----
module {
  func.func @fold_composite_op(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    return %arg0 : f32
  }
}

// -----
module {
  func.func @extract_construct(%arg0: vector<3xf32>, %arg1: f32) -> (f32, f32) {
    %0 = spirv.CompositeConstruct %arg0, %arg1 : (vector<3xf32>, f32) -> vector<4xf32>
    %1 = spirv.CompositeExtract %0[0 : i32] : vector<4xf32>
    %2 = spirv.CompositeExtract %0[1 : i32] : vector<4xf32>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func @deduplicate_scalar_constant() -> (i32, i32) {
    %cst42_i32 = spirv.Constant 42 : i32
    return %cst42_i32, %cst42_i32 : i32, i32
  }
}

// -----
module {
  func.func @deduplicate_vector_constant() -> (vector<3xi32>, vector<3xi32>) {
    %cst_vec_3xi32 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    return %cst_vec_3xi32, %cst_vec_3xi32 : vector<3xi32>, vector<3xi32>
  }
}

// -----
module {
  func.func @deduplicate_composite_constant() -> (!spirv.array<1 x vector<2xi32>>, !spirv.array<1 x vector<2xi32>>) {
    %cst = spirv.Constant [dense<5> : vector<2xi32>] : !spirv.array<1 x vector<2xi32>>
    return %cst, %cst : !spirv.array<1 x vector<2xi32>>, !spirv.array<1 x vector<2xi32>>
  }
}

// -----
module {
  func.func @iadd_zero(%arg0: i32) -> (i32, i32) {
    return %arg0, %arg0 : i32, i32
  }
  func.func @const_fold_scalar_iadd_normal() -> (i32, i32, i32) {
    %cst10_i32 = spirv.Constant 10 : i32
    %cst-16_i32 = spirv.Constant -16 : i32
    %cst-3_i32 = spirv.Constant -3 : i32
    return %cst10_i32, %cst-16_i32, %cst-3_i32 : i32, i32, i32
  }
  func.func @const_fold_scalar_iadd_flow() -> (i32, i32, i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    %cst2147483646_i32 = spirv.Constant 2147483646 : i32
    return %cst0_i32, %cst1_i32, %cst2147483647_i32, %cst2147483646_i32 : i32, i32, i32, i32
  }
  func.func @const_fold_vector_iadd() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[39, -70, 155]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
  func.func @iadd_poison(%arg0: i32) -> i32 {
    %0 = ub.poison : i32
    return %0 : i32
  }
}

// -----
module {
  func.func @iaddcarry_x_0(%arg0: i32) -> !spirv.struct<(i32, i32)> {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.CompositeConstruct %cst0_i32, %arg0 : (i32, i32) -> !spirv.struct<(i32, i32)>
    return %0 : !spirv.struct<(i32, i32)>
  }
  func.func @const_fold_scalar_iaddcarry() -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) {
    %cst1_i32 = spirv.Constant 1 : i32
    %cst-13_i32 = spirv.Constant -13 : i32
    %cst-3_i32 = spirv.Constant -3 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.Undef : !spirv.struct<(i32, i32)>
    %1 = spirv.CompositeInsert %cst-3_i32, %0[0 : i32] : i32 into !spirv.struct<(i32, i32)>
    %2 = spirv.CompositeInsert %cst0_i32, %1[1 : i32] : i32 into !spirv.struct<(i32, i32)>
    %3 = spirv.Undef : !spirv.struct<(i32, i32)>
    %4 = spirv.CompositeInsert %cst-13_i32, %3[0 : i32] : i32 into !spirv.struct<(i32, i32)>
    %5 = spirv.CompositeInsert %cst1_i32, %4[1 : i32] : i32 into !spirv.struct<(i32, i32)>
    return %2, %5 : !spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>
  }
  func.func @const_fold_vector_iaddcarry() -> !spirv.struct<(vector<3xi32>, vector<3xi32>)> {
    %cst_vec_3xi32 = spirv.Constant dense<[-3, -11, 0]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[0, 1, 1]> : vector<3xi32>
    %0 = spirv.Undef : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %1 = spirv.CompositeInsert %cst_vec_3xi32, %0[0 : i32] : vector<3xi32> into !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %2 = spirv.CompositeInsert %cst_vec_3xi32_0, %1[1 : i32] : vector<3xi32> into !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    return %2 : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
  }
}

// -----
module {
  func.func @imul_zero_one(%arg0: i32) -> (i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    return %cst0_i32, %arg0 : i32, i32
  }
  func.func @const_fold_scalar_imul_normal() -> (i32, i32, i32) {
    %cst35_i32 = spirv.Constant 35 : i32
    %cst-40_i32 = spirv.Constant -40 : i32
    %cst-56_i32 = spirv.Constant -56 : i32
    return %cst35_i32, %cst-40_i32, %cst-56_i32 : i32, i32, i32
  }
  func.func @const_fold_scalar_imul_flow() -> (i32, i32, i32) {
    %cst-2_i32 = spirv.Constant -2 : i32
    %cst-4_i32 = spirv.Constant -4 : i32
    return %cst-2_i32, %cst-2_i32, %cst-4_i32 : i32, i32, i32
  }
  func.func @const_fold_vector_imul() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[-126, 825, 3556]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @smulextended_x_0(%arg0: i32) -> !spirv.struct<(i32, i32)> {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.CompositeConstruct %cst0_i32, %cst0_i32 : (i32, i32) -> !spirv.struct<(i32, i32)>
    return %0 : !spirv.struct<(i32, i32)>
  }
  func.func @const_fold_scalar_smulextended() -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst40_i32 = spirv.Constant 40 : i32
    %cst-40_i32 = spirv.Constant -40 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %0 = spirv.Undef : !spirv.struct<(i32, i32)>
    %1 = spirv.CompositeInsert %cst-40_i32, %0[0 : i32] : i32 into !spirv.struct<(i32, i32)>
    %2 = spirv.CompositeInsert %cst-1_i32, %1[1 : i32] : i32 into !spirv.struct<(i32, i32)>
    %3 = spirv.Undef : !spirv.struct<(i32, i32)>
    %4 = spirv.CompositeInsert %cst40_i32, %3[0 : i32] : i32 into !spirv.struct<(i32, i32)>
    %5 = spirv.CompositeInsert %cst0_i32, %4[1 : i32] : i32 into !spirv.struct<(i32, i32)>
    return %2, %5 : !spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>
  }
  func.func @const_fold_vector_smulextended() -> !spirv.struct<(vector<3xi32>, vector<3xi32>)> {
    %cst_vec_3xi32 = spirv.Constant dense<[2147483643, 40, -1]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[2, 0, -1]> : vector<3xi32>
    %0 = spirv.Undef : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %1 = spirv.CompositeInsert %cst_vec_3xi32, %0[0 : i32] : vector<3xi32> into !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %2 = spirv.CompositeInsert %cst_vec_3xi32_0, %1[1 : i32] : vector<3xi32> into !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    return %2 : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
  }
}

// -----
module {
  func.func @umulextended_x_0(%arg0: i32) -> !spirv.struct<(i32, i32)> {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.CompositeConstruct %cst0_i32, %cst0_i32 : (i32, i32) -> !spirv.struct<(i32, i32)>
    return %0 : !spirv.struct<(i32, i32)>
  }
  func.func @umulextended_x_1(%arg0: i32) -> !spirv.struct<(i32, i32)> {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = spirv.CompositeConstruct %arg0, %cst0_i32 : (i32, i32) -> !spirv.struct<(i32, i32)>
    return %0 : !spirv.struct<(i32, i32)>
  }
  func.func @const_fold_scalar_umulextended() -> (!spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) {
    %cst-13_i32 = spirv.Constant -13 : i32
    %cst40_i32 = spirv.Constant 40 : i32
    %cst-40_i32 = spirv.Constant -40 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %0 = spirv.Undef : !spirv.struct<(i32, i32)>
    %1 = spirv.CompositeInsert %cst-40_i32, %0[0 : i32] : i32 into !spirv.struct<(i32, i32)>
    %2 = spirv.CompositeInsert %cst4_i32, %1[1 : i32] : i32 into !spirv.struct<(i32, i32)>
    %3 = spirv.Undef : !spirv.struct<(i32, i32)>
    %4 = spirv.CompositeInsert %cst40_i32, %3[0 : i32] : i32 into !spirv.struct<(i32, i32)>
    %5 = spirv.CompositeInsert %cst-13_i32, %4[1 : i32] : i32 into !spirv.struct<(i32, i32)>
    return %2, %5 : !spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>
  }
  func.func @const_fold_vector_umulextended() -> !spirv.struct<(vector<3xi32>, vector<3xi32>)> {
    %cst_vec_3xi32 = spirv.Constant dense<[2147483643, 40, -1]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[2, -13, 0]> : vector<3xi32>
    %0 = spirv.Undef : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %1 = spirv.CompositeInsert %cst_vec_3xi32, %0[0 : i32] : vector<3xi32> into !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    %2 = spirv.CompositeInsert %cst_vec_3xi32_0, %1[1 : i32] : vector<3xi32> into !spirv.struct<(vector<3xi32>, vector<3xi32>)>
    return %2 : !spirv.struct<(vector<3xi32>, vector<3xi32>)>
  }
}

// -----
module {
  func.func @isub_x_x(%arg0: i32) -> i32 {
    %cst0_i32 = spirv.Constant 0 : i32
    return %cst0_i32 : i32
  }
  func.func @isub_vector_x_x(%arg0: vector<3xi32>) -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
  func.func @const_fold_scalar_isub_normal() -> (i32, i32, i32) {
    %cst2_i32 = spirv.Constant 2 : i32
    %cst13_i32 = spirv.Constant 13 : i32
    %cst-15_i32 = spirv.Constant -15 : i32
    return %cst2_i32, %cst13_i32, %cst-15_i32 : i32, i32, i32
  }
  func.func @const_fold_scalar_isub_flow() -> (i32, i32, i32, i32) {
    %cst1_i32 = spirv.Constant 1 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    return %cst1_i32, %cst2_i32, %cst-2147483648_i32, %cst2147483647_i32 : i32, i32, i32, i32
  }
  func.func @const_fold_vector_isub() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[45, -40, 99]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @sdiv_x_1(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @sdiv_div_0_or_overflow() -> (i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %0 = spirv.SDiv %cst-1_i32, %cst0_i32 : i32
    %1 = spirv.SDiv %cst-2147483648_i32, %cst-1_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @const_fold_scalar_sdiv() -> (i32, i32, i32, i32) {
    %cst8_i32 = spirv.Constant 8 : i32
    %cst-7_i32 = spirv.Constant -7 : i32
    %cst-2_i32 = spirv.Constant -2 : i32
    %cst-18_i32 = spirv.Constant -18 : i32
    return %cst8_i32, %cst-7_i32, %cst-2_i32, %cst-18_i32 : i32, i32, i32, i32
  }
  func.func @const_fold_vector_sdiv() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[0, -1, -3]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @smod_x_1(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    return %cst0_i32, %cst_vec_3xi32 : i32, vector<3xi32>
  }
  func.func @smod_div_0_or_overflow() -> (i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %0 = spirv.SMod %cst-1_i32, %cst0_i32 : i32
    %1 = spirv.SMod %cst-2147483648_i32, %cst-1_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @const_fold_scalar_smod() -> (i32, i32, i32, i32, i32, i32, i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst53_i32 = spirv.Constant 53 : i32
    %cst-3_i32 = spirv.Constant -3 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %cst-53_i32 = spirv.Constant -53 : i32
    return %cst0_i32, %cst0_i32, %cst2_i32, %cst53_i32, %cst-3_i32, %cst3_i32, %cst-53_i32, %cst-3_i32 : i32, i32, i32, i32, i32, i32, i32, i32
  }
  func.func @const_fold_vector_smod() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[42, -4, 4]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @srem_x_1(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    return %cst0_i32, %cst_vec_3xi32 : i32, vector<3xi32>
  }
  func.func @srem_div_0_or_overflow() -> (i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst-2147483648_i32 = spirv.Constant -2147483648 : i32
    %0 = spirv.SRem %cst-1_i32, %cst0_i32 : i32
    %1 = spirv.SRem %cst-2147483648_i32, %cst-1_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @const_fold_scalar_srem() -> (i32, i32, i32, i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst-3_i32 = spirv.Constant -3 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    return %cst0_i32, %cst0_i32, %cst2_i32, %cst-3_i32, %cst1_i32 : i32, i32, i32, i32, i32
  }
}

// -----
module {
  func.func @udiv_x_1(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @udiv_div_0() -> i32 {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %0 = spirv.UDiv %cst-1_i32, %cst0_i32 : i32
    return %0 : i32
  }
  func.func @const_fold_scalar_udiv() -> (i32, i32, i32) {
    %cst8_i32 = spirv.Constant 8 : i32
    %cst1431655762_i32 = spirv.Constant 1431655762 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    return %cst8_i32, %cst1431655762_i32, %cst0_i32 : i32, i32, i32
  }
}

// -----
module {
  func.func @umod_x_1(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    return %cst0_i32, %cst_vec_3xi32 : i32, vector<3xi32>
  }
  func.func @umod_div_0() -> i32 {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %0 = spirv.UMod %cst-1_i32, %cst0_i32 : i32
    return %0 : i32
  }
  func.func @const_fold_scalar_umod() -> (i32, i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst56_i32 = spirv.Constant 56 : i32
    return %cst0_i32, %cst2_i32, %cst56_i32 : i32, i32, i32
  }
  func.func @const_fold_vector_umod() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[42, 24, 0]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
  func.func @umod_fold(%arg0: i32) -> (i32, i32) {
    %cst4_i32 = spirv.Constant 4 : i32
    %cst32_i32 = spirv.Constant 32 : i32
    %0 = spirv.UMod %arg0, %cst32_i32 : i32
    %1 = spirv.UMod %arg0, %cst4_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @umod_vector_fold(%arg0: vector<4xi32>) -> (vector<4xi32>, vector<4xi32>) {
    %cst_vec_4xi32 = spirv.Constant dense<4> : vector<4xi32>
    %cst_vec_4xi32_0 = spirv.Constant dense<32> : vector<4xi32>
    %0 = spirv.UMod %arg0, %cst_vec_4xi32_0 : vector<4xi32>
    %1 = spirv.UMod %arg0, %cst_vec_4xi32 : vector<4xi32>
    return %0, %1 : vector<4xi32>, vector<4xi32>
  }
  func.func @umod_fold_same_divisor(%arg0: i32) -> (i32, i32) {
    %cst32_i32 = spirv.Constant 32 : i32
    %0 = spirv.UMod %arg0, %cst32_i32 : i32
    %1 = spirv.UMod %arg0, %cst32_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @umod_fail_1_fold(%arg0: i32) -> (i32, i32) {
    %cst5_i32 = spirv.Constant 5 : i32
    %cst32_i32 = spirv.Constant 32 : i32
    %0 = spirv.UMod %arg0, %cst32_i32 : i32
    %1 = spirv.UMod %0, %cst5_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @umod_fail_2_fold(%arg0: i32) -> (i32, i32) {
    %cst32_i32 = spirv.Constant 32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %0 = spirv.UMod %arg0, %cst4_i32 : i32
    %1 = spirv.UMod %0, %cst32_i32 : i32
    return %0, %1 : i32, i32
  }
  func.func @umod_vector_fail_1_fold(%arg0: vector<4xi32>) -> (vector<4xi32>, vector<4xi32>) {
    %cst_vec_4xi32 = spirv.Constant dense<9> : vector<4xi32>
    %cst_vec_4xi32_0 = spirv.Constant dense<64> : vector<4xi32>
    %0 = spirv.UMod %arg0, %cst_vec_4xi32_0 : vector<4xi32>
    %1 = spirv.UMod %0, %cst_vec_4xi32 : vector<4xi32>
    return %0, %1 : vector<4xi32>, vector<4xi32>
  }
  func.func @umod_vector_fail_2_fold(%arg0: vector<4xi32>) -> (vector<4xi32>, vector<4xi32>) {
    %cst_vec_4xi32 = spirv.Constant dense<32> : vector<4xi32>
    %cst_vec_4xi32_0 = spirv.Constant dense<4> : vector<4xi32>
    %0 = spirv.UMod %arg0, %cst_vec_4xi32_0 : vector<4xi32>
    %1 = spirv.UMod %0, %cst_vec_4xi32 : vector<4xi32>
    return %0, %1 : vector<4xi32>, vector<4xi32>
  }
}

// -----
module {
  func.func @snegate_twice(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @snegate_min() -> (i8, i8) {
    %cst-128_i8 = spirv.Constant -128 : i8
    return %cst-128_i8, %cst-128_i8 : i8, i8
  }
  func.func @const_fold_scalar_snegate() -> (i32, i32, i32) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-3_i32 = spirv.Constant -3 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    return %cst0_i32, %cst-3_i32, %cst3_i32 : i32, i32, i32
  }
  func.func @const_fold_vector_snegate() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 3, -3]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @not_twice(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @const_fold_scalar_not() -> (i32, i32, i32) {
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst-4_i32 = spirv.Constant -4 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    return %cst-1_i32, %cst-4_i32, %cst2_i32 : i32, i32, i32
  }
  func.func @const_fold_vector_not() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 3, -3]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @convert_logical_and_true_false_scalar(%arg0: i1) -> (i1, i1) {
    %false = spirv.Constant false
    return %arg0, %false : i1, i1
  }
  func.func @convert_logical_and_true_false_vector(%arg0: vector<3xi1>) -> (vector<3xi1>, vector<3xi1>) {
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %arg0, %cst_vec_3xi1 : vector<3xi1>, vector<3xi1>
  }
}

// -----
module {
  func.func @logical_not_twice(%arg0: i1) -> i1 {
    return %arg0 : i1
  }
  func.func @const_fold_scalar_logical_not() -> i1 {
    %false = spirv.Constant false
    return %false : i1
  }
  func.func @const_fold_vector_logical_not() -> vector<2xi1> {
    %cst_vec_2xi1 = spirv.Constant dense<[false, true]> : vector<2xi1>
    return %cst_vec_2xi1 : vector<2xi1>
  }
}

// -----
module {
  func.func @convert_logical_not_to_not_equal(%arg0: vector<3xi64>, %arg1: vector<3xi64>) -> vector<3xi1> {
    %0 = spirv.INotEqual %arg0, %arg1 : vector<3xi64>
    spirv.ReturnValue %0 : vector<3xi1>
  }
}

// -----
module {
  func.func @logical_equal_same(%arg0: i1, %arg1: vector<3xi1>) -> (i1, vector<3xi1>) {
    %true = spirv.Constant true
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %true, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_logical_equal() -> (i1, i1) {
    %false = spirv.Constant false
    %true = spirv.Constant true
    return %false, %true : i1, i1
  }
  func.func @const_fold_vector_logical_equal() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[true, true, false]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @convert_logical_not_equal_false(%arg0: vector<4xi1>) -> vector<4xi1> {
    spirv.ReturnValue %arg0 : vector<4xi1>
  }
  func.func @logical_not_equal_same(%arg0: i1, %arg1: vector<3xi1>) -> (i1, vector<3xi1>) {
    %false = spirv.Constant false
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %false, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_logical_not_equal() -> (i1, i1) {
    %true = spirv.Constant true
    %false = spirv.Constant false
    return %true, %false : i1, i1
  }
  func.func @const_fold_vector_logical_not_equal() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[false, false, true]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @convert_logical_not_to_equal(%arg0: vector<3xi64>, %arg1: vector<3xi64>) -> vector<3xi1> {
    %0 = spirv.IEqual %arg0, %arg1 : vector<3xi64>
    spirv.ReturnValue %0 : vector<3xi1>
  }
}

// -----
module {
  func.func @convert_logical_not_parent_multi_use(%arg0: vector<3xi64>, %arg1: vector<3xi64>, %arg2: !spirv.ptr<vector<3xi1>, Uniform>) -> vector<3xi1> {
    %0 = spirv.INotEqual %arg0, %arg1 : vector<3xi64>
    %1 = spirv.IEqual %arg0, %arg1 : vector<3xi64>
    spirv.Store "Uniform" %arg2, %0 : vector<3xi1>
    spirv.ReturnValue %1 : vector<3xi1>
  }
}

// -----
module {
  func.func @convert_logical_not_to_logical_not_equal(%arg0: vector<3xi1>, %arg1: vector<3xi1>) -> vector<3xi1> {
    %0 = spirv.LogicalNotEqual %arg0, %arg1 : vector<3xi1>
    spirv.ReturnValue %0 : vector<3xi1>
  }
}

// -----
module {
  func.func @convert_logical_not_to_logical_equal(%arg0: vector<3xi1>, %arg1: vector<3xi1>) -> vector<3xi1> {
    %0 = spirv.LogicalEqual %arg0, %arg1 : vector<3xi1>
    spirv.ReturnValue %0 : vector<3xi1>
  }
}

// -----
module {
  func.func @convert_logical_or_true_false_scalar(%arg0: i1) -> (i1, i1) {
    %true = spirv.Constant true
    return %true, %arg0 : i1, i1
  }
  func.func @convert_logical_or_true_false_vector(%arg0: vector<3xi1>) -> (vector<3xi1>, vector<3xi1>) {
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %cst_vec_3xi1, %arg0 : vector<3xi1>, vector<3xi1>
  }
}

// -----
module {
  func.func @convert_select_scalar(%arg0: i32, %arg1: i32) -> (i32, i32) {
    return %arg0, %arg1 : i32, i32
  }
  func.func @convert_select_vector(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> (vector<3xi32>, vector<3xi32>) {
    return %arg0, %arg1 : vector<3xi32>, vector<3xi32>
  }
  func.func @convert_select_vector_extra(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> (vector<2xi32>, vector<2xi32>) {
    %cst_vec_2xi32 = spirv.Constant dense<42> : vector<2xi32>
    return %cst_vec_2xi32, %arg1 : vector<2xi32>, vector<2xi32>
  }
}

// -----
module {
  func.func @iequal_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %true = spirv.Constant true
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %true, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_iequal() -> (i1, i1) {
    %false = spirv.Constant false
    %true = spirv.Constant true
    return %false, %true : i1, i1
  }
  func.func @const_fold_vector_iequal() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[true, false, true]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @inotequal_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %false = spirv.Constant false
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %false, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_inotequal() -> (i1, i1) {
    %true = spirv.Constant true
    %false = spirv.Constant false
    return %true, %false : i1, i1
  }
  func.func @const_fold_vector_inotequal() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[false, true, false]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @sgt_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %false = spirv.Constant false
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %false, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_sgt() -> (i1, i1) {
    %false = spirv.Constant false
    %true = spirv.Constant true
    return %false, %true : i1, i1
  }
  func.func @const_fold_vector_sgt() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[false, false, true]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @sge_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %true = spirv.Constant true
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %true, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_sge() -> (i1, i1) {
    %false = spirv.Constant false
    %true = spirv.Constant true
    return %false, %true : i1, i1
  }
  func.func @const_fold_vector_sge() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[true, false, true]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @ugt_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %false = spirv.Constant false
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %false, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_ugt() -> (i1, i1) {
    %false = spirv.Constant false
    %true = spirv.Constant true
    return %false, %true : i1, i1
  }
  func.func @const_fold_vector_ugt() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[false, false, true]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @uge_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %true = spirv.Constant true
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %true, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_uge() -> (i1, i1) {
    %false = spirv.Constant false
    %true = spirv.Constant true
    return %false, %true : i1, i1
  }
  func.func @const_fold_vector_uge() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[true, false, true]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @slt_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %false = spirv.Constant false
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %false, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_slt() -> (i1, i1) {
    %true = spirv.Constant true
    %false = spirv.Constant false
    return %true, %false : i1, i1
  }
  func.func @const_fold_vector_slt() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[false, true, false]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @sle_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %true = spirv.Constant true
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %true, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_sle() -> (i1, i1) {
    %true = spirv.Constant true
    %false = spirv.Constant false
    return %true, %false : i1, i1
  }
  func.func @const_fold_vector_sle() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[true, true, false]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @ult_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %false = spirv.Constant false
    %cst_vec_3xi1 = spirv.Constant dense<false> : vector<3xi1>
    return %false, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_ult() -> (i1, i1) {
    %true = spirv.Constant true
    %false = spirv.Constant false
    return %true, %false : i1, i1
  }
  func.func @const_fold_vector_ult() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[false, true, false]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @ule_same(%arg0: i32, %arg1: vector<3xi32>) -> (i1, vector<3xi1>) {
    %true = spirv.Constant true
    %cst_vec_3xi1 = spirv.Constant dense<true> : vector<3xi1>
    return %true, %cst_vec_3xi1 : i1, vector<3xi1>
  }
  func.func @const_fold_scalar_ule() -> (i1, i1) {
    %true = spirv.Constant true
    %false = spirv.Constant false
    return %true, %false : i1, i1
  }
  func.func @const_fold_vector_ule() -> vector<3xi1> {
    %cst_vec_3xi1 = spirv.Constant dense<[true, true, false]> : vector<3xi1>
    return %cst_vec_3xi1 : vector<3xi1>
  }
}

// -----
module {
  func.func @lsl_x_0(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @lsl_shift_overflow(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst32_i32 = spirv.Constant 32 : i32
    %cst_vec_3xi32 = spirv.Constant dense<[6, 18, 128]> : vector<3xi32>
    %0 = spirv.ShiftLeftLogical %arg0, %cst32_i32 : i32, i32
    %1 = spirv.ShiftLeftLogical %arg1, %cst_vec_3xi32 : vector<3xi32>, vector<3xi32>
    return %0, %1 : i32, vector<3xi32>
  }
  func.func @const_fold_scalar_lsl() -> i32 {
    %cst-131072_i32 = spirv.Constant -131072 : i32
    return %cst-131072_i32 : i32
  }
  func.func @const_fold_vector_lsl() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[-2147483648, -65536, 1040384]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @asr_x_0(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @asr_shift_overflow(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst32_i32 = spirv.Constant 32 : i32
    %cst_vec_3xi32 = spirv.Constant dense<[6, 18, 128]> : vector<3xi32>
    %0 = spirv.ShiftRightArithmetic %arg0, %cst32_i32 : i32, i32
    %1 = spirv.ShiftRightArithmetic %arg1, %cst_vec_3xi32 : vector<3xi32>, vector<3xi32>
    return %0, %1 : i32, vector<3xi32>
  }
  func.func @const_fold_scalar_asr() -> i32 {
    %cst-1_i32 = spirv.Constant -1 : i32
    return %cst-1_i32 : i32
  }
  func.func @const_fold_vector_asr() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[-1, 3, 0]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @lsr_x_0(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @lsr_shift_overflow(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst32_i32 = spirv.Constant 32 : i32
    %cst_vec_3xi32 = spirv.Constant dense<[6, 18, 128]> : vector<3xi32>
    %0 = spirv.ShiftRightLogical %arg0, %cst32_i32 : i32, i32
    %1 = spirv.ShiftRightLogical %arg1, %cst_vec_3xi32 : vector<3xi32>, vector<3xi32>
    return %0, %1 : i32, vector<3xi32>
  }
  func.func @const_fold_scalar_lsr() -> i32 {
    %cst32767_i32 = spirv.Constant 32767 : i32
    return %cst32767_i32 : i32
  }
  func.func @const_fold_vector_lsr() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[1, 65535, 524287]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @bitwise_and_x_x(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @bitwise_and_x_0(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    return %cst0_i32, %cst_vec_3xi32 : i32, vector<3xi32>
  }
  func.func @bitwise_and_x_n1(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @const_fold_scalar_band() -> i32 {
    %cst0_i32 = spirv.Constant 0 : i32
    return %cst0_i32 : i32
  }
  func.func @const_fold_vector_band() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[40, -63, 28]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @bitwise_or_x_x(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @bitwise_or_x_0(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @bitwise_or_x_n1(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst-1_i32 = spirv.Constant -1 : i32
    %cst_vec_3xi32 = spirv.Constant dense<-1> : vector<3xi32>
    return %cst-1_i32, %cst_vec_3xi32 : i32, vector<3xi32>
  }
  func.func @const_fold_scalar_bor() -> i32 {
    %cst-1_i32 = spirv.Constant -1 : i32
    return %cst-1_i32 : i32
  }
  func.func @const_fold_vector_bor() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[-1, -7, 127]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @bitwise_xor_x_0(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    return %arg0, %arg1 : i32, vector<3xi32>
  }
  func.func @bitwise_xor_x_x(%arg0: i32, %arg1: vector<3xi32>) -> (i32, vector<3xi32>) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst_vec_3xi32 = spirv.Constant dense<0> : vector<3xi32>
    return %cst0_i32, %cst_vec_3xi32 : i32, vector<3xi32>
  }
  func.func @const_fold_scalar_bxor() -> i32 {
    %cst2147483647_i32 = spirv.Constant 2147483647 : i32
    return %cst2147483647_i32 : i32
  }
  func.func @const_fold_vector_bxor() -> vector<3xi32> {
    %cst_vec_3xi32 = spirv.Constant dense<[-41, 56, 99]> : vector<3xi32>
    return %cst_vec_3xi32 : vector<3xi32>
  }
}

// -----
module {
  func.func @canonicalize_selection_op_scalar_type(%arg0: i1) {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %0 = spirv.Variable init(%cst0_i32) : !spirv.ptr<i32, Function>
    %1 = spirv.Select %arg0, %cst1_i32, %cst2_i32 : i1, i32
    spirv.Store "Function" %0, %1 ["Aligned", 4] : i32
    spirv.Return
  }
}

// -----
module {
  func.func @canonicalize_selection_op_vector_type(%arg0: i1) {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<[2, 3, 4]> : vector<3xi32>
    %0 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    %1 = spirv.Select %arg0, %cst_vec_3xi32_0, %cst_vec_3xi32_1 : i1, vector<3xi32>
    spirv.Store "Function" %0, %1 ["Aligned", 8] : vector<3xi32>
    spirv.Return
  }
}

// -----
module {
  func.func @cannot_canonicalize_selection_op_0(%arg0: i1) {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<[2, 3, 4]> : vector<3xi32>
    %0 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    %1 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg0, ^bb1(%0, %cst_vec_3xi32_0 : !spirv.ptr<vector<3xi32>, Function>, vector<3xi32>), ^bb1(%1, %cst_vec_3xi32_1 : !spirv.ptr<vector<3xi32>, Function>, vector<3xi32>)
    ^bb1(%2: !spirv.ptr<vector<3xi32>, Function>, %3: vector<3xi32>):  // 2 preds: ^bb0, ^bb0
      spirv.Store "Function" %2, %3 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb2
    ^bb2:  // pred: ^bb1
      spirv.mlir.merge
    }
    spirv.Return
  }
}

// -----
module {
  func.func @cannot_canonicalize_selection_op_1(%arg0: i1) {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<[2, 3, 4]> : vector<3xi32>
    %0 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    %1 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      spirv.Store "Function" %0, %cst_vec_3xi32_0 ["Aligned", 8] : vector<3xi32>
      spirv.Store "Function" %1, %cst_vec_3xi32_0 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.Store "Function" %1, %cst_vec_3xi32_1 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    spirv.Return
  }
}

// -----
module {
  func.func @cannot_canonicalize_selection_op_2(%arg0: i1) {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<[2, 3, 4]> : vector<3xi32>
    %0 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg0, ^bb1, ^bb2
    ^bb1:  // 2 preds: ^bb0, ^bb2
      spirv.Store "Function" %0, %cst_vec_3xi32_0 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.Store "Function" %0, %cst_vec_3xi32_1 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb1
    ^bb3:  // pred: ^bb1
      spirv.mlir.merge
    }
    spirv.Return
  }
}

// -----
module {
  func.func @cannot_canonicalize_selection_op_3(%arg0: i1) {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<[2, 3, 4]> : vector<3xi32>
    %0 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      spirv.Store "Function" %0, %cst_vec_3xi32_0 ["Aligned", 8] : vector<3xi32>
      spirv.Return
    ^bb2:  // pred: ^bb0
      spirv.Store "Function" %0, %cst_vec_3xi32_1 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb3
    ^bb3:  // pred: ^bb2
      spirv.mlir.merge
    }
    spirv.Return
  }
}

// -----
module {
  func.func @cannot_canonicalize_selection_op_4(%arg0: i1) {
    %cst_vec_3xi32 = spirv.Constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_vec_3xi32_0 = spirv.Constant dense<[1, 2, 3]> : vector<3xi32>
    %cst_vec_3xi32_1 = spirv.Constant dense<[2, 3, 4]> : vector<3xi32>
    %0 = spirv.Variable init(%cst_vec_3xi32) : !spirv.ptr<vector<3xi32>, Function>
    spirv.mlir.selection {
      spirv.BranchConditional %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      spirv.Store "Function" %0, %cst_vec_3xi32_0 ["Aligned", 4] : vector<3xi32>
      spirv.Branch ^bb3
    ^bb2:  // pred: ^bb0
      spirv.Store "Function" %0, %cst_vec_3xi32_1 ["Aligned", 8] : vector<3xi32>
      spirv.Branch ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      spirv.mlir.merge
    }
    spirv.Return
  }
}

