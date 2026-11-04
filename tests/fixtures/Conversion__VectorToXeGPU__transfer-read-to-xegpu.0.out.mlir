module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant dense<true> : vector<8xi1>
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = vector.step : vector<8xindex>
      %1 = arith.muli %arg1, %c512 : index
      %2 = arith.muli %arg1, %c32 : index
      %3 = arith.addi %1, %2 : index
      %4 = arith.addi %3, %arg1 : index
      %5 = vector.broadcast %4 : index to vector<8xindex>
      %6 = arith.addi %5, %0 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<8x16x32xf32> -> index
      %7 = arith.index_cast %intptr : index to i64
      %8 = xegpu.load %7[%6], %cst  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf32>
      gpu.return %8 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_2D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, 16, 32] [1, 1, 1] : memref<8x16x32xf32> to memref<16x32xf32, strided<[32, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<16x32xf32, strided<[32, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [16, 32], strides : [32, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg1, %arg1]  : !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %4 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_zero_pad_out_of_bounds(%arg0: memref<32x64xf32>, %arg1: index) -> vector<8x16xf32> {
      %0 = xegpu.create_nd_tdesc %arg0 : memref<32x64xf32> -> !xegpu.tensor_desc<8x16xf32>
      %1 = xegpu.load_nd %0[%arg1, %arg1]  : !xegpu.tensor_desc<8x16xf32> -> vector<8x16xf32>
      gpu.return %1 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_transposed(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16xf32> {
      %0 = xegpu.create_nd_tdesc %arg0 : memref<32x64xf32> -> !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %1 = xegpu.load_nd %0[%arg1, %arg2] <{transpose = array<i64: 1, 0>}> : !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %1 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_dynamic_source(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, %sizes#1, %sizes#2] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %base_buffer_0, %offset_1, %sizes_2:2, %strides_3:2 = memref.extract_strided_metadata %subview : memref<?x?xf32, strided<[?, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer_0 : memref<f32> -> index
      %0 = arith.muli %offset_1, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [%sizes_2#0, %sizes_2#1], strides : [%strides_3#0, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg3]  : !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %4 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_dynamic_source2(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, 8, 16] [1, 1, 1] : memref<?x8x16xf32> to memref<8x16xf32, strided<[16, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<8x16xf32, strided<[16, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [8, 16], strides : [16, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg3]  : !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %4 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_dynamic_source3(%arg0: memref<?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> vector<2x4x8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2, %arg3, %arg4, %arg5], %cst {in_bounds = [true, true, true, true]} : memref<?x?x?x?x?xf32>, vector<2x4x8x16xf32>
      gpu.return %0 : vector<2x4x8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_high_dim_vector(%arg0: memref<16x32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16x32xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2, %arg1], %cst {in_bounds = [true, true, true]} : memref<16x32x64xf32>, vector<8x16x32xf32>
      gpu.return %0 : vector<8x16x32xf32>
    }
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_transpose_f16(%arg0: memref<32x64xf16>, %arg1: index) -> vector<8x16xf16> {
      %cst = arith.constant 0.000000e+00 : f16
      %0 = vector.transfer_read %arg0[%arg1, %arg1], %cst {in_bounds = [true, true], permutation_map = #map} : memref<32x64xf16>, vector<8x16xf16>
      gpu.return %0 : vector<8x16xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_out_of_bounds_non_zero_pad(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index, %arg3: f32) -> (vector<8x16xf32>, vector<8x16xf32>) {
      %cst = arith.constant 1.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst {in_bounds = [true, false]} : memref<32x64xf32>, vector<8x16xf32>
      %1 = vector.transfer_read %arg0[%arg2, %arg1], %arg3 {in_bounds = [false, true]} : memref<32x64xf32>, vector<8x16xf32>
      gpu.return %0, %1 : vector<8x16xf32>, vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_out_of_bounds_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1, %arg1], %cst : memref<8x16x32xf32>, vector<8xf32>
      gpu.return %0 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_masked(%arg0: memref<4xf32>, %arg1: index) -> vector<4xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %cst_0 = arith.constant dense<[false, true, false, true]> : vector<4xi1>
      %0 = vector.transfer_read %arg0[%arg1], %cst, %cst_0 {in_bounds = [true]} : memref<4xf32>, vector<4xf32>
      gpu.return %0 : vector<4xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_tensor(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst {in_bounds = [true, true]} : tensor<32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_non_unit_inner_stride(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1], %cst {in_bounds = [true]} : memref<32xf32, strided<[?], offset: ?>>, vector<8xf32>
      gpu.return %0 : vector<8xf32>
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_unsupported_map(%arg0: memref<16x32x64xf32>, %arg1: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1, %arg1], %cst {in_bounds = [true, true], permutation_map = #map} : memref<16x32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_from_subview_1D(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index) -> vector<8xf16> {
      %cst = arith.constant dense<true> : vector<8xi1>
      %c4096 = arith.constant 4096 : index
      %subview = memref.subview %arg0[%arg1, %arg2] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %0 = vector.step : vector<8xindex>
      %1 = arith.muli %arg2, %c4096 : index
      %2 = arith.addi %offset, %1 : index
      %3 = arith.addi %2, %arg2 : index
      %4 = vector.broadcast %3 : index to vector<8xindex>
      %5 = arith.addi %4, %0 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %cst  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf16>
      gpu.return %7 : vector<8xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_from_subview_2D(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index) -> vector<8x16xf16> {
      %c2 = arith.constant 2 : index
      %subview = memref.subview %arg0[%arg1, %arg2] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f16> -> index
      %0 = arith.muli %offset, %c2 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [256, 256], strides : [4096, 1] : i64 -> !xegpu.tensor_desc<8x16xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg2]  : !xegpu.tensor_desc<8x16xf16, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf16>
      gpu.return %4 : vector<8x16xf16>
    }
  }
}

