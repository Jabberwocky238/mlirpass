module {
  func.func @load_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8xf32> {
    %c4 = arith.constant 4 : index
    %subview = memref.subview %arg0[%arg1, %arg1, 0] [1, 1, 32] [1, 1, 1] : memref<8x16x32xf32> to memref<32xf32, strided<[1], offset: ?>>
    %base_buffer, %offset, %sizes, %strides = memref.extract_strided_metadata %subview : memref<32xf32, strided<[1], offset: ?>> -> memref<f32>, index, index, index
    %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
    %0 = arith.muli %offset, %c4 : index
    %1 = arith.addi %intptr, %0 : index
    %2 = arith.index_cast %1 : index to i64
    %3 = xegpu.create_nd_tdesc %2, shape : [32], strides : [1] : i64 -> !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
    %4 = xegpu.load_nd %3[%arg1]  : !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8xf32>
    return %4 : vector<8xf32>
  }
}

// -----
module {
  func.func @load_2D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8x16xf32> {
    %c4 = arith.constant 4 : index
    %subview = memref.subview %arg0[%arg1, 0, 0] [1, 16, 32] [1, 1, 1] : memref<8x16x32xf32> to memref<16x32xf32, strided<[32, 1], offset: ?>>
    %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<16x32xf32, strided<[32, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
    %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
    %0 = arith.muli %offset, %c4 : index
    %1 = arith.addi %intptr, %0 : index
    %2 = arith.index_cast %1 : index to i64
    %3 = xegpu.create_nd_tdesc %2, shape : [16, 32], strides : [32, 1] : i64 -> !xegpu.tensor_desc<8x16xf32>
    %4 = xegpu.load_nd %3[%arg1, %arg1]  : !xegpu.tensor_desc<8x16xf32> -> vector<8x16xf32>
    return %4 : vector<8x16xf32>
  }
}

// -----
module {
  func.func @load_dynamic_source(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
    %c4 = arith.constant 4 : index
    %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
    %subview = memref.subview %arg0[%arg1, 0, 0] [1, %sizes#1, %sizes#2] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
    %base_buffer_0, %offset_1, %sizes_2:2, %strides_3:2 = memref.extract_strided_metadata %subview : memref<?x?xf32, strided<[?, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
    %intptr = memref.extract_aligned_pointer_as_index %base_buffer_0 : memref<f32> -> index
    %0 = arith.muli %offset_1, %c4 : index
    %1 = arith.addi %intptr, %0 : index
    %2 = arith.index_cast %1 : index to i64
    %3 = xegpu.create_nd_tdesc %2, shape : [%sizes_2#0, %sizes_2#1], strides : [%strides_3#0, 1] : i64 -> !xegpu.tensor_desc<8x16xf32>
    %4 = xegpu.load_nd %3[%arg2, %arg3]  : !xegpu.tensor_desc<8x16xf32> -> vector<8x16xf32>
    return %4 : vector<8x16xf32>
  }
}

// -----
module {
  func.func @load_out_of_bounds(%arg0: memref<7x15xf32>, %arg1: index) -> vector<8x16xf32> {
    %0 = xegpu.create_nd_tdesc %arg0 : memref<7x15xf32> -> !xegpu.tensor_desc<8x16xf32>
    %1 = xegpu.load_nd %0[%arg1, %arg1]  : !xegpu.tensor_desc<8x16xf32> -> vector<8x16xf32>
    return %1 : vector<8x16xf32>
  }
}

// -----
module {
  func.func @no_load_high_dim_vector(%arg0: memref<16x32x64xf32>, %arg1: index) -> vector<8x16x32xf32> {
    %0 = vector.load %arg0[%arg1, %arg1, %arg1] : memref<16x32x64xf32>, vector<8x16x32xf32>
    return %0 : vector<8x16x32xf32>
  }
}

// -----
module {
  func.func @no_load_zero_dim_vector(%arg0: memref<64xf32>, %arg1: index) -> vector<f32> {
    %0 = vector.load %arg0[%arg1] : memref<64xf32>, vector<f32>
    return %0 : vector<f32>
  }
}

