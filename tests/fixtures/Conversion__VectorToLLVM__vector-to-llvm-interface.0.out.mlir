module {
  func.func @bitcast_f32_to_i32_vector_0d(%arg0: vector<f32>) -> vector<i32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = llvm.bitcast %0 : vector<1xf32> to vector<1xi32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<1xi32> to vector<i32>
    return %2 : vector<i32>
  }
}

// -----
module {
  func.func @bitcast_f32_to_i32_vector(%arg0: vector<16xf32>) -> vector<16xi32> {
    %0 = llvm.bitcast %arg0 : vector<16xf32> to vector<16xi32>
    return %0 : vector<16xi32>
  }
}

// -----
module {
  func.func @bitcast_f32_to_i32_vector_scalable(%arg0: vector<[16]xf32>) -> vector<[16]xi32> {
    %0 = llvm.bitcast %arg0 : vector<[16]xf32> to vector<[16]xi32>
    return %0 : vector<[16]xi32>
  }
}

// -----
module {
  func.func @bitcast_i8_to_f32_vector(%arg0: vector<64xi8>) -> vector<16xf32> {
    %0 = llvm.bitcast %arg0 : vector<64xi8> to vector<16xf32>
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @bitcast_i8_to_f32_vector_scalable(%arg0: vector<[64]xi8>) -> vector<[16]xf32> {
    %0 = llvm.bitcast %arg0 : vector<[64]xi8> to vector<[16]xf32>
    return %0 : vector<[16]xf32>
  }
}

// -----
module {
  func.func @bitcast_index_to_i8_vector(%arg0: vector<16xindex>) -> vector<128xi8> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<16xindex> to vector<16xi64>
    %1 = llvm.bitcast %0 : vector<16xi64> to vector<128xi8>
    return %1 : vector<128xi8>
  }
}

// -----
module {
  func.func @bitcast_index_to_i8_vector_scalable(%arg0: vector<[16]xindex>) -> vector<[128]xi8> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<[16]xindex> to vector<[16]xi64>
    %1 = llvm.bitcast %0 : vector<[16]xi64> to vector<[128]xi8>
    return %1 : vector<[128]xi8>
  }
}

// -----
module {
  func.func @broadcast_vec0d_from_vec0d(%arg0: vector<f32>) -> vector<f32> {
    return %arg0 : vector<f32>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_vec1d(%arg0: vector<2xf32>) -> vector<2xf32> {
    return %arg0 : vector<2xf32>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_vec1d_scalable(%arg0: vector<[2]xf32>) -> vector<[2]xf32> {
    return %arg0 : vector<[2]xf32>
  }
}

// -----
module {
  func.func @broadcast_vec0d_from_scalar(%arg0: f32) -> vector<f32> {
    %0 = llvm.mlir.poison : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<1xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<1xf32> to vector<f32>
    return %3 : vector<f32>
  }
}

// -----
module {
  func.func @broadcast_vec1d_from_scalar(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<4xf32> 
    return %3 : vector<4xf32>
  }
}

// -----
module {
  func.func @broadcast_scalable_vec1d_from_scalar(%arg0: vector<[4]xf32>, %arg1: f32) -> vector<[4]xf32> {
    %0 = llvm.mlir.poison : vector<[4]xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg1, %0[%1 : i32] : vector<[4]xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<[4]xf32> 
    return %3 : vector<[4]xf32>
  }
  func.func @shuffle_0D_direct(%arg0: vector<f32>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = llvm.shufflevector %0, %0 [0, 1, 0] : vector<1xf32> 
    return %1 : vector<3xf32>
  }
}

// -----
module {
  func.func @shuffle_1D_direct(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    return %arg0 : vector<2xf32>
  }
}

// -----
module {
  func.func @shuffle_1D_index_direct(%arg0: vector<2xindex>, %arg1: vector<2xindex>) -> vector<2xindex> {
    return %arg0 : vector<2xindex>
  }
}

// -----
module {
  func.func @shuffle_poison_mask(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, 3, -1] : vector<2xf32> 
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @shuffle_1D(%arg0: vector<2xf32>, %arg1: vector<3xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.poison : vector<5xf32>
    %1 = llvm.mlir.constant(2 : index) : i64
    %2 = llvm.extractelement %arg1[%1 : i64] : vector<3xf32>
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertelement %2, %0[%3 : i64] : vector<5xf32>
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.extractelement %arg1[%5 : i64] : vector<3xf32>
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.insertelement %6, %4[%7 : i64] : vector<5xf32>
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.extractelement %arg1[%9 : i64] : vector<3xf32>
    %11 = llvm.mlir.constant(2 : index) : i64
    %12 = llvm.insertelement %10, %8[%11 : i64] : vector<5xf32>
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.extractelement %arg0[%13 : i64] : vector<2xf32>
    %15 = llvm.mlir.constant(3 : index) : i64
    %16 = llvm.insertelement %14, %12[%15 : i64] : vector<5xf32>
    %17 = llvm.mlir.constant(0 : index) : i64
    %18 = llvm.extractelement %arg0[%17 : i64] : vector<2xf32>
    %19 = llvm.mlir.constant(4 : index) : i64
    %20 = llvm.insertelement %18, %16[%19 : i64] : vector<5xf32>
    return %20 : vector<5xf32>
  }
}

// -----
module {
  func.func @shuffle_2D(%arg0: vector<1x4xf32>, %arg1: vector<2x4xf32>) -> vector<3x4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1x4xf32> to !llvm.array<1 x vector<4xf32>>
    %2 = llvm.mlir.poison : !llvm.array<3 x vector<4xf32>>
    %3 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xf32>> 
    %4 = llvm.insertvalue %3, %2[0] : !llvm.array<3 x vector<4xf32>> 
    %5 = llvm.extractvalue %1[0] : !llvm.array<1 x vector<4xf32>> 
    %6 = llvm.insertvalue %5, %4[1] : !llvm.array<3 x vector<4xf32>> 
    %7 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xf32>> 
    %8 = llvm.insertvalue %7, %6[2] : !llvm.array<3 x vector<4xf32>> 
    %9 = builtin.unrealized_conversion_cast %8 : !llvm.array<3 x vector<4xf32>> to vector<3x4xf32>
    return %9 : vector<3x4xf32>
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_f32(%arg0: vector<16xf32>) -> f32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<16xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_f32_scalable(%arg0: vector<[16]xf32>) -> f32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<[16]xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @extract_vec_1e_from_vec_1d_f32(%arg0: vector<16xf32>) -> vector<1xf32> {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<16xf32>
    %2 = builtin.unrealized_conversion_cast %1 : f32 to vector<1xf32>
    return %2 : vector<1xf32>
  }
}

// -----
module {
  func.func @extract_vec_1e_from_vec_1d_f32_scalable(%arg0: vector<[16]xf32>) -> vector<1xf32> {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<[16]xf32>
    %2 = builtin.unrealized_conversion_cast %1 : f32 to vector<1xf32>
    return %2 : vector<1xf32>
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_index(%arg0: vector<16xindex>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<16xindex> to vector<16xi64>
    %1 = llvm.mlir.constant(15 : i64) : i64
    %2 = llvm.extractelement %0[%1 : i64] : vector<16xi64>
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_index_scalable(%arg0: vector<[16]xindex>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<[16]xindex> to vector<[16]xi64>
    %1 = llvm.mlir.constant(15 : i64) : i64
    %2 = llvm.extractelement %0[%1 : i64] : vector<[16]xi64>
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  }
}

// -----
module {
  func.func @extract_vec_2d_from_vec_3d_f32(%arg0: vector<4x3x16xf32>) -> vector<3x16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3x16xf32> to !llvm.array<4 x array<3 x vector<16xf32>>>
    %1 = llvm.extractvalue %0[0] : !llvm.array<4 x array<3 x vector<16xf32>>> 
    %2 = builtin.unrealized_conversion_cast %1 : !llvm.array<3 x vector<16xf32>> to vector<3x16xf32>
    return %2 : vector<3x16xf32>
  }
}

// -----
module {
  func.func @extract_vec_2d_from_vec_3d_f32_scalable(%arg0: vector<4x3x[16]xf32>) -> vector<3x[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3x[16]xf32> to !llvm.array<4 x array<3 x vector<[16]xf32>>>
    %1 = llvm.extractvalue %0[0] : !llvm.array<4 x array<3 x vector<[16]xf32>>> 
    %2 = builtin.unrealized_conversion_cast %1 : !llvm.array<3 x vector<[16]xf32>> to vector<3x[16]xf32>
    return %2 : vector<3x[16]xf32>
  }
}

// -----
module {
  func.func @extract_vec_1d_from_vec_3d_f32(%arg0: vector<4x3x16xf32>) -> vector<16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3x16xf32> to !llvm.array<4 x array<3 x vector<16xf32>>>
    %1 = llvm.extractvalue %0[0, 0] : !llvm.array<4 x array<3 x vector<16xf32>>> 
    return %1 : vector<16xf32>
  }
}

// -----
module {
  func.func @extract_vec_1d_from_vec_3d_f32_scalable(%arg0: vector<4x3x[16]xf32>) -> vector<[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3x[16]xf32> to !llvm.array<4 x array<3 x vector<[16]xf32>>>
    %1 = llvm.extractvalue %0[0, 0] : !llvm.array<4 x array<3 x vector<[16]xf32>>> 
    return %1 : vector<[16]xf32>
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_3d_f32(%arg0: vector<4x3x16xf32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3x16xf32> to !llvm.array<4 x array<3 x vector<16xf32>>>
    %1 = llvm.extractvalue %0[0, 0] : !llvm.array<4 x array<3 x vector<16xf32>>> 
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %1[%2 : i64] : vector<16xf32>
    return %3 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_3d_f32_scalable(%arg0: vector<4x3x[16]xf32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x3x[16]xf32> to !llvm.array<4 x array<3 x vector<[16]xf32>>>
    %1 = llvm.extractvalue %0[0, 0] : !llvm.array<4 x array<3 x vector<[16]xf32>>> 
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %1[%2 : i64] : vector<[16]xf32>
    return %3 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_f32_dynamic_idx(%arg0: vector<16xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<16xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_1d_f32_dynamic_idx_scalable(%arg0: vector<[16]xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<[16]xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_2d_f32_inner_dynamic_idx(%arg0: vector<1x16xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1x16xf32> to !llvm.array<1 x vector<16xf32>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<1 x vector<16xf32>> 
    %3 = llvm.extractelement %2[%0 : i64] : vector<16xf32>
    return %3 : f32
  }
  func.func @extract_scalar_from_vec_2d_f32_inner_dynamic_idx_scalable(%arg0: vector<1x[16]xf32>, %arg1: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1x[16]xf32> to !llvm.array<1 x vector<[16]xf32>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<1 x vector<[16]xf32>> 
    %3 = llvm.extractelement %2[%0 : i64] : vector<[16]xf32>
    return %3 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_2d_f32_outer_dynamic_idx(%arg0: vector<1x16xf32>, %arg1: index) -> f32 {
    %0 = vector.extract %arg0[%arg1, 0] : f32 from vector<1x16xf32>
    return %0 : f32
  }
  func.func @extract_scalar_from_vec_2d_f32_outer_dynamic_idx_scalable(%arg0: vector<1x[16]xf32>, %arg1: index) -> f32 {
    %0 = vector.extract %arg0[%arg1, 0] : f32 from vector<1x[16]xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_0d_index(%arg0: vector<index>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<index> to vector<1xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.extractelement %0[%1 : i64] : vector<1xi64>
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    return %3 : index
  }
}

// -----
module {
  func.func @extract_scalar_from_vec_2d_f32_dynamic_idxs_compile_time_const(%arg0: vector<32x1xf32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<32x1xf32> to !llvm.array<32 x vector<1xf32>>
    %c0 = arith.constant 0 : index
    %1 = llvm.extractvalue %0[0] : !llvm.array<32 x vector<1xf32>> 
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %1[%2 : i64] : vector<1xf32>
    return %3 : f32
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_0d(%arg0: f32, %arg1: vector<f32>) -> vector<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<f32> to vector<1xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<1xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<1xf32> to vector<f32>
    return %3 : vector<f32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_1d_f32(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    return %1 : vector<4xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_1d_f32_scalable(%arg0: f32, %arg1: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<[4]xf32>
    return %1 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_1d_index(%arg0: index, %arg1: vector<4xindex>) -> vector<4xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xindex> to vector<4xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.insertelement %1, %0[%2 : i64] : vector<4xi64>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi64> to vector<4xindex>
    return %4 : vector<4xindex>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_1d_index_scalable(%arg0: index, %arg1: vector<[4]xindex>) -> vector<[4]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<[4]xindex> to vector<[4]xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.insertelement %1, %0[%2 : i64] : vector<[4]xi64>
    %4 = builtin.unrealized_conversion_cast %3 : vector<[4]xi64> to vector<[4]xindex>
    return %4 : vector<[4]xindex>
  }
}

// -----
module {
  func.func @insert_vec_2d_into_vec_3d_f32(%arg0: vector<8x16xf32>, %arg1: vector<4x8x16xf32>) -> vector<4x8x16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x8x16xf32> to !llvm.array<4 x array<8 x vector<16xf32>>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<8x16xf32> to !llvm.array<8 x vector<16xf32>>
    %2 = llvm.insertvalue %1, %0[3] : !llvm.array<4 x array<8 x vector<16xf32>>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x array<8 x vector<16xf32>>> to vector<4x8x16xf32>
    return %3 : vector<4x8x16xf32>
  }
}

// -----
module {
  func.func @insert_vec_2d_into_vec_3d_f32_scalable(%arg0: vector<8x[16]xf32>, %arg1: vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x8x[16]xf32> to !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<8x[16]xf32> to !llvm.array<8 x vector<[16]xf32>>
    %2 = llvm.insertvalue %1, %0[3] : !llvm.array<4 x array<8 x vector<[16]xf32>>> 
    %3 = builtin.unrealized_conversion_cast %2 : !llvm.array<4 x array<8 x vector<[16]xf32>>> to vector<4x8x[16]xf32>
    return %3 : vector<4x8x[16]xf32>
  }
}

// -----
module {
  func.func @insert_vec_1d_into_vec_3d_f32(%arg0: vector<16xf32>, %arg1: vector<4x8x16xf32>) -> vector<4x8x16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x8x16xf32> to !llvm.array<4 x array<8 x vector<16xf32>>>
    %1 = llvm.insertvalue %arg0, %0[3, 7] : !llvm.array<4 x array<8 x vector<16xf32>>> 
    %2 = builtin.unrealized_conversion_cast %1 : !llvm.array<4 x array<8 x vector<16xf32>>> to vector<4x8x16xf32>
    return %2 : vector<4x8x16xf32>
  }
}

// -----
module {
  func.func @insert_vec_1d_into_vec_3d_f32_scalable(%arg0: vector<[16]xf32>, %arg1: vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x8x[16]xf32> to !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %1 = llvm.insertvalue %arg0, %0[3, 7] : !llvm.array<4 x array<8 x vector<[16]xf32>>> 
    %2 = builtin.unrealized_conversion_cast %1 : !llvm.array<4 x array<8 x vector<[16]xf32>>> to vector<4x8x[16]xf32>
    return %2 : vector<4x8x[16]xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_3d_f32(%arg0: f32, %arg1: vector<4x8x16xf32>) -> vector<4x8x16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x8x16xf32> to !llvm.array<4 x array<8 x vector<16xf32>>>
    %1 = llvm.extractvalue %0[3, 7] : !llvm.array<4 x array<8 x vector<16xf32>>> 
    %2 = llvm.mlir.constant(15 : i64) : i64
    %3 = llvm.insertelement %arg0, %1[%2 : i64] : vector<16xf32>
    %4 = llvm.insertvalue %3, %0[3, 7] : !llvm.array<4 x array<8 x vector<16xf32>>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<4 x array<8 x vector<16xf32>>> to vector<4x8x16xf32>
    return %5 : vector<4x8x16xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_3d_f32_scalable(%arg0: f32, %arg1: vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4x8x[16]xf32> to !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %1 = llvm.extractvalue %0[3, 7] : !llvm.array<4 x array<8 x vector<[16]xf32>>> 
    %2 = llvm.mlir.constant(15 : i64) : i64
    %3 = llvm.insertelement %arg0, %1[%2 : i64] : vector<[16]xf32>
    %4 = llvm.insertvalue %3, %0[3, 7] : !llvm.array<4 x array<8 x vector<[16]xf32>>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<4 x array<8 x vector<[16]xf32>>> to vector<4x8x[16]xf32>
    return %5 : vector<4x8x[16]xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_1d_f32_dynamic_idx(%arg0: vector<16xf32>, %arg1: f32, %arg2: index) -> vector<16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<16xf32>
    return %1 : vector<16xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_1d_f32_dynamic_idx_scalable(%arg0: vector<[16]xf32>, %arg1: f32, %arg2: index) -> vector<[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<[16]xf32>
    return %1 : vector<[16]xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_2d_f32_dynamic_idx(%arg0: vector<1x16xf32>, %arg1: f32, %arg2: index) -> vector<1x16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1x16xf32> to !llvm.array<1 x vector<16xf32>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<1 x vector<16xf32>> 
    %3 = llvm.insertelement %arg1, %2[%0 : i64] : vector<16xf32>
    %4 = llvm.insertvalue %3, %1[0] : !llvm.array<1 x vector<16xf32>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<1 x vector<16xf32>> to vector<1x16xf32>
    return %5 : vector<1x16xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_2d_f32_dynamic_idx_scalable(%arg0: vector<1x[16]xf32>, %arg1: f32, %arg2: index) -> vector<1x[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<1x[16]xf32> to !llvm.array<1 x vector<[16]xf32>>
    %2 = llvm.extractvalue %1[0] : !llvm.array<1 x vector<[16]xf32>> 
    %3 = llvm.insertelement %arg1, %2[%0 : i64] : vector<[16]xf32>
    %4 = llvm.insertvalue %3, %1[0] : !llvm.array<1 x vector<[16]xf32>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<1 x vector<[16]xf32>> to vector<1x[16]xf32>
    return %5 : vector<1x[16]xf32>
  }
}

// -----
module {
  func.func @insert_scalar_into_vec_2d_f32_dynamic_idx_fail(%arg0: vector<2x16xf32>, %arg1: f32, %arg2: index) -> vector<2x16xf32> {
    %0 = vector.insert %arg1, %arg0 [%arg2, 0] : f32 into vector<2x16xf32>
    return %0 : vector<2x16xf32>
  }
}

// -----
module {
  func.func @insert_scalar_from_vec_2d_f32_dynamic_idxs_compile_time_const(%arg0: vector<4x1xf32>) -> vector<4x1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x1xf32> to !llvm.array<4 x vector<1xf32>>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f32
    %1 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<1xf32>> 
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.insertelement %cst, %1[%2 : i64] : vector<1xf32>
    %4 = llvm.insertvalue %3, %0[0] : !llvm.array<4 x vector<1xf32>> 
    %5 = builtin.unrealized_conversion_cast %4 : !llvm.array<4 x vector<1xf32>> to vector<4x1xf32>
    return %5 : vector<4x1xf32>
  }
}

// -----
module {
  func.func @type_cast_f32(%arg0: memref<8x8x8xf32>) -> memref<vector<8x8x8xf32>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8x8x8xf32> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %2, %1[0] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %4, %3[1] : !llvm.struct<(ptr, ptr, i64)> 
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr, ptr, i64)> to memref<vector<8x8x8xf32>>
    return %8 : memref<vector<8x8x8xf32>>
  }
}

// -----
module {
  func.func @type_cast_index(%arg0: memref<8x8x8xindex>) -> memref<vector<8x8x8xindex>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8x8x8xindex> to !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %2, %1[0] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %4, %3[1] : !llvm.struct<(ptr, ptr, i64)> 
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr, ptr, i64)> to memref<vector<8x8x8xindex>>
    return %8 : memref<vector<8x8x8xindex>>
  }
}

// -----
module {
  func.func @type_cast_non_zero_addrspace(%arg0: memref<8x8x8xf32, 3>) -> memref<vector<8x8x8xf32>, 3> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8x8x8xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %2, %1[0] : !llvm.struct<(ptr<3>, ptr<3>, i64)> 
    %4 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %4, %3[1] : !llvm.struct<(ptr<3>, ptr<3>, i64)> 
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr<3>, ptr<3>, i64)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr<3>, ptr<3>, i64)> to memref<vector<8x8x8xf32>, 3>
    return %8 : memref<vector<8x8x8xf32>, 3>
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printI64(i64)
  func.func @print_scalar_i64(%arg0: i64) {
    llvm.call @printI64(%arg0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printU64(i64)
  func.func @print_scalar_ui64(%arg0: ui64) {
    %0 = builtin.unrealized_conversion_cast %arg0 : ui64 to i64
    llvm.call @printU64(%0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printU64(i64)
  func.func @print_scalar_index(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i64
    llvm.call @printU64(%0) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printF32(f32)
  func.func @print_scalar_f32(%arg0: f32) {
    llvm.call @printF32(%arg0) : (f32) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printNewline()
  llvm.func @printF64(f64)
  func.func @print_scalar_f64(%arg0: f64) {
    llvm.call @printF64(%arg0) : (f64) -> ()
    llvm.call @printNewline() : () -> ()
    return
  }
}

// -----
module {
  llvm.func @printString(!llvm.ptr)
  llvm.mlir.global private constant @vector_print_str(dense<[72, 101, 108, 108, 111, 44, 32, 87, 111, 114, 108, 100, 33, 0]> : tensor<14xi8>) {addr_space = 0 : i32} : !llvm.array<14 x i8>
  func.func @print_string() {
    %0 = llvm.mlir.addressof @vector_print_str : !llvm.ptr
    %1 = llvm.getelementptr %0[0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<14 x i8>
    llvm.call @printString(%1) : (!llvm.ptr) -> ()
    return
  }
}

// -----
module {
  func.func @reduce_0d_f32(%arg0: vector<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f32> to vector<1xf32>
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = "llvm.intr.vector.reduce.fadd"(%1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<1xf32>) -> f32
    return %2 : f32
  }
}

// -----
module {
  func.func @reduce_f16(%arg0: vector<16xf16>) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f16, vector<16xf16>) -> f16
    return %1 : f16
  }
}

// -----
module {
  func.func @reduce_f16_scalable(%arg0: vector<[16]xf16>) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f16, vector<[16]xf16>) -> f16
    return %1 : f16
  }
}

// -----
module {
  func.func @reduce_f32(%arg0: vector<16xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<16xf32>) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_f32_scalable(%arg0: vector<[16]xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<[16]xf32>) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_f64(%arg0: vector<16xf64>) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, vector<16xf64>) -> f64
    return %1 : f64
  }
}

// -----
module {
  func.func @reduce_f64_scalable(%arg0: vector<[16]xf64>) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, vector<[16]xf64>) -> f64
    return %1 : f64
  }
}

// -----
module {
  func.func @reduce_i8(%arg0: vector<16xi8>) -> i8 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi8>) -> i8
    return %0 : i8
  }
}

// -----
module {
  func.func @reduce_i8_scalable(%arg0: vector<[16]xi8>) -> i8 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi8>) -> i8
    return %0 : i8
  }
}

// -----
module {
  func.func @reduce_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.add %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.add %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_mul_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_mul_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_mul_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.mul %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_mul_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.mul %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_fmaximum_f32(%arg0: vector<16xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fmaximum(%arg0) : (vector<16xf32>) -> f32
    %1 = llvm.intr.maximum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fmaximum_f32_scalable(%arg0: vector<[16]xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fmaximum(%arg0) : (vector<[16]xf32>) -> f32
    %1 = llvm.intr.maximum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fminimum_f32(%arg0: vector<16xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fminimum(%arg0) : (vector<16xf32>) -> f32
    %1 = llvm.intr.minimum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fminimum_f32_scalable(%arg0: vector<[16]xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fminimum(%arg0) : (vector<[16]xf32>) -> f32
    %1 = llvm.intr.minimum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fmax_f32(%arg0: vector<16xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fmax(%arg0) : (vector<16xf32>) -> f32
    %1 = llvm.intr.maxnum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fmax_f32_scalable(%arg0: vector<[16]xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fmax(%arg0) : (vector<[16]xf32>) -> f32
    %1 = llvm.intr.maxnum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fmin_f32(%arg0: vector<16xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fmin(%arg0) : (vector<16xf32>) -> f32
    %1 = llvm.intr.minnum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_fmin_f32_scalable(%arg0: vector<[16]xf32>, %arg1: f32) -> f32 {
    %0 = llvm.intr.vector.reduce.fmin(%arg0) : (vector<[16]xf32>) -> f32
    %1 = llvm.intr.minnum(%0, %arg1) : (f32, f32) -> f32
    return %1 : f32
  }
}

// -----
module {
  func.func @reduce_minui_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_minui_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_minui_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.icmp "ule" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_minui_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.icmp "ule" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_maxui_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_maxui_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_maxui_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.icmp "uge" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_maxui_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.icmp "uge" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_minsi_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_minsi_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_minsi_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.icmp "sle" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_minsi_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.icmp "sle" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_maxsi_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_maxsi_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_maxsi_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.icmp "sge" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_maxsi_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.icmp "sge" %arg1, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    return %2 : i32
  }
}

// -----
module {
  func.func @reduce_and_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_and_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_and_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.and %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_and_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.and %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_or_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_or_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_or_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.or %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_or_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.or %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_xor_i32(%arg0: vector<16xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<16xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_xor_i32_scalable(%arg0: vector<[16]xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<[16]xi32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @reduce_xor_acc_i32(%arg0: vector<16xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<16xi32>) -> i32
    %1 = llvm.xor %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_xor_acc_i32_scalable(%arg0: vector<[16]xi32>, %arg1: i32) -> i32 {
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = llvm.xor %arg1, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @reduce_i64(%arg0: vector<16xi64>) -> i64 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi64>) -> i64
    return %0 : i64
  }
}

// -----
module {
  func.func @reduce_i64_scalable(%arg0: vector<[16]xi64>) -> i64 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi64>) -> i64
    return %0 : i64
  }
}

// -----
module {
  func.func @reduce_index(%arg0: vector<16xindex>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<16xindex> to vector<16xi64>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<16xi64>) -> i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    return %2 : index
  }
}

// -----
module {
  func.func @reduce_index_scalable(%arg0: vector<[16]xindex>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<[16]xindex> to vector<[16]xi64>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<[16]xi64>) -> i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    return %2 : index
  }
}

// -----
module {
  func.func @transpose_0d(%arg0: vector<f32>) -> vector<f32> {
    return %arg0 : vector<f32>
  }
}

// -----
module {
  func.func @load(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @load_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<[8]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<[8]xf32>
    return %8 : vector<[8]xf32>
  }
}

// -----
module {
  func.func @load_nontemporal(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @load_nontemporal_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<[8]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> vector<[8]xf32>
    return %8 : vector<[8]xf32>
  }
}

// -----
module {
  func.func @load_index(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) -> vector<8xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi64>
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xi64> to vector<8xindex>
    return %9 : vector<8xindex>
  }
}

// -----
module {
  func.func @load_index_scalable(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) -> vector<[8]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> vector<[8]xi64>
    %9 = builtin.unrealized_conversion_cast %8 : vector<[8]xi64> to vector<[8]xindex>
    return %9 : vector<[8]xindex>
  }
}

// -----
module {
  func.func @load_0d(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<f32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<1xf32>
    %9 = builtin.unrealized_conversion_cast %8 : vector<1xf32> to vector<f32>
    return %9 : vector<f32>
  }
}

// -----
module {
  func.func @load_with_alignment(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @store(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<4xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<[4]xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64} : vector<[4]xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_nontemporal(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<4xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64, nontemporal} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_nontemporal_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<[4]xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64, nontemporal} : vector<[4]xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_index(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<11> : vector<4xindex>
    %3 = builtin.unrealized_conversion_cast %cst : vector<4xindex> to vector<4xi64>
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(100 : index) : i64
    %6 = llvm.mul %1, %5 : i64
    %7 = llvm.add %6, %0 : i64
    %8 = llvm.getelementptr %4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %8 {alignment = 8 : i64} : vector<4xi64>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_index_scalable(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<11> : vector<[4]xindex>
    %3 = builtin.unrealized_conversion_cast %cst : vector<[4]xindex> to vector<[4]xi64>
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(100 : index) : i64
    %6 = llvm.mul %1, %5 : i64
    %7 = llvm.add %6, %0 : i64
    %8 = llvm.getelementptr %4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %8 {alignment = 8 : i64} : vector<[4]xi64>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_0d(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<f32>
    %3 = builtin.unrealized_conversion_cast %cst : vector<f32> to vector<1xf32>
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(100 : index) : i64
    %6 = llvm.mul %1, %5 : i64
    %7 = llvm.add %6, %0 : i64
    %8 = llvm.getelementptr %4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %3, %8 {alignment = 4 : i64} : vector<1xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_with_alignment(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index, %arg3: vector<4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %7 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_load(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.intr.masked.load %3, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    return %4 : vector<16xf32>
  }
}

// -----
module {
  func.func @masked_load_scalable(%arg0: memref<?xf32>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xf32>) -> vector<[16]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.intr.masked.load %3, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<[16]xi1>, vector<[16]xf32>) -> vector<[16]xf32>
    return %4 : vector<[16]xf32>
  }
}

// -----
module {
  func.func @masked_load_index(%arg0: memref<?xindex>, %arg1: vector<16xi1>, %arg2: vector<16xindex>) -> vector<16xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<16xindex> to vector<16xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.intr.masked.load %4, %arg1, %0 {alignment = 8 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi64>) -> vector<16xi64>
    %6 = builtin.unrealized_conversion_cast %5 : vector<16xi64> to vector<16xindex>
    return %6 : vector<16xindex>
  }
}

// -----
module {
  func.func @masked_load_index_scalable(%arg0: memref<?xindex>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xindex>) -> vector<[16]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<[16]xindex> to vector<[16]xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.intr.masked.load %4, %arg1, %0 {alignment = 8 : i32} : (!llvm.ptr, vector<[16]xi1>, vector<[16]xi64>) -> vector<[16]xi64>
    %6 = builtin.unrealized_conversion_cast %5 : vector<[16]xi64> to vector<[16]xindex>
    return %6 : vector<[16]xindex>
  }
}

// -----
module {
  func.func @masked_load_with_alignment(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>, %arg3: index) -> vector<16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg3 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.intr.masked.load %3, %arg1, %arg2 {alignment = 2 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    return %4 : vector<16xf32>
  }
}

// -----
module {
  func.func @masked_store(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %arg2, %3, %arg1 {alignment = 4 : i32} : vector<16xf32>, vector<16xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_store_scalable(%arg0: memref<?xf32>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %arg2, %3, %arg1 {alignment = 4 : i32} : vector<[16]xf32>, vector<[16]xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_store_index(%arg0: memref<?xindex>, %arg1: vector<16xi1>, %arg2: vector<16xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<16xindex> to vector<16xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.intr.masked.store %0, %4, %arg1 {alignment = 8 : i32} : vector<16xi64>, vector<16xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_store_index_scalable(%arg0: memref<?xindex>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<[16]xindex> to vector<[16]xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.intr.masked.store %0, %4, %arg1 {alignment = 8 : i32} : vector<[16]xi64>, vector<[16]xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_store_with_alignment(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>, %arg3: index) {
    %0 = builtin.unrealized_conversion_cast %arg3 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %arg2, %3, %arg1 {alignment = 2 : i32} : vector<16xf32>, vector<16xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @gather(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 4 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    return %5 : vector<3xf32>
  }
}

// -----
module {
  func.func @gather_scalable(%arg0: memref<?xf32>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>) -> vector<[3]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 4 : i32} : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    return %5 : vector<[3]xf32>
  }
}

// -----
module {
  func.func @gather_global_memory(%arg0: memref<?xf32, 1>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr<1>, vector<3xi32>) -> vector<3x!llvm.ptr<1>>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 4 : i32} : (vector<3x!llvm.ptr<1>>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    return %5 : vector<3xf32>
  }
}

// -----
module {
  func.func @gather_global_memory_scalable(%arg0: memref<?xf32, 1>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>) -> vector<[3]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, 1> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr<1>, vector<[3]xi32>) -> vector<[3]x!llvm.ptr<1>>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 4 : i32} : (vector<[3]x!llvm.ptr<1>>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    return %5 : vector<[3]xf32>
  }
}

// -----
module {
  func.func @gather_index(%arg0: memref<?xindex>, %arg1: vector<3xindex>, %arg2: vector<3xi1>, %arg3: vector<3xindex>) -> vector<3xindex> {
    %0 = builtin.unrealized_conversion_cast %arg3 : vector<3xindex> to vector<3xi64>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<3xindex> to vector<3xi64>
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to i64
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %6 = llvm.getelementptr %5[%1] : (!llvm.ptr, vector<3xi64>) -> vector<3x!llvm.ptr>, i64
    %7 = llvm.intr.masked.gather %6, %arg2, %0 {alignment = 8 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xi64>) -> vector<3xi64>
    %8 = builtin.unrealized_conversion_cast %7 : vector<3xi64> to vector<3xindex>
    return %8 : vector<3xindex>
  }
}

// -----
module {
  func.func @gather_index_scalable(%arg0: memref<?xindex>, %arg1: vector<[3]xindex>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xindex>) -> vector<[3]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg3 : vector<[3]xindex> to vector<[3]xi64>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<[3]xindex> to vector<[3]xi64>
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to i64
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %6 = llvm.getelementptr %5[%1] : (!llvm.ptr, vector<[3]xi64>) -> vector<[3]x!llvm.ptr>, i64
    %7 = llvm.intr.masked.gather %6, %arg2, %0 {alignment = 8 : i32} : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xi64>) -> vector<[3]xi64>
    %8 = builtin.unrealized_conversion_cast %7 : vector<[3]xi64> to vector<[3]xindex>
    return %8 : vector<[3]xindex>
  }
}

// -----
module {
  func.func @gather_1d_from_2d(%arg0: memref<4x4xf32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xf32>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %c3 = arith.constant 3 : index
    %1 = builtin.unrealized_conversion_cast %c3 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.constant(4 : index) : i64
    %4 = llvm.mul %1, %3 : i64
    %5 = llvm.add %4, %1 : i64
    %6 = llvm.getelementptr %2[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.getelementptr %6[%arg1] : (!llvm.ptr, vector<4xi32>) -> vector<4x!llvm.ptr>, f32
    %8 = llvm.intr.masked.gather %7, %arg2, %arg3 {alignment = 4 : i32} : (vector<4x!llvm.ptr>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    return %8 : vector<4xf32>
  }
}

// -----
module {
  func.func @gather_1d_from_2d_scalable(%arg0: memref<4x?xf32>, %arg1: vector<[4]xi32>, %arg2: vector<[4]xi1>, %arg3: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %c3 = arith.constant 3 : index
    %1 = builtin.unrealized_conversion_cast %c3 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mul %1, %3 : i64
    %5 = llvm.add %4, %1 : i64
    %6 = llvm.getelementptr %2[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.getelementptr %6[%arg1] : (!llvm.ptr, vector<[4]xi32>) -> vector<[4]x!llvm.ptr>, f32
    %8 = llvm.intr.masked.gather %7, %arg2, %arg3 {alignment = 4 : i32} : (vector<[4]x!llvm.ptr>, vector<[4]xi1>, vector<[4]xf32>) -> vector<[4]xf32>
    return %8 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @gather_with_alignment(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>, %arg4: index) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 8 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    return %5 : vector<3xf32>
  }
}

// -----
module {
  func.func @scatter(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %4, %arg2 {alignment = 4 : i32} : vector<3xf32>, vector<3xi1> into vector<3x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_scalable(%arg0: memref<?xf32>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %4, %arg2 {alignment = 4 : i32} : vector<[3]xf32>, vector<[3]xi1> into vector<[3]x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_index(%arg0: memref<?xindex>, %arg1: vector<3xindex>, %arg2: vector<3xi1>, %arg3: vector<3xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg3 : vector<3xindex> to vector<3xi64>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<3xindex> to vector<3xi64>
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to i64
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %6 = llvm.getelementptr %5[%1] : (!llvm.ptr, vector<3xi64>) -> vector<3x!llvm.ptr>, i64
    llvm.intr.masked.scatter %0, %6, %arg2 {alignment = 8 : i32} : vector<3xi64>, vector<3xi1> into vector<3x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_index_scalable(%arg0: memref<?xindex>, %arg1: vector<[3]xindex>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg3 : vector<[3]xindex> to vector<[3]xi64>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<[3]xindex> to vector<[3]xi64>
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to i64
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %6 = llvm.getelementptr %5[%1] : (!llvm.ptr, vector<[3]xi64>) -> vector<[3]x!llvm.ptr>, i64
    llvm.intr.masked.scatter %0, %6, %arg2 {alignment = 8 : i32} : vector<[3]xi64>, vector<[3]xi1> into vector<[3]x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_1d_into_2d(%arg0: memref<4x4xf32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %c3 = arith.constant 3 : index
    %1 = builtin.unrealized_conversion_cast %c3 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.constant(4 : index) : i64
    %4 = llvm.mul %1, %3 : i64
    %5 = llvm.add %4, %1 : i64
    %6 = llvm.getelementptr %2[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.getelementptr %6[%arg1] : (!llvm.ptr, vector<4xi32>) -> vector<4x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %7, %arg2 {alignment = 4 : i32} : vector<4xf32>, vector<4xi1> into vector<4x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_1d_into_2d_scalable(%arg0: memref<4x?xf32>, %arg1: vector<[4]xi32>, %arg2: vector<[4]xi1>, %arg3: vector<[4]xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %c3 = arith.constant 3 : index
    %1 = builtin.unrealized_conversion_cast %c3 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mul %1, %3 : i64
    %5 = llvm.add %4, %1 : i64
    %6 = llvm.getelementptr %2[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.getelementptr %6[%arg1] : (!llvm.ptr, vector<[4]xi32>) -> vector<[4]x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %7, %arg2 {alignment = 4 : i32} : vector<[4]xf32>, vector<[4]xi1> into vector<[4]x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_with_alignment(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>, %arg4: index) {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %4, %arg2 {alignment = 8 : i32} : vector<3xf32>, vector<3xi1> into vector<3x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @expand_load_op(%arg0: memref<?xf32>, %arg1: vector<11xi1>, %arg2: vector<11xf32>) -> vector<11xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = "llvm.intr.masked.expandload"(%3, %arg1, %arg2) : (!llvm.ptr, vector<11xi1>, vector<11xf32>) -> vector<11xf32>
    return %4 : vector<11xf32>
  }
}

// -----
module {
  func.func @expand_load_op_index(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>) -> vector<11xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<11xindex> to vector<11xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = "llvm.intr.masked.expandload"(%4, %arg1, %0) : (!llvm.ptr, vector<11xi1>, vector<11xi64>) -> vector<11xi64>
    %6 = builtin.unrealized_conversion_cast %5 : vector<11xi64> to vector<11xindex>
    return %6 : vector<11xindex>
  }
}

// -----
module {
  func.func @expand_load_op_with_alignment(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>, %arg3: index) -> vector<11xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<11xindex> to vector<11xi64>
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = "llvm.intr.masked.expandload"(%4, %arg1, %0) <{arg_attrs = [{llvm.align = 8 : i64}, {}, {}]}> : (!llvm.ptr, vector<11xi1>, vector<11xi64>) -> vector<11xi64>
    %6 = builtin.unrealized_conversion_cast %5 : vector<11xi64> to vector<11xindex>
    return %6 : vector<11xindex>
  }
}

// -----
module {
  func.func @compress_store_op(%arg0: memref<?xf32>, %arg1: vector<11xi1>, %arg2: vector<11xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    "llvm.intr.masked.compressstore"(%arg2, %3, %arg1) : (vector<11xf32>, !llvm.ptr, vector<11xi1>) -> ()
    return
  }
}

// -----
module {
  func.func @compress_store_op_index(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<11xindex> to vector<11xi64>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i64
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    "llvm.intr.masked.compressstore"(%0, %4, %arg1) : (vector<11xi64>, !llvm.ptr, vector<11xi1>) -> ()
    return
  }
}

// -----
module {
  func.func @compress_store_op_with_alignment(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>, %arg3: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<11xindex> to vector<11xi64>
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    "llvm.intr.masked.compressstore"(%0, %4, %arg1) <{arg_attrs = [{}, {llvm.align = 8 : i64}, {}]}> : (vector<11xi64>, !llvm.ptr, vector<11xi1>) -> ()
    return
  }
}

// -----
module {
  func.func @scalable_insert(%arg0: vector<4xf32>, %arg1: vector<[4]xf32>) -> vector<[4]xf32> {
    %0 = llvm.intr.vector.insert %arg0, %arg1[0] : vector<4xf32> into vector<[4]xf32>
    %1 = llvm.intr.vector.insert %arg0, %0[4] : vector<4xf32> into vector<[4]xf32>
    return %1 : vector<[4]xf32>
  }
}

// -----
module {
  func.func @scalable_extract(%arg0: vector<[4]xf32>) -> vector<8xf32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<8xf32> from vector<[4]xf32>
    return %0 : vector<8xf32>
  }
}

// -----
module {
  func.func @interleave_0d(%arg0: vector<i8>, %arg1: vector<i8>) -> vector<2xi8> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<i8> to vector<1xi8>
    %1 = builtin.unrealized_conversion_cast %arg0 : vector<i8> to vector<1xi8>
    %2 = llvm.shufflevector %1, %0 [0, 1] : vector<1xi8> 
    return %2 : vector<2xi8>
  }
}

// -----
module {
  func.func @interleave_1d(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<16xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 8, 1, 9, 2, 10, 3, 11, 4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32> 
    return %0 : vector<16xf32>
  }
}

// -----
module {
  func.func @interleave_1d_scalable(%arg0: vector<[4]xi32>, %arg1: vector<[4]xi32>) -> vector<[8]xi32> {
    %0 = "llvm.intr.vector.interleave2"(%arg0, %arg1) : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[8]xi32>
    return %0 : vector<[8]xi32>
  }
}

// -----
module {
  func.func @deinterleave_1d(%arg0: vector<4xi32>) -> (vector<2xi32>, vector<2xi32>) {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 2] : vector<4xi32> 
    %2 = llvm.shufflevector %arg0, %0 [1, 3] : vector<4xi32> 
    return %1, %2 : vector<2xi32>, vector<2xi32>
  }
}

// -----
module {
  func.func @deinterleave_1d_scalable(%arg0: vector<[4]xi32>) -> (vector<[2]xi32>, vector<[2]xi32>) {
    %0 = "llvm.intr.vector.deinterleave2"(%arg0) : (vector<[4]xi32>) -> !llvm.struct<(vector<[2]xi32>, vector<[2]xi32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(vector<[2]xi32>, vector<[2]xi32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(vector<[2]xi32>, vector<[2]xi32>)> 
    return %1, %2 : vector<[2]xi32>, vector<[2]xi32>
  }
}

// -----
module {
  func.func @from_elements_1d(%arg0: f32, %arg1: f32) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<3xf32>
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.insertelement %arg1, %2[%3 : i64] : vector<3xf32>
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.insertelement %arg0, %4[%5 : i64] : vector<3xf32>
    return %6 : vector<3xf32>
  }
}

// -----
module {
  func.func @from_elements_0d(%arg0: f32) -> vector<f32> {
    %0 = llvm.mlir.poison : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<1xf32>
    %3 = builtin.unrealized_conversion_cast %2 : vector<1xf32> to vector<f32>
    return %3 : vector<f32>
  }
}

// -----
module {
  func.func @to_elements_no_dead_elements(%arg0: vector<4xf32>) -> (f32, f32, f32, f32) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.extractelement %arg0[%2 : i64] : vector<4xf32>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %arg0[%4 : i64] : vector<4xf32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %arg0[%6 : i64] : vector<4xf32>
    return %1, %3, %5, %7 : f32, f32, f32, f32
  }
}

// -----
module {
  func.func @to_elements_dead_elements(%arg0: vector<4xf32>) -> (f32, f32) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<4xf32>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.extractelement %arg0[%2 : i64] : vector<4xf32>
    return %1, %3 : f32, f32
  }
}

// -----
module {
  func.func @step_scalable() -> vector<[4]xindex> {
    %0 = llvm.intr.stepvector : vector<[4]xi64>
    %1 = builtin.unrealized_conversion_cast %0 : vector<[4]xi64> to vector<[4]xindex>
    return %1 : vector<[4]xindex>
  }
}

