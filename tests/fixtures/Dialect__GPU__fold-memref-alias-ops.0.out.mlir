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
  func.func @fold_gpu_subgroup_mma_load_matrix_expand_shape(%arg0: memref<4096xf32>, %arg1: index, %arg2: index) -> !gpu.mma_matrix<16x16xf16, "COp"> {
    %0 = affine.linearize_index disjoint [%arg1, %arg2] by (64, 64) : index
    %1 = gpu.subgroup_mma_load_matrix %arg0[%0] {leadDimension = 64 : index} : memref<4096xf32> -> !gpu.mma_matrix<16x16xf16, "COp">
    return %1 : !gpu.mma_matrix<16x16xf16, "COp">
  }
}

// -----
module {
  func.func @fold_gpu_subgroup_mma_store_matrix_expand_shape(%arg0: memref<4096xf32>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">) {
    %0 = affine.linearize_index disjoint [%arg1, %arg2] by (64, 64) : index
    gpu.subgroup_mma_store_matrix %arg3, %arg0[%0] {leadDimension = 64 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<4096xf32>
    return
  }
}

