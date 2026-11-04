#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
module {
  func.func @fold_static_stride_subview_with_load(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> f32 {
    %0 = affine.apply #map()[%arg1, %arg3]
    %1 = affine.apply #map1()[%arg2, %arg4]
    %2 = memref.load %arg0[%0, %1] : memref<12x32xf32>
    return %2 : f32
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * s2)>
module {
  func.func @fold_dynamic_stride_subview_with_load(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index) -> f32 {
    %0 = affine.apply #map()[%arg1, %arg3, %arg5]
    %1 = affine.apply #map()[%arg2, %arg4, %arg6]
    %2 = memref.load %arg0[%0, %1] : memref<12x32xf32>
    return %2 : f32
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
module {
  func.func @fold_static_stride_subview_with_store(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32) {
    %0 = affine.apply #map()[%arg1, %arg3]
    %1 = affine.apply #map1()[%arg2, %arg4]
    memref.store %arg5, %arg0[%0, %1] : memref<12x32xf32>
    return
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * s2)>
module {
  func.func @fold_dynamic_stride_subview_with_store(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: f32) {
    %0 = affine.apply #map()[%arg1, %arg3, %arg5]
    %1 = affine.apply #map()[%arg2, %arg4, %arg6]
    memref.store %arg7, %arg0[%0, %1] : memref<12x32xf32>
    return
  }
}

// -----
module {
  func.func @fold_subview_with_transfer_read_0d(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<f32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst : memref<12x32xf32>, vector<f32>
    return %0 : vector<f32>
  }
}

// -----
module {
  func.func @fold_subview_with_transfer_read(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index) -> vector<4xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %subview = memref.subview %arg0[%arg1, %arg2] [4, 4] [%arg5, %arg6] : memref<12x32xf32> to memref<4x4xf32, strided<[?, ?], offset: ?>>
    %0 = vector.transfer_read %subview[%arg3, %arg4], %cst {in_bounds = [true]} : memref<4x4xf32, strided<[?, ?], offset: ?>>, vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  func.func @fold_static_stride_subview_with_transfer_write_0d(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<f32>) {
    vector.transfer_write %arg4, %arg0[%arg1, %arg2] : vector<f32>, memref<12x32xf32>
    return
  }
}

// -----
module {
  func.func @fold_static_stride_subview_with_transfer_write(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4xf32>) {
    %subview = memref.subview %arg0[%arg1, %arg2] [4, 4] [%arg5, %arg6] : memref<12x32xf32> to memref<4x4xf32, strided<[?, ?], offset: ?>>
    vector.transfer_write %arg7, %subview[%arg3, %arg4] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[?, ?], offset: ?>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * s2)>
module {
  func.func @fold_rank_reducing_subview_with_load(%arg0: memref<?x?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index) -> f32 {
    %0 = affine.apply #map()[%arg1, %arg13, %arg7]
    %1 = affine.apply #map()[%arg3, %arg14, %arg9]
    %2 = affine.apply #map()[%arg4, %arg15, %arg10]
    %3 = affine.apply #map()[%arg5, %arg16, %arg11]
    %4 = memref.load %arg0[%0, %arg2, %1, %2, %3, %arg6] : memref<?x?x?x?x?x?xf32>
    return %4 : f32
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_vector_transfer_read_with_rank_reduced_subview(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index) -> vector<4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %0 = affine.apply #map()[%arg1, %arg5]
    %1 = affine.apply #map()[%arg2, %arg6]
    %2 = vector.transfer_read %arg0[%c0, %0, %1], %cst {in_bounds = [true]} : memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, vector<4xf32>
    return %2 : vector<4xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_vector_transfer_write_with_rank_reduced_subview(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index) {
    %c0 = arith.constant 0 : index
    %0 = affine.apply #map()[%arg2, %arg6]
    %1 = affine.apply #map()[%arg3, %arg7]
    vector.transfer_write %arg1, %arg0[%c0, %0, %1] {in_bounds = [true]} : vector<4xf32>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2) -> (d1)>
module {
  func.func @fold_vector_transfer_write_with_inner_rank_reduced_subview(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index) {
    %c0 = arith.constant 0 : index
    %0 = affine.apply #map()[%arg2, %arg6]
    %1 = affine.apply #map()[%arg3, %arg7]
    vector.transfer_write %arg1, %arg0[%0, %1, %c0] {in_bounds = [true], permutation_map = #map1} : vector<4xf32>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_masked_vector_transfer_read_with_subview(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4xi1>) -> vector<4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = affine.apply #map()[%arg1, %arg5]
    %1 = affine.apply #map()[%arg2, %arg6]
    %2 = vector.transfer_read %arg0[%0, %1], %cst, %arg7 {in_bounds = [true]} : memref<?x?xf32, strided<[?, ?], offset: ?>>, vector<4xf32>
    return %2 : vector<4xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d1)>
module {
  func.func @fold_masked_vector_transfer_read_with_rank_reducing_subview(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4x3xi1>) -> vector<3x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %0 = affine.apply #map()[%arg1, %arg5]
    %1 = affine.apply #map()[%arg2, %arg6]
    %2 = vector.transfer_read %arg0[%c0, %0, %c0, %1], %cst, %arg7 {in_bounds = [true, true], permutation_map = #map1} : memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, vector<3x4xf32>
    return %2 : vector<3x4xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_masked_vector_transfer_write_with_subview(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: vector<4xi1>) {
    %0 = affine.apply #map()[%arg2, %arg6]
    %1 = affine.apply #map()[%arg3, %arg7]
    vector.transfer_write %arg1, %arg0[%0, %1], %arg8 {in_bounds = [true]} : vector<4xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d1)>
module {
  func.func @fold_masked_vector_transfer_write_with_rank_reducing_subview(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: vector<3x4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: vector<4x3xi1>) {
    %c0 = arith.constant 0 : index
    %0 = affine.apply #map()[%arg2, %arg6]
    %1 = affine.apply #map()[%arg3, %arg7]
    vector.transfer_write %arg1, %arg0[%c0, %0, %c0, %1], %arg8 {in_bounds = [true, true], permutation_map = #map1} : vector<3x4xf32>, memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>
    return
  }
}

// -----
module {
  func.func @fold_dynamic_subview_with_memref_load_expand_shape(%arg0: memref<16x?xf32, strided<[16, 1]>>, %arg1: index, %arg2: index, %arg3: index) -> f32 {
    %c0 = arith.constant 0 : index
    %0 = affine.linearize_index disjoint [%c0, %arg1] by (1, 16) : index
    %1 = affine.linearize_index disjoint [%arg2, %c0] by (%arg3, 1) : index
    %2 = memref.load %arg0[%0, %1] {nontemporal = true} : memref<16x?xf32, strided<[16, 1]>>
    return %2 : f32
  }
}

// -----
module {
  func.func @fold_dynamic_subview_with_memref_store_expand_shape(%arg0: memref<16x?xf32, strided<[16, 1]>>, %arg1: index, %arg2: index, %arg3: index) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f32
    %0 = affine.linearize_index disjoint [%c0, %arg1] by (1, 16) : index
    %1 = affine.linearize_index disjoint [%arg2, %c0] by (%arg3, 1) : index
    memref.store %cst, %arg0[%0, %1] {nontemporal = true} : memref<16x?xf32, strided<[16, 1]>>
    return
  }
}

// -----
module {
  func.func @fold_static_stride_subview_with_memref_expand_shape_with_constant_access_index(%arg0: memref<1024x1024xf32>, %arg1: memref<1xf32>, %arg2: index) -> f32 {
    %c0 = arith.constant 0 : index
    affine.for %arg3 = 0 to 1 {
      affine.for %arg4 = 0 to 1024 {
        affine.for %arg5 = 0 to 1020 {
          affine.for %arg6 = 0 to 1 {
            %1 = affine.linearize_index disjoint [%arg3, %c0] by (1, 1024) : index
            %2 = affine.linearize_index disjoint [%arg5, %arg6] by (1024, 1) : index
            %3 = memref.load %arg0[%1, %2] : memref<1024x1024xf32>
            memref.store %3, %arg1[%arg2] : memref<1xf32>
          }
        }
      }
    }
    %0 = memref.load %arg1[%arg2] : memref<1xf32>
    return %0 : f32
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 2)>
module {
  func.func @subview_of_subview(%arg0: memref<8x1024xf32, 3>, %arg1: index) -> memref<f32, strided<[], offset: ?>, 3> {
    %0 = affine.apply #map()[%arg1]
    %subview = memref.subview %arg0[4, %0] [1, 1] [1, 1] : memref<8x1024xf32, 3> to memref<f32, strided<[], offset: ?>, 3>
    return %subview : memref<f32, strided<[], offset: ?>, 3>
  }
}

// -----
module {
  func.func @subview_of_subview_rank_reducing(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index) -> memref<f32, strided<[], offset: ?>> {
    %subview = memref.subview %arg0[3, 7, 8] [1, 1, 1] [1, 1, 1] : memref<?x?x?xf32> to memref<f32, strided<[], offset: ?>>
    return %subview : memref<f32, strided<[], offset: ?>>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
module {
  func.func @fold_load_keep_nontemporal(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> f32 {
    %0 = affine.apply #map()[%arg1, %arg3]
    %1 = affine.apply #map1()[%arg2, %arg4]
    %2 = memref.load %arg0[%0, %1] {nontemporal = true} : memref<12x32xf32>
    return %2 : f32
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
module {
  func.func @fold_store_keep_nontemporal(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32) {
    %0 = affine.apply #map()[%arg1, %arg3]
    %1 = affine.apply #map1()[%arg2, %arg4]
    memref.store %arg5, %arg0[%0, %1] {nontemporal = true} : memref<12x32xf32>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_gpu_subgroup_mma_load_matrix_1d(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index) -> !gpu.mma_matrix<16x16xf16, "COp"> {
    %0 = affine.apply #map()[%arg1, %arg2]
    %1 = gpu.subgroup_mma_load_matrix %arg0[%0] {leadDimension = 160 : index} : memref<?xvector<4xf32>> -> !gpu.mma_matrix<16x16xf16, "COp">
    return %1 : !gpu.mma_matrix<16x16xf16, "COp">
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_gpu_subgroup_mma_store_matrix_1d(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">) {
    %0 = affine.apply #map()[%arg1, %arg2]
    gpu.subgroup_mma_store_matrix %arg3, %arg0[%0] {leadDimension = 160 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<?xvector<4xf32>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_gpu_subgroup_mma_load_matrix_2d(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> !gpu.mma_matrix<16x16xf16, "COp"> {
    %0 = affine.apply #map()[%arg1, %arg3]
    %1 = affine.apply #map1()[%arg2, %arg4]
    %2 = gpu.subgroup_mma_load_matrix %arg0[%0, %1] {leadDimension = 32 : index} : memref<128x128xf32> -> !gpu.mma_matrix<16x16xf16, "COp">
    return %2 : !gpu.mma_matrix<16x16xf16, "COp">
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_gpu_subgroup_mma_load_matrix_2d(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: !gpu.mma_matrix<16x16xf16, "COp">) {
    %0 = affine.apply #map()[%arg1, %arg3]
    %1 = affine.apply #map1()[%arg2, %arg4]
    gpu.subgroup_mma_store_matrix %arg5, %arg0[%0, %1] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<128x128xf32>
    return
  }
}

// -----
module {
  func.func @fold_nvgpu_device_async_copy_zero_sub_idx(%arg0: memref<2x128x768xf16>, %arg1: index, %arg2: index, %arg3: index) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    %0 = nvgpu.device_async_copy %arg0[%arg1, %arg2, %arg3], %alloc[%c0, %c0, %c0, %c0], 8 {bypassL1} : memref<2x128x768xf16> to memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_src_nvgpu_device_async_copy(%arg0: memref<2x128x768xf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    %0 = affine.apply #map()[%arg1, %arg4]
    %1 = affine.apply #map()[%arg3, %arg5]
    %2 = nvgpu.device_async_copy %arg0[%0, %arg2, %1], %alloc[%c0, %c0, %c0, %c0], 8 {bypassL1} : memref<2x128x768xf16> to memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_src_fold_dest_nvgpu_device_async_copy(%arg0: memref<2x128x768xf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index) {
    %alloc = memref.alloc() : memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    %0 = affine.apply #map()[%arg1, %arg4]
    %1 = affine.apply #map()[%arg3, %arg5]
    %2 = affine.apply #map()[%arg7, %arg10]
    %3 = affine.apply #map()[%arg9, %arg11]
    %4 = nvgpu.device_async_copy %arg0[%0, %arg2, %1], %alloc[%arg6, %2, %arg8, %3], 8 {bypassL1} : memref<2x128x768xf16> to memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    return
  }
}

// -----
module {
  func.func @test_ldmatrix(%arg0: memref<4x32x32xf16, 3>, %arg1: index, %arg2: index, %arg3: index) -> vector<4x2xf16> {
    %0 = nvgpu.ldmatrix %arg0[%arg1, %arg2, %arg3] {numTiles = 4 : i32, transpose = false} : memref<4x32x32xf16, 3> -> vector<4x2xf16>
    return %0 : vector<4x2xf16>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_vector_load_subview(%arg0: memref<24x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> vector<12x32xf32> {
    %0 = affine.apply #map()[%arg1, %arg5]
    %1 = affine.apply #map()[%arg2, %arg5]
    %2 = vector.load %arg0[%0, %1] : memref<24x64xf32>, vector<12x32xf32>
    return %2 : vector<12x32xf32>
  }
}

// -----
module {
  func.func @fold_vector_maskedload_subview(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: vector<32xi1>, %arg4: vector<32xf32>) -> vector<32xf32> {
    %0 = vector.maskedload %arg0[%arg1, %arg2], %arg3, %arg4 : memref<12x32xf32>, vector<32xi1>, vector<32xf32> into vector<32xf32>
    return %0 : vector<32xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @fold_vector_store_subview(%arg0: memref<24x64xf32>, %arg1: index, %arg2: index, %arg3: vector<2x32xf32>, %arg4: index, %arg5: index, %arg6: index) {
    %0 = affine.apply #map()[%arg1, %arg4]
    %1 = affine.apply #map()[%arg2, %arg4]
    vector.store %arg3, %arg0[%0, %1] : memref<24x64xf32>, vector<2x32xf32>
    return
  }
}

// -----
module {
  func.func @fold_vector_maskedstore_subview(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: vector<32xi1>, %arg4: vector<32xf32>) {
    vector.maskedstore %arg0[%arg1, %arg2], %arg3, %arg4 : memref<12x32xf32>, vector<32xi1>, vector<32xf32>
    return
  }
}

// -----
module {
  func.func @fold_vector_load_expand_shape(%arg0: memref<32xf32>, %arg1: index) -> vector<8xf32> {
    %c0 = arith.constant 0 : index
    %0 = affine.linearize_index [%arg1, %c0] by (4, 8) : index
    %1 = vector.load %arg0[%0] {nontemporal = true} : memref<32xf32>, vector<8xf32>
    return %1 : vector<8xf32>
  }
}

// -----
module {
  func.func @fold_vector_maskedload_expand_shape(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>) -> vector<8xf32> {
    %c0 = arith.constant 0 : index
    %0 = affine.linearize_index [%arg1, %c0] by (4, 8) : index
    %1 = vector.maskedload %arg0[%0], %arg2, %arg3 : memref<32xf32>, vector<8xi1>, vector<8xf32> into vector<8xf32>
    return %1 : vector<8xf32>
  }
}

// -----
module {
  func.func @fold_vector_store_expand_shape(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xf32>) {
    %c0 = arith.constant 0 : index
    %0 = affine.linearize_index [%arg1, %c0] by (4, 8) : index
    vector.store %arg2, %arg0[%0] {nontemporal = true} : memref<32xf32>, vector<8xf32>
    return
  }
}

// -----
module {
  func.func @fold_vector_maskedstore_expand_shape(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>) {
    %c0 = arith.constant 0 : index
    %0 = affine.linearize_index [%arg1, %c0] by (4, 8) : index
    vector.maskedstore %arg0[%0], %arg2, %arg3 : memref<32xf32>, vector<8xi1>, vector<8xf32>
    return
  }
}

// -----
module {
  func.func @fold_vector_transfer_read_expand_shape(%arg0: memref<32xf32>, %arg1: index) -> vector<8xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : f32
    %1 = affine.linearize_index [%arg1, %c0] by (4, 8) : index
    %2 = vector.transfer_read %arg0[%1], %0 {in_bounds = [true]} : memref<32xf32>, vector<8xf32>
    return %2 : vector<8xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
module {
  func.func @fold_vector_transfer_read_with_perm_map(%arg0: memref<32xf32>, %arg1: index) -> vector<4x4xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : f32
    %expand_shape = memref.expand_shape %arg0 [[0, 1]] output_shape [4, 8] : memref<32xf32> into memref<4x8xf32>
    %1 = vector.transfer_read %expand_shape[%arg1, %c0], %0 {in_bounds = [true, true], permutation_map = #map} : memref<4x8xf32>, vector<4x4xf32>
    return %1 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @fold_vector_transfer_read_rank_mismatch(%arg0: memref<32xf32>, %arg1: index) -> vector<4x4xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : f32
    %expand_shape = memref.expand_shape %arg0 [[0, 1, 2]] output_shape [2, 4, 4] : memref<32xf32> into memref<2x4x4xf32>
    %1 = vector.transfer_read %expand_shape[%arg1, %c0, %c0], %0 {in_bounds = [true, true]} : memref<2x4x4xf32>, vector<4x4xf32>
    return %1 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @fold_vector_load_collapse_shape(%arg0: memref<4x8xf32>, %arg1: index) -> vector<8xf32> {
    %0:2 = affine.delinearize_index %arg1 into (4, 8) : index, index
    %1 = vector.load %arg0[%0#0, %0#1] {nontemporal = true} : memref<4x8xf32>, vector<8xf32>
    return %1 : vector<8xf32>
  }
}

// -----
module {
  func.func @fold_vector_maskedload_collapse_shape(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>) -> vector<8xf32> {
    %0:2 = affine.delinearize_index %arg1 into (4, 8) : index, index
    %1 = vector.maskedload %arg0[%0#0, %0#1], %arg2, %arg3 : memref<4x8xf32>, vector<8xi1>, vector<8xf32> into vector<8xf32>
    return %1 : vector<8xf32>
  }
}

// -----
module {
  func.func @fold_vector_store_collapse_shape(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xf32>) {
    %0:2 = affine.delinearize_index %arg1 into (4, 8) : index, index
    vector.store %arg2, %arg0[%0#0, %0#1] {nontemporal = true} : memref<4x8xf32>, vector<8xf32>
    return
  }
}

// -----
module {
  func.func @fold_vector_maskedstore_collapse_shape(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>) {
    %0:2 = affine.delinearize_index %arg1 into (4, 8) : index, index
    vector.maskedstore %arg0[%0#0, %0#1], %arg2, %arg3 : memref<4x8xf32>, vector<8xi1>, vector<8xf32>
    return
  }
}

