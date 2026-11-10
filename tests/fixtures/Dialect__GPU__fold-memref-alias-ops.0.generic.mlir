#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index):
    %0 = "affine.apply"(%arg1, %arg2) <{map = #map}> : (index, index) -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0) <{leadDimension = 160 : index}> : (memref<?xvector<4xf32>>, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_store_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "affine.apply"(%arg1, %arg2) <{map = #map}> : (index, index) -> index
    "gpu.subgroup_mma_store_matrix"(%arg3, %arg0, %0) <{leadDimension = 160 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<?xvector<4xf32>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    %2 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %1) <{leadDimension = 32 : index}> : (memref<128x128xf32>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%2) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    "gpu.subgroup_mma_store_matrix"(%arg5, %arg0, %0, %1) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<128x128xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4096xf32>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_expand_shape"}> ({
  ^bb0(%arg0: memref<4096xf32>, %arg1: index, %arg2: index):
    %0 = "affine.linearize_index"(%arg1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 64, 64>}> : (index, index) -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0) <{leadDimension = 64 : index}> : (memref<4096xf32>, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4096xf32>, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_store_matrix_expand_shape"}> ({
  ^bb0(%arg0: memref<4096xf32>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "affine.linearize_index"(%arg1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 64, 64>}> : (index, index) -> index
    "gpu.subgroup_mma_store_matrix"(%arg3, %arg0, %0) <{leadDimension = 64 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<4096xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

