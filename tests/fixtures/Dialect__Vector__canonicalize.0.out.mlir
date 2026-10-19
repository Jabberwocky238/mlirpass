module {
  func.func @create_vector_mask_to_constant_mask() -> vector<4x3xi1> {
    %0 = vector.constant_mask [3, 2] : vector<4x3xi1>
    return %0 : vector<4x3xi1>
  }
}

// -----
module {
  func.func @create_scalable_vector_mask_to_constant_mask() -> vector<[8]xi1> {
    %cst = arith.constant dense<false> : vector<[8]xi1>
    return %cst : vector<[8]xi1>
  }
}

// -----
module {
  func.func @create_vector_mask_to_constant_mask_truncation() -> vector<4x3xi1> {
    %0 = vector.constant_mask [4, 2] : vector<4x3xi1>
    return %0 : vector<4x3xi1>
  }
}

// -----
module {
  func.func @create_vector_mask_to_constant_mask_truncation_neg() -> vector<4x3xi1> {
    %cst = arith.constant dense<false> : vector<4x3xi1>
    return %cst : vector<4x3xi1>
  }
}

// -----
module {
  func.func @create_vector_mask_to_constant_mask_truncation_zero() -> vector<4x3xi1> {
    %cst = arith.constant dense<false> : vector<4x3xi1>
    return %cst : vector<4x3xi1>
  }
}

// -----
module {
  func.func @create_vector_mask_to_constant_mask_scalable_all_true() -> vector<8x[16]xi1> {
    %cst = arith.constant dense<true> : vector<8x[16]xi1>
    return %cst : vector<8x[16]xi1>
  }
}

// -----
module {
  func.func @create_mask_transpose_to_transposed_create_mask(%arg0: index, %arg1: index, %arg2: index) -> (vector<2x3x4xi1>, vector<4x2x3xi1>) {
    %0 = vector.create_mask %arg0, %arg1, %arg2 : vector<2x3x4xi1>
    %1 = vector.create_mask %arg2, %arg0, %arg1 : vector<4x2x3xi1>
    return %0, %1 : vector<2x3x4xi1>, vector<4x2x3xi1>
  }
}

// -----
module {
  func.func @extract_from_create_mask(%arg0: index, %arg1: index) -> vector<[4]x[4]xi1> {
    %0 = vector.create_mask %arg0, %arg1 : vector<[4]x[4]xi1>
    return %0 : vector<[4]x[4]xi1>
  }
}

// -----
module {
  func.func @extract_from_create_mask_all_false(%arg0: index, %arg1: index) -> vector<[4]x[4]xi1> {
    %cst = arith.constant dense<false> : vector<[4]x[4]xi1>
    return %cst : vector<[4]x[4]xi1>
  }
}

// -----
module {
  func.func @extract_from_create_mask_leading_scalable(%arg0: index) -> vector<8xi1> {
    %0 = vector.create_mask %arg0 : vector<8xi1>
    return %0 : vector<8xi1>
  }
}

// -----
module {
  func.func @extract_from_create_mask_dynamic_position(%arg0: index, %arg1: index) -> vector<6xi1> {
    %0 = vector.create_mask %arg0 : vector<6xi1>
    return %0 : vector<6xi1>
  }
}

// -----
module {
  func.func @extract_scalar_poison() -> f32 {
    %0 = ub.poison : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_vector_poison() -> vector<8xf32> {
    %0 = ub.poison : vector<8xf32>
    return %0 : vector<8xf32>
  }
}

// -----
module {
  func.func @extract_scalar_poison_idx(%arg0: vector<4x5xf32>) -> f32 {
    %0 = ub.poison : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_scalar_poison_idx_non_cst(%arg0: vector<4x5xf32>) -> f32 {
    %0 = ub.poison : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @no_fold_extract_scalar_oob_idx(%arg0: vector<4x5xf32>) -> f32 {
    %c-2 = arith.constant -2 : index
    %0 = vector.extract %arg0[%c-2, 0] : f32 from vector<4x5xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_vector_poison_idx(%arg0: vector<4x5xf32>) -> vector<5xf32> {
    %0 = ub.poison : vector<5xf32>
    return %0 : vector<5xf32>
  }
}

// -----
module {
  func.func @extract_multiple_poison_idx(%arg0: vector<4x5x8xf32>) -> vector<8xf32> {
    %0 = ub.poison : vector<8xf32>
    return %0 : vector<8xf32>
  }
}

// -----
module {
  func.func @extract_from_create_mask_dynamic_position_all_false(%arg0: index, %arg1: index) -> vector<6xi1> {
    %cst = arith.constant dense<false> : vector<6xi1>
    return %cst : vector<6xi1>
  }
}

// -----
module {
  func.func @extract_from_create_mask_dynamic_position_unknown(%arg0: index, %arg1: index) -> vector<6xi1> {
    %c2 = arith.constant 2 : index
    %0 = vector.create_mask %c2, %arg0 : vector<4x6xi1>
    %1 = vector.extract %0[%arg1] : vector<6xi1> from vector<4x6xi1>
    return %1 : vector<6xi1>
  }
}

// -----
module {
  func.func @extract_from_create_mask_mixed_position_unknown(%arg0: index, %arg1: index) -> vector<4xi1> {
    %c2 = arith.constant 2 : index
    %0 = vector.create_mask %c2, %c2, %arg0 : vector<2x4x4xi1>
    %1 = vector.extract %0[1, %arg1] : vector<4xi1> from vector<2x4x4xi1>
    return %1 : vector<4xi1>
  }
}

// -----
module {
  func.func @extract_from_non_constant_create_mask(%arg0: index) -> vector<[2]xi1> {
    %0 = vector.create_mask %arg0, %arg0 : vector<[2]x[2]xi1>
    %1 = vector.extract %0[0] : vector<[2]xi1> from vector<[2]x[2]xi1>
    return %1 : vector<[2]xi1>
  }
}

// -----
module {
  func.func @constant_mask_to_true_splat() -> vector<2x4xi1> {
    %cst = arith.constant dense<true> : vector<2x4xi1>
    return %cst : vector<2x4xi1>
  }
  func.func @constant_mask_to_false_splat() -> vector<2x4xi1> {
    %cst = arith.constant dense<false> : vector<2x4xi1>
    return %cst : vector<2x4xi1>
  }
  func.func @constant_mask_to_true_splat_0d() -> vector<i1> {
    %cst = arith.constant dense<true> : vector<i1>
    return %cst : vector<i1>
  }
  func.func @constant_mask_transpose_to_transposed_constant_mask() -> (vector<2x3x4xi1>, vector<4x2x3xi1>) {
    %0 = vector.constant_mask [1, 2, 3] : vector<2x3x4xi1>
    %1 = vector.constant_mask [3, 1, 2] : vector<4x2x3xi1>
    return %0, %1 : vector<2x3x4xi1>, vector<4x2x3xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x2xi1> {
    %cst = arith.constant dense<true> : vector<2x2xi1>
    return %cst : vector<2x2xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x2xi1> {
    %0 = vector.constant_mask [1, 2] : vector<2x2xi1>
    return %0 : vector<2x2xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x2xi1> {
    %0 = vector.constant_mask [2, 1] : vector<2x2xi1>
    return %0 : vector<2x2xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x2xi1> {
    %cst = arith.constant dense<false> : vector<2x2xi1>
    return %cst : vector<2x2xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x1xi1> {
    %cst = arith.constant dense<false> : vector<2x1xi1>
    return %cst : vector<2x1xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x1xi1> {
    %cst = arith.constant dense<true> : vector<2x1xi1>
    return %cst : vector<2x1xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<2x1xi1> {
    %0 = vector.constant_mask [1, 1] : vector<2x1xi1>
    return %0 : vector<2x1xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_of_create_mask(%arg0: index, %arg1: index) -> vector<2x2xi1> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %0 = arith.subi %arg0, %c2 : index
    %1 = arith.subi %arg1, %c1 : index
    %2 = vector.create_mask %0, %1 : vector<2x2xi1>
    return %2 : vector<2x2xi1>
  }
}

// -----
module {
  func.func @extract_strided_slice_partial_of_create_mask(%arg0: index, %arg1: index, %arg2: index) -> vector<2x2x8xi1> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %0 = arith.subi %arg0, %c2 : index
    %1 = arith.subi %arg1, %c1 : index
    %2 = vector.create_mask %0, %1, %arg2 : vector<2x2x8xi1>
    return %2 : vector<2x2x8xi1>
  }
}

// -----
module {
  func.func @extract_strided_fold(%arg0: vector<4x3xi1>) -> vector<4x3xi1> {
    return %arg0 : vector<4x3xi1>
  }
}

// -----
module {
  func.func @extract_strided_fold_insert(%arg0: vector<4x4xf32>, %arg1: vector<8x16xf32>) -> vector<4x4xf32> {
    return %arg0 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @extract_strided_fold_insert(%arg0: vector<6x4xf32>, %arg1: vector<8x16xf32>) -> vector<4x4xf32> {
    %0 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [4, 4], strides = [1, 1]} : vector<6x4xf32> to vector<4x4xf32>
    return %0 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @negative_extract_strided_fold(%arg0: vector<4x4xf32>, %arg1: vector<8x16xf32>) -> vector<6x4xf32> {
    %0 = vector.insert_strided_slice %arg0, %arg1 {offsets = [2, 2], strides = [1, 1]} : vector<4x4xf32> into vector<8x16xf32>
    %1 = vector.extract_strided_slice %0 {offsets = [2, 2], sizes = [6, 4], strides = [1, 1]} : vector<8x16xf32> to vector<6x4xf32>
    return %1 : vector<6x4xf32>
  }
}

// -----
module {
  func.func @extract_strided_fold_insert(%arg0: vector<2x8xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>) -> vector<1x1xf32> {
    %0 = vector.extract_strided_slice %arg1 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<1x4xf32> to vector<1x1xf32>
    return %0 : vector<1x1xf32>
  }
}

// -----
module {
  func.func @transpose_3D_identity(%arg0: vector<4x3x2xf32>) -> vector<4x3x2xf32> {
    return %arg0 : vector<4x3x2xf32>
  }
}

// -----
module {
  func.func @transpose_2D_sequence(%arg0: vector<4x3xf32>) -> vector<4x3xf32> {
    %0 = arith.addf %arg0, %arg0 : vector<4x3xf32>
    return %0 : vector<4x3xf32>
  }
}

// -----
module {
  func.func @transpose_3D_sequence(%arg0: vector<4x3x2xf32>) -> vector<4x3x2xf32> {
    %0 = vector.transpose %arg0, [2, 1, 0] : vector<4x3x2xf32> to vector<2x3x4xf32>
    %1 = vector.transpose %arg0, [2, 1, 0] : vector<4x3x2xf32> to vector<2x3x4xf32>
    %2 = arith.mulf %0, %1 : vector<2x3x4xf32>
    %3 = vector.transpose %2, [2, 1, 0] : vector<2x3x4xf32> to vector<4x3x2xf32>
    %4 = arith.addf %3, %arg0 : vector<4x3x2xf32>
    return %4 : vector<4x3x2xf32>
  }
}

// -----
module {
  func.func @cast_transfers(%arg0: memref<4x8xf32>) -> vector<4x8xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<4x8xf32>, vector<4x8xf32>
    vector.transfer_write %0, %arg0[%c0, %c0] {in_bounds = [true, true]} : vector<4x8xf32>, memref<4x8xf32>
    return %0 : vector<4x8xf32>
  }
}

// -----
module {
  func.func @cast_transfers(%arg0: tensor<4x8xf32>) -> vector<4x8xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : tensor<4x8xf32>, vector<4x8xf32>
    return %0 : vector<4x8xf32>
  }
}

// -----
module {
  func.func @insert_extract_transpose_2d(%arg0: vector<2x3xf32>, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> (f32, f32, f32) {
    return %arg3, %arg2, %arg3 : f32, f32, f32
  }
}

// -----
module {
  func.func @insert_extract_chain(%arg0: vector<3x3x4xf32>, %arg1: vector<3x4xf32>, %arg2: vector<4xf32>) -> (vector<4xf32>, vector<4xf32>, vector<3x4xf32>, vector<3x4xf32>) {
    %0 = vector.insert %arg1, %arg0 [0] : vector<3x4xf32> into vector<3x3x4xf32>
    %1 = vector.insert %arg1, %0 [1] : vector<3x4xf32> into vector<3x3x4xf32>
    %2 = vector.insert %arg2, %1 [1, 0] : vector<4xf32> into vector<3x3x4xf32>
    %3 = vector.insert %arg2, %2 [1, 1] : vector<4xf32> into vector<3x3x4xf32>
    %4 = vector.extract %arg1[0] : vector<4xf32> from vector<3x4xf32>
    %5 = vector.extract %3[1] : vector<3x4xf32> from vector<3x3x4xf32>
    return %arg2, %4, %5, %arg1 : vector<4xf32>, vector<4xf32>, vector<3x4xf32>, vector<3x4xf32>
  }
}

// -----
module {
  func.func @insert_extract_transpose_3d(%arg0: vector<2x3x4xf32>, %arg1: vector<4x3xf32>, %arg2: f32) -> (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<3x4xf32>) {
    %0 = vector.extract %arg0[1, 2] : vector<4xf32> from vector<2x3x4xf32>
    %1 = vector.transpose %arg0, [2, 1, 0] : vector<2x3x4xf32> to vector<4x3x2xf32>
    %2 = vector.insert %arg2, %1 [0, 2, 1] : f32 into vector<4x3x2xf32>
    %3 = vector.transpose %2, [2, 1, 0] : vector<4x3x2xf32> to vector<2x3x4xf32>
    %4 = vector.extract %3[1, 2] : vector<4xf32> from vector<2x3x4xf32>
    %5 = vector.transpose %arg0, [0, 2, 1] : vector<2x3x4xf32> to vector<2x4x3xf32>
    %6 = vector.insert %arg1, %5 [0] : vector<4x3xf32> into vector<2x4x3xf32>
    %7 = vector.transpose %6, [0, 2, 1] : vector<2x4x3xf32> to vector<2x3x4xf32>
    %8 = vector.extract %7[0, 1] : vector<4xf32> from vector<2x3x4xf32>
    %9 = vector.transpose %arg0, [0, 2, 1] : vector<2x3x4xf32> to vector<2x4x3xf32>
    %10 = vector.insert %arg1, %9 [0] : vector<4x3xf32> into vector<2x4x3xf32>
    %11 = vector.transpose %10, [0, 2, 1] : vector<2x4x3xf32> to vector<2x3x4xf32>
    %12 = vector.extract %11[0] : vector<3x4xf32> from vector<2x3x4xf32>
    return %0, %4, %8, %12 : vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<3x4xf32>
  }
}

// -----
module {
  func.func @fold_extracts(%arg0: vector<3x4x5x6xf32>) -> (f32, vector<4x5x6xf32>) {
    %0 = vector.extract %arg0[0, 1, 2, 3] : f32 from vector<3x4x5x6xf32>
    %1 = vector.extract %arg0[0] : vector<4x5x6xf32> from vector<3x4x5x6xf32>
    return %0, %1 : f32, vector<4x5x6xf32>
  }
}

// -----
module {
  func.func @fold_extract_transpose(%arg0: vector<3x4x5x6xf32>, %arg1: vector<3x6x5x6xf32>) -> (vector<6xf32>, vector<6xf32>, vector<6xf32>) {
    %0 = vector.extract %arg0[0, 2, 1] : vector<6xf32> from vector<3x4x5x6xf32>
    %1 = vector.extract %arg0[2, 0, 1] : vector<6xf32> from vector<3x4x5x6xf32>
    %2 = vector.transpose %arg1, [0, 2, 3, 1] : vector<3x6x5x6xf32> to vector<3x5x6x6xf32>
    %3 = vector.extract %2[0, 1, 2] : vector<6xf32> from vector<3x5x6x6xf32>
    return %0, %1, %3 : vector<6xf32>, vector<6xf32>, vector<6xf32>
  }
}

// -----
module {
  func.func @fold_extract_broadcast_same_input_output_scalar(%arg0: f32, %arg1: index, %arg2: index, %arg3: index) -> f32 {
    return %arg0 : f32
  }
}

// -----
module {
  func.func @fold_extract_broadcast_same_input_output_vec(%arg0: vector<4xf32>, %arg1: index, %arg2: index) -> vector<4xf32> {
    return %arg0 : vector<4xf32>
  }
}

// -----
module {
  func.func @fold_extract_broadcast_0dvec_input_scalar_output(%arg0: vector<f32>, %arg1: index, %arg2: index, %arg3: index) -> f32 {
    %0 = vector.extract %arg0[] : f32 from vector<f32>
    return %0 : f32
  }
}

// -----
module {
  func.func @negative_fold_extract_broadcast(%arg0: vector<1x1xf32>) -> vector<4xf32> {
    %0 = vector.broadcast %arg0 : vector<1x1xf32> to vector<1x1x4xf32>
    %1 = vector.extract %0[0, 0] : vector<4xf32> from vector<1x1x4xf32>
    return %1 : vector<4xf32>
  }
}

// -----
module {
  func.func @fold_extract_splatlike(%arg0: f32, %arg1: index, %arg2: index, %arg3: index) -> f32 {
    return %arg0 : f32
  }
}

// -----
module {
  func.func @fold_extract_vector_from_splat(%arg0: f32, %arg1: index, %arg2: index) -> vector<4xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @fold_extract_broadcast_dim1_broadcasting(%arg0: vector<2x1xf32>, %arg1: index, %arg2: index, %arg3: index) -> f32 {
    %0 = vector.extract %arg0[%arg2, 0] : f32 from vector<2x1xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @fold_extract_broadcast_to_lower_rank(%arg0: vector<2x4xf32>, %arg1: index, %arg2: index) -> vector<4xf32> {
    %0 = vector.extract %arg0[%arg2] : vector<4xf32> from vector<2x4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @fold_extract_shape_cast_to_lower_rank(%arg0: vector<2x4xf32>, %arg1: index, %arg2: index) -> vector<4xf32> {
    %0 = vector.extract %arg0[%arg2] : vector<4xf32> from vector<2x4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @negative_fold_extract_shape_cast_to_lower_rank(%arg0: vector<2x4xf32>, %arg1: index, %arg2: index) -> vector<2xf32> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf32> to vector<1x4x2xf32>
    %1 = vector.extract %0[%arg1, %arg2] : vector<2xf32> from vector<1x4x2xf32>
    return %1 : vector<2xf32>
  }
}

// -----
module {
  func.func @fold_extract_broadcast_to_higher_rank(%arg0: f32, %arg1: index, %arg2: index) -> vector<4xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @fold_extract_broadcast_to_equal_rank(%arg0: vector<1xf32>, %arg1: index) -> vector<8xf32> {
    %0 = vector.broadcast %arg0 : vector<1xf32> to vector<8xf32>
    return %0 : vector<8xf32>
  }
}

// -----
module {
  func.func @fold_extract_broadcastlike_shape_cast(%arg0: vector<1xf32>, %arg1: index) -> vector<1x1xf32> {
    %0 = vector.broadcast %arg0 : vector<1xf32> to vector<1x1xf32>
    return %0 : vector<1x1xf32>
  }
}

// -----
module {
  func.func @fold_extract_shuffle(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> (f32, f32, f32, f32) {
    %0 = vector.extract %arg0[0] : f32 from vector<8xf32>
    %1 = vector.extract %arg1[0] : f32 from vector<8xf32>
    %2 = vector.extract %arg0[7] : f32 from vector<8xf32>
    %3 = vector.extract %arg1[7] : f32 from vector<8xf32>
    return %0, %1, %2, %3 : f32, f32, f32, f32
  }
}

// -----
module {
  func.func @fold_extract_shapecast(%arg0: vector<5x1x3x2xf32>, %arg1: vector<8x4x2xf32>) -> (f32, vector<2xf32>, vector<4x2xf32>, vector<8x4x2xf32>) {
    %0 = vector.extract %arg0[1, 0, 1, 1] : f32 from vector<5x1x3x2xf32>
    %1 = vector.extract %arg0[1, 0, 2] : vector<2xf32> from vector<5x1x3x2xf32>
    %2 = vector.extract %arg1[7] : vector<4x2xf32> from vector<8x4x2xf32>
    return %0, %1, %2, %arg1 : f32, vector<2xf32>, vector<4x2xf32>, vector<8x4x2xf32>
  }
}

// -----
module {
  func.func @fold_extract_shapecast_0d_result(%arg0: vector<1x1x1xf32>) -> f32 {
    %0 = vector.extract %arg0[0, 0, 0] : f32 from vector<1x1x1xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @fold_extract_shapecast_0d_source(%arg0: vector<f32>) -> f32 {
    %0 = vector.extract %arg0[] : f32 from vector<f32>
    return %0 : f32
  }
}

// -----
module {
  func.func @negative_fold_extract_shapecast(%arg0: vector<16xf32>) -> vector<4x2xf32> {
    %0 = vector.shape_cast %arg0 : vector<16xf32> to vector<2x4x2xf32>
    %1 = vector.extract %0[1] : vector<4x2xf32> from vector<2x4x2xf32>
    return %1 : vector<4x2xf32>
  }
}

// -----
module {
  func.func @fold_extract_shapecast_to_shapecast(%arg0: vector<3x4xf32>) -> vector<12xf32> {
    %0 = vector.shape_cast %arg0 : vector<3x4xf32> to vector<12xf32>
    return %0 : vector<12xf32>
  }
}

// -----
module {
  func.func @extract_no_fold_scalar_to_0d(%arg0: vector<f32>) -> f32 {
    %0 = vector.extract %arg0[] : f32 from vector<f32>
    return %0 : f32
  }
}

// -----
module {
  func.func @insert_fold_same_rank(%arg0: vector<2x2xf32>) -> vector<2x2xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    return %cst : vector<2x2xf32>
  }
}

// -----
module {
  func.func @insert_no_fold_scalar_to_0d(%arg0: vector<f32>) -> vector<f32> {
    %cst = arith.constant dense<0.000000e+00> : vector<f32>
    return %cst : vector<f32>
  }
}

// -----
module {
  func.func @dont_fold_expand_collapse(%arg0: vector<1x1x64xf32>) -> vector<8x8xf32> {
    %0 = vector.shape_cast %arg0 : vector<1x1x64xf32> to vector<8x8xf32>
    return %0 : vector<8x8xf32>
  }
}

// -----
module {
  func.func @fold_broadcast_shapecast(%arg0: vector<4xf32>) -> vector<4xf32> {
    return %arg0 : vector<4xf32>
  }
}

// -----
module {
  func.func @canonicalize_broadcast_shapecast_scalar(%arg0: f32) -> vector<1xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<1xf32>
    return %0 : vector<1xf32>
  }
}

// -----
module {
  func.func @dont_fold_broadcast_shapecast_diff_shape(%arg0: vector<4xf32>) -> vector<8xf32> {
    %0 = vector.broadcast %arg0 : vector<4xf32> to vector<1x2x4xf32>
    %1 = vector.shape_cast %0 : vector<1x2x4xf32> to vector<8xf32>
    return %1 : vector<8xf32>
  }
}

// -----
module {
  func.func @canonicalize_broadcast_shapecast_to_broadcast(%arg0: vector<3xf32>) -> vector<8x3xf32> {
    %0 = vector.broadcast %arg0 : vector<3xf32> to vector<8x3xf32>
    return %0 : vector<8x3xf32>
  }
}

// -----
module {
  func.func @canonicalize_broadcast_shapecast_to_broadcast_ones(%arg0: vector<1x1xi8>) -> vector<1x1x6x1x4xi8> {
    %0 = vector.broadcast %arg0 : vector<1x1xi8> to vector<1x1x6x1x4xi8>
    return %0 : vector<1x1x6x1x4xi8>
  }
}

// -----
module {
  func.func @canonicalize_broadcast_shapecast_to_broadcast_scalar(%arg0: f32) -> vector<3x4x1xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<3x4x1xf32>
    return %0 : vector<3x4x1xf32>
  }
}

// -----
module {
  func.func @canonicalize_broadcast_shapecast_to_shapcast(%arg0: vector<2xf32>) -> vector<1x2x1xf32> {
    %0 = vector.shape_cast %arg0 : vector<2xf32> to vector<1x2x1xf32>
    return %0 : vector<1x2x1xf32>
  }
}

// -----
module {
  func.func @canonicalize_broadcast_shapecast_both_possible(%arg0: vector<1xf32>) -> vector<1x1xf32> {
    %0 = vector.shape_cast %arg0 : vector<1xf32> to vector<1x1xf32>
    return %0 : vector<1x1xf32>
  }
}

// -----
module {
  func.func @canonicalize_shapecast_broadcast_to_broadcast_prepend_dim(%arg0: vector<2xf32>) -> vector<32x2xf32> {
    %0 = vector.broadcast %arg0 : vector<2xf32> to vector<32x2xf32>
    return %0 : vector<32x2xf32>
  }
}

// -----
module {
  func.func @canonicalize_shapecast_broadcast_to_broadcast_prepend_dim2(%arg0: vector<2x1xf32>) -> vector<32x2x1xf32> {
    %0 = vector.broadcast %arg0 : vector<2x1xf32> to vector<32x2x1xf32>
    return %0 : vector<32x2x1xf32>
  }
}

// -----
module {
  func.func @canonicalize_shapecast_broadcast_to_broadcast_prepend_dim3(%arg0: vector<2x1xf32>) -> vector<32x2x4xf32> {
    %0 = vector.broadcast %arg0 : vector<2x1xf32> to vector<32x2x4xf32>
    return %0 : vector<32x2x4xf32>
  }
}

// -----
module {
  func.func @canonicalize_shapecast_broadcast_to_broadcast_remove_leading_dim(%arg0: vector<1x2xf32>) -> vector<32x2xf32> {
    %0 = vector.broadcast %arg0 : vector<1x2xf32> to vector<32x2xf32>
    return %0 : vector<32x2xf32>
  }
}

// -----
module {
  func.func @negative_canonicalize_shapecast_broadcast_invalid_shape(%arg0: vector<64xf32>) -> vector<2x4x16xf32> {
    %0 = vector.shape_cast %arg0 : vector<64xf32> to vector<4x16xf32>
    %1 = vector.broadcast %0 : vector<4x16xf32> to vector<2x4x16xf32>
    return %1 : vector<2x4x16xf32>
  }
}

// -----
module {
  func.func @negative_canonicalize_shapecast_broadcast_invalid_broadcasted_dims(%arg0: vector<2x1xf32>) -> vector<2x2xf32> {
    %0 = vector.shape_cast %arg0 : vector<2x1xf32> to vector<1x2xf32>
    %1 = vector.broadcast %0 : vector<1x2xf32> to vector<2x2xf32>
    return %1 : vector<2x2xf32>
  }
}

// -----
module {
  func.func @negative_canonicalize_shapecast_broadcast_to_broadcast_append_dim(%arg0: vector<2xf32>) -> vector<2x4xf32> {
    %0 = vector.shape_cast %arg0 : vector<2xf32> to vector<2x1xf32>
    %1 = vector.broadcast %0 : vector<2x1xf32> to vector<2x4xf32>
    return %1 : vector<2x4xf32>
  }
}

// -----
module {
  func.func @negative_canonicalize_shapecast_broadcast_to_broadcast_remove_trailing_dim(%arg0: vector<2x1xf32>) -> vector<32x2xf32> {
    %0 = vector.shape_cast %arg0 : vector<2x1xf32> to vector<2xf32>
    %1 = vector.broadcast %0 : vector<2xf32> to vector<32x2xf32>
    return %1 : vector<32x2xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
module {
  func.func @fold_vector_transfer_masks(%arg0: memref<?x?xf32>) -> (vector<4x8xf32>, vector<4x[4]xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {permutation_map = #map} : memref<?x?xf32>, vector<4x8xf32>
    vector.transfer_write %0, %arg0[%c0, %c0] {permutation_map = #map} : vector<4x8xf32>, memref<?x?xf32>
    %1 = vector.transfer_read %arg0[%c0, %c0], %cst : memref<?x?xf32>, vector<4x[4]xf32>
    vector.transfer_write %1, %arg0[%c0, %c0] : vector<4x[4]xf32>, memref<?x?xf32>
    return %0, %1 : vector<4x8xf32>, vector<4x[4]xf32>
  }
}

// -----
module {
  func.func @fold_vector_transfers(%arg0: memref<?x8xf32>) -> (vector<4x8xf32>, vector<4x9xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [false, true]} : memref<?x8xf32>, vector<4x8xf32>
    vector.transfer_write %0, %arg0[%c0, %c0] {in_bounds = [false, true]} : vector<4x8xf32>, memref<?x8xf32>
    %1 = vector.transfer_read %arg0[%c0, %c0], %cst : memref<?x8xf32>, vector<4x9xf32>
    vector.transfer_write %1, %arg0[%c0, %c0] : vector<4x9xf32>, memref<?x8xf32>
    return %0, %1 : vector<4x8xf32>, vector<4x9xf32>
  }
}

// -----
module {
  func.func @bitcast_folding(%arg0: vector<4x8xf32>, %arg1: vector<2xi32>) -> (vector<4x8xf32>, vector<2xi32>) {
    return %arg0, %arg1 : vector<4x8xf32>, vector<2xi32>
  }
}

// -----
module {
  func.func @bitcast_f16_to_f32() -> (vector<4xf32>, vector<4xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant dense<2.00390625> : vector<4xf32>
    return %cst, %cst_0 : vector<4xf32>, vector<4xf32>
  }
}

// -----
module {
  func.func @bitcast_i8_to_i32() -> (vector<4xi32>, vector<4xi32>) {
    %cst = arith.constant dense<0> : vector<4xi32>
    %cst_0 = arith.constant dense<-1600085856> : vector<4xi32>
    return %cst, %cst_0 : vector<4xi32>, vector<4xi32>
  }
}

// -----
module {
  func.func @broadcast_poison() -> vector<4x6xi8> {
    %0 = ub.poison : vector<4x6xi8>
    return %0 : vector<4x6xi8>
  }
}

// -----
module {
  func.func @broadcast_splat_constant() -> vector<4x6xi8> {
    %cst = arith.constant dense<1> : vector<4x6xi8>
    return %cst : vector<4x6xi8>
  }
}

// -----
module {
  func.func @broadcast_folding1() -> vector<4xi32> {
    %cst = arith.constant dense<42> : vector<4xi32>
    return %cst : vector<4xi32>
  }
}

// -----
module {
  func.func @broadcast_folding2() -> vector<4x16xi32> {
    %cst = arith.constant dense<42> : vector<4x16xi32>
    return %cst : vector<4x16xi32>
  }
}

// -----
module {
  func.func @fold_consecutive_broadcasts(%arg0: i32) -> vector<4x16xi32> {
    %0 = vector.broadcast %arg0 : i32 to vector<4x16xi32>
    return %0 : vector<4x16xi32>
  }
}

// -----
module {
  func.func @shape_cast_splat_constant() -> (vector<20x2xf32>, vector<3x4x2xi32>) {
    %cst = arith.constant dense<2.000000e+00> : vector<20x2xf32>
    %cst_0 = arith.constant dense<1> : vector<3x4x2xi32>
    return %cst, %cst_0 : vector<20x2xf32>, vector<3x4x2xi32>
  }
}

// -----
module {
  func.func @shape_cast_dense_int_constant() -> vector<2x3xi8> {
    %cst = arith.constant dense<[[2, 3, 5], [7, 11, 13]]> : vector<2x3xi8>
    return %cst : vector<2x3xi8>
  }
}

// -----
module {
  func.func @shape_cast_dense_float_constant() -> (vector<2xf32>, vector<1x2xf32>) {
    %cst = arith.constant dense<[[1.000000e+00, 2.000000e+00]]> : vector<1x2xf32>
    %cst_0 = arith.constant dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>
    return %cst_0, %cst : vector<2xf32>, vector<1x2xf32>
  }
}

// -----
module {
  func.func @shape_cast_poison() -> (vector<20x2xf32>, vector<3x4x2xi32>) {
    %0 = ub.poison : vector<20x2xf32>
    %1 = ub.poison : vector<3x4x2xi32>
    return %0, %1 : vector<20x2xf32>, vector<3x4x2xi32>
  }
}

// -----
module {
  func.func @extract_strided_constant() -> (vector<12x2xf32>, vector<2x13x3xi32>) {
    %cst = arith.constant dense<2.000000e+00> : vector<12x2xf32>
    %cst_0 = arith.constant dense<1> : vector<2x13x3xi32>
    return %cst, %cst_0 : vector<12x2xf32>, vector<2x13x3xi32>
  }
}

// -----
module {
  func.func @extract_strided_broadcast(%arg0: vector<4xf16>) -> vector<2x4xf16> {
    %0 = vector.broadcast %arg0 : vector<4xf16> to vector<2x4xf16>
    return %0 : vector<2x4xf16>
  }
}

// -----
module {
  func.func @extract_strided_broadcast2(%arg0: vector<4xf16>) -> vector<2x2xf16> {
    %0 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf16> to vector<2xf16>
    %1 = vector.broadcast %0 : vector<2xf16> to vector<2x2xf16>
    return %1 : vector<2x2xf16>
  }
}

// -----
module {
  func.func @extract_strided_broadcast3(%arg0: vector<1xf32>) -> vector<1x4xf32> {
    %0 = vector.broadcast %arg0 : vector<1xf32> to vector<1x4xf32>
    return %0 : vector<1x4xf32>
  }
}

// -----
module {
  func.func @extract_strided_broadcast4(%arg0: f32) -> vector<1x4xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<1x4xf32>
    return %0 : vector<1x4xf32>
  }
}

// -----
module {
  func.func @extract_strided_broadcast5(%arg0: vector<2x1xf32>) -> vector<2x4xf32> {
    %0 = vector.broadcast %arg0 : vector<2x1xf32> to vector<2x4xf32>
    return %0 : vector<2x4xf32>
  }
}

// -----
module {
  func.func @consecutive_shape_cast(%arg0: vector<16xf16>) -> vector<4x4xf16> {
    %0 = vector.shape_cast %arg0 : vector<16xf16> to vector<4x4xf16>
    return %0 : vector<4x4xf16>
  }
}

// -----
module {
  func.func @dead_transfer_op(%arg0: tensor<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: vector<1x4xf32>) {
    return
  }
}

// -----
module {
  func.func @dead_load(%arg0: memref<?xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>) {
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @contractions(%arg0: vector<2x3xf32>, %arg1: vector<3x4xf32>, %arg2: vector<2x4xf32>, %arg3: vector<2x3xi8>, %arg4: vector<3x4xi8>, %arg5: vector<2x4xi8>) -> (vector<2x4xf32>, vector<2x4xi8>) {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<2x3xf32>, vector<3x4xf32> into vector<2x4xf32>
    %1 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg3, %arg4, %arg5 : vector<2x3xi8>, vector<3x4xi8> into vector<2x4xi8>
    return %0, %1 : vector<2x4xf32>, vector<2x4xi8>
  }
}

// -----
module {
  func.func @transfer_folding_1(%arg0: tensor<2x3x4xf32>, %arg1: tensor<2x3x4xf32>) -> (tensor<2x3x4xf32>, tensor<2x3x4xf32>, tensor<2x3x4xf32>) {
    %0 = "some_op_that_may_have_side_effects"() : () -> tensor<2x3x4xf32>
    return %arg0, %arg0, %arg0 : tensor<2x3x4xf32>, tensor<2x3x4xf32>, tensor<2x3x4xf32>
  }
}

// -----
module {
  func.func @store_after_load_tensor(%arg0: tensor<4x4xf32>) -> tensor<4x4xf32> {
    return %arg0 : tensor<4x4xf32>
  }
}

// -----
module {
  func.func @negative_store_after_load_tensor(%arg0: tensor<4x4xf32>) -> tensor<4x4xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c1, %c0], %cst {in_bounds = [true, true]} : tensor<4x4xf32>, vector<1x4xf32>
    %1 = vector.transfer_write %0, %arg0[%c0, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    return %1 : tensor<4x4xf32>
  }
}

// -----
module {
  func.func @store_to_load_tensor(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>) -> vector<1x4xf32> {
    return %arg1 : vector<1x4xf32>
  }
}

// -----
module {
  func.func @negative_store_to_load_tensor(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>, %arg3: index) -> vector<1x4xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_write %arg1, %arg0[%c1, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    %1 = vector.transfer_write %arg1, %0[%arg3, %arg3] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    %2 = vector.transfer_read %1[%c1, %c0], %cst {in_bounds = [true, true]} : tensor<4x4xf32>, vector<1x4xf32>
    return %2 : vector<1x4xf32>
  }
}

// -----
module {
  func.func @store_to_load_tensor_broadcast(%arg0: tensor<4x4xf32>, %arg1: vector<4x2xf32>) -> vector<4x2x6xf32> {
    %0 = vector.broadcast %arg1 : vector<4x2xf32> to vector<6x4x2xf32>
    %1 = vector.transpose %0, [1, 2, 0] : vector<6x4x2xf32> to vector<4x2x6xf32>
    return %1 : vector<4x2x6xf32>
  }
}

// -----
module {
  func.func @negative_store_to_load_tensor_memref(%arg0: tensor<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: vector<4x2xf32>) -> vector<4x2xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    vector.transfer_write %arg2, %arg1[%c0, %c0] {in_bounds = [true, true]} : vector<4x2xf32>, memref<?x?xf32>
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : tensor<?x?xf32>, vector<4x2xf32>
    return %0 : vector<4x2xf32>
  }
}

// -----
module {
  func.func @negative_store_to_load_tensor_no_actual_broadcast(%arg0: tensor<?x?xf32>, %arg1: vector<4x2xf32>) -> vector<4x2xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_write %arg1, %arg0[%c0, %c0] : vector<4x2xf32>, tensor<?x?xf32>
    %1 = vector.transfer_read %0[%c0, %c0], %cst {in_bounds = [true, true]} : tensor<?x?xf32>, vector<4x2xf32>
    return %1 : vector<4x2xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1, 0)>
module {
  func.func @negative_store_to_load_tensor_broadcast_out_of_bounds(%arg0: tensor<?x?xf32>, %arg1: vector<4x2xf32>) -> vector<4x2x6xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_write %arg1, %arg0[%c0, %c0] : vector<4x2xf32>, tensor<?x?xf32>
    %1 = vector.transfer_read %0[%c0, %c0], %cst {in_bounds = [true, true, true], permutation_map = #map} : tensor<?x?xf32>, vector<4x2x6xf32>
    return %1 : vector<4x2x6xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1, 0)>
module {
  func.func @negative_store_to_load_tensor_broadcast_masked(%arg0: tensor<?x?xf32>, %arg1: vector<4x2xf32>, %arg2: vector<4x2xi1>) -> vector<4x2x6xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_write %arg1, %arg0[%c0, %c0], %arg2 {in_bounds = [true, true]} : vector<4x2xf32>, tensor<?x?xf32>
    %1 = vector.transfer_read %0[%c0, %c0], %cst {in_bounds = [true, true, true], permutation_map = #map} : tensor<?x?xf32>, vector<4x2x6xf32>
    return %1 : vector<4x2x6xf32>
  }
}

// -----
module {
  func.func @store_to_load_tensor_broadcast_scalable(%arg0: tensor<?xf32>, %arg1: vector<[4]xf32>) -> vector<6x[4]xf32> {
    %0 = vector.broadcast %arg1 : vector<[4]xf32> to vector<6x[4]xf32>
    return %0 : vector<6x[4]xf32>
  }
}

// -----
module {
  func.func @store_to_load_tensor_perm_broadcast(%arg0: tensor<4x4x4xf32>, %arg1: vector<4x1xf32>) -> vector<1x100x4x5xf32> {
    %0 = vector.broadcast %arg1 : vector<4x1xf32> to vector<100x5x4x1xf32>
    %1 = vector.transpose %0, [3, 0, 2, 1] : vector<100x5x4x1xf32> to vector<1x100x4x5xf32>
    return %1 : vector<1x100x4x5xf32>
  }
}

// -----
module {
  func.func @store_to_load_tensor_forwarding_unit_dim_broadcast(%arg0: vector<4x8xf32>, %arg1: tensor<1x1x4x8xf32>) -> vector<1x1x4x8xf32> {
    %0 = vector.broadcast %arg0 : vector<4x8xf32> to vector<1x1x4x8xf32>
    return %0 : vector<1x1x4x8xf32>
  }
}

// -----
module {
  func.func @dead_store_tensor(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>, %arg3: index) -> tensor<4x4xf32> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %0 = vector.transfer_write %arg1, %arg0[%c2, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    %1 = vector.transfer_write %arg2, %0[%c1, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    return %1 : tensor<4x4xf32>
  }
}

// -----
module {
  func.func @negative_dead_store_tensor(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>, %arg3: index) -> tensor<4x4xf32> {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_write %arg1, %arg0[%c1, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    %1 = vector.transfer_write %arg1, %0[%c2, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    %2 = vector.transfer_read %1[%arg3, %arg3], %cst {in_bounds = [true, true]} : tensor<4x4xf32>, vector<1x4xf32>
    %3 = arith.addf %2, %2 : vector<1x4xf32>
    %4 = vector.transfer_write %3, %arg0[%c1, %c0] {in_bounds = [true, true]} : vector<1x4xf32>, tensor<4x4xf32>
    return %4 : tensor<4x4xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
module {
  func.func @swap_extract_slice_transfer_write(%arg0: vector<8x4xf32>, %arg1: tensor<4x8xf32>, %arg2: tensor<64x64xf32>, %arg3: index, %arg4: index) -> tensor<64x64xf32> {
    %c0 = arith.constant 0 : index
    %extracted_slice = tensor.extract_slice %arg2[%arg3, 16] [%arg4, 8] [1, 1] : tensor<64x64xf32> to tensor<?x8xf32>
    %0 = vector.transfer_write %arg0, %extracted_slice[%c0, %c0] {in_bounds = [true, false], permutation_map = #map} : vector<8x4xf32>, tensor<?x8xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg2[%arg3, 16] [%arg4, 8] [1, 1] : tensor<?x8xf32> into tensor<64x64xf32>
    return %inserted_slice : tensor<64x64xf32>
  }
}

// -----
module {
  func.func @do_not_swap_extract_slice_transfer_write(%arg0: vector<8xf32>, %arg1: vector<4xf32>, %arg2: tensor<8xf32>, %arg3: tensor<64xf32>, %arg4: index, %arg5: index) -> (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) {
    %c0 = arith.constant 0 : index
    %0 = vector.transfer_write %arg0, %arg2[%c0] {in_bounds = [true]} : vector<8xf32>, tensor<8xf32>
    %extracted_slice = tensor.extract_slice %0[0] [%arg4] [1] : tensor<8xf32> to tensor<?xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg3[%arg4] [%arg5] [1] : tensor<?xf32> into tensor<64xf32>
    %1 = vector.transfer_write %arg1, %arg2[%c0] {in_bounds = [true]} : vector<4xf32>, tensor<8xf32>
    %extracted_slice_0 = tensor.extract_slice %1[0] [%arg5] [1] : tensor<8xf32> to tensor<?xf32>
    %inserted_slice_1 = tensor.insert_slice %extracted_slice_0 into %arg3[%arg4] [%arg5] [1] : tensor<?xf32> into tensor<64xf32>
    %2 = vector.transfer_write %arg0, %arg2[%c0] {in_bounds = [true]} : vector<8xf32>, tensor<8xf32>
    %extracted_slice_2 = tensor.extract_slice %2[0] [1] [1] : tensor<8xf32> to tensor<f32>
    %inserted_slice_3 = tensor.insert_slice %extracted_slice_2 into %arg3[%arg4] [1] [1] : tensor<f32> into tensor<64xf32>
    return %inserted_slice, %inserted_slice_1, %inserted_slice_3 : tensor<64xf32>, tensor<64xf32>, tensor<64xf32>
  }
}

// -----
module {
  func.func @vector_multi_reduction_single_parallel(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    return %arg0 : vector<2xf32>
  }
}

// -----
module {
  func.func @masked_vector_multi_reduction_single_parallel(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xi1>) -> vector<2xf32> {
    return %arg0 : vector<2xf32>
  }
}

// -----
module {
  func.func @vector_multi_reduction_unit_dimensions(%arg0: vector<5x1x4x1x20xf32>, %arg1: vector<5x4x20xf32>) -> vector<5x4x20xf32> {
    %0 = vector.shape_cast %arg0 : vector<5x1x4x1x20xf32> to vector<5x4x20xf32>
    %1 = arith.mulf %arg1, %0 : vector<5x4x20xf32>
    return %1 : vector<5x4x20xf32>
  }
}

// -----
module {
  func.func @vector_multi_reduction_scalable(%arg0: vector<1x[4]x1xf32>, %arg1: vector<1x[4]xf32>, %arg2: vector<1x[4]x1xi1>) -> vector<1x[4]xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x[4]x1xi1> to vector<1x[4]xi1>
    %1 = vector.shape_cast %arg0 : vector<1x[4]x1xf32> to vector<1x[4]xf32>
    %2 = arith.addf %arg1, %1 : vector<1x[4]xf32>
    %3 = arith.select %0, %2, %1 : vector<1x[4]xi1>, vector<1x[4]xf32>
    return %3 : vector<1x[4]xf32>
  }
}

// -----
module {
  func.func @masked_vector_multi_reduction_unit_dimensions(%arg0: vector<5x1x4x1x20xf32>, %arg1: vector<5x4x20xf32>, %arg2: vector<5x1x4x1x20xi1>) -> vector<5x4x20xf32> {
    %0 = vector.shape_cast %arg2 : vector<5x1x4x1x20xi1> to vector<5x4x20xi1>
    %1 = vector.shape_cast %arg0 : vector<5x1x4x1x20xf32> to vector<5x4x20xf32>
    %2 = arith.mulf %arg1, %1 : vector<5x4x20xf32>
    %3 = arith.select %0, %2, %1 : vector<5x4x20xi1>, vector<5x4x20xf32>
    return %3 : vector<5x4x20xf32>
  }
}

// -----
module {
  func.func @vector_multi_reduction_unit_dimensions_fail(%arg0: vector<5x1x4x1x20xf32>, %arg1: vector<5x1x20xf32>) -> vector<5x1x20xf32> {
    %0 = vector.multi_reduction <mul>, %arg0, %arg1 [1, 2] : vector<5x1x4x1x20xf32> to vector<5x1x20xf32>
    return %0 : vector<5x1x20xf32>
  }
}

// -----
module {
  func.func @vector_multi_reduction_unit_dimensions_single_elem(%arg0: vector<1x1x1xf32>, %arg1: f32) -> f32 {
    %0 = vector.extract %arg0[0, 0, 0] : f32 from vector<1x1x1xf32>
    %1 = arith.mulf %arg1, %0 : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @masked_vector_multi_reduction_unit_dimensions_single_elem(%arg0: vector<1x1x1xf32>, %arg1: f32, %arg2: vector<1x1x1xi1>) -> f32 {
    %0 = vector.extract %arg2[0, 0, 0] : i1 from vector<1x1x1xi1>
    %1 = vector.extract %arg0[0, 0, 0] : f32 from vector<1x1x1xf32>
    %2 = arith.mulf %arg1, %1 : f32
    %3 = arith.select %0, %2, %1 : f32
    return %3 : f32
  }
}

// -----
module {
  func.func @insert_strided_slice_full_range(%arg0: vector<16x16xf16>, %arg1: vector<16x16xf16>) -> vector<16x16xf16> {
    return %arg0 : vector<16x16xf16>
  }
}

// -----
module {
  func.func @extract_strided_splatlike(%arg0: f16) -> vector<2x4xf16> {
    %0 = vector.broadcast %arg0 : f16 to vector<2x4xf16>
    return %0 : vector<2x4xf16>
  }
}

// -----
module {
  func.func @insert_extract_to_broadcast(%arg0: vector<1x1x4xf32>, %arg1: vector<4xf32>) -> (vector<4xf32>, vector<1x1x4xf32>) {
    %0 = vector.extract %arg0[0, 0] : vector<4xf32> from vector<1x1x4xf32>
    %1 = vector.broadcast %arg1 : vector<4xf32> to vector<1x1x4xf32>
    return %0, %1 : vector<4xf32>, vector<1x1x4xf32>
  }
}

// -----
module {
  func.func @extract_splat_constant() -> (vector<7xf32>, i32) {
    %cst = arith.constant dense<2.000000e+00> : vector<7xf32>
    %c1_i32 = arith.constant 1 : i32
    return %cst, %c1_i32 : vector<7xf32>, i32
  }
}

// -----
module {
  func.func @extract_1d_constant() -> (i32, index, f32) {
    %c3_i32 = arith.constant 3 : i32
    %c1 = arith.constant 1 : index
    %cst = arith.constant 2.000000e+00 : f32
    return %c3_i32, %c1, %cst : i32, index, f32
  }
}

// -----
module {
  func.func @extract_2d_constant() -> (i32, i32, i32, i32) {
    %c0_i32 = arith.constant 0 : i32
    %c2_i32 = arith.constant 2 : i32
    %c3_i32 = arith.constant 3 : i32
    %c5_i32 = arith.constant 5 : i32
    return %c0_i32, %c2_i32, %c3_i32, %c5_i32 : i32, i32, i32, i32
  }
}

// -----
module {
  func.func @extract_vector_2d_constant() -> (vector<3xi32>, vector<3xi32>) {
    %cst = arith.constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_0 = arith.constant dense<[3, 4, 5]> : vector<3xi32>
    return %cst, %cst_0 : vector<3xi32>, vector<3xi32>
  }
}

// -----
module {
  func.func @extract_3d_constant() -> (i32, i32, i32, i32) {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c9_i32 = arith.constant 9 : i32
    %c10_i32 = arith.constant 10 : i32
    return %c0_i32, %c1_i32, %c9_i32, %c10_i32 : i32, i32, i32, i32
  }
}

// -----
module {
  func.func @extract_vector_3d_constant() -> (vector<3x2xi32>, vector<3x2xi32>, vector<2xi32>, vector<2xi32>) {
    %cst = arith.constant dense<[[0, 1], [2, 3], [4, 5]]> : vector<3x2xi32>
    %cst_0 = arith.constant dense<[[6, 7], [8, 9], [10, 11]]> : vector<3x2xi32>
    %cst_1 = arith.constant dense<[8, 9]> : vector<2xi32>
    %cst_2 = arith.constant dense<[10, 11]> : vector<2xi32>
    return %cst, %cst_0, %cst_1, %cst_2 : vector<3x2xi32>, vector<3x2xi32>, vector<2xi32>, vector<2xi32>
  }
}

// -----
module {
  func.func @extract_splat_vector_3d_constant() -> (vector<2xi32>, vector<2xi32>, vector<2xi32>) {
    %cst = arith.constant dense<0> : vector<2xi32>
    %cst_0 = arith.constant dense<4> : vector<2xi32>
    %cst_1 = arith.constant dense<5> : vector<2xi32>
    return %cst, %cst_0, %cst_1 : vector<2xi32>, vector<2xi32>, vector<2xi32>
  }
}

// -----
module {
  func.func @extract_strided_slice_1d_constant() -> (vector<3xi32>, vector<2xi32>, vector<1xi32>) {
    %cst = arith.constant dense<[0, 1, 2]> : vector<3xi32>
    %cst_0 = arith.constant dense<[1, 2]> : vector<2xi32>
    %cst_1 = arith.constant dense<2> : vector<1xi32>
    return %cst, %cst_0, %cst_1 : vector<3xi32>, vector<2xi32>, vector<1xi32>
  }
}

// -----
module {
  func.func @extract_strided_slice_2d_constant() -> (vector<1x1xi32>, vector<1x2xi32>, vector<2x2xi32>) {
    %cst = arith.constant dense<0> : vector<1x1xi32>
    %cst_0 = arith.constant dense<[[4, 5]]> : vector<1x2xi32>
    %cst_1 = arith.constant dense<[[1, 2], [4, 5]]> : vector<2x2xi32>
    return %cst, %cst_0, %cst_1 : vector<1x1xi32>, vector<1x2xi32>, vector<2x2xi32>
  }
}

// -----
module {
  func.func @extract_strided_slice_3d_constant() -> (vector<1x2x2xi32>, vector<1x1x2xi32>, vector<2x1x2xi32>, vector<1x1x1xi32>) {
    %cst = arith.constant dense<[[[8, 9], [10, 11]]]> : vector<1x2x2xi32>
    %cst_0 = arith.constant dense<[[[2, 3]]]> : vector<1x1x2xi32>
    %cst_1 = arith.constant dense<[[[6, 7]], [[10, 11]]]> : vector<2x1x2xi32>
    %cst_2 = arith.constant dense<11> : vector<1x1x1xi32>
    return %cst, %cst_0, %cst_1, %cst_2 : vector<1x2x2xi32>, vector<1x1x2xi32>, vector<2x1x2xi32>, vector<1x1x1xi32>
  }
}

// -----
module {
  func.func @extract_extract_strided(%arg0: vector<32x16x4xf16>) -> vector<4xf16> {
    %0 = vector.extract %arg0[9, 7] : vector<4xf16> from vector<32x16x4xf16>
    return %0 : vector<4xf16>
  }
}

// -----
module {
  func.func @extract_insert_strided(%arg0: vector<6x4xf32>, %arg1: vector<8x16xf32>) -> f32 {
    %0 = vector.extract %arg0[0, 2] : f32 from vector<6x4xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_insert_rank_reduce(%arg0: vector<4xf32>, %arg1: vector<8x16xf32>) -> f32 {
    %0 = vector.extract %arg0[2] : f32 from vector<4xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @negative_extract_insert(%arg0: vector<2x15xf32>, %arg1: vector<12x8x16xf32>) -> vector<16xf32> {
    %0 = vector.insert_strided_slice %arg0, %arg1 {offsets = [4, 2, 0], strides = [1, 1]} : vector<2x15xf32> into vector<12x8x16xf32>
    %1 = vector.extract %0[4, 2] : vector<16xf32> from vector<12x8x16xf32>
    return %1 : vector<16xf32>
  }
}

// -----
module {
  func.func @extract_insert_chain(%arg0: vector<2x16xf32>, %arg1: vector<12x8x16xf32>, %arg2: vector<2x16xf32>) -> vector<16xf32> {
    %0 = vector.extract %arg2[0] : vector<16xf32> from vector<2x16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @extract_from_extract_chain_should_not_fold_dynamic_extracts(%arg0: vector<2x4xf32>, %arg1: index) -> f32 {
    %0 = vector.extract %arg0[%arg1] : vector<4xf32> from vector<2x4xf32>
    %1 = vector.extract %0[1] : f32 from vector<4xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @extract_extract_strided2(%arg0: vector<2x4xf32>) -> vector<4xf32> {
    %0 = vector.extract %arg0[1] : vector<4xf32> from vector<2x4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @splatlike_fold() -> vector<4xf32> {
    %cst = arith.constant dense<1.000000e+00> : vector<4xf32>
    return %cst : vector<4xf32>
  }
}

// -----
module {
  func.func @shuffle_1d() -> vector<4xi32> {
    %cst = arith.constant dense<[3, 2, 5, 1]> : vector<4xi32>
    return %cst : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_1d_dense_resource() -> vector<4xi32> {
    %cst = arith.constant dense_resource<__elided__> : vector<3xi32>
    %0 = vector.shuffle %cst, %cst [3, 2, 5, 1] : vector<3xi32>, vector<3xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_1d_poison_idx() -> vector<4xi32> {
    %cst = arith.constant dense<[13, 10, 15, 10]> : vector<4xi32>
    return %cst : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_1d_rhs_lhs_poison() -> vector<4xi32> {
    %0 = ub.poison : vector<4xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_1d_lhs_poison() -> vector<4xi32> {
    %cst = arith.constant dense<[11, 12, 11, 11]> : vector<4xi32>
    return %cst : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_1d_rhs_poison() -> vector<4xi32> {
    %cst = arith.constant dense<[11, 11, 13, 12]> : vector<4xi32>
    return %cst : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_canonicalize_0d(%arg0: vector<i32>, %arg1: vector<i32>) -> vector<1xi32> {
    %0 = vector.broadcast %arg0 : vector<i32> to vector<1xi32>
    return %0 : vector<1xi32>
  }
}

// -----
module {
  func.func @shuffle_fold1(%arg0: vector<4xi32>, %arg1: vector<2xi32>) -> vector<4xi32> {
    return %arg0 : vector<4xi32>
  }
}

// -----
module {
  func.func @shuffle_fold2(%arg0: vector<4xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    return %arg1 : vector<2xi32>
  }
}

// -----
module {
  func.func @shuffle_fold3(%arg0: vector<4x5x6xi32>, %arg1: vector<2x5x6xi32>) -> vector<4x5x6xi32> {
    return %arg0 : vector<4x5x6xi32>
  }
}

// -----
module {
  func.func @shuffle_fold4(%arg0: vector<4x5x6xi32>, %arg1: vector<2x5x6xi32>) -> vector<2x5x6xi32> {
    return %arg1 : vector<2x5x6xi32>
  }
}

// -----
module {
  func.func @shuffle_nofold1(%arg0: vector<4xi32>, %arg1: vector<2xi32>) -> vector<5xi32> {
    %0 = vector.shuffle %arg0, %arg1 [0, 1, 2, 3, 4] : vector<4xi32>, vector<2xi32>
    return %0 : vector<5xi32>
  }
}

// -----
module {
  func.func @transpose_splatlike_constant() -> vector<8x4xf32> {
    %cst = arith.constant dense<5.000000e+00> : vector<8x4xf32>
    return %cst : vector<8x4xf32>
  }
}

// -----
module {
  func.func @transpose_splatlike2(%arg0: f32) -> vector<3x4xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<3x4xf32>
    return %0 : vector<3x4xf32>
  }
}

// -----
module {
  func.func @transpose_poison() -> vector<4x6xi8> {
    %0 = ub.poison : vector<4x6xi8>
    return %0 : vector<4x6xi8>
  }
}

// -----
module {
  func.func @insert_1d_constant() -> (vector<3xi32>, vector<3xi32>, vector<3xi32>) {
    %cst = arith.constant dense<[9, 1, 2]> : vector<3xi32>
    %cst_0 = arith.constant dense<[0, 9, 2]> : vector<3xi32>
    %cst_1 = arith.constant dense<[0, 1, 9]> : vector<3xi32>
    return %cst, %cst_0, %cst_1 : vector<3xi32>, vector<3xi32>, vector<3xi32>
  }
}

// -----
module {
  func.func @insert_2d_constant() -> (vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>) {
    %cst = arith.constant dense<[[99, 1, 2], [3, 4, 5]]> : vector<2x3xi32>
    %cst_0 = arith.constant dense<[[0, 1, 2], [3, 4, 99]]> : vector<2x3xi32>
    %cst_1 = arith.constant dense<[[90, 91, 92], [3, 4, 5]]> : vector<2x3xi32>
    %cst_2 = arith.constant dense<[[0, 1, 2], [90, 91, 92]]> : vector<2x3xi32>
    return %cst, %cst_0, %cst_1, %cst_2 : vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>
  }
}

// -----
module {
  func.func @fully_insert_scalar_to_vector(%arg0: vector<2xi64>, %arg1: i64, %arg2: i64) -> vector<2xi64> {
    %0 = vector.from_elements %arg1, %arg2 : vector<2xi64>
    return %0 : vector<2xi64>
  }
}

// -----
module {
  func.func @fully_insert_vector_to_vector(%arg0: vector<2x2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2x2xi64> {
    %0:2 = vector.to_elements %arg1 : vector<2xi64>
    %1:2 = vector.to_elements %arg2 : vector<2xi64>
    %2 = vector.from_elements %0#0, %0#1, %1#0, %1#1 : vector<2x2xi64>
    return %2 : vector<2x2xi64>
  }
}

// -----
module {
  func.func @fully_insert_to_vector_overlap_1(%arg0: vector<2x2xi64>, %arg1: vector<2xi64>, %arg2: i64) -> vector<2x2xi64> {
    %0:2 = vector.to_elements %arg1 : vector<2xi64>
    %1:2 = vector.to_elements %arg1 : vector<2xi64>
    %2 = vector.from_elements %0#0, %0#1, %1#0, %arg2 : vector<2x2xi64>
    return %2 : vector<2x2xi64>
  }
}

// -----
module {
  func.func @fully_insert_to_vector_overlap_2(%arg0: vector<2x2xi64>, %arg1: i64, %arg2: i64, %arg3: vector<2xi64>, %arg4: vector<2xi64>) -> vector<2x2xi64> {
    %0:2 = vector.to_elements %arg3 : vector<2xi64>
    %1:2 = vector.to_elements %arg4 : vector<2xi64>
    %2 = vector.from_elements %0#0, %0#1, %1#0, %1#1 : vector<2x2xi64>
    return %2 : vector<2x2xi64>
  }
}

// -----
module {
  func.func @negative_partially_insert_vector_to_vector(%arg0: vector<2x2xi64>, %arg1: vector<2xi64>, %arg2: i64) -> vector<2x2xi64> {
    %0 = vector.insert %arg1, %arg0 [0] : vector<2xi64> into vector<2x2xi64>
    %1 = vector.insert %arg2, %0 [0, 0] : i64 into vector<2x2xi64>
    return %1 : vector<2x2xi64>
  }
}

// -----
module {
  func.func @negative_intermediate_insert_multiple_users(%arg0: vector<3xi64>, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64) -> (vector<3xi64>, vector<3xi64>) {
    %0 = vector.insert %arg1, %arg0 [0] : i64 into vector<3xi64>
    %1 = vector.insert %arg2, %0 [1] : i64 into vector<3xi64>
    %2 = vector.insert %arg3, %1 [2] : i64 into vector<3xi64>
    %3 = vector.insert %arg4, %1 [2] : i64 into vector<3xi64>
    return %2, %3 : vector<3xi64>, vector<3xi64>
  }
}

// -----
module {
  func.func @insert_2d_splat_constant() -> (vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>) {
    %cst = arith.constant dense<0> : vector<2x3xi32>
    %cst_0 = arith.constant dense<[[99, 0, 0], [0, 0, 0]]> : vector<2x3xi32>
    %cst_1 = arith.constant dense<[[0, 0, 0], [0, 99, 0]]> : vector<2x3xi32>
    %cst_2 = arith.constant dense<[[33, 33, 33], [0, 0, 0]]> : vector<2x3xi32>
    %cst_3 = arith.constant dense<[[0, 0, 0], [33, 33, 33]]> : vector<2x3xi32>
    return %cst, %cst_0, %cst_1, %cst_2, %cst_3 : vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>
  }
}

// -----
module {
  func.func @reduce_one_element_vector_extract(%arg0: vector<1xf32>) -> f32 {
    %0 = vector.extract %arg0[0] : f32 from vector<1xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @masked_reduce_one_element_vector_extract(%arg0: vector<1xf32>, %arg1: vector<1xi1>) -> f32 {
    %0 = vector.extract %arg0[0] : f32 from vector<1xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @reduce_one_element_vector_addf(%arg0: vector<1xf32>, %arg1: f32) -> f32 {
    %0 = vector.extract %arg0[0] : f32 from vector<1xf32>
    %1 = arith.addf %0, %arg1 : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_one_element_vector_addf_fastmath(%arg0: vector<1xf32>, %arg1: f32) -> f32 {
    %0 = vector.extract %arg0[0] : f32 from vector<1xf32>
    %1 = arith.addf %0, %arg1 fastmath<nnan,ninf> : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @masked_reduce_one_element_vector_addf(%arg0: vector<1xf32>, %arg1: f32, %arg2: vector<1xi1>) -> f32 {
    %0 = vector.extract %arg2[0] : i1 from vector<1xi1>
    %1 = vector.extract %arg0[0] : f32 from vector<1xf32>
    %2 = arith.addf %1, %arg1 : f32
    %3 = arith.select %0, %2, %arg1 : f32
    return %3 : f32
  }
}

// -----
module {
  func.func @reduce_one_element_vector_mulf(%arg0: vector<1xf32>, %arg1: f32) -> f32 {
    %0 = vector.extract %arg0[0] : f32 from vector<1xf32>
    %1 = arith.mulf %0, %arg1 : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @dont_reduce_one_element_vector(%arg0: vector<4xf32>) -> f32 {
    %0 = vector.reduction <add>, %arg0 : vector<4xf32> into f32
    return %0 : f32
  }
}

// -----
module {
  func.func @reduce_one_element_vector_maximumf(%arg0: vector<1xf32>, %arg1: f32) -> f32 {
    %0 = vector.extract %arg0[0] : f32 from vector<1xf32>
    %1 = arith.maximumf %0, %arg1 : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @bitcast(%arg0: vector<4x8xf32>) -> vector<4x16xi16> {
    %0 = vector.bitcast %arg0 : vector<4x8xf32> to vector<4x16xi16>
    return %0 : vector<4x16xi16>
  }
}

// -----
module {
  func.func @insert_strided_slice_splatlike(%arg0: f32) -> vector<8x16xf32> {
    %0 = vector.broadcast %arg0 : f32 to vector<8x16xf32>
    return %0 : vector<8x16xf32>
  }
}

// -----
module {
  func.func @insert_extract_strided_slice(%arg0: vector<8x16xf32>) -> vector<8x16xf32> {
    return %arg0 : vector<8x16xf32>
  }
}

// -----
module {
  func.func @insert_strided_1d_constant() -> (vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>) {
    %cst = arith.constant dense<[7, 8, 9]> : vector<3xi32>
    %cst_0 = arith.constant dense<[4, 1, 2]> : vector<3xi32>
    %cst_1 = arith.constant dense<[0, 1, 4]> : vector<3xi32>
    %cst_2 = arith.constant dense<[5, 6, 2]> : vector<3xi32>
    %cst_3 = arith.constant dense<[0, 5, 6]> : vector<3xi32>
    return %cst_0, %cst_1, %cst_2, %cst_3, %cst : vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>
  }
}

// -----
module {
  func.func @insert_strided_2d_constant() -> (vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>) {
    %cst = arith.constant dense<[[0, 1], [9, 3], [4, 5]]> : vector<3x2xi32>
    %cst_0 = arith.constant dense<[[0, 1], [2, 3], [4, 9]]> : vector<3x2xi32>
    %cst_1 = arith.constant dense<[[18, 19], [2, 3], [4, 5]]> : vector<3x2xi32>
    %cst_2 = arith.constant dense<[[0, 1], [18, 19], [4, 5]]> : vector<3x2xi32>
    %cst_3 = arith.constant dense<[[0, 1], [2, 3], [18, 19]]> : vector<3x2xi32>
    %cst_4 = arith.constant dense<[[28, 29], [38, 39], [4, 5]]> : vector<3x2xi32>
    %cst_5 = arith.constant dense<[[0, 1], [28, 29], [38, 39]]> : vector<3x2xi32>
    return %cst, %cst_0, %cst_1, %cst_2, %cst_3, %cst_4, %cst_5 : vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>
  }
}

// -----
module {
  func.func @shuffle_splatlike(%arg0: i32) -> vector<4xi32> {
    %0 = vector.broadcast %arg0 : i32 to vector<4xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @insert_splatlike(%arg0: i32) -> vector<2x4x3xi32> {
    %0 = vector.broadcast %arg0 : i32 to vector<2x4x3xi32>
    return %0 : vector<2x4x3xi32>
  }
}

// -----
module {
  func.func @transfer_read_from_rank_reducing_extract_slice(%arg0: tensor<1x8x8x8xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> vector<4xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0, %arg1, %arg2, %arg3] [1, 4, 1, 4] [1, 1, 1, 1] : tensor<1x8x8x8xf32> to tensor<1x4x4xf32>
    %0 = vector.transfer_read %extracted_slice[%c0, %arg4, %c0], %cst {in_bounds = [true]} : tensor<1x4x4xf32>, vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @extract_from_broadcast(%arg0: vector<1x1x1xf32>) -> vector<1xf32> {
    %0 = vector.extract %arg0[0, 0] : vector<1xf32> from vector<1x1x1xf32>
    return %0 : vector<1xf32>
  }
  func.func @extract_from_stretch_broadcast(%arg0: vector<3x1x2xf32>) -> f32 {
    %0 = vector.extract %arg0[0, 0, 0] : f32 from vector<3x1x2xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_strided_slice_of_constant_mask() -> vector<5x7xi1> {
    %0 = vector.constant_mask [5, 4] : vector<5x7xi1>
    return %0 : vector<5x7xi1>
  }
}

// -----
module {
  func.func @fold_0d_vector_reduction(%arg0: vector<f32>) -> f32 {
    %0 = vector.extract %arg0[] : f32 from vector<f32>
    return %0 : f32
  }
}

// -----
module {
  func.func @empty_vector_mask(%arg0: vector<8xi1>) {
    return
  }
}

// -----
module {
  func.func @empty_vector_mask_with_return(%arg0: vector<8xf32>, %arg1: vector<8xi1>) -> vector<8xf32> {
    return %arg0 : vector<8xf32>
  }
}

// -----
module {
  func.func @empty_vector_mask_with_passthru(%arg0: vector<8xf32>, %arg1: vector<8xi1>, %arg2: vector<8xf32>) -> vector<8xf32> {
    %0 = arith.select %arg1, %arg0, %arg2 : vector<8xi1>, vector<8xf32>
    return %0 : vector<8xf32>
  }
}

// -----
module {
  func.func @all_true_vector_mask(%arg0: tensor<3x4xf32>) -> vector<3x4xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : tensor<3x4xf32>, vector<3x4xf32>
    return %0 : vector<3x4xf32>
  }
}

// -----
module {
  func.func @all_true_vector_mask_no_result(%arg0: vector<3x4xf32>, %arg1: memref<3x4xf32>) {
    %c0 = arith.constant 0 : index
    vector.transfer_write %arg0, %arg1[%c0, %c0] {in_bounds = [true, true]} : vector<3x4xf32>, memref<3x4xf32>
    return
  }
}

// -----
module {
  func.func @fold_shape_cast_with_mask(%arg0: tensor<1x?xf32>) -> vector<1x4xi1> {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<1x4xi1>
    return %0 : vector<1x4xi1>
  }
}

// -----
module {
  func.func @fold_shape_cast_with_mask_scalable(%arg0: tensor<1x?xf32>) -> vector<1x[4]xi1> {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<1x[4]xi1>
    return %0 : vector<1x[4]xi1>
  }
}

// -----
module {
  func.func @fold_shape_cast_with_mask_scalable_one(%arg0: tensor<1x?xf32>) -> vector<1x[1]xi1> {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?xf32>
    %0 = vector.create_mask %c1, %dim : vector<1x[1]xi1>
    return %0 : vector<1x[1]xi1>
  }
}

// -----
module {
  func.func @fold_shape_cast_with_constant_mask() -> vector<4xi1> {
    %0 = vector.constant_mask [1] : vector<4xi1>
    return %0 : vector<4xi1>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d1, 0, d2, 0)>
module {
  func.func @load_store_forwarding_rank_mismatch(%arg0: vector<4x1x1xf32>, %arg1: tensor<4x4x4xf32>) -> vector<1x100x4x5xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_write %arg0, %arg1[%c0, %c0, %c0] {in_bounds = [true, true, true], permutation_map = #map} : vector<4x1x1xf32>, tensor<4x4x4xf32>
    %1 = vector.transfer_read %0[%c0, %c0, %c0], %cst {in_bounds = [true, true, true, true], permutation_map = #map1} : tensor<4x4x4xf32>, vector<1x100x4x5xf32>
    return %1 : vector<1x100x4x5xf32>
  }
}

// -----
module {
  func.func @rank_0_shuffle_to_interleave(%arg0: vector<f64>, %arg1: vector<f64>) -> vector<2xf64> {
    %0 = vector.interleave %arg0, %arg1 : vector<f64> -> vector<2xf64>
    return %0 : vector<2xf64>
  }
}

// -----
module {
  func.func @rank_1_shuffle_to_interleave(%arg0: vector<6xi32>, %arg1: vector<6xi32>) -> vector<12xi32> {
    %0 = vector.interleave %arg0, %arg1 : vector<6xi32> -> vector<12xi32>
    return %0 : vector<12xi32>
  }
}

// -----
module {
  func.func @extract_from_splatlike_broadcast(%arg0: f32, %arg1: vector<f32>, %arg2: vector<2xf32>) -> (f32, f32, f32, f32, vector<6x7xf32>, vector<3xf32>) {
    %0 = vector.extract %arg1[] : f32 from vector<f32>
    %1 = vector.broadcast %arg0 : f32 to vector<6x7xf32>
    %2 = vector.broadcast %arg0 : f32 to vector<3xf32>
    return %arg0, %0, %arg0, %arg0, %1, %2 : f32, f32, f32, f32, vector<6x7xf32>, vector<3xf32>
  }
}

// -----
module {
  func.func @to_elements_from_elements_no_op(%arg0: f32, %arg1: f32) -> (f32, f32) {
    return %arg1, %arg0 : f32, f32
  }
}

// -----
module {
  func.func @from_elements_to_elements_no_op(%arg0: vector<4x2xf32>) -> vector<4x2xf32> {
    return %arg0 : vector<4x2xf32>
  }
}

// -----
module {
  func.func @from_elements_to_elements_dup_elems(%arg0: vector<4xf32>) -> vector<4x2xf32> {
    %0:4 = vector.to_elements %arg0 : vector<4xf32>
    %1 = vector.from_elements %0#0, %0#1, %0#2, %0#3, %0#0, %0#1, %0#2, %0#3 : vector<4x2xf32>
    return %1 : vector<4x2xf32>
  }
}

// -----
module {
  func.func @from_elements_to_elements_shuffle(%arg0: vector<4x2xf32>) -> vector<4x2xf32> {
    %0:8 = vector.to_elements %arg0 : vector<4x2xf32>
    %1 = vector.from_elements %0#7, %0#0, %0#6, %0#1, %0#5, %0#2, %0#4, %0#3 : vector<4x2xf32>
    return %1 : vector<4x2xf32>
  }
}

// -----
module {
  func.func @to_elements_of_scalar_broadcast_folds(%arg0: f32) -> (f32, f32, f32, f32) {
    return %arg0, %arg0, %arg0, %arg0 : f32, f32, f32, f32
  }
}

// -----
module {
  func.func @to_elements_of_vector_broadcast(%arg0: vector<2xf32>) -> (f32, f32, f32, f32, f32, f32) {
    %0:2 = vector.to_elements %arg0 : vector<2xf32>
    return %0#0, %0#1, %0#0, %0#1, %0#0, %0#1 : f32, f32, f32, f32, f32, f32
  }
}

// -----
module {
  func.func @to_elements_of_vector_broadcast_inner_dim(%arg0: vector<2x1x2xf32>) -> (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) {
    %0:4 = vector.to_elements %arg0 : vector<2x1x2xf32>
    return %0#0, %0#1, %0#0, %0#1, %0#0, %0#1, %0#2, %0#3, %0#2, %0#3, %0#2, %0#3 : f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32
  }
}

// -----
module {
  func.func @from_elements_to_constant() -> vector<2x2xi32> {
    %cst = arith.constant dense<[[0, 1], [2, 3]]> : vector<2x2xi32>
    return %cst : vector<2x2xi32>
  }
}

// -----
module {
  func.func @negative_from_elements_to_constant(%arg0: f32) -> vector<2xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = vector.from_elements %arg0, %cst : vector<2xf32>
    return %0 : vector<2xf32>
  }
}

// -----
module {
  llvm.mlir.global external constant @my_symbol() {addr_space = 0 : i32} : i32
  func.func @negative_from_elements_to_constant() -> vector<1x!llvm.ptr> {
    %0 = llvm.mlir.addressof @my_symbol : !llvm.ptr
    %1 = vector.broadcast %0 : !llvm.ptr to vector<1x!llvm.ptr>
    return %1 : vector<1x!llvm.ptr>
  }
}

// -----
module {
  func.func @negative_from_elements_poison_f32() -> vector<2xf32> {
    %0 = ub.poison : vector<2xf32>
    return %0 : vector<2xf32>
  }
}

// -----
module {
  func.func @negative_from_elements_poison_i32() -> vector<2xi32> {
    %0 = ub.poison : vector<2xi32>
    return %0 : vector<2xi32>
  }
}

// -----
module {
  func.func @negative_from_elements_poison_constant_mix() -> vector<2xf32> {
    %0 = ub.poison : f32
    %cst = arith.constant 1.000000e+00 : f32
    %1 = vector.from_elements %0, %cst : vector<2xf32>
    return %1 : vector<2xf32>
  }
}

// -----
module {
  func.func @from_elements_float8_to_i8_conversion() -> vector<6xi8> {
    %cst = arith.constant dense<[0, 56, -72, 69, 127, -1]> : vector<6xi8>
    return %cst : vector<6xi8>
  }
  func.func @from_elements_float16_to_i16_conversion() -> vector<6xi16> {
    %cst = arith.constant dense<[0, 15360, -17408, 16968, 31743, -1025]> : vector<6xi16>
    return %cst : vector<6xi16>
  }
  func.func @from_elements_f64_to_i64_conversion() -> vector<6xi64> {
    %cst = arith.constant dense<[0, 4607182418800017408, -4616189618054758400, 4614253070214989087, 9218868437227405311, -4503599627370497]> : vector<6xi64>
    return %cst : vector<6xi64>
  }
}

// -----
module {
  func.func @from_elements_i1_to_i8_conversion() -> vector<1xi8> {
    %cst = arith.constant dense<0> : vector<1xi8>
    return %cst : vector<1xi8>
  }
}

// -----
module {
  func.func @from_elements_index_to_i64_conversion() -> vector<3xi64> {
    %cst = arith.constant dense<[0, 1, 42]> : vector<3xi64>
    return %cst : vector<3xi64>
  }
}

// -----
module {
  func.func @transpose_from_elements_1d(%arg0: i32, %arg1: i32) -> vector<2xi32> {
    %0 = vector.from_elements %arg0, %arg1 : vector<2xi32>
    return %0 : vector<2xi32>
  }
  func.func @transpose_from_elements_2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> vector<3x2xi32> {
    %0 = vector.from_elements %arg0, %arg3, %arg1, %arg4, %arg2, %arg5 : vector<3x2xi32>
    return %0 : vector<3x2xi32>
  }
  func.func @transpose_from_elements_3d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) -> vector<2x2x3xi32> {
    %0 = vector.from_elements %arg0, %arg2, %arg4, %arg1, %arg3, %arg5, %arg6, %arg8, %arg10, %arg7, %arg9, %arg11 : vector<2x2x3xi32>
    return %0 : vector<2x2x3xi32>
  }
}

// -----
module {
  func.func @negative_insert_llvm_undef(%arg0: i8) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = vector.insert %arg0, %0 [0] : i8 into vector<4xi8>
    return %1 : vector<4xi8>
  }
}

// -----
module {
  func.func @insert_scalar_poison(%arg0: vector<4x8xf32>) -> vector<4x8xf32> {
    %0 = ub.poison : f32
    %1 = vector.insert %0, %arg0 [2, 3] : f32 into vector<4x8xf32>
    return %1 : vector<4x8xf32>
  }
}

// -----
module {
  func.func @insert_vector_poison(%arg0: vector<4x8xf32>) -> vector<4x8xf32> {
    %0 = ub.poison : vector<8xf32>
    %1 = vector.insert %0, %arg0 [2] : vector<8xf32> into vector<4x8xf32>
    return %1 : vector<4x8xf32>
  }
}

// -----
module {
  func.func @insert_scalar_poison_idx(%arg0: vector<4x5xf32>, %arg1: f32) -> vector<4x5xf32> {
    %0 = ub.poison : vector<4x5xf32>
    return %0 : vector<4x5xf32>
  }
}

// -----
module {
  func.func @insert_vector_poison_idx(%arg0: vector<4x5xf32>, %arg1: vector<5xf32>) -> vector<4x5xf32> {
    %0 = ub.poison : vector<4x5xf32>
    return %0 : vector<4x5xf32>
  }
}

// -----
module {
  func.func @insert_vector_poison_idx_non_cst(%arg0: vector<4x5xf32>, %arg1: vector<5xf32>) -> vector<4x5xf32> {
    %0 = ub.poison : vector<4x5xf32>
    return %0 : vector<4x5xf32>
  }
}

// -----
module {
  func.func @no_fold_insert_scalar_idx_oob(%arg0: vector<4x5xf32>, %arg1: vector<5xf32>) -> vector<4x5xf32> {
    %c-2 = arith.constant -2 : index
    %0 = vector.insert %arg1, %arg0 [%c-2] : vector<5xf32> into vector<4x5xf32>
    return %0 : vector<4x5xf32>
  }
}

// -----
module {
  func.func @insert_multiple_poison_idx(%arg0: vector<4x5x8xf32>, %arg1: vector<8xf32>) -> vector<4x5x8xf32> {
    %0 = ub.poison : vector<4x5x8xf32>
    return %0 : vector<4x5x8xf32>
  }
}

// -----
module {
  func.func @contiguous_extract_strided_slices_to_extract_sizes_and_outer_source_dims_overlap(%arg0: vector<8x1x2x1x1x4xi32>) -> vector<4xi32> {
    %0 = vector.extract %arg0[0, 0, 0, 0, 0] : vector<4xi32> from vector<8x1x2x1x1x4xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @contiguous_extract_strided_slices_to_extract_sizes_and_outer_source_dims_no_overlap(%arg0: vector<8x2x4xi32>) -> vector<4xi32> {
    %0 = vector.extract %arg0[0, 0] : vector<4xi32> from vector<8x2x4xi32>
    return %0 : vector<4xi32>
  }
}

// -----
module {
  func.func @contiguous_extract_strided_slices_to_extract_shorter_size_list(%arg0: vector<8x1x2x1x1x4xi32>) -> vector<1x4xi32> {
    %0 = vector.extract %arg0[0, 0, 0, 0] : vector<1x4xi32> from vector<8x1x2x1x1x4xi32>
    return %0 : vector<1x4xi32>
  }
}

// -----
module {
  func.func @contiguous_extract_strided_slices_to_extract_failure_non_unit_outer_size(%arg0: vector<8x1x2x1x1x4xi32>) -> vector<8x1x1x1x1x4xi32> {
    %0 = vector.extract_strided_slice %arg0 {offsets = [0, 0, 0, 0, 0, 0], sizes = [8, 1, 1, 1, 1, 4], strides = [1, 1, 1, 1, 1, 1]} : vector<8x1x2x1x1x4xi32> to vector<8x1x1x1x1x4xi32>
    return %0 : vector<8x1x1x1x1x4xi32>
  }
}

// -----
module {
  func.func @contiguous_extract_strided_slices_to_extract_failure_non_full_size(%arg0: vector<8x1x2x1x1x4xi32>) -> vector<1x1x1x1x1x2xi32> {
    %0 = vector.extract_strided_slice %arg0 {offsets = [0, 0, 0, 0, 0, 0], sizes = [1, 1, 1, 1, 1, 2], strides = [1, 1, 1, 1, 1, 1]} : vector<8x1x2x1x1x4xi32> to vector<1x1x1x1x1x2xi32>
    return %0 : vector<1x1x1x1x1x2xi32>
  }
}

// -----
module {
  func.func @contiguous_extract_strided_slices_to_extract_failure_non_full_inner_size(%arg0: vector<8x1x2x1x1x4xi32>) -> vector<1x1x2x1x1x1xi32> {
    %0 = vector.extract_strided_slice %arg0 {offsets = [0, 0, 0, 0, 0, 0], sizes = [1, 1, 2, 1, 1, 1], strides = [1, 1, 1, 1, 1, 1]} : vector<8x1x2x1x1x4xi32> to vector<1x1x2x1x1x1xi32>
    return %0 : vector<1x1x2x1x1x1xi32>
  }
}

// -----
module {
  func.func @contiguous_gather(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.maskedload %arg0[%c0], %arg1, %arg2 : memref<?xf32>, vector<16xi1>, vector<16xf32> into vector<16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @contiguous_gather_non_zero_start(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<16xi32>
    %0 = vector.gather %arg0[%c0] [%cst], %arg1, %arg2 : memref<?xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32> into vector<16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @contiguous_gather_2d(%arg0: memref<?x?xf32>, %arg1: vector<4x4xi1>, %arg2: vector<4x4xf32>) -> vector<4x4xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]]> : vector<4x4xi32>
    %0 = vector.gather %arg0[%c0, %c0] [%cst], %arg1, %arg2 : memref<?x?xf32>, vector<4x4xi32>, vector<4x4xi1>, vector<4x4xf32> into vector<4x4xf32>
    return %0 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @contiguous_gather_const_mask(%arg0: memref<?xf32>, %arg1: vector<16xf32>) -> vector<16xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.load %arg0[%c0] : memref<?xf32>, vector<16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @contiguous_gather_step(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.maskedload %arg0[%c0], %arg1, %arg2 : memref<?xf32>, vector<16xi1>, vector<16xf32> into vector<16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @no_fold_contiguous_gather_tensor(%arg0: tensor<8xf32>, %arg1: vector<4xi1>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[0, 1, 2, 3]> : vector<4xindex>
    %0 = vector.gather %arg0[%c0] [%cst], %arg1, %arg2 : tensor<8xf32>, vector<4xindex>, vector<4xi1>, vector<4xf32> into vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @gather_broadcast(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0> : vector<16xi32>
    %0 = vector.gather %arg0[%c0] [%cst], %arg1, %arg2 : memref<?xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32> into vector<16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @contiguous_scatter(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) {
    %c0 = arith.constant 0 : index
    vector.maskedstore %arg0[%c0], %arg1, %arg2 : memref<?xf32>, vector<16xi1>, vector<16xf32>
    return
  }
}

// -----
module {
  func.func @contiguous_scatter_const_mask(%arg0: memref<?xf32>, %arg1: vector<16xf32>) {
    %c0 = arith.constant 0 : index
    vector.store %arg1, %arg0[%c0] : memref<?xf32>, vector<16xf32>
    return
  }
}

// -----
module {
  func.func @contiguous_scatter_step(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) {
    %c0 = arith.constant 0 : index
    vector.maskedstore %arg0[%c0], %arg1, %arg2 : memref<?xf32>, vector<16xi1>, vector<16xf32>
    return
  }
}

// -----
module {
  func.func @no_fold_contiguous_scatter_tensor(%arg0: tensor<16xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> tensor<16xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>
    %0 = vector.scatter %arg0[%c0] [%cst], %arg1, %arg2 : tensor<16xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32> -> tensor<16xf32>
    return %0 : tensor<16xf32>
  }
}

// -----
module {
  func.func @scatter_memref_all_false(%arg0: memref<?xf32>, %arg1: vector<16xindex>, %arg2: vector<16xf32>) {
    return
  }
}

// -----
module {
  func.func @scatter_tensor_all_false(%arg0: tensor<16xf32>, %arg1: vector<16xindex>, %arg2: vector<16xf32>) -> tensor<16xf32> {
    return %arg0 : tensor<16xf32>
  }
}

// -----
module {
  func.func @fold_extract_constant_indices(%arg0: vector<32x1xi32>) -> i32 {
    %0 = vector.extract %arg0[0, 0] : i32 from vector<32x1xi32>
    return %0 : i32
  }
}

// -----
module {
  func.func @fold_insert_constant_indices(%arg0: vector<4x1xi32>) -> vector<4x1xi32> {
    %c1_i32 = arith.constant 1 : i32
    %0 = vector.insert %c1_i32, %arg0 [0, 0] : i32 into vector<4x1xi32>
    return %0 : vector<4x1xi32>
  }
}

// -----
module {
  func.func @fold_insert_use_chain(%arg0: vector<4x4xf32>, %arg1: f32, %arg2: index) -> vector<4x4xf32> {
    %0 = vector.insert %arg1, %arg0 [%arg2, 0] : f32 into vector<4x4xf32>
    return %0 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @no_fold_insert_use_chain_mismatch_static_position(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = vector.insert %arg1, %arg0 [0] : f32 into vector<4xf32>
    %1 = vector.insert %arg1, %0 [1] : f32 into vector<4xf32>
    return %1 : vector<4xf32>
  }
}

