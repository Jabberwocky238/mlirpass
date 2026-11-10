"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 81920>, static_strides = array<i64: 1>}> : (memref<?xvector<4xf32>>, index) -> memref<81920xvector<4xf32>, strided<[1], offset: ?>>
    %1 = "gpu.subgroup_mma_load_matrix"(%0, %arg2) <{leadDimension = 160 : index}> : (memref<81920xvector<4xf32>, strided<[1], offset: ?>>, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_store_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 81920>, static_strides = array<i64: 1>}> : (memref<?xvector<4xf32>>, index) -> memref<81920xvector<4xf32>, strided<[1], offset: ?>>
    "gpu.subgroup_mma_store_matrix"(%arg3, %0, %arg2) <{leadDimension = 160 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<81920xvector<4xf32>, strided<[1], offset: ?>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 2, 1>}> : (memref<128x128xf32>, index, index) -> memref<64x32xf32, strided<[256, 1], offset: ?>>
    %1 = "gpu.subgroup_mma_load_matrix"(%0, %arg3, %arg4) <{leadDimension = 32 : index}> : (memref<64x32xf32, strided<[256, 1], offset: ?>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 2, 1>}> : (memref<128x128xf32>, index, index) -> memref<64x32xf32, strided<[256, 1], offset: ?>>
    "gpu.subgroup_mma_store_matrix"(%arg5, %0, %arg3, %arg4) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<64x32xf32, strided<[256, 1], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4096xf32>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_expand_shape"}> ({
  ^bb0(%arg0: memref<4096xf32>, %arg1: index, %arg2: index):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 64>}> : (memref<4096xf32>) -> memref<64x64xf32>
    %1 = "gpu.subgroup_mma_load_matrix"(%0, %arg1, %arg2) <{leadDimension = 64 : index}> : (memref<64x64xf32>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4096xf32>, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_store_matrix_expand_shape"}> ({
  ^bb0(%arg0: memref<4096xf32>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 64, 64>}> : (memref<4096xf32>) -> memref<64x64xf32>
    "gpu.subgroup_mma_store_matrix"(%arg3, %0, %arg1, %arg2) <{leadDimension = 64 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<64x64xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

