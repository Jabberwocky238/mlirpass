module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16], []>, #spirv.resource_limits<>>} {
  func.func @bitcast(%arg0: vector<2xf32>, %arg1: vector<2xf16>) -> (vector<4xf16>, vector<1xf32>) {
    %0 = spirv.Bitcast %arg0 : vector<2xf32> to vector<4xf16>
    %1 = spirv.Bitcast %arg1 : vector<2xf16> to f32
    %2 = builtin.unrealized_conversion_cast %1 : f32 to vector<1xf32>
    return %0, %2 : vector<4xf16>, vector<1xf32>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @bitcast(%arg0: vector<2xf32>, %arg1: vector<2xf16>) -> (vector<4xf16>, vector<1xf32>) {
    %0 = vector.bitcast %arg0 : vector<2xf32> to vector<4xf16>
    %1 = vector.bitcast %arg1 : vector<2xf16> to vector<1xf32>
    return %0, %1 : vector<4xf16>, vector<1xf32>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} {
  func.func @cl_fma(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = spirv.CL.fma %arg0, %arg1, %arg2 : vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @cl_fma_size1_vector(%arg0: vector<1xf32>, %arg1: vector<1xf32>, %arg2: vector<1xf32>) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<1xf32> to f32
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<1xf32> to f32
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %3 = spirv.CL.fma %2, %1, %0 : f32
    %4 = builtin.unrealized_conversion_cast %3 : f32 to vector<1xf32>
    return %4 : vector<1xf32>
  }
  func.func @cl_reduction_maximumf(%arg0: vector<3xf32>, %arg1: f32) -> f32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xf32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xf32>
    %3 = spirv.CL.fmax %0, %1 : f32
    %4 = spirv.CL.fmax %3, %2 : f32
    %5 = spirv.CL.fmax %4, %arg1 : f32
    return %5 : f32
  }
  func.func @cl_reduction_minimumf(%arg0: vector<3xf32>, %arg1: f32) -> f32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xf32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xf32>
    %3 = spirv.CL.fmin %0, %1 : f32
    %4 = spirv.CL.fmin %3, %2 : f32
    %5 = spirv.CL.fmin %4, %arg1 : f32
    return %5 : f32
  }
  func.func @cl_reduction_maxsi(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.CL.s_max %0, %1 : i32
    %4 = spirv.CL.s_max %3, %2 : i32
    %5 = spirv.CL.s_max %4, %arg1 : i32
    return %5 : i32
  }
  func.func @cl_reduction_minsi(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.CL.s_min %0, %1 : i32
    %4 = spirv.CL.s_min %3, %2 : i32
    %5 = spirv.CL.s_min %4, %arg1 : i32
    return %5 : i32
  }
  func.func @cl_reduction_maxui(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.CL.u_max %0, %1 : i32
    %4 = spirv.CL.u_max %3, %2 : i32
    %5 = spirv.CL.u_max %4, %arg1 : i32
    return %5 : i32
  }
  func.func @cl_reduction_minui(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.CL.u_min %0, %1 : i32
    %4 = spirv.CL.u_min %3, %2 : i32
    %5 = spirv.CL.u_min %4, %arg1 : i32
    return %5 : i32
  }
}

// -----
module {
  func.func @broadcast(%arg0: f32) -> (vector<4xf32>, vector<2xf32>) {
    %0 = spirv.CompositeConstruct %arg0, %arg0, %arg0, %arg0 : (f32, f32, f32, f32) -> vector<4xf32>
    %1 = spirv.CompositeConstruct %arg0, %arg0 : (f32, f32) -> vector<2xf32>
    return %0, %1 : vector<4xf32>, vector<2xf32>
  }
}

// -----
module {
  func.func @broadcast_index(%arg0: index) -> vector<4xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %1 = spirv.CompositeConstruct %0, %0, %0, %0 : (i32, i32, i32, i32) -> vector<4xi32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4xi32> to vector<4xindex>
    return %2 : vector<4xindex>
  }
}

// -----
module {
  func.func @extract(%arg0: vector<2xf32>) -> (vector<1xf32>, f32) {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %0 : f32 to vector<1xf32>
    %2 = spirv.CompositeExtract %arg0[1 : i32] : vector<2xf32>
    return %1, %2 : vector<1xf32>, f32
  }
}

// -----
module {
  func.func @extract_poison_idx(%arg0: vector<4xf32>) -> f32 {
    %0 = spirv.Undef : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_size1_vector(%arg0: vector<1xf32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_size1_vector_dynamic(%arg0: vector<1xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_dynamic(%arg0: vector<4xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %cst3_i32 = spirv.Constant 3 : i32
    %1 = spirv.BitwiseAnd %0, %cst3_i32 : i32
    %2 = spirv.VectorExtractDynamic %arg0[%1] : vector<4xf32>, i32
    return %2 : f32
  }
}

// -----
module {
  func.func @extract_dynamic_non_pow2(%arg0: vector<3xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %1 = spirv.IEqual %0, %cst-1_i32 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.Select %1, %cst0_i32, %0 : i1, i32
    %3 = spirv.VectorExtractDynamic %arg0[%2] : vector<3xf32>, i32
    return %3 : f32
  }
}

// -----
module {
  func.func @extract_dynamic_cst(%arg0: vector<4xf32>) -> f32 {
    %c1 = arith.constant 1 : index
    %0 = spirv.CompositeExtract %arg0[1 : i32] : vector<4xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @to_elements_one_element(%arg0: vector<1xf32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    return %0 : f32
  }
  func.func @to_elements_no_dead_elements(%arg0: vector<4xf32>) -> (f32, f32, f32, f32) {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<4xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<4xf32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<4xf32>
    %3 = spirv.CompositeExtract %arg0[3 : i32] : vector<4xf32>
    return %0, %1, %2, %3 : f32, f32, f32, f32
  }
  func.func @to_elements_dead_elements(%arg0: vector<4xf32>) -> (f32, f32) {
    %0 = spirv.CompositeExtract %arg0[1 : i32] : vector<4xf32>
    %1 = spirv.CompositeExtract %arg0[3 : i32] : vector<4xf32>
    return %0, %1 : f32, f32
  }
}

// -----
module {
  func.func @from_elements_0d_f32(%arg0: f32) -> vector<f32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : f32 to vector<f32>
    return %0 : vector<f32>
  }
  func.func @from_elements_1xf32(%arg0: f32) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : f32 to vector<1xf32>
    return %0 : vector<1xf32>
  }
  func.func @from_elements_3xf32(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<3xf32> {
    %0 = spirv.CompositeConstruct %arg0, %arg1, %arg2 : (f32, f32, f32) -> vector<3xf32>
    return %0 : vector<3xf32>
  }
  func.func @from_elements_3xi8(%arg0: i8, %arg1: i8, %arg2: i8) -> vector<3xi8> {
    %0 = builtin.unrealized_conversion_cast %arg2 : i8 to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : i8 to i32
    %2 = builtin.unrealized_conversion_cast %arg0 : i8 to i32
    %3 = spirv.CompositeConstruct %2, %1, %0 : (i32, i32, i32) -> vector<3xi32>
    %4 = builtin.unrealized_conversion_cast %3 : vector<3xi32> to vector<3xi8>
    return %4 : vector<3xi8>
  }
}

// -----
module {
  func.func @insert(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = spirv.CompositeInsert %arg1, %arg0[2 : i32] : f32 into vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @insert_poison_idx(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = spirv.Undef : vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @insert_index_vector(%arg0: vector<4xindex>, %arg1: index) -> vector<4xindex> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xindex> to vector<4xi32>
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = spirv.CompositeInsert %1, %0[2 : i32] : i32 into vector<4xi32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi32> to vector<4xindex>
    return %3 : vector<4xindex>
  }
}

// -----
module {
  func.func @insert_size1_vector(%arg0: vector<1xf32>, %arg1: f32) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : f32 to vector<1xf32>
    return %0 : vector<1xf32>
  }
}

// -----
module {
  func.func @insert_size1_vector_dynamic(%arg0: vector<1xf32>, %arg1: f32, %arg2: index) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : f32 to vector<1xf32>
    return %0 : vector<1xf32>
  }
}

// -----
module {
  func.func @insert_dynamic(%arg0: f32, %arg1: vector<4xf32>, %arg2: index) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %cst3_i32 = spirv.Constant 3 : i32
    %1 = spirv.BitwiseAnd %0, %cst3_i32 : i32
    %2 = spirv.VectorInsertDynamic %arg0, %arg1[%1] : vector<4xf32>, i32
    return %2 : vector<4xf32>
  }
}

// -----
module {
  func.func @insert_dynamic_non_pow2(%arg0: f32, %arg1: vector<3xf32>, %arg2: index) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %cst-1_i32 = spirv.Constant -1 : i32
    %1 = spirv.IEqual %0, %cst-1_i32 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.Select %1, %cst0_i32, %0 : i1, i32
    %3 = spirv.VectorInsertDynamic %arg0, %arg1[%2] : vector<3xf32>, i32
    return %3 : vector<3xf32>
  }
}

// -----
module {
  func.func @insert_dynamic_cst(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %c2 = arith.constant 2 : index
    %0 = spirv.CompositeInsert %arg0, %arg1[2 : i32] : f32 into vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @extract_strided_slice(%arg0: vector<4xf32>) -> (vector<2xf32>, vector<1xf32>) {
    %0 = spirv.VectorShuffle [1 : i32, 2 : i32] %arg0, %arg0 : vector<4xf32>, vector<4xf32> -> vector<2xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<4xf32>
    %2 = builtin.unrealized_conversion_cast %1 : f32 to vector<1xf32>
    return %0, %2 : vector<2xf32>, vector<1xf32>
  }
}

// -----
module {
  func.func @insert_strided_slice(%arg0: vector<2xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = spirv.VectorShuffle [0 : i32, 4 : i32, 5 : i32, 3 : i32] %arg1, %arg0 : vector<4xf32>, vector<2xf32> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @insert_size1_vector(%arg0: vector<1xf32>, %arg1: vector<3xf32>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %1 = spirv.CompositeInsert %0, %arg1[2 : i32] : f32 into vector<3xf32>
    return %1 : vector<3xf32>
  }
}

// -----
module {
  func.func @fma(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = spirv.GL.Fma %arg0, %arg1, %arg2 : vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @fma_size1_vector(%arg0: vector<1xf32>, %arg1: vector<1xf32>, %arg2: vector<1xf32>) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<1xf32> to f32
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<1xf32> to f32
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %3 = spirv.GL.Fma %2, %1, %0 : f32
    %4 = builtin.unrealized_conversion_cast %3 : f32 to vector<1xf32>
    return %4 : vector<1xf32>
  }
}

// -----
module {
  func.func @splat(%arg0: f32) -> vector<4xf32> {
    %0 = spirv.CompositeConstruct %arg0, %arg0, %arg0, %arg0 : (f32, f32, f32, f32) -> vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @splat_size1_vector(%arg0: f32) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : f32 to vector<1xf32>
    return %0 : vector<1xf32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<1xf32>, %arg1: vector<1xf32>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xf32> to f32
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %2 = spirv.CompositeConstruct %1, %0, %0, %1 : (f32, f32, f32, f32) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
}

// -----
module {
  func.func @shuffle_index_vector(%arg0: vector<1xindex>, %arg1: vector<1xindex>) -> vector<4xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xindex> to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xindex> to i32
    %2 = spirv.CompositeConstruct %1, %0, %0, %1 : (i32, i32, i32, i32) -> vector<4xi32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi32> to vector<4xindex>
    return %3 : vector<4xindex>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<3xf32>, %arg1: vector<3xf32>) -> vector<4xf32> {
    %0 = spirv.VectorShuffle [3 : i32, 2 : i32, 5 : i32, 1 : i32] %arg0, %arg1 : vector<3xf32>, vector<3xf32> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<2x16xf32>, %arg1: vector<1x16xf32>) -> vector<3x16xf32> {
    %0 = vector.shuffle %arg0, %arg1 [0, 1, 2] : vector<2x16xf32>, vector<1x16xf32>
    return %0 : vector<3x16xf32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<1xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xi32> to i32
    %1 = spirv.CompositeExtract %arg1[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg1[2 : i32] : vector<3xi32>
    %3 = spirv.CompositeConstruct %0, %1, %2 : (i32, i32, i32) -> vector<3xi32>
    return %3 : vector<3xi32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<3xi32>, %arg1: vector<1xi32>) -> vector<3xi32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xi32> to i32
    %1 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.CompositeConstruct %1, %2, %0 : (i32, i32, i32) -> vector<3xi32>
    return %3 : vector<3xi32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<1xi32>, %arg1: vector<1xi32>) -> vector<2xi32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xi32> to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xi32> to i32
    %2 = spirv.CompositeConstruct %1, %0 : (i32, i32) -> vector<2xi32>
    return %2 : vector<2xi32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<1xi32> {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<4xi32>
    %1 = builtin.unrealized_conversion_cast %0 : i32 to vector<1xi32>
    return %1 : vector<1xi32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<1xi32> {
    %0 = spirv.CompositeExtract %arg1[1 : i32] : vector<4xi32>
    %1 = builtin.unrealized_conversion_cast %0 : i32 to vector<1xi32>
    return %1 : vector<1xi32>
  }
}

// -----
module {
  func.func @shuffle(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = spirv.VectorShuffle [1 : i32, -1 : i32, 5 : i32, -1 : i32] %arg0, %arg1 : vector<4xi32>, vector<4xi32> -> vector<4xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @interleave(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<4xf32> {
    %0 = spirv.VectorShuffle [0 : i32, 2 : i32, 1 : i32, 3 : i32] %arg0, %arg1 : vector<2xf32>, vector<2xf32> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @interleave_size1(%arg0: vector<1xf32>, %arg1: vector<1xf32>) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<1xf32> to f32
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %2 = spirv.CompositeConstruct %1, %0 : (f32, f32) -> vector<2xf32>
    return %2 : vector<2xf32>
  }
}

// -----
module {
  func.func @deinterleave(%arg0: vector<4xf32>) -> (vector<2xf32>, vector<2xf32>) {
    %0 = spirv.VectorShuffle [0 : i32, 2 : i32] %arg0, %arg0 : vector<4xf32>, vector<4xf32> -> vector<2xf32>
    %1 = spirv.VectorShuffle [1 : i32, 3 : i32] %arg0, %arg0 : vector<4xf32>, vector<4xf32> -> vector<2xf32>
    return %0, %1 : vector<2xf32>, vector<2xf32>
  }
}

// -----
module {
  func.func @deinterleave_scalar(%arg0: vector<2xf32>) -> (vector<1xf32>, vector<1xf32>) {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %0 : f32 to vector<1xf32>
    %2 = spirv.CompositeExtract %arg0[1 : i32] : vector<2xf32>
    %3 = builtin.unrealized_conversion_cast %2 : f32 to vector<1xf32>
    return %1, %3 : vector<1xf32>, vector<1xf32>
  }
}

// -----
module {
  func.func @reduction_add(%arg0: vector<4xi32>) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<4xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<4xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<4xi32>
    %3 = spirv.CompositeExtract %arg0[3 : i32] : vector<4xi32>
    %4 = spirv.IAdd %0, %1 : i32
    %5 = spirv.IAdd %4, %2 : i32
    %6 = spirv.IAdd %5, %3 : i32
    return %6 : i32
  }
}

// -----
module {
  func.func @reduction_addf_mulf(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> f32 {
    %0 = arith.mulf %arg0, %arg1 : vector<4xf32>
    %1 = spirv.Dot %arg0, %arg1 : vector<4xf32> -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduction_addf_acc_mulf(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: f32) -> f32 {
    %0 = arith.mulf %arg0, %arg1 : vector<4xf32>
    %1 = spirv.Dot %arg0, %arg1 : vector<4xf32> -> f32
    %2 = spirv.FAdd %arg2, %1 : f32
    return %2 : f32
  }
}

// -----
module {
  func.func @reduction_addf_mulf(%arg0: vector<4xf32>) -> f32 {
    %cst_vec_4xf32 = spirv.Constant dense<1.000000e+00> : vector<4xf32>
    %0 = spirv.Dot %arg0, %cst_vec_4xf32 : vector<4xf32> -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @reduction_addf_acc(%arg0: vector<4xf32>, %arg1: f32) -> f32 {
    %cst_vec_4xf32 = spirv.Constant dense<1.000000e+00> : vector<4xf32>
    %0 = spirv.Dot %arg0, %cst_vec_4xf32 : vector<4xf32> -> f32
    %1 = spirv.FAdd %arg1, %0 : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduction_addf_one_elem(%arg0: vector<1xf32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    return %0 : f32
  }
}

// -----
module {
  func.func @reduction_addf_one_elem_acc(%arg0: vector<1xf32>, %arg1: f32) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf32> to f32
    %1 = spirv.FAdd %arg1, %0 : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduction_mul(%arg0: vector<3xf32>, %arg1: f32) -> f32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xf32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xf32>
    %3 = spirv.FMul %0, %1 : f32
    %4 = spirv.FMul %3, %2 : f32
    %5 = spirv.FMul %4, %arg1 : f32
    return %5 : f32
  }
}

// -----
module {
  func.func @reduction_maximumf(%arg0: vector<3xf32>, %arg1: f32) -> f32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xf32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xf32>
    %3 = spirv.GL.FMax %0, %1 : f32
    %4 = spirv.GL.FMax %3, %2 : f32
    %5 = spirv.GL.FMax %4, %arg1 : f32
    return %5 : f32
  }
}

// -----
module {
  func.func @reduction_minimumf(%arg0: vector<3xf32>, %arg1: f32) -> f32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xf32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xf32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xf32>
    %3 = spirv.GL.FMin %0, %1 : f32
    %4 = spirv.GL.FMin %3, %2 : f32
    %5 = spirv.GL.FMin %4, %arg1 : f32
    return %5 : f32
  }
}

// -----
module {
  func.func @reduction_maxsi(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.GL.SMax %0, %1 : i32
    %4 = spirv.GL.SMax %3, %2 : i32
    %5 = spirv.GL.SMax %4, %arg1 : i32
    return %5 : i32
  }
}

// -----
module {
  func.func @reduction_minsi(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.GL.SMin %0, %1 : i32
    %4 = spirv.GL.SMin %3, %2 : i32
    %5 = spirv.GL.SMin %4, %arg1 : i32
    return %5 : i32
  }
}

// -----
module {
  func.func @reduction_maxui(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.GL.UMax %0, %1 : i32
    %4 = spirv.GL.UMax %3, %2 : i32
    %5 = spirv.GL.UMax %4, %arg1 : i32
    return %5 : i32
  }
}

// -----
module {
  func.func @reduction_minui(%arg0: vector<3xi32>, %arg1: i32) -> i32 {
    %0 = spirv.CompositeExtract %arg0[0 : i32] : vector<3xi32>
    %1 = spirv.CompositeExtract %arg0[1 : i32] : vector<3xi32>
    %2 = spirv.CompositeExtract %arg0[2 : i32] : vector<3xi32>
    %3 = spirv.GL.UMin %0, %1 : i32
    %4 = spirv.GL.UMin %3, %2 : i32
    %5 = spirv.GL.UMin %4, %arg1 : i32
    return %5 : i32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [BFloat16DotProductKHR], [SPV_KHR_bfloat16]>, #spirv.resource_limits<>>} {
  func.func @reduction_bf16_addf_mulf(%arg0: vector<4xbf16>, %arg1: vector<4xbf16>) -> bf16 {
    %0 = arith.mulf %arg0, %arg1 : vector<4xbf16>
    %1 = spirv.Dot %arg0, %arg1 : vector<4xbf16> -> bf16
    return %1 : bf16
  }
}

// -----
module {
  func.func @shape_cast_same_type(%arg0: vector<2xf32>) -> vector<2xf32> {
    return %arg0 : vector<2xf32>
  }
}

// -----
module {
  func.func @shape_cast_size1_vector(%arg0: vector<f32>) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to f32
    %1 = builtin.unrealized_conversion_cast %0 : f32 to vector<1xf32>
    return %1 : vector<1xf32>
  }
}

// -----
module {
  func.func @step() -> vector<4xindex> {
    %cst0_i32 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %0 = spirv.CompositeConstruct %cst0_i32, %cst1_i32, %cst2_i32, %cst3_i32 : (i32, i32, i32, i32) -> vector<4xi32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4xi32> to vector<4xindex>
    return %1 : vector<4xindex>
  }
}

// -----
module {
  func.func @step_size1() -> vector<1xindex> {
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = builtin.unrealized_conversion_cast %cst0_i32 : i32 to vector<1xindex>
    return %0 : vector<1xindex>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @vector_load(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %cst = arith.constant 0.000000e+00 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %3 = spirv.Bitcast %2 : !spirv.ptr<f32, StorageBuffer> to !spirv.ptr<vector<4xf32>, StorageBuffer>
    %4 = spirv.Load "StorageBuffer" %3 : vector<4xf32>
    return %4 : vector<4xf32>
  }
  func.func @vector_load_single_elem(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %cst = arith.constant 0.000000e+00 : f32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %3 = spirv.Load "StorageBuffer" %2 : f32
    %4 = builtin.unrealized_conversion_cast %3 : f32 to vector<1xf32>
    return %4 : vector<1xf32>
  }
  func.func @vector_load_aligned(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %3 = spirv.Bitcast %2 : !spirv.ptr<f32, StorageBuffer> to !spirv.ptr<vector<4xf32>, StorageBuffer>
    %4 = spirv.Load "StorageBuffer" %3 ["Aligned", 8] : vector<4xf32>
    return %4 : vector<4xf32>
  }
  func.func @vector_load_2d(%arg0: memref<4x4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %c1 = arith.constant 1 : index
    %2 = builtin.unrealized_conversion_cast %c1 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %3 = spirv.IMul %1, %cst4_i32 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %4 = spirv.IAdd %2, %3 : i32
    %5 = spirv.AccessChain %0[%cst0_i32, %4] : !spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %6 = spirv.Bitcast %5 : !spirv.ptr<f32, StorageBuffer> to !spirv.ptr<vector<4xf32>, StorageBuffer>
    %7 = spirv.Load "StorageBuffer" %6 : vector<4xf32>
    return %7 : vector<4xf32>
  }
  func.func @vector_store(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: vector<4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %3 = spirv.Bitcast %2 : !spirv.ptr<f32, StorageBuffer> to !spirv.ptr<vector<4xf32>, StorageBuffer>
    spirv.Store "StorageBuffer" %3, %arg1 : vector<4xf32>
    return
  }
  func.func @vector_store_aligned(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: vector<4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %2 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %3 = spirv.Bitcast %2 : !spirv.ptr<f32, StorageBuffer> to !spirv.ptr<vector<4xf32>, StorageBuffer>
    spirv.Store "StorageBuffer" %3, %arg1 ["Aligned", 8] : vector<4xf32>
    return
  }
  func.func @vector_store_single_elem(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: vector<1xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<1xf32> to f32
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %3 = spirv.AccessChain %0[%cst0_i32, %2] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %3, %1 : f32
    return
  }
  func.func @vector_store_2d(%arg0: memref<4x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: vector<4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %c1 = arith.constant 1 : index
    %2 = builtin.unrealized_conversion_cast %c1 : index to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %3 = spirv.IMul %1, %cst4_i32 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %4 = spirv.IAdd %2, %3 : i32
    %5 = spirv.AccessChain %0[%cst0_i32, %4] : !spirv.ptr<!spirv.struct<(!spirv.array<16 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %6 = spirv.Bitcast %5 : !spirv.ptr<f32, StorageBuffer> to !spirv.ptr<vector<4xf32>, StorageBuffer>
    spirv.Store "StorageBuffer" %6, %arg1 : vector<4xf32>
    return
  }
}

// -----
module {
  func.func @vector_load(%arg0: memref<4xf32, #spirv.storage_class<StorageBuffer>>) -> vector<4xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.load %arg0[%c0] : memref<4xf32, #spirv.storage_class<StorageBuffer>>, vector<4xf32>
    return %0 : vector<4xf32>
  }
}

