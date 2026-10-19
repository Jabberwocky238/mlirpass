"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x3xi1>, sym_name = "create_vector_mask_to_constant_mask"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0) : (index, index) -> vector<4x3xi1>
    "func.return"(%2) : (vector<4x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[8]xi1>, sym_name = "create_scalable_vector_mask_to_constant_mask"}> ({
    %0 = "arith.constant"() <{value = -1 : index}> : () -> index
    %1 = "vector.create_mask"(%0) : (index) -> vector<[8]xi1>
    "func.return"(%1) : (vector<[8]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x3xi1>, sym_name = "create_vector_mask_to_constant_mask_truncation"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0) : (index, index) -> vector<4x3xi1>
    "func.return"(%2) : (vector<4x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x3xi1>, sym_name = "create_vector_mask_to_constant_mask_truncation_neg"}> ({
    %0 = "arith.constant"() <{value = -2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0) : (index, index) -> vector<4x3xi1>
    "func.return"(%2) : (vector<4x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x3xi1>, sym_name = "create_vector_mask_to_constant_mask_truncation_zero"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0) : (index, index) -> vector<4x3xi1>
    "func.return"(%2) : (vector<4x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<8x[16]xi1>, sym_name = "create_vector_mask_to_constant_mask_scalable_all_true"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "vector.vscale"() : () -> index
    %3 = "arith.muli"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %4 = "vector.create_mask"(%0, %3) : (index, index) -> vector<8x[16]xi1>
    "func.return"(%4) : (vector<8x[16]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (vector<2x3x4xi1>, vector<4x2x3xi1>), sym_name = "create_mask_transpose_to_transposed_create_mask"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "vector.create_mask"(%arg0, %arg1, %arg2) : (index, index, index) -> vector<2x3x4xi1>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 2, 0, 1>}> : (vector<2x3x4xi1>) -> vector<4x2x3xi1>
    "func.return"(%0, %1) : (vector<2x3x4xi1>, vector<4x2x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<[4]x[4]xi1>, sym_name = "extract_from_create_mask"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "vector.create_mask"(%0, %arg0, %arg1) : (index, index, index) -> vector<4x[4]x[4]xi1>
    %2 = "vector.extract"(%1) <{static_position = array<i64: 1>}> : (vector<4x[4]x[4]xi1>) -> vector<[4]x[4]xi1>
    "func.return"(%2) : (vector<[4]x[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<[4]x[4]xi1>, sym_name = "extract_from_create_mask_all_false"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "vector.create_mask"(%0, %arg0, %arg1) : (index, index, index) -> vector<4x[4]x[4]xi1>
    %2 = "vector.extract"(%1) <{static_position = array<i64: 2>}> : (vector<4x[4]x[4]xi1>) -> vector<[4]x[4]xi1>
    "func.return"(%2) : (vector<[4]x[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<8xi1>, sym_name = "extract_from_create_mask_leading_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "vector.create_mask"(%0, %arg0) : (index, index) -> vector<[4]x8xi1>
    %2 = "vector.extract"(%1) <{static_position = array<i64: 1>}> : (vector<[4]x8xi1>) -> vector<8xi1>
    "func.return"(%2) : (vector<8xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<6xi1>, sym_name = "extract_from_create_mask_dynamic_position"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0, %arg0) : (index, index, index) -> vector<4x4x6xi1>
    %3 = "vector.extract"(%2, %arg1) <{static_position = array<i64: 2, -9223372036854775808>}> : (vector<4x4x6xi1>, index) -> vector<6xi1>
    "func.return"(%3) : (vector<6xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "extract_scalar_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x8xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 2, 4>}> : (vector<4x8xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<8xf32>, sym_name = "extract_vector_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<4x8xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 2>}> : (vector<4x8xf32>) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>) -> f32, sym_name = "extract_scalar_poison_idx"}> ({
  ^bb0(%arg0: vector<4x5xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: -1, 0>}> : (vector<4x5xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>) -> f32, sym_name = "extract_scalar_poison_idx_non_cst"}> ({
  ^bb0(%arg0: vector<4x5xf32>):
    %0 = "arith.constant"() <{value = -1 : index}> : () -> index
    %1 = "vector.extract"(%arg0, %0) <{static_position = array<i64: -9223372036854775808, 0>}> : (vector<4x5xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>) -> f32, sym_name = "no_fold_extract_scalar_oob_idx"}> ({
  ^bb0(%arg0: vector<4x5xf32>):
    %0 = "arith.constant"() <{value = -2 : index}> : () -> index
    %1 = "vector.extract"(%arg0, %0) <{static_position = array<i64: -9223372036854775808, 0>}> : (vector<4x5xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>) -> vector<5xf32>, sym_name = "extract_vector_poison_idx"}> ({
  ^bb0(%arg0: vector<4x5xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: -1>}> : (vector<4x5xf32>) -> vector<5xf32>
    "func.return"(%0) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5x8xf32>) -> vector<8xf32>, sym_name = "extract_multiple_poison_idx"}> ({
  ^bb0(%arg0: vector<4x5x8xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: -1, -1>}> : (vector<4x5x8xf32>) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<6xi1>, sym_name = "extract_from_create_mask_dynamic_position_all_false"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0, %arg0) : (index, index, index) -> vector<1x4x6xi1>
    %3 = "vector.extract"(%2, %arg1) <{static_position = array<i64: 0, -9223372036854775808>}> : (vector<1x4x6xi1>, index) -> vector<6xi1>
    "func.return"(%3) : (vector<6xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<6xi1>, sym_name = "extract_from_create_mask_dynamic_position_unknown"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "vector.create_mask"(%0, %arg0) : (index, index) -> vector<4x6xi1>
    %2 = "vector.extract"(%1, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<4x6xi1>, index) -> vector<6xi1>
    "func.return"(%2) : (vector<6xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<4xi1>, sym_name = "extract_from_create_mask_mixed_position_unknown"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "vector.create_mask"(%0, %0, %arg0) : (index, index, index) -> vector<2x4x4xi1>
    %2 = "vector.extract"(%1, %arg1) <{static_position = array<i64: 1, -9223372036854775808>}> : (vector<2x4x4xi1>, index) -> vector<4xi1>
    "func.return"(%2) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<[2]xi1>, sym_name = "extract_from_non_constant_create_mask"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.create_mask"(%arg0, %arg0) : (index, index) -> vector<[2]x[2]xi1>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<[2]x[2]xi1>) -> vector<[2]xi1>
    "func.return"(%1) : (vector<[2]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x4xi1>, sym_name = "constant_mask_to_true_splat"}> ({
    %4 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 4>}> : () -> vector<2x4xi1>
    "func.return"(%4) : (vector<2x4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2x4xi1>, sym_name = "constant_mask_to_false_splat"}> ({
    %3 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 0, 0>}> : () -> vector<2x4xi1>
    "func.return"(%3) : (vector<2x4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<i1>, sym_name = "constant_mask_to_true_splat_0d"}> ({
    %2 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 1>}> : () -> vector<i1>
    "func.return"(%2) : (vector<i1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<2x3x4xi1>, vector<4x2x3xi1>), sym_name = "constant_mask_transpose_to_transposed_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 1, 2, 3>}> : () -> vector<2x3x4xi1>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 2, 0, 1>}> : (vector<2x3x4xi1>) -> vector<4x2x3xi1>
    "func.return"(%0, %1) : (vector<2x3x4xi1>, vector<4x2x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x2xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x2xi1>
    "func.return"(%1) : (vector<2x2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x2xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [1, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x2xi1>
    "func.return"(%1) : (vector<2x2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x2xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 1], sizes = [2, 2], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x2xi1>
    "func.return"(%1) : (vector<2x2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x2xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x2xi1>
    "func.return"(%1) : (vector<2x2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x1xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 2], sizes = [2, 1], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x1xi1>
    "func.return"(%1) : (vector<2x1xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x1xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 1], sizes = [2, 1], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x1xi1>
    "func.return"(%1) : (vector<2x1xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x1xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 2, 2>}> : () -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [1, 1], sizes = [2, 1], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x1xi1>
    "func.return"(%1) : (vector<2x1xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> vector<2x2xi1>, sym_name = "extract_strided_slice_of_create_mask"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "vector.create_mask"(%arg0, %arg1) : (index, index) -> vector<4x3xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2, 1], sizes = [2, 2], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<2x2xi1>
    "func.return"(%1) : (vector<2x2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> vector<2x2x8xi1>, sym_name = "extract_strided_slice_partial_of_create_mask"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "vector.create_mask"(%arg0, %arg1, %arg2) : (index, index, index) -> vector<4x3x8xi1>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2, 1], sizes = [2, 2], strides = [1, 1]}> : (vector<4x3x8xi1>) -> vector<2x2x8xi1>
    "func.return"(%1) : (vector<2x2x8xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xi1>) -> vector<4x3xi1>, sym_name = "extract_strided_fold"}> ({
  ^bb0(%arg0: vector<4x3xi1>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [4, 3], strides = [1, 1]}> : (vector<4x3xi1>) -> vector<4x3xi1>
    "func.return"(%0) : (vector<4x3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xf32>, vector<8x16xf32>) -> vector<4x4xf32>, sym_name = "extract_strided_fold_insert"}> ({
  ^bb0(%arg0: vector<4x4xf32>, %arg1: vector<8x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 2], strides = [1, 1]}> : (vector<4x4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2, 2], sizes = [4, 4], strides = [1, 1]}> : (vector<8x16xf32>) -> vector<4x4xf32>
    "func.return"(%1) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<6x4xf32>, vector<8x16xf32>) -> vector<4x4xf32>, sym_name = "extract_strided_fold_insert"}> ({
  ^bb0(%arg0: vector<6x4xf32>, %arg1: vector<8x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 2], strides = [1, 1]}> : (vector<6x4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2, 2], sizes = [4, 4], strides = [1, 1]}> : (vector<8x16xf32>) -> vector<4x4xf32>
    "func.return"(%1) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xf32>, vector<8x16xf32>) -> vector<6x4xf32>, sym_name = "negative_extract_strided_fold"}> ({
  ^bb0(%arg0: vector<4x4xf32>, %arg1: vector<8x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 2], strides = [1, 1]}> : (vector<4x4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2, 2], sizes = [6, 4], strides = [1, 1]}> : (vector<8x16xf32>) -> vector<6x4xf32>
    "func.return"(%1) : (vector<6x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x8xf32>, vector<1x4xf32>, vector<1x4xf32>) -> vector<1x1xf32>, sym_name = "extract_strided_fold_insert"}> ({
  ^bb0(%arg0: vector<2x8xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>):
    %0 = "vector.insert_strided_slice"(%arg1, %arg0) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x4xf32>, vector<2x8xf32>) -> vector<2x8xf32>
    %1 = "vector.insert_strided_slice"(%arg2, %0) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x4xf32>, vector<2x8xf32>) -> vector<2x8xf32>
    %2 = "vector.extract_strided_slice"(%1) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x8xf32>) -> vector<1x1xf32>
    "func.return"(%2) : (vector<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x2xf32>) -> vector<4x3x2xf32>, sym_name = "transpose_3D_identity"}> ({
  ^bb0(%arg0: vector<4x3x2xf32>):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 0, 1, 2>}> : (vector<4x3x2xf32>) -> vector<4x3x2xf32>
    "func.return"(%0) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> vector<4x3xf32>, sym_name = "transpose_2D_sequence"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x3xf32>) -> vector<3x4xf32>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 0, 1>}> : (vector<3x4xf32>) -> vector<3x4xf32>
    %2 = "vector.transpose"(%1) <{permutation = array<i64: 1, 0>}> : (vector<3x4xf32>) -> vector<4x3xf32>
    %3 = "vector.transpose"(%2) <{permutation = array<i64: 0, 1>}> : (vector<4x3xf32>) -> vector<4x3xf32>
    %4 = "arith.addf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (vector<4x3xf32>, vector<4x3xf32>) -> vector<4x3xf32>
    "func.return"(%4) : (vector<4x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x2xf32>) -> vector<4x3x2xf32>, sym_name = "transpose_3D_sequence"}> ({
  ^bb0(%arg0: vector<4x3x2xf32>):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 2, 0>}> : (vector<4x3x2xf32>) -> vector<3x2x4xf32>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 1, 0, 2>}> : (vector<3x2x4xf32>) -> vector<2x3x4xf32>
    %2 = "vector.transpose"(%1) <{permutation = array<i64: 2, 1, 0>}> : (vector<2x3x4xf32>) -> vector<4x3x2xf32>
    %3 = "vector.transpose"(%2) <{permutation = array<i64: 2, 1, 0>}> : (vector<4x3x2xf32>) -> vector<2x3x4xf32>
    %4 = "arith.mulf"(%1, %3) <{fastmath = #arith.fastmath<none>}> : (vector<2x3x4xf32>, vector<2x3x4xf32>) -> vector<2x3x4xf32>
    %5 = "vector.transpose"(%4) <{permutation = array<i64: 2, 1, 0>}> : (vector<2x3x4xf32>) -> vector<4x3x2xf32>
    %6 = "vector.transpose"(%3) <{permutation = array<i64: 2, 1, 0>}> : (vector<2x3x4xf32>) -> vector<4x3x2xf32>
    %7 = "arith.addf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (vector<4x3x2xf32>, vector<4x3x2xf32>) -> vector<4x3x2xf32>
    "func.return"(%7) : (vector<4x3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>) -> vector<4x8xf32>, sym_name = "cast_transfers"}> ({
  ^bb0(%arg0: memref<4x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "memref.cast"(%arg0) : (memref<4x8xf32>) -> memref<?x?xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32) -> vector<4x8xf32>
    "vector.transfer_write"(%3, %2, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x8xf32>, memref<?x?xf32>, index, index) -> ()
    "func.return"(%3) : (vector<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8xf32>) -> vector<4x8xf32>, sym_name = "cast_transfers"}> ({
  ^bb0(%arg0: tensor<4x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.cast"(%arg0) : (tensor<4x8xf32>) -> tensor<?x?xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4x8xf32>
    "func.return"(%3) : (vector<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xf32>, f32, f32, f32, f32) -> (f32, f32, f32), sym_name = "insert_extract_transpose_2d"}> ({
  ^bb0(%arg0: vector<2x3xf32>, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0, 0>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 0, 1>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %2 = "vector.insert"(%arg3, %1) <{static_position = array<i64: 1, 0>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %3 = "vector.insert"(%arg4, %2) <{static_position = array<i64: 1, 1>}> : (f32, vector<2x3xf32>) -> vector<2x3xf32>
    %4 = "vector.transpose"(%3) <{permutation = array<i64: 1, 0>}> : (vector<2x3xf32>) -> vector<3x2xf32>
    %5 = "vector.insert"(%arg4, %4) <{static_position = array<i64: 1, 0>}> : (f32, vector<3x2xf32>) -> vector<3x2xf32>
    %6 = "vector.transpose"(%5) <{permutation = array<i64: 1, 0>}> : (vector<3x2xf32>) -> vector<2x3xf32>
    %7 = "vector.extract"(%3) <{static_position = array<i64: 1, 0>}> : (vector<2x3xf32>) -> f32
    %8 = "vector.extract"(%4) <{static_position = array<i64: 1, 0>}> : (vector<3x2xf32>) -> f32
    %9 = "vector.extract"(%6) <{static_position = array<i64: 1, 0>}> : (vector<2x3xf32>) -> f32
    "func.return"(%7, %8, %9) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x3x4xf32>, vector<3x4xf32>, vector<4xf32>) -> (vector<4xf32>, vector<4xf32>, vector<3x4xf32>, vector<3x4xf32>), sym_name = "insert_extract_chain"}> ({
  ^bb0(%arg0: vector<3x3x4xf32>, %arg1: vector<3x4xf32>, %arg2: vector<4xf32>):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (vector<3x4xf32>, vector<3x3x4xf32>) -> vector<3x3x4xf32>
    %1 = "vector.insert"(%arg1, %0) <{static_position = array<i64: 1>}> : (vector<3x4xf32>, vector<3x3x4xf32>) -> vector<3x3x4xf32>
    %2 = "vector.insert"(%arg2, %1) <{static_position = array<i64: 1, 0>}> : (vector<4xf32>, vector<3x3x4xf32>) -> vector<3x3x4xf32>
    %3 = "vector.insert"(%arg2, %2) <{static_position = array<i64: 1, 1>}> : (vector<4xf32>, vector<3x3x4xf32>) -> vector<3x3x4xf32>
    %4 = "vector.extract"(%3) <{static_position = array<i64: 1, 1>}> : (vector<3x3x4xf32>) -> vector<4xf32>
    %5 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<3x3x4xf32>) -> vector<4xf32>
    %6 = "vector.extract"(%3) <{static_position = array<i64: 1>}> : (vector<3x3x4xf32>) -> vector<3x4xf32>
    %7 = "vector.extract"(%3) <{static_position = array<i64: 0>}> : (vector<3x3x4xf32>) -> vector<3x4xf32>
    "func.return"(%4, %5, %6, %7) : (vector<4xf32>, vector<4xf32>, vector<3x4xf32>, vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3x4xf32>, vector<4x3xf32>, f32) -> (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<3x4xf32>), sym_name = "insert_extract_transpose_3d"}> ({
  ^bb0(%arg0: vector<2x3x4xf32>, %arg1: vector<4x3xf32>, %arg2: f32):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 2, 1, 0>}> : (vector<2x3x4xf32>) -> vector<4x3x2xf32>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 0, 0, 1>}> : (f32, vector<4x3x2xf32>) -> vector<4x3x2xf32>
    %2 = "vector.transpose"(%1) <{permutation = array<i64: 2, 1, 0>}> : (vector<4x3x2xf32>) -> vector<2x3x4xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 1, 2>}> : (vector<2x3x4xf32>) -> vector<4xf32>
    %4 = "vector.transpose"(%arg0) <{permutation = array<i64: 2, 1, 0>}> : (vector<2x3x4xf32>) -> vector<4x3x2xf32>
    %5 = "vector.insert"(%arg2, %4) <{static_position = array<i64: 0, 2, 1>}> : (f32, vector<4x3x2xf32>) -> vector<4x3x2xf32>
    %6 = "vector.transpose"(%5) <{permutation = array<i64: 2, 1, 0>}> : (vector<4x3x2xf32>) -> vector<2x3x4xf32>
    %7 = "vector.extract"(%6) <{static_position = array<i64: 1, 2>}> : (vector<2x3x4xf32>) -> vector<4xf32>
    %8 = "vector.transpose"(%arg0) <{permutation = array<i64: 0, 2, 1>}> : (vector<2x3x4xf32>) -> vector<2x4x3xf32>
    %9 = "vector.insert"(%arg1, %8) <{static_position = array<i64: 0>}> : (vector<4x3xf32>, vector<2x4x3xf32>) -> vector<2x4x3xf32>
    %10 = "vector.transpose"(%9) <{permutation = array<i64: 0, 2, 1>}> : (vector<2x4x3xf32>) -> vector<2x3x4xf32>
    %11 = "vector.extract"(%10) <{static_position = array<i64: 0, 1>}> : (vector<2x3x4xf32>) -> vector<4xf32>
    %12 = "vector.transpose"(%arg0) <{permutation = array<i64: 0, 2, 1>}> : (vector<2x3x4xf32>) -> vector<2x4x3xf32>
    %13 = "vector.insert"(%arg1, %12) <{static_position = array<i64: 0>}> : (vector<4x3xf32>, vector<2x4x3xf32>) -> vector<2x4x3xf32>
    %14 = "vector.transpose"(%13) <{permutation = array<i64: 0, 2, 1>}> : (vector<2x4x3xf32>) -> vector<2x3x4xf32>
    %15 = "vector.extract"(%14) <{static_position = array<i64: 0>}> : (vector<2x3x4xf32>) -> vector<3x4xf32>
    "func.return"(%3, %7, %11, %15) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x4x5x6xf32>) -> (f32, vector<4x5x6xf32>), sym_name = "fold_extracts"}> ({
  ^bb0(%arg0: vector<3x4x5x6xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<3x4x5x6xf32>) -> vector<4x5x6xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 1, 2>}> : (vector<4x5x6xf32>) -> vector<6xf32>
    %2 = "vector.extract"(%1) <{static_position = array<i64: 3>}> : (vector<6xf32>) -> f32
    %3 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<3x4x5x6xf32>) -> vector<4x5x6xf32>
    "func.return"(%2, %3) : (f32, vector<4x5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x4x5x6xf32>, vector<3x6x5x6xf32>) -> (vector<6xf32>, vector<6xf32>, vector<6xf32>), sym_name = "fold_extract_transpose"}> ({
  ^bb0(%arg0: vector<3x4x5x6xf32>, %arg1: vector<3x6x5x6xf32>):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 0, 2, 1, 3>}> : (vector<3x4x5x6xf32>) -> vector<3x5x4x6xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0, 1, 2>}> : (vector<3x5x4x6xf32>) -> vector<6xf32>
    %2 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 2, 0, 3>}> : (vector<3x4x5x6xf32>) -> vector<4x5x3x6xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0, 1, 2>}> : (vector<4x5x3x6xf32>) -> vector<6xf32>
    %4 = "vector.transpose"(%arg1) <{permutation = array<i64: 0, 2, 3, 1>}> : (vector<3x6x5x6xf32>) -> vector<3x5x6x6xf32>
    %5 = "vector.extract"(%4) <{static_position = array<i64: 0, 1, 2>}> : (vector<3x5x6x6xf32>) -> vector<6xf32>
    "func.return"(%1, %3, %5) : (vector<6xf32>, vector<6xf32>, vector<6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index, index) -> f32, sym_name = "fold_extract_broadcast_same_input_output_scalar"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index, %arg3: index):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2, %arg3) <{static_position = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, index, index) -> vector<4xf32>, sym_name = "fold_extract_broadcast_same_input_output_vec"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: index, %arg2: index):
    %0 = "vector.broadcast"(%arg0) : (vector<4xf32>) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>, index, index, index) -> f32, sym_name = "fold_extract_broadcast_0dvec_input_scalar_output"}> ({
  ^bb0(%arg0: vector<f32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "vector.broadcast"(%arg0) : (vector<f32>) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2, %arg3) <{static_position = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1xf32>) -> vector<4xf32>, sym_name = "negative_fold_extract_broadcast"}> ({
  ^bb0(%arg0: vector<1x1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1x1xf32>) -> vector<1x1x4xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0, 0>}> : (vector<1x1x4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index, index) -> f32, sym_name = "fold_extract_splatlike"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index, %arg3: index):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2, %arg3) <{static_position = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> vector<4xf32>, sym_name = "fold_extract_vector_from_splat"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1xf32>, index, index, index) -> f32, sym_name = "fold_extract_broadcast_dim1_broadcasting"}> ({
  ^bb0(%arg0: vector<2x1xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "vector.broadcast"(%arg0) : (vector<2x1xf32>) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2, %arg3) <{static_position = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>, index, index) -> vector<4xf32>, sym_name = "fold_extract_broadcast_to_lower_rank"}> ({
  ^bb0(%arg0: vector<2x4xf32>, %arg1: index, %arg2: index):
    %0 = "vector.broadcast"(%arg0) : (vector<2x4xf32>) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>, index, index) -> vector<4xf32>, sym_name = "fold_extract_shape_cast_to_lower_rank"}> ({
  ^bb0(%arg0: vector<2x4xf32>, %arg1: index, %arg2: index):
    %0 = "vector.shape_cast"(%arg0) : (vector<2x4xf32>) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>, index, index) -> vector<2xf32>, sym_name = "negative_fold_extract_shape_cast_to_lower_rank"}> ({
  ^bb0(%arg0: vector<2x4xf32>, %arg1: index, %arg2: index):
    %0 = "vector.shape_cast"(%arg0) : (vector<2x4xf32>) -> vector<1x4x2xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x4x2xf32>, index, index) -> vector<2xf32>
    "func.return"(%1) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> vector<4xf32>, sym_name = "fold_extract_broadcast_to_higher_rank"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1x2x4xf32>
    %1 = "vector.extract"(%0, %arg1, %arg2) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x2x4xf32>, index, index) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, index) -> vector<8xf32>, sym_name = "fold_extract_broadcast_to_equal_rank"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: index):
    %0 = "vector.broadcast"(%arg0) : (vector<1xf32>) -> vector<1x8xf32>
    %1 = "vector.extract"(%0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<1x8xf32>, index) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, index) -> vector<1x1xf32>, sym_name = "fold_extract_broadcastlike_shape_cast"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: index):
    %0 = "vector.shape_cast"(%arg0) : (vector<1xf32>) -> vector<1x1x1xf32>
    %1 = "vector.extract"(%0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<1x1x1xf32>, index) -> vector<1x1xf32>
    "func.return"(%1) : (vector<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<8xf32>) -> (f32, f32, f32, f32), sym_name = "fold_extract_shuffle"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 8, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<4xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
    %2 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<4xf32>) -> f32
    %3 = "vector.extract"(%0) <{static_position = array<i64: 2>}> : (vector<4xf32>) -> f32
    %4 = "vector.extract"(%0) <{static_position = array<i64: 3>}> : (vector<4xf32>) -> f32
    "func.return"(%1, %2, %3, %4) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5x1x3x2xf32>, vector<8x4x2xf32>) -> (f32, vector<2xf32>, vector<4x2xf32>, vector<8x4x2xf32>), sym_name = "fold_extract_shapecast"}> ({
  ^bb0(%arg0: vector<5x1x3x2xf32>, %arg1: vector<8x4x2xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<5x1x3x2xf32>) -> vector<15x2xf32>
    %1 = "vector.shape_cast"(%arg1) : (vector<8x4x2xf32>) -> vector<4x2x4x2xf32>
    %2 = "vector.shape_cast"(%arg1) : (vector<8x4x2xf32>) -> vector<1x8x4x2xf32>
    %3 = "vector.extract"(%0) <{static_position = array<i64: 4, 1>}> : (vector<15x2xf32>) -> f32
    %4 = "vector.extract"(%0) <{static_position = array<i64: 5>}> : (vector<15x2xf32>) -> vector<2xf32>
    %5 = "vector.extract"(%1) <{static_position = array<i64: 3, 1>}> : (vector<4x2x4x2xf32>) -> vector<4x2xf32>
    %6 = "vector.extract"(%2) <{static_position = array<i64: 0>}> : (vector<1x8x4x2xf32>) -> vector<8x4x2xf32>
    "func.return"(%3, %4, %5, %6) : (f32, vector<2xf32>, vector<4x2xf32>, vector<8x4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1xf32>) -> f32, sym_name = "fold_extract_shapecast_0d_result"}> ({
  ^bb0(%arg0: vector<1x1x1xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<1x1x1xf32>) -> vector<f32>
    %1 = "vector.extract"(%0) <{static_position = array<i64>}> : (vector<f32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> f32, sym_name = "fold_extract_shapecast_0d_source"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<1xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> vector<4x2xf32>, sym_name = "negative_fold_extract_shapecast"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<16xf32>) -> vector<2x4x2xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<2x4x2xf32>) -> vector<4x2xf32>
    "func.return"(%1) : (vector<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x4xf32>) -> vector<12xf32>, sym_name = "fold_extract_shapecast_to_shapecast"}> ({
  ^bb0(%arg0: vector<3x4xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<3x4xf32>) -> vector<1x12xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<1x12xf32>) -> vector<12xf32>
    "func.return"(%1) : (vector<12xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> f32, sym_name = "extract_no_fold_scalar_to_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64>}> : (vector<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>) -> vector<2x2xf32>, sym_name = "insert_fold_same_rank"}> ({
  ^bb0(%arg0: vector<2x2xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %1 = "vector.insert"(%0, %arg0) <{static_position = array<i64>}> : (vector<2x2xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%1) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<f32>, sym_name = "insert_no_fold_scalar_to_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "vector.insert"(%0, %arg0) <{static_position = array<i64>}> : (f32, vector<f32>) -> vector<f32>
    "func.return"(%1) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x64xf32>) -> vector<8x8xf32>, sym_name = "dont_fold_expand_collapse"}> ({
  ^bb0(%arg0: vector<1x1x64xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<1x1x64xf32>) -> vector<1x1x8x8xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x8x8xf32>) -> vector<8x8xf32>
    "func.return"(%1) : (vector<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "fold_broadcast_shapecast"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<4xf32>) -> vector<1x1x4xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<1xf32>, sym_name = "canonicalize_broadcast_shapecast_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1x1x1xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x1xf32>) -> vector<1xf32>
    "func.return"(%1) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> vector<8xf32>, sym_name = "dont_fold_broadcast_shapecast_diff_shape"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<4xf32>) -> vector<1x2x4xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x2x4xf32>) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf32>) -> vector<8x3xf32>, sym_name = "canonicalize_broadcast_shapecast_to_broadcast"}> ({
  ^bb0(%arg0: vector<3xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<3xf32>) -> vector<2x4x3xf32>
    %1 = "vector.shape_cast"(%0) : (vector<2x4x3xf32>) -> vector<8x3xf32>
    "func.return"(%1) : (vector<8x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1xi8>) -> vector<1x1x6x1x4xi8>, sym_name = "canonicalize_broadcast_shapecast_to_broadcast_ones"}> ({
  ^bb0(%arg0: vector<1x1xi8>):
    %0 = "vector.broadcast"(%arg0) : (vector<1x1xi8>) -> vector<6x4xi8>
    %1 = "vector.shape_cast"(%0) : (vector<6x4xi8>) -> vector<1x1x6x1x4xi8>
    "func.return"(%1) : (vector<1x1x6x1x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<3x4x1xf32>, sym_name = "canonicalize_broadcast_shapecast_to_broadcast_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<12xf32>
    %1 = "vector.shape_cast"(%0) : (vector<12xf32>) -> vector<3x4x1xf32>
    "func.return"(%1) : (vector<3x4x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<1x2x1xf32>, sym_name = "canonicalize_broadcast_shapecast_to_shapcast"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2xf32>) -> vector<1x2xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x2xf32>) -> vector<1x2x1xf32>
    "func.return"(%1) : (vector<1x2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1x1xf32>, sym_name = "canonicalize_broadcast_shapecast_both_possible"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1xf32>) -> vector<1x1x1xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x1xf32>) -> vector<1x1xf32>
    "func.return"(%1) : (vector<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<32x2xf32>, sym_name = "canonicalize_shapecast_broadcast_to_broadcast_prepend_dim"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2xf32>) -> vector<1x2xf32>
    %1 = "vector.broadcast"(%0) : (vector<1x2xf32>) -> vector<32x2xf32>
    "func.return"(%1) : (vector<32x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1xf32>) -> vector<32x2x1xf32>, sym_name = "canonicalize_shapecast_broadcast_to_broadcast_prepend_dim2"}> ({
  ^bb0(%arg0: vector<2x1xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2x1xf32>) -> vector<1x2x1xf32>
    %1 = "vector.broadcast"(%0) : (vector<1x2x1xf32>) -> vector<32x2x1xf32>
    "func.return"(%1) : (vector<32x2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1xf32>) -> vector<32x2x4xf32>, sym_name = "canonicalize_shapecast_broadcast_to_broadcast_prepend_dim3"}> ({
  ^bb0(%arg0: vector<2x1xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2x1xf32>) -> vector<1x2x1xf32>
    %1 = "vector.broadcast"(%0) : (vector<1x2x1xf32>) -> vector<32x2x4xf32>
    "func.return"(%1) : (vector<32x2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x2xf32>) -> vector<32x2xf32>, sym_name = "canonicalize_shapecast_broadcast_to_broadcast_remove_leading_dim"}> ({
  ^bb0(%arg0: vector<1x2xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<1x2xf32>) -> vector<2xf32>
    %1 = "vector.broadcast"(%0) : (vector<2xf32>) -> vector<32x2xf32>
    "func.return"(%1) : (vector<32x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<64xf32>) -> vector<2x4x16xf32>, sym_name = "negative_canonicalize_shapecast_broadcast_invalid_shape"}> ({
  ^bb0(%arg0: vector<64xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<64xf32>) -> vector<4x16xf32>
    %1 = "vector.broadcast"(%0) : (vector<4x16xf32>) -> vector<2x4x16xf32>
    "func.return"(%1) : (vector<2x4x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1xf32>) -> vector<2x2xf32>, sym_name = "negative_canonicalize_shapecast_broadcast_invalid_broadcasted_dims"}> ({
  ^bb0(%arg0: vector<2x1xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2x1xf32>) -> vector<1x2xf32>
    %1 = "vector.broadcast"(%0) : (vector<1x2xf32>) -> vector<2x2xf32>
    "func.return"(%1) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2x4xf32>, sym_name = "negative_canonicalize_shapecast_broadcast_to_broadcast_append_dim"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2xf32>) -> vector<2x1xf32>
    %1 = "vector.broadcast"(%0) : (vector<2x1xf32>) -> vector<2x4xf32>
    "func.return"(%1) : (vector<2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1xf32>) -> vector<32x2xf32>, sym_name = "negative_canonicalize_shapecast_broadcast_to_broadcast_remove_trailing_dim"}> ({
  ^bb0(%arg0: vector<2x1xf32>):
    %0 = "vector.shape_cast"(%arg0) : (vector<2x1xf32>) -> vector<2xf32>
    %1 = "vector.broadcast"(%0) : (vector<2xf32>) -> vector<32x2xf32>
    "func.return"(%1) : (vector<32x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (vector<4x8xf32>, vector<4x[4]xf32>), sym_name = "fold_vector_transfer_masks"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 8, 4>}> : () -> vector<8x4xi1>
    %3 = "arith.constant"() <{value = dense<true> : vector<4x[4]xi1>}> : () -> vector<4x[4]xi1>
    %4 = "vector.transfer_read"(%arg0, %0, %0, %1, %2) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32, vector<8x4xi1>) -> vector<4x8xf32>
    "vector.transfer_write"(%4, %arg0, %0, %0, %2) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<4x8xf32>, memref<?x?xf32>, index, index, vector<8x4xi1>) -> ()
    %5 = "vector.transfer_read"(%arg0, %0, %0, %1, %3) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map1}> : (memref<?x?xf32>, index, index, f32, vector<4x[4]xi1>) -> vector<4x[4]xf32>
    "vector.transfer_write"(%5, %arg0, %0, %0, %3) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map1}> : (vector<4x[4]xf32>, memref<?x?xf32>, index, index, vector<4x[4]xi1>) -> ()
    "func.return"(%4, %5) : (vector<4x8xf32>, vector<4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x8xf32>) -> (vector<4x8xf32>, vector<4x9xf32>), sym_name = "fold_vector_transfers"}> ({
  ^bb0(%arg0: memref<?x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x8xf32>, index, index, f32) -> vector<4x8xf32>
    "vector.transfer_write"(%2, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x8xf32>, memref<?x8xf32>, index, index) -> ()
    %3 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x8xf32>, index, index, f32) -> vector<4x9xf32>
    "vector.transfer_write"(%3, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x9xf32>, memref<?x8xf32>, index, index) -> ()
    "func.return"(%2, %3) : (vector<4x8xf32>, vector<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>, vector<2xi32>) -> (vector<4x8xf32>, vector<2xi32>), sym_name = "bitcast_folding"}> ({
  ^bb0(%arg0: vector<4x8xf32>, %arg1: vector<2xi32>):
    %0 = "vector.bitcast"(%arg0) : (vector<4x8xf32>) -> vector<4x8xf32>
    %1 = "vector.bitcast"(%arg1) : (vector<2xi32>) -> vector<4xi16>
    %2 = "vector.bitcast"(%1) : (vector<4xi16>) -> vector<2xi32>
    "func.return"(%0, %2) : (vector<4x8xf32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<4xf32>, vector<4xf32>), sym_name = "bitcast_f16_to_f32"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf16>}> : () -> vector<8xf16>
    %1 = "arith.constant"() <{value = dense<2.000000e+00> : vector<8xf16>}> : () -> vector<8xf16>
    %2 = "vector.bitcast"(%0) : (vector<8xf16>) -> vector<4xf32>
    %3 = "vector.bitcast"(%1) : (vector<8xf16>) -> vector<4xf32>
    "func.return"(%2, %3) : (vector<4xf32>, vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi32>), sym_name = "bitcast_i8_to_i32"}> ({
    %0 = "arith.constant"() <{value = dense<0> : vector<16xi8>}> : () -> vector<16xi8>
    %1 = "arith.constant"() <{value = dense<-96> : vector<16xi8>}> : () -> vector<16xi8>
    %2 = "vector.bitcast"(%0) : (vector<16xi8>) -> vector<4xi32>
    %3 = "vector.bitcast"(%1) : (vector<16xi8>) -> vector<4xi32>
    "func.return"(%2, %3) : (vector<4xi32>, vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x6xi8>, sym_name = "broadcast_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<6xi8>
    %1 = "vector.broadcast"(%0) : (vector<6xi8>) -> vector<4x6xi8>
    "func.return"(%1) : (vector<4x6xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x6xi8>, sym_name = "broadcast_splat_constant"}> ({
    %0 = "arith.constant"() <{value = dense<1> : vector<6xi8>}> : () -> vector<6xi8>
    %1 = "vector.broadcast"(%0) : (vector<6xi8>) -> vector<4x6xi8>
    "func.return"(%1) : (vector<4x6xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "broadcast_folding1"}> ({
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "vector.broadcast"(%0) : (i32) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x16xi32>, sym_name = "broadcast_folding2"}> ({
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "vector.broadcast"(%0) : (i32) -> vector<16xi32>
    %2 = "vector.broadcast"(%1) : (vector<16xi32>) -> vector<4x16xi32>
    "func.return"(%2) : (vector<4x16xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> vector<4x16xi32>, sym_name = "fold_consecutive_broadcasts"}> ({
  ^bb0(%arg0: i32):
    %0 = "vector.broadcast"(%arg0) : (i32) -> vector<16xi32>
    %1 = "vector.broadcast"(%0) : (vector<16xi32>) -> vector<4x16xi32>
    "func.return"(%1) : (vector<4x16xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<20x2xf32>, vector<3x4x2xi32>), sym_name = "shape_cast_splat_constant"}> ({
    %0 = "arith.constant"() <{value = dense<2.000000e+00> : vector<5x4x2xf32>}> : () -> vector<5x4x2xf32>
    %1 = "arith.constant"() <{value = dense<1> : vector<12x2xi32>}> : () -> vector<12x2xi32>
    %2 = "vector.shape_cast"(%0) : (vector<5x4x2xf32>) -> vector<20x2xf32>
    %3 = "vector.shape_cast"(%1) : (vector<12x2xi32>) -> vector<3x4x2xi32>
    "func.return"(%2, %3) : (vector<20x2xf32>, vector<3x4x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x3xi8>, sym_name = "shape_cast_dense_int_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[2, 3, 5, 7, 11, 13]> : vector<6xi8>}> : () -> vector<6xi8>
    %1 = "vector.shape_cast"(%0) : (vector<6xi8>) -> vector<2x3xi8>
    "func.return"(%1) : (vector<2x3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<2xf32>, vector<1x2xf32>), sym_name = "shape_cast_dense_float_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[1.000000e+00, 2.000000e+00]]> : vector<1x2xf32>}> : () -> vector<1x2xf32>
    %1 = "vector.shape_cast"(%0) : (vector<1x2xf32>) -> vector<2xf32>
    "func.return"(%1, %0) : (vector<2xf32>, vector<1x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<20x2xf32>, vector<3x4x2xi32>), sym_name = "shape_cast_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<5x4x2xf32>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<12x2xi32>
    %2 = "vector.shape_cast"(%0) : (vector<5x4x2xf32>) -> vector<20x2xf32>
    %3 = "vector.shape_cast"(%1) : (vector<12x2xi32>) -> vector<3x4x2xi32>
    "func.return"(%2, %3) : (vector<20x2xf32>, vector<3x4x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<12x2xf32>, vector<2x13x3xi32>), sym_name = "extract_strided_constant"}> ({
    %0 = "arith.constant"() <{value = dense<2.000000e+00> : vector<29x7xf32>}> : () -> vector<29x7xf32>
    %1 = "arith.constant"() <{value = dense<1> : vector<4x37x9xi32>}> : () -> vector<4x37x9xi32>
    %2 = "vector.extract_strided_slice"(%0) <{offsets = [2, 3], sizes = [12, 2], strides = [1, 1]}> : (vector<29x7xf32>) -> vector<12x2xf32>
    %3 = "vector.extract_strided_slice"(%1) <{offsets = [1, 2, 5], sizes = [2, 13, 3], strides = [1, 1, 1]}> : (vector<4x37x9xi32>) -> vector<2x13x3xi32>
    "func.return"(%2, %3) : (vector<12x2xf32>, vector<2x13x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf16>) -> vector<2x4xf16>, sym_name = "extract_strided_broadcast"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "vector.broadcast"(%arg0) : (vector<4xf16>) -> vector<16x4xf16>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 0], sizes = [2, 4], strides = [1, 1]}> : (vector<16x4xf16>) -> vector<2x4xf16>
    "func.return"(%1) : (vector<2x4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf16>) -> vector<2x2xf16>, sym_name = "extract_strided_broadcast2"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "vector.broadcast"(%arg0) : (vector<4xf16>) -> vector<16x4xf16>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<16x4xf16>) -> vector<2x2xf16>
    "func.return"(%1) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1x4xf32>, sym_name = "extract_strided_broadcast3"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<1xf32>) -> vector<1x8xf32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 4], sizes = [1, 4], strides = [1, 1]}> : (vector<1x8xf32>) -> vector<1x4xf32>
    "func.return"(%1) : (vector<1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<1x4xf32>, sym_name = "extract_strided_broadcast4"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<1x8xf32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 4], sizes = [1, 4], strides = [1, 1]}> : (vector<1x8xf32>) -> vector<1x4xf32>
    "func.return"(%1) : (vector<1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1xf32>) -> vector<2x4xf32>, sym_name = "extract_strided_broadcast5"}> ({
  ^bb0(%arg0: vector<2x1xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2x1xf32>) -> vector<2x8xf32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 4], sizes = [2, 4], strides = [1, 1]}> : (vector<2x8xf32>) -> vector<2x4xf32>
    "func.return"(%1) : (vector<2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf16>) -> vector<4x4xf16>, sym_name = "consecutive_shape_cast"}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "vector.shape_cast"(%arg0) : (vector<16xf16>) -> vector<2x8xf16>
    %1 = "vector.shape_cast"(%0) : (vector<2x8xf16>) -> vector<4x4xf16>
    "func.return"(%1) : (vector<4x4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>, memref<4x4xf32>, vector<1x4xf32>) -> (), sym_name = "dead_transfer_op"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: memref<4x4xf32>, %arg2: vector<1x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xf32>, index, index, f32) -> vector<1x4xf32>
    %3 = "vector.transfer_write"(%arg2, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "dead_load"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg2, %arg3) : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    %2 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    %3 = "vector.expandload"(%arg0, %0, %arg2, %arg3) : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xf32>, vector<3x4xf32>, vector<2x4xf32>, vector<2x3xi8>, vector<3x4xi8>, vector<2x4xi8>) -> (vector<2x4xf32>, vector<2x4xi8>), sym_name = "contractions"}> ({
  ^bb0(%arg0: vector<2x3xf32>, %arg1: vector<3x4xf32>, %arg2: vector<2x4xf32>, %arg3: vector<2x3xi8>, %arg4: vector<3x4xi8>, %arg5: vector<2x4xi8>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x4xf32>}> : () -> vector<2x4xf32>
    %1 = "vector.contract"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<2x3xf32>, vector<3x4xf32>, vector<2x4xf32>) -> vector<2x4xf32>
    %2 = "arith.addf"(%1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2x4xf32>, vector<2x4xf32>) -> vector<2x4xf32>
    %3 = "arith.constant"() <{value = dense<0> : vector<2x4xi8>}> : () -> vector<2x4xi8>
    %4 = "vector.contract"(%arg3, %arg4, %3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<2x3xi8>, vector<3x4xi8>, vector<2x4xi8>) -> vector<2x4xi8>
    %5 = "arith.addi"(%4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (vector<2x4xi8>, vector<2x4xi8>) -> vector<2x4xi8>
    "func.return"(%2, %5) : (vector<2x4xf32>, vector<2x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>, tensor<2x3x4xf32>) -> (tensor<2x3x4xf32>, tensor<2x3x4xf32>, tensor<2x3x4xf32>), sym_name = "transfer_folding_1"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>, %arg1: tensor<2x3x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%arg0, %0, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (tensor<2x3x4xf32>, index, index, index, f32) -> vector<2x3x4xf32>
    %3 = "vector.transfer_write"(%2, %arg1, %0, %0, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<2x3x4xf32>, tensor<2x3x4xf32>, index, index, index) -> tensor<2x3x4xf32>
    %4 = "test.constant"() <{value = dense<6.000000e+00> : tensor<2x3x4xf32>}> : () -> tensor<2x3x4xf32>
    %5 = "vector.transfer_write"(%2, %4, %0, %0, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<2x3x4xf32>, tensor<2x3x4xf32>, index, index, index) -> tensor<2x3x4xf32>
    %6 = "some_op_that_may_have_side_effects"() : () -> tensor<2x3x4xf32>
    %7 = "vector.transfer_write"(%2, %arg0, %0, %0, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<2x3x4xf32>, tensor<2x3x4xf32>, index, index, index) -> tensor<2x3x4xf32>
    "func.return"(%3, %5, %7) : (tensor<2x3x4xf32>, tensor<2x3x4xf32>, tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>) -> tensor<4x4xf32>, sym_name = "store_after_load_tensor"}> ({
  ^bb0(%arg0: tensor<4x4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg0, %0, %1, %2) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<4x4xf32>, index, index, f32) -> vector<1x4xf32>
    %4 = "vector.transfer_write"(%3, %arg0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    "func.return"(%4) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>) -> tensor<4x4xf32>, sym_name = "negative_store_after_load_tensor"}> ({
  ^bb0(%arg0: tensor<4x4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%arg0, %0, %1, %2) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<4x4xf32>, index, index, f32) -> vector<1x4xf32>
    %4 = "vector.transfer_write"(%3, %arg0, %1, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    "func.return"(%4) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>, vector<1x4xf32>, vector<1x4xf32>) -> vector<1x4xf32>, sym_name = "store_to_load_tensor"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_write"(%arg1, %arg0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %5 = "vector.transfer_write"(%arg2, %4, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %6 = "vector.transfer_read"(%5, %0, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<4x4xf32>, index, index, f32) -> vector<1x4xf32>
    "func.return"(%6) : (vector<1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>, vector<1x4xf32>, vector<1x4xf32>, index) -> vector<1x4xf32>, sym_name = "negative_store_to_load_tensor"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_write"(%arg1, %arg0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %5 = "vector.transfer_write"(%arg1, %4, %arg3, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %6 = "vector.transfer_read"(%5, %0, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<4x4xf32>, index, index, f32) -> vector<1x4xf32>
    "func.return"(%6) : (vector<1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>, vector<4x2xf32>) -> vector<4x2x6xf32>, sym_name = "store_to_load_tensor_broadcast"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: vector<4x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x2xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (tensor<4x4xf32>, index, index, f32) -> vector<4x2x6xf32>
    "func.return"(%3) : (vector<4x2x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, memref<?x?xf32>, vector<4x2xf32>) -> vector<4x2xf32>, sym_name = "negative_store_to_load_tensor_memref"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: vector<4x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "vector.transfer_write"(%arg2, %arg1, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x2xf32>, memref<?x?xf32>, index, index) -> ()
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4x2xf32>
    "func.return"(%2) : (vector<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<4x2xf32>) -> vector<4x2xf32>, sym_name = "negative_store_to_load_tensor_no_actual_broadcast"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<4x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4x2xf32>
    "func.return"(%3) : (vector<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<4x2xf32>) -> vector<4x2x6xf32>, sym_name = "negative_store_to_load_tensor_broadcast_out_of_bounds"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<4x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x2xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (tensor<?x?xf32>, index, index, f32) -> vector<4x2x6xf32>
    "func.return"(%3) : (vector<4x2x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<4x2xf32>, vector<4x2xi1>) -> vector<4x2x6xf32>, sym_name = "negative_store_to_load_tensor_broadcast_masked"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<4x2xf32>, %arg2: vector<4x2xi1>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg1, %arg0, %0, %0, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<4x2xf32>, tensor<?x?xf32>, index, index, vector<4x2xi1>) -> tensor<?x?xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (tensor<?x?xf32>, index, index, f32) -> vector<4x2x6xf32>
    "func.return"(%3) : (vector<4x2x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<[4]xf32>) -> vector<6x[4]xf32>, sym_name = "store_to_load_tensor_broadcast_scalable"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<[4]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[4]xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %3 = "vector.transfer_read"(%2, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map1}> : (tensor<?xf32>, index, f32) -> vector<6x[4]xf32>
    "func.return"(%3) : (vector<6x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d1, 0, d2, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4x4xf32>, vector<4x1xf32>) -> vector<1x100x4x5xf32>, sym_name = "store_to_load_tensor_perm_broadcast"}> ({
  ^bb0(%arg0: tensor<4x4x4xf32>, %arg1: vector<4x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg1, %arg0, %0, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<4x1xf32>, tensor<4x4x4xf32>, index, index, index) -> tensor<4x4x4xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %0, %1) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<4x4x4xf32>, index, index, index, f32) -> vector<1x100x4x5xf32>
    "func.return"(%3) : (vector<1x100x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>, tensor<1x1x4x8xf32>) -> vector<1x1x4x8xf32>, sym_name = "store_to_load_tensor_forwarding_unit_dim_broadcast"}> ({
  ^bb0(%arg0: vector<4x8xf32>, %arg1: tensor<1x1x4x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg0, %arg1, %0, %0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map}> : (vector<4x8xf32>, tensor<1x1x4x8xf32>, index, index, index, index) -> tensor<1x1x4x8xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %0, %0, %1) <{in_bounds = [false, false, false, false], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (tensor<1x1x4x8xf32>, index, index, index, index, f32) -> vector<1x1x4x8xf32>
    "func.return"(%3) : (vector<1x1x4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>, vector<1x4xf32>, vector<1x4xf32>, index) -> tensor<4x4xf32>, sym_name = "dead_store_tensor"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_write"(%arg1, %arg0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %5 = "vector.transfer_write"(%arg1, %4, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %6 = "vector.transfer_write"(%arg2, %5, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    "func.return"(%6) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x4xf32>, vector<1x4xf32>, vector<1x4xf32>, index) -> tensor<4x4xf32>, sym_name = "negative_dead_store_tensor"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: vector<1x4xf32>, %arg2: vector<1x4xf32>, %arg3: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_write"(%arg1, %arg0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %5 = "vector.transfer_write"(%arg1, %4, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    %6 = "vector.transfer_read"(%5, %arg3, %arg3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<4x4xf32>, index, index, f32) -> vector<1x4xf32>
    %7 = "arith.addf"(%6, %6) <{fastmath = #arith.fastmath<none>}> : (vector<1x4xf32>, vector<1x4xf32>) -> vector<1x4xf32>
    %8 = "vector.transfer_write"(%7, %4, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
    "func.return"(%8) : (tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x4xf32>, tensor<4x8xf32>, tensor<64x64xf32>, index, index) -> tensor<64x64xf32>, sym_name = "swap_extract_slice_transfer_write"}> ({
  ^bb0(%arg0: vector<8x4xf32>, %arg1: tensor<4x8xf32>, %arg2: tensor<64x64xf32>, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.transfer_write"(%arg0, %arg1, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x4xf32>, tensor<4x8xf32>, index, index) -> tensor<4x8xf32>
    %2 = "tensor.extract_slice"(%1, %arg4) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<4x8xf32>, index) -> tensor<?x8xf32>
    %3 = "tensor.insert_slice"(%2, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 16>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xf32>, tensor<64x64xf32>, index, index) -> tensor<64x64xf32>
    "func.return"(%3) : (tensor<64x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<4xf32>, tensor<8xf32>, tensor<64xf32>, index, index) -> (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>), sym_name = "do_not_swap_extract_slice_transfer_write"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<4xf32>, %arg2: tensor<8xf32>, %arg3: tensor<64xf32>, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.transfer_write"(%arg0, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<8xf32>, tensor<8xf32>, index) -> tensor<8xf32>
    %2 = "tensor.extract_slice"(%1, %arg4) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%2, %arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<64xf32>, index, index) -> tensor<64xf32>
    %4 = "vector.transfer_write"(%arg1, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<8xf32>, index) -> tensor<8xf32>
    %5 = "tensor.extract_slice"(%4, %arg5) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<8xf32>, index) -> tensor<?xf32>
    %6 = "tensor.insert_slice"(%5, %arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<64xf32>, index, index) -> tensor<64xf32>
    %7 = "vector.transfer_write"(%arg0, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<8xf32>, tensor<8xf32>, index) -> tensor<8xf32>
    %8 = "tensor.extract_slice"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<8xf32>) -> tensor<f32>
    %9 = "tensor.insert_slice"(%8, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<f32>, tensor<64xf32>, index) -> tensor<64xf32>
    "func.return"(%3, %6, %9) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "vector_multi_reduction_single_parallel"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>, vector<2xi1>) -> vector<2xf32>, sym_name = "masked_vector_multi_reduction_single_parallel"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xi1>):
    %0 = "vector.mask"(%arg2) ({
      %1 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
      "vector.yield"(%1) : (vector<2xf32>) -> ()
    }) : (vector<2xi1>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5x1x4x1x20xf32>, vector<5x4x20xf32>) -> vector<5x4x20xf32>, sym_name = "vector_multi_reduction_unit_dimensions"}> ({
  ^bb0(%arg0: vector<5x1x4x1x20xf32>, %arg1: vector<5x4x20xf32>):
    %0 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64: 1, 3>}> : (vector<5x1x4x1x20xf32>, vector<5x4x20xf32>) -> vector<5x4x20xf32>
    "func.return"(%0) : (vector<5x4x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x[4]x1xf32>, vector<1x[4]xf32>, vector<1x[4]x1xi1>) -> vector<1x[4]xf32>, sym_name = "vector_multi_reduction_scalable"}> ({
  ^bb0(%arg0: vector<1x[4]x1xf32>, %arg1: vector<1x[4]xf32>, %arg2: vector<1x[4]x1xi1>):
    %0 = "vector.mask"(%arg2) ({
      %1 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<add>, reduction_dims = array<i64: 2>}> : (vector<1x[4]x1xf32>, vector<1x[4]xf32>) -> vector<1x[4]xf32>
      "vector.yield"(%1) : (vector<1x[4]xf32>) -> ()
    }) : (vector<1x[4]x1xi1>) -> vector<1x[4]xf32>
    "func.return"(%0) : (vector<1x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5x1x4x1x20xf32>, vector<5x4x20xf32>, vector<5x1x4x1x20xi1>) -> vector<5x4x20xf32>, sym_name = "masked_vector_multi_reduction_unit_dimensions"}> ({
  ^bb0(%arg0: vector<5x1x4x1x20xf32>, %arg1: vector<5x4x20xf32>, %arg2: vector<5x1x4x1x20xi1>):
    %0 = "vector.mask"(%arg2) ({
      %1 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64: 1, 3>}> : (vector<5x1x4x1x20xf32>, vector<5x4x20xf32>) -> vector<5x4x20xf32>
      "vector.yield"(%1) : (vector<5x4x20xf32>) -> ()
    }) : (vector<5x1x4x1x20xi1>) -> vector<5x4x20xf32>
    "func.return"(%0) : (vector<5x4x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5x1x4x1x20xf32>, vector<5x1x20xf32>) -> vector<5x1x20xf32>, sym_name = "vector_multi_reduction_unit_dimensions_fail"}> ({
  ^bb0(%arg0: vector<5x1x4x1x20xf32>, %arg1: vector<5x1x20xf32>):
    %0 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64: 1, 2>}> : (vector<5x1x4x1x20xf32>, vector<5x1x20xf32>) -> vector<5x1x20xf32>
    "func.return"(%0) : (vector<5x1x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1xf32>, f32) -> f32, sym_name = "vector_multi_reduction_unit_dimensions_single_elem"}> ({
  ^bb0(%arg0: vector<1x1x1xf32>, %arg1: f32):
    %0 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64: 0, 1, 2>}> : (vector<1x1x1xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1xf32>, f32, vector<1x1x1xi1>) -> f32, sym_name = "masked_vector_multi_reduction_unit_dimensions_single_elem"}> ({
  ^bb0(%arg0: vector<1x1x1xf32>, %arg1: f32, %arg2: vector<1x1x1xi1>):
    %0 = "vector.mask"(%arg2) ({
      %1 = "vector.multi_reduction"(%arg0, %arg1) <{kind = #vector.kind<mul>, reduction_dims = array<i64: 0, 1, 2>}> : (vector<1x1x1xf32>, f32) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<1x1x1xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>, sym_name = "insert_strided_slice_full_range"}> ({
  ^bb0(%arg0: vector<16x16xf16>, %arg1: vector<16x16xf16>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [0, 0], strides = [1, 1]}> : (vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "func.return"(%0) : (vector<16x16xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> vector<2x4xf16>, sym_name = "extract_strided_splatlike"}> ({
  ^bb0(%arg0: f16):
    %0 = "vector.broadcast"(%arg0) : (f16) -> vector<16x4xf16>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [1, 0], sizes = [2, 4], strides = [1, 1]}> : (vector<16x4xf16>) -> vector<2x4xf16>
    "func.return"(%1) : (vector<2x4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x4xf32>, vector<4xf32>) -> (vector<4xf32>, vector<1x1x4xf32>), sym_name = "insert_extract_to_broadcast"}> ({
  ^bb0(%arg0: vector<1x1x4xf32>, %arg1: vector<4xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0>}> : (vector<1x1x4xf32>) -> vector<4xf32>
    %1 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0, 0>}> : (vector<4xf32>, vector<1x1x4xf32>) -> vector<1x1x4xf32>
    "func.return"(%0, %1) : (vector<4xf32>, vector<1x1x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<7xf32>, i32), sym_name = "extract_splat_constant"}> ({
    %0 = "arith.constant"() <{value = dense<2.000000e+00> : vector<29x7xf32>}> : () -> vector<29x7xf32>
    %1 = "arith.constant"() <{value = dense<1> : vector<4x37x9xi32>}> : () -> vector<4x37x9xi32>
    %2 = "vector.extract"(%0) <{static_position = array<i64: 2>}> : (vector<29x7xf32>) -> vector<7xf32>
    %3 = "vector.extract"(%1) <{static_position = array<i64: 1, 4, 5>}> : (vector<4x37x9xi32>) -> i32
    "func.return"(%2, %3) : (vector<7xf32>, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, index, f32), sym_name = "extract_1d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 2, 3, 4]> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 2>}> : (vector<4xi32>) -> i32
    %2 = "arith.constant"() <{value = dense<[0, 1, 2]> : vector<3xindex>}> : () -> vector<3xindex>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 1>}> : (vector<3xindex>) -> index
    %4 = "arith.constant"() <{value = dense<[2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<3xf32>}> : () -> vector<3xf32>
    %5 = "vector.extract"(%4) <{static_position = array<i64: 0>}> : (vector<3xf32>) -> f32
    "func.return"(%1, %3, %5) : (i32, index, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "extract_2d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[0, 1, 2], [3, 4, 5]]> : vector<2x3xi32>}> : () -> vector<2x3xi32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0, 0>}> : (vector<2x3xi32>) -> i32
    %2 = "vector.extract"(%0) <{static_position = array<i64: 0, 2>}> : (vector<2x3xi32>) -> i32
    %3 = "vector.extract"(%0) <{static_position = array<i64: 1, 0>}> : (vector<2x3xi32>) -> i32
    %4 = "vector.extract"(%0) <{static_position = array<i64: 1, 2>}> : (vector<2x3xi32>) -> i32
    "func.return"(%1, %2, %3, %4) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3xi32>, vector<3xi32>), sym_name = "extract_vector_2d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[0, 1, 2], [3, 4, 5]]> : vector<2x3xi32>}> : () -> vector<2x3xi32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<2x3xi32>) -> vector<3xi32>
    %2 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<2x3xi32>) -> vector<3xi32>
    "func.return"(%1, %2) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32, i32, i32), sym_name = "extract_3d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[[0, 1], [2, 3], [4, 5]], [[6, 7], [8, 9], [10, 11]]]> : vector<2x3x2xi32>}> : () -> vector<2x3x2xi32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0, 0, 0>}> : (vector<2x3x2xi32>) -> i32
    %2 = "vector.extract"(%0) <{static_position = array<i64: 0, 0, 1>}> : (vector<2x3x2xi32>) -> i32
    %3 = "vector.extract"(%0) <{static_position = array<i64: 1, 1, 1>}> : (vector<2x3x2xi32>) -> i32
    %4 = "vector.extract"(%0) <{static_position = array<i64: 1, 2, 0>}> : (vector<2x3x2xi32>) -> i32
    "func.return"(%1, %2, %3, %4) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3x2xi32>, vector<3x2xi32>, vector<2xi32>, vector<2xi32>), sym_name = "extract_vector_3d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[[0, 1], [2, 3], [4, 5]], [[6, 7], [8, 9], [10, 11]]]> : vector<2x3x2xi32>}> : () -> vector<2x3x2xi32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<2x3x2xi32>) -> vector<3x2xi32>
    %2 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<2x3x2xi32>) -> vector<3x2xi32>
    %3 = "vector.extract"(%0) <{static_position = array<i64: 1, 1>}> : (vector<2x3x2xi32>) -> vector<2xi32>
    %4 = "vector.extract"(%0) <{static_position = array<i64: 1, 2>}> : (vector<2x3x2xi32>) -> vector<2xi32>
    "func.return"(%1, %2, %3, %4) : (vector<3x2xi32>, vector<3x2xi32>, vector<2xi32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<2xi32>, vector<2xi32>, vector<2xi32>), sym_name = "extract_splat_vector_3d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[[0, 0], [1, 1], [2, 2]], [[3, 3], [4, 4], [5, 5]]]> : vector<2x3x2xi32>}> : () -> vector<2x3x2xi32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0, 0>}> : (vector<2x3x2xi32>) -> vector<2xi32>
    %2 = "vector.extract"(%0) <{static_position = array<i64: 1, 1>}> : (vector<2x3x2xi32>) -> vector<2xi32>
    %3 = "vector.extract"(%0) <{static_position = array<i64: 1, 2>}> : (vector<2x3x2xi32>) -> vector<2xi32>
    "func.return"(%1, %2, %3) : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3xi32>, vector<2xi32>, vector<1xi32>), sym_name = "extract_strided_slice_1d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<3xi32>) -> vector<3xi32>
    %2 = "vector.extract_strided_slice"(%0) <{offsets = [1], sizes = [2], strides = [1]}> : (vector<3xi32>) -> vector<2xi32>
    %3 = "vector.extract_strided_slice"(%0) <{offsets = [2], sizes = [1], strides = [1]}> : (vector<3xi32>) -> vector<1xi32>
    "func.return"(%1, %2, %3) : (vector<3xi32>, vector<2xi32>, vector<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<1x1xi32>, vector<1x2xi32>, vector<2x2xi32>), sym_name = "extract_strided_slice_2d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[0, 1, 2], [3, 4, 5]]> : vector<2x3xi32>}> : () -> vector<2x3xi32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x3xi32>) -> vector<1x1xi32>
    %2 = "vector.extract_strided_slice"(%0) <{offsets = [1, 1], sizes = [1, 2], strides = [1, 1]}> : (vector<2x3xi32>) -> vector<1x2xi32>
    %3 = "vector.extract_strided_slice"(%0) <{offsets = [0, 1], sizes = [2, 2], strides = [1, 1]}> : (vector<2x3xi32>) -> vector<2x2xi32>
    "func.return"(%1, %2, %3) : (vector<1x1xi32>, vector<1x2xi32>, vector<2x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<1x2x2xi32>, vector<1x1x2xi32>, vector<2x1x2xi32>, vector<1x1x1xi32>), sym_name = "extract_strided_slice_3d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[[0, 1], [2, 3]], [[4, 5], [6, 7]], [[8, 9], [10, 11]]]> : vector<3x2x2xi32>}> : () -> vector<3x2x2xi32>
    %1 = "vector.extract_strided_slice"(%0) <{offsets = [2], sizes = [1], strides = [1]}> : (vector<3x2x2xi32>) -> vector<1x2x2xi32>
    %2 = "vector.extract_strided_slice"(%0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<3x2x2xi32>) -> vector<1x1x2xi32>
    %3 = "vector.extract_strided_slice"(%0) <{offsets = [1, 1, 0], sizes = [2, 1, 2], strides = [1, 1, 1]}> : (vector<3x2x2xi32>) -> vector<2x1x2xi32>
    %4 = "vector.extract_strided_slice"(%0) <{offsets = [2, 1, 1], sizes = [1, 1, 1], strides = [1, 1, 1]}> : (vector<3x2x2xi32>) -> vector<1x1x1xi32>
    "func.return"(%1, %2, %3, %4) : (vector<1x2x2xi32>, vector<1x1x2xi32>, vector<2x1x2xi32>, vector<1x1x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32x16x4xf16>) -> vector<4xf16>, sym_name = "extract_extract_strided"}> ({
  ^bb0(%arg0: vector<32x16x4xf16>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [7, 3], sizes = [10, 8], strides = [1, 1]}> : (vector<32x16x4xf16>) -> vector<10x8x4xf16>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 2, 4>}> : (vector<10x8x4xf16>) -> vector<4xf16>
    "func.return"(%1) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<6x4xf32>, vector<8x16xf32>) -> f32, sym_name = "extract_insert_strided"}> ({
  ^bb0(%arg0: vector<6x4xf32>, %arg1: vector<8x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 2], strides = [1, 1]}> : (vector<6x4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 2, 4>}> : (vector<8x16xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<8x16xf32>) -> f32, sym_name = "extract_insert_rank_reduce"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<8x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [2, 2], strides = [1]}> : (vector<4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 2, 4>}> : (vector<8x16xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x15xf32>, vector<12x8x16xf32>) -> vector<16xf32>, sym_name = "negative_extract_insert"}> ({
  ^bb0(%arg0: vector<2x15xf32>, %arg1: vector<12x8x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg0, %arg1) <{offsets = [4, 2, 0], strides = [1, 1]}> : (vector<2x15xf32>, vector<12x8x16xf32>) -> vector<12x8x16xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 4, 2>}> : (vector<12x8x16xf32>) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x16xf32>, vector<12x8x16xf32>, vector<2x16xf32>) -> vector<16xf32>, sym_name = "extract_insert_chain"}> ({
  ^bb0(%arg0: vector<2x16xf32>, %arg1: vector<12x8x16xf32>, %arg2: vector<2x16xf32>):
    %0 = "vector.insert_strided_slice"(%arg2, %arg1) <{offsets = [4, 2, 0], strides = [1, 1]}> : (vector<2x16xf32>, vector<12x8x16xf32>) -> vector<12x8x16xf32>
    %1 = "vector.insert_strided_slice"(%arg0, %0) <{offsets = [0, 2, 0], strides = [1, 1]}> : (vector<2x16xf32>, vector<12x8x16xf32>) -> vector<12x8x16xf32>
    %2 = "vector.extract"(%1) <{static_position = array<i64: 4, 2>}> : (vector<12x8x16xf32>) -> vector<16xf32>
    "func.return"(%2) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>, index) -> f32, sym_name = "extract_from_extract_chain_should_not_fold_dynamic_extracts"}> ({
  ^bb0(%arg0: vector<2x4xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<2x4xf32>, index) -> vector<4xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 1>}> : (vector<4xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<4xf32>, sym_name = "extract_extract_strided2"}> ({
  ^bb0(%arg0: vector<2x4xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 4], strides = [1, 1]}> : (vector<2x4xf32>) -> vector<1x4xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0>}> : (vector<1x4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "splatlike_fold"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "vector.broadcast"(%0) : (f32) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "shuffle_1d"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = dense<[3, 4, 5]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 3, 2, 5, 1>}> : (vector<3xi32>, vector<3xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "shuffle_1d_dense_resource"}> ({
    %0 = "arith.constant"() <{value = dense_resource<__elided__> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = dense_resource<__elided__> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 3, 2, 5, 1>}> : (vector<3xi32>, vector<3xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "shuffle_1d_poison_idx"}> ({
    %0 = "arith.constant"() <{value = dense<[10, 11, 12]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = dense<[13, 14, 15]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 3, -1, 5, -1>}> : (vector<3xi32>, vector<3xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "shuffle_1d_rhs_lhs_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3xi32>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 3, 1, 5, 4>}> : (vector<3xi32>, vector<3xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "shuffle_1d_lhs_poison"}> ({
    %0 = "arith.constant"() <{value = dense<[11, 12, 13]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 3, 1, 5, 4>}> : (vector<3xi32>, vector<3xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "shuffle_1d_rhs_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = dense<[11, 12, 13]> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 3, 1, 5, 4>}> : (vector<3xi32>, vector<3xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>, vector<i32>) -> vector<1xi32>, sym_name = "shuffle_canonicalize_0d"}> ({
  ^bb0(%arg0: vector<i32>, %arg1: vector<i32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0>}> : (vector<i32>, vector<i32>) -> vector<1xi32>
    "func.return"(%0) : (vector<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<2xi32>) -> vector<4xi32>, sym_name = "shuffle_fold1"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<2xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1, 2, 3>}> : (vector<4xi32>, vector<2xi32>) -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<2xi32>) -> vector<2xi32>, sym_name = "shuffle_fold2"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<2xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 4, 5>}> : (vector<4xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5x6xi32>, vector<2x5x6xi32>) -> vector<4x5x6xi32>, sym_name = "shuffle_fold3"}> ({
  ^bb0(%arg0: vector<4x5x6xi32>, %arg1: vector<2x5x6xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1, 2, 3>}> : (vector<4x5x6xi32>, vector<2x5x6xi32>) -> vector<4x5x6xi32>
    "func.return"(%0) : (vector<4x5x6xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5x6xi32>, vector<2x5x6xi32>) -> vector<2x5x6xi32>, sym_name = "shuffle_fold4"}> ({
  ^bb0(%arg0: vector<4x5x6xi32>, %arg1: vector<2x5x6xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 4, 5>}> : (vector<4x5x6xi32>, vector<2x5x6xi32>) -> vector<2x5x6xi32>
    "func.return"(%0) : (vector<2x5x6xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<2xi32>) -> vector<5xi32>, sym_name = "shuffle_nofold1"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<2xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1, 2, 3, 4>}> : (vector<4xi32>, vector<2xi32>) -> vector<5xi32>
    "func.return"(%0) : (vector<5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<8x4xf32>, sym_name = "transpose_splatlike_constant"}> ({
    %0 = "arith.constant"() <{value = dense<5.000000e+00> : vector<4x8xf32>}> : () -> vector<4x8xf32>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 1, 0>}> : (vector<4x8xf32>) -> vector<8x4xf32>
    "func.return"(%1) : (vector<8x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<3x4xf32>, sym_name = "transpose_splatlike2"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<4x3xf32>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 1, 0>}> : (vector<4x3xf32>) -> vector<3x4xf32>
    "func.return"(%1) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4x6xi8>, sym_name = "transpose_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<6x4xi8>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 1, 0>}> : (vector<6x4xi8>) -> vector<4x6xi8>
    "func.return"(%1) : (vector<4x6xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3xi32>, vector<3xi32>, vector<3xi32>), sym_name = "insert_1d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = 9 : i32}> : () -> i32
    %2 = "vector.insert"(%1, %0) <{static_position = array<i64: 0>}> : (i32, vector<3xi32>) -> vector<3xi32>
    %3 = "vector.insert"(%1, %0) <{static_position = array<i64: 1>}> : (i32, vector<3xi32>) -> vector<3xi32>
    %4 = "vector.insert"(%1, %0) <{static_position = array<i64: 2>}> : (i32, vector<3xi32>) -> vector<3xi32>
    "func.return"(%2, %3, %4) : (vector<3xi32>, vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>), sym_name = "insert_2d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[0, 1, 2], [3, 4, 5]]> : vector<2x3xi32>}> : () -> vector<2x3xi32>
    %1 = "arith.constant"() <{value = 99 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<[90, 91, 92]> : vector<3xi32>}> : () -> vector<3xi32>
    %3 = "vector.insert"(%1, %0) <{static_position = array<i64: 0, 0>}> : (i32, vector<2x3xi32>) -> vector<2x3xi32>
    %4 = "vector.insert"(%1, %0) <{static_position = array<i64: 1, 2>}> : (i32, vector<2x3xi32>) -> vector<2x3xi32>
    %5 = "vector.insert"(%2, %0) <{static_position = array<i64: 0>}> : (vector<3xi32>, vector<2x3xi32>) -> vector<2x3xi32>
    %6 = "vector.insert"(%2, %0) <{static_position = array<i64: 1>}> : (vector<3xi32>, vector<2x3xi32>) -> vector<2x3xi32>
    "func.return"(%3, %4, %5, %6) : (vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi64>, i64, i64) -> vector<2xi64>, sym_name = "fully_insert_scalar_to_vector"}> ({
  ^bb0(%arg0: vector<2xi64>, %arg1: i64, %arg2: i64):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (i64, vector<2xi64>) -> vector<2xi64>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 1>}> : (i64, vector<2xi64>) -> vector<2xi64>
    "func.return"(%1) : (vector<2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2x2xi64>, sym_name = "fully_insert_vector_to_vector"}> ({
  ^bb0(%arg0: vector<2x2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 1>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    "func.return"(%1) : (vector<2x2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xi64>, vector<2xi64>, i64) -> vector<2x2xi64>, sym_name = "fully_insert_to_vector_overlap_1"}> ({
  ^bb0(%arg0: vector<2x2xi64>, %arg1: vector<2xi64>, %arg2: i64):
    %0 = "vector.insert"(%arg2, %arg0) <{static_position = array<i64: 0, 0>}> : (i64, vector<2x2xi64>) -> vector<2x2xi64>
    %1 = "vector.insert"(%arg1, %0) <{static_position = array<i64: 0>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    %2 = "vector.insert"(%arg1, %1) <{static_position = array<i64: 1>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    %3 = "vector.insert"(%arg2, %2) <{static_position = array<i64: 1, 1>}> : (i64, vector<2x2xi64>) -> vector<2x2xi64>
    "func.return"(%3) : (vector<2x2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xi64>, i64, i64, vector<2xi64>, vector<2xi64>) -> vector<2x2xi64>, sym_name = "fully_insert_to_vector_overlap_2"}> ({
  ^bb0(%arg0: vector<2x2xi64>, %arg1: i64, %arg2: i64, %arg3: vector<2xi64>, %arg4: vector<2xi64>):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0, 0>}> : (i64, vector<2x2xi64>) -> vector<2x2xi64>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 0, 1>}> : (i64, vector<2x2xi64>) -> vector<2x2xi64>
    %2 = "vector.insert"(%arg3, %1) <{static_position = array<i64: 0>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    %3 = "vector.insert"(%arg4, %2) <{static_position = array<i64: 1>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    "func.return"(%3) : (vector<2x2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xi64>, vector<2xi64>, i64) -> vector<2x2xi64>, sym_name = "negative_partially_insert_vector_to_vector"}> ({
  ^bb0(%arg0: vector<2x2xi64>, %arg1: vector<2xi64>, %arg2: i64):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (vector<2xi64>, vector<2x2xi64>) -> vector<2x2xi64>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 0, 0>}> : (i64, vector<2x2xi64>) -> vector<2x2xi64>
    "func.return"(%1) : (vector<2x2xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi64>, i64, i64, i64, i64) -> (vector<3xi64>, vector<3xi64>), sym_name = "negative_intermediate_insert_multiple_users"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (i64, vector<3xi64>) -> vector<3xi64>
    %1 = "vector.insert"(%arg2, %0) <{static_position = array<i64: 1>}> : (i64, vector<3xi64>) -> vector<3xi64>
    %2 = "vector.insert"(%arg3, %1) <{static_position = array<i64: 2>}> : (i64, vector<3xi64>) -> vector<3xi64>
    %3 = "vector.insert"(%arg4, %1) <{static_position = array<i64: 2>}> : (i64, vector<3xi64>) -> vector<3xi64>
    "func.return"(%2, %3) : (vector<3xi64>, vector<3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>), sym_name = "insert_2d_splat_constant"}> ({
    %0 = "arith.constant"() <{value = dense<0> : vector<2x3xi32>}> : () -> vector<2x3xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 99 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = dense<33> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "vector.insert"(%1, %0) <{static_position = array<i64: 0, 0>}> : (i32, vector<2x3xi32>) -> vector<2x3xi32>
    %5 = "vector.insert"(%2, %0) <{static_position = array<i64: 0, 0>}> : (i32, vector<2x3xi32>) -> vector<2x3xi32>
    %6 = "vector.insert"(%2, %0) <{static_position = array<i64: 1, 1>}> : (i32, vector<2x3xi32>) -> vector<2x3xi32>
    %7 = "vector.insert"(%3, %0) <{static_position = array<i64: 0>}> : (vector<3xi32>, vector<2x3xi32>) -> vector<2x3xi32>
    %8 = "vector.insert"(%3, %0) <{static_position = array<i64: 1>}> : (vector<3xi32>, vector<2x3xi32>) -> vector<2x3xi32>
    "func.return"(%4, %5, %6, %7, %8) : (vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>, vector<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>) -> f32, sym_name = "reduce_one_element_vector_extract"}> ({
  ^bb0(%arg0: vector<1xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<1xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, vector<1xi1>) -> f32, sym_name = "masked_reduce_one_element_vector_extract"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: vector<1xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<1xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<1xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> f32, sym_name = "reduce_one_element_vector_addf"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<1xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> f32, sym_name = "reduce_one_element_vector_addf_fastmath"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<nnan,ninf>, kind = #vector.kind<add>}> : (vector<1xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32, vector<1xi1>) -> f32, sym_name = "masked_reduce_one_element_vector_addf"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32, %arg2: vector<1xi1>):
    %0 = "vector.mask"(%arg2) ({
      %1 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<1xf32>, f32) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<1xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> f32, sym_name = "reduce_one_element_vector_mulf"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<1xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> f32, sym_name = "dont_reduce_one_element_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<4xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf32>, f32) -> f32, sym_name = "reduce_one_element_vector_maximumf"}> ({
  ^bb0(%arg0: vector<1xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maximumf>}> : (vector<1xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<4x16xi16>, sym_name = "bitcast"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "vector.bitcast"(%arg0) : (vector<4x8xf32>) -> vector<4x8xi32>
    %1 = "vector.bitcast"(%0) : (vector<4x8xi32>) -> vector<4x16xi16>
    "func.return"(%1) : (vector<4x16xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<8x16xf32>, sym_name = "insert_strided_slice_splatlike"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<4x4xf32>
    %1 = "vector.broadcast"(%arg0) : (f32) -> vector<8x16xf32>
    %2 = "vector.insert_strided_slice"(%0, %1) <{offsets = [2, 2], strides = [1, 1]}> : (vector<4x4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%2) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf32>) -> vector<8x16xf32>, sym_name = "insert_extract_strided_slice"}> ({
  ^bb0(%arg0: vector<8x16xf32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 8], sizes = [2, 4], strides = [1, 1]}> : (vector<8x16xf32>) -> vector<2x4xf32>
    %1 = "vector.insert_strided_slice"(%0, %arg0) <{offsets = [0, 8], strides = [1, 1]}> : (vector<2x4xf32>, vector<8x16xf32>) -> vector<8x16xf32>
    "func.return"(%1) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>), sym_name = "insert_strided_1d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 1, 2]> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = dense<4> : vector<1xi32>}> : () -> vector<1xi32>
    %2 = "arith.constant"() <{value = dense<[5, 6]> : vector<2xi32>}> : () -> vector<2xi32>
    %3 = "arith.constant"() <{value = dense<[7, 8, 9]> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "vector.insert_strided_slice"(%1, %0) <{offsets = [0], strides = [1]}> : (vector<1xi32>, vector<3xi32>) -> vector<3xi32>
    %5 = "vector.insert_strided_slice"(%1, %0) <{offsets = [2], strides = [1]}> : (vector<1xi32>, vector<3xi32>) -> vector<3xi32>
    %6 = "vector.insert_strided_slice"(%2, %0) <{offsets = [0], strides = [1]}> : (vector<2xi32>, vector<3xi32>) -> vector<3xi32>
    %7 = "vector.insert_strided_slice"(%2, %0) <{offsets = [1], strides = [1]}> : (vector<2xi32>, vector<3xi32>) -> vector<3xi32>
    %8 = "vector.insert_strided_slice"(%3, %0) <{offsets = [0], strides = [1]}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%4, %5, %6, %7, %8) : (vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>), sym_name = "insert_strided_2d_constant"}> ({
    %0 = "arith.constant"() <{value = dense<[[0, 1], [2, 3], [4, 5]]> : vector<3x2xi32>}> : () -> vector<3x2xi32>
    %1 = "arith.constant"() <{value = dense<9> : vector<1xi32>}> : () -> vector<1xi32>
    %2 = "arith.constant"() <{value = dense<[18, 19]> : vector<2xi32>}> : () -> vector<2xi32>
    %3 = "arith.constant"() <{value = dense<[[28, 29], [38, 39]]> : vector<2x2xi32>}> : () -> vector<2x2xi32>
    %4 = "vector.insert_strided_slice"(%1, %0) <{offsets = [1, 0], strides = [1]}> : (vector<1xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    %5 = "vector.insert_strided_slice"(%1, %0) <{offsets = [2, 1], strides = [1]}> : (vector<1xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    %6 = "vector.insert_strided_slice"(%2, %0) <{offsets = [0, 0], strides = [1]}> : (vector<2xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    %7 = "vector.insert_strided_slice"(%2, %0) <{offsets = [1, 0], strides = [1]}> : (vector<2xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    %8 = "vector.insert_strided_slice"(%2, %0) <{offsets = [2, 0], strides = [1]}> : (vector<2xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    %9 = "vector.insert_strided_slice"(%3, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<2x2xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    %10 = "vector.insert_strided_slice"(%3, %0) <{offsets = [1, 0], strides = [1, 1]}> : (vector<2x2xi32>, vector<3x2xi32>) -> vector<3x2xi32>
    "func.return"(%4, %5, %6, %7, %8, %9, %10) : (vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>, vector<3x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> vector<4xi32>, sym_name = "shuffle_splatlike"}> ({
  ^bb0(%arg0: i32):
    %0 = "vector.broadcast"(%arg0) : (i32) -> vector<4xi32>
    %1 = "vector.broadcast"(%arg0) : (i32) -> vector<2xi32>
    %2 = "vector.shuffle"(%0, %1) <{mask = array<i64: 2, 3, 4, 5>}> : (vector<4xi32>, vector<2xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> vector<2x4x3xi32>, sym_name = "insert_splatlike"}> ({
  ^bb0(%arg0: i32):
    %0 = "vector.broadcast"(%arg0) : (i32) -> vector<4x3xi32>
    %1 = "vector.broadcast"(%arg0) : (i32) -> vector<2x4x3xi32>
    %2 = "vector.insert"(%0, %1) <{static_position = array<i64: 0>}> : (vector<4x3xi32>, vector<2x4x3xi32>) -> vector<2x4x3xi32>
    "func.return"(%2) : (vector<2x4x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x8x8x8xf32>, index, index, index, index) -> vector<4xf32>, sym_name = "transfer_read_from_rank_reducing_extract_slice"}> ({
  ^bb0(%arg0: tensor<1x8x8x8xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.extract_slice"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 4, 1, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x8x8x8xf32>, index, index, index) -> tensor<1x4x4xf32>
    %3 = "vector.transfer_read"(%2, %0, %arg4, %0, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (tensor<1x4x4xf32>, index, index, index, f32) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1xf32>) -> vector<1xf32>, sym_name = "extract_from_broadcast"}> ({
  ^bb0(%arg1: vector<1x1x1xf32>):
    %2 = "vector.broadcast"(%arg1) : (vector<1x1x1xf32>) -> vector<1x1x32x1xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0, 0, 31>}> : (vector<1x1x32x1xf32>) -> vector<1xf32>
    "func.return"(%3) : (vector<1xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1x2xf32>) -> f32, sym_name = "extract_from_stretch_broadcast"}> ({
  ^bb0(%arg0: vector<3x1x2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<3x1x2xf32>) -> vector<3x4x2xf32>
    %1 = "vector.extract"(%0) <{static_position = array<i64: 0, 2, 0>}> : (vector<3x4x2xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<5x7xi1>, sym_name = "extract_strided_slice_of_constant_mask"}> ({
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "vector.create_mask"(%1, %0) : (index, index) -> vector<12x7xi1>
    %3 = "vector.extract_strided_slice"(%2) <{offsets = [3], sizes = [5], strides = [1]}> : (vector<12x7xi1>) -> vector<5x7xi1>
    "func.return"(%3) : (vector<5x7xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> f32, sym_name = "fold_0d_vector_reduction"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xi1>) -> (), sym_name = "empty_vector_mask"}> ({
  ^bb0(%arg0: vector<8xi1>):
    "vector.mask"(%arg0) ({
      "vector.yield"() : () -> ()
    }) : (vector<8xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<8xi1>) -> vector<8xf32>, sym_name = "empty_vector_mask_with_return"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xi1>):
    %0 = "vector.mask"(%arg1) ({
      "vector.yield"(%arg0) : (vector<8xf32>) -> ()
    }) : (vector<8xi1>) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>, sym_name = "empty_vector_mask_with_passthru"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xi1>, %arg2: vector<8xf32>):
    %0 = "vector.mask"(%arg1, %arg2) ({
      "vector.yield"(%arg0) : (vector<8xf32>) -> ()
    }) : (vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4xf32>) -> vector<3x4xf32>, sym_name = "all_true_vector_mask"}> ({
  ^bb0(%arg0: tensor<3x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 3, 4>}> : () -> vector<3x4xi1>
    %3 = "vector.mask"(%2) ({
      %4 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<3x4xf32>, index, index, f32) -> vector<3x4xf32>
      "vector.yield"(%4) : (vector<3x4xf32>) -> ()
    }) : (vector<3x4xi1>) -> vector<3x4xf32>
    "func.return"(%3) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x4xf32>, memref<3x4xf32>) -> (), sym_name = "all_true_vector_mask_no_result"}> ({
  ^bb0(%arg0: vector<3x4xf32>, %arg1: memref<3x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 3, 4>}> : () -> vector<3x4xi1>
    "vector.mask"(%1) ({
      "vector.transfer_write"(%arg0, %arg1, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3x4xf32>, memref<3x4xf32>, index, index) -> ()
      "vector.yield"() : () -> ()
    }) : (vector<3x4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>) -> vector<1x4xi1>, sym_name = "fold_shape_cast_with_mask"}> ({
  ^bb0(%arg0: tensor<1x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1x?xf32>, index) -> index
    %2 = "vector.create_mask"(%0, %1, %0, %0) : (index, index, index, index) -> vector<1x4x1x1xi1>
    %3 = "vector.shape_cast"(%2) : (vector<1x4x1x1xi1>) -> vector<1x4xi1>
    "func.return"(%3) : (vector<1x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>) -> vector<1x[4]xi1>, sym_name = "fold_shape_cast_with_mask_scalable"}> ({
  ^bb0(%arg0: tensor<1x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1x?xf32>, index) -> index
    %2 = "vector.create_mask"(%0, %1, %0, %0) : (index, index, index, index) -> vector<1x[4]x1x1xi1>
    %3 = "vector.shape_cast"(%2) : (vector<1x[4]x1x1xi1>) -> vector<1x[4]xi1>
    "func.return"(%3) : (vector<1x[4]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>) -> vector<1x[1]xi1>, sym_name = "fold_shape_cast_with_mask_scalable_one"}> ({
  ^bb0(%arg0: tensor<1x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<1x?xf32>, index) -> index
    %2 = "vector.create_mask"(%0, %1, %0) : (index, index, index) -> vector<1x[1]x1xi1>
    %3 = "vector.shape_cast"(%2) : (vector<1x[1]x1xi1>) -> vector<1x[1]xi1>
    "func.return"(%3) : (vector<1x[1]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "fold_shape_cast_with_constant_mask"}> ({
    %0 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 1, 1, 1>}> : () -> vector<4x1x1xi1>
    %1 = "vector.shape_cast"(%0) : (vector<4x1x1xi1>) -> vector<4xi1>
    "func.return"(%1) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d1, 0, d2, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1x1xf32>, tensor<4x4x4xf32>) -> vector<1x100x4x5xf32>, sym_name = "load_store_forwarding_rank_mismatch"}> ({
  ^bb0(%arg0: vector<4x1x1xf32>, %arg1: tensor<4x4x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_write"(%arg0, %arg1, %0, %0, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<4x1x1xf32>, tensor<4x4x4xf32>, index, index, index) -> tensor<4x4x4xf32>
    %3 = "vector.transfer_read"(%2, %0, %0, %0, %1) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<4x4x4xf32>, index, index, index, f32) -> vector<1x100x4x5xf32>
    "func.return"(%3) : (vector<1x100x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f64>, vector<f64>) -> vector<2xf64>, sym_name = "rank_0_shuffle_to_interleave"}> ({
  ^bb0(%arg0: vector<f64>, %arg1: vector<f64>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1>}> : (vector<f64>, vector<f64>) -> vector<2xf64>
    "func.return"(%0) : (vector<2xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<6xi32>, vector<6xi32>) -> vector<12xi32>, sym_name = "rank_1_shuffle_to_interleave"}> ({
  ^bb0(%arg0: vector<6xi32>, %arg1: vector<6xi32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 11>}> : (vector<6xi32>, vector<6xi32>) -> vector<12xi32>
    "func.return"(%0) : (vector<12xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<f32>, vector<2xf32>) -> (f32, f32, f32, f32, vector<6x7xf32>, vector<3xf32>), sym_name = "extract_from_splatlike_broadcast"}> ({
  ^bb0(%arg0: f32, %arg1: vector<f32>, %arg2: vector<2xf32>):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<f32>
    %1 = "vector.extract"(%0) <{static_position = array<i64>}> : (vector<f32>) -> f32
    %2 = "vector.broadcast"(%arg1) : (vector<f32>) -> vector<1x2x4xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0, 0, 1>}> : (vector<1x2x4xf32>) -> f32
    %4 = "vector.broadcast"(%arg0) : (f32) -> vector<2x3xf32>
    %5 = "vector.extract"(%4) <{static_position = array<i64: 0, 1>}> : (vector<2x3xf32>) -> f32
    %6 = "vector.broadcast"(%arg0) : (f32) -> vector<5x6x7xf32>
    %7 = "vector.extract"(%6) <{static_position = array<i64: 2, 1, 5>}> : (vector<5x6x7xf32>) -> f32
    %8 = "vector.extract"(%6) <{static_position = array<i64: 2>}> : (vector<5x6x7xf32>) -> vector<6x7xf32>
    %9 = "vector.extract"(%4) <{static_position = array<i64: 1>}> : (vector<2x3xf32>) -> vector<3xf32>
    "func.return"(%1, %3, %5, %7, %8, %9) : (f32, f32, f32, f32, vector<6x7xf32>, vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (f32, f32), sym_name = "to_elements_from_elements_no_op"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "vector.from_elements"(%arg1, %arg0) : (f32, f32) -> vector<2xf32>
    %1:2 = "vector.to_elements"(%0) : (vector<2xf32>) -> (f32, f32)
    "func.return"(%1#0, %1#1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x2xf32>) -> vector<4x2xf32>, sym_name = "from_elements_to_elements_no_op"}> ({
  ^bb0(%arg0: vector<4x2xf32>):
    %0:8 = "vector.to_elements"(%arg0) : (vector<4x2xf32>) -> (f32, f32, f32, f32, f32, f32, f32, f32)
    %1 = "vector.from_elements"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5, %0#6, %0#7) : (f32, f32, f32, f32, f32, f32, f32, f32) -> vector<4x2xf32>
    "func.return"(%1) : (vector<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4x2xf32>, sym_name = "from_elements_to_elements_dup_elems"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0:4 = "vector.to_elements"(%arg0) : (vector<4xf32>) -> (f32, f32, f32, f32)
    %1 = "vector.from_elements"(%0#0, %0#1, %0#2, %0#3, %0#0, %0#1, %0#2, %0#3) : (f32, f32, f32, f32, f32, f32, f32, f32) -> vector<4x2xf32>
    "func.return"(%1) : (vector<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x2xf32>) -> vector<4x2xf32>, sym_name = "from_elements_to_elements_shuffle"}> ({
  ^bb0(%arg0: vector<4x2xf32>):
    %0:8 = "vector.to_elements"(%arg0) : (vector<4x2xf32>) -> (f32, f32, f32, f32, f32, f32, f32, f32)
    %1 = "vector.from_elements"(%0#7, %0#0, %0#6, %0#1, %0#5, %0#2, %0#4, %0#3) : (f32, f32, f32, f32, f32, f32, f32, f32) -> vector<4x2xf32>
    "func.return"(%1) : (vector<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "to_elements_of_scalar_broadcast_folds"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<4xf32>
    %1:4 = "vector.to_elements"(%0) : (vector<4xf32>) -> (f32, f32, f32, f32)
    "func.return"(%1#0, %1#1, %1#2, %1#3) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (f32, f32, f32, f32, f32, f32), sym_name = "to_elements_of_vector_broadcast"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2xf32>) -> vector<3x2xf32>
    %1:6 = "vector.to_elements"(%0) : (vector<3x2xf32>) -> (f32, f32, f32, f32, f32, f32)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5) : (f32, f32, f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1x2xf32>) -> (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32), sym_name = "to_elements_of_vector_broadcast_inner_dim"}> ({
  ^bb0(%arg0: vector<2x1x2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2x1x2xf32>) -> vector<2x3x2xf32>
    %1:12 = "vector.to_elements"(%0) : (vector<2x3x2xf32>) -> (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5, %1#6, %1#7, %1#8, %1#9, %1#10, %1#11) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2x2xi32>, sym_name = "from_elements_to_constant"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %4 = "vector.from_elements"(%0, %1, %2, %3) : (i32, i32, i32, i32) -> vector<2x2xi32>
    "func.return"(%4) : (vector<2x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<2xf32>, sym_name = "negative_from_elements_to_constant"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "vector.from_elements"(%arg0, %0) : (f32, f32) -> vector<2xf32>
    "func.return"(%1) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = i32, linkage = #llvm.linkage<external>, sym_name = "my_symbol", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<1x!llvm.ptr>, sym_name = "negative_from_elements_to_constant"}> ({
    %0 = "llvm.mlir.addressof"() <{global_name = @my_symbol}> : () -> !llvm.ptr
    %1 = "vector.from_elements"(%0) : (!llvm.ptr) -> vector<1x!llvm.ptr>
    "func.return"(%1) : (vector<1x!llvm.ptr>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2xf32>, sym_name = "negative_from_elements_poison_f32"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %1 = "vector.from_elements"(%0, %0) : (f32, f32) -> vector<2xf32>
    "func.return"(%1) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2xi32>, sym_name = "negative_from_elements_poison_i32"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "vector.from_elements"(%0, %0) : (i32, i32) -> vector<2xi32>
    "func.return"(%1) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<2xf32>, sym_name = "negative_from_elements_poison_constant_mix"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "vector.from_elements"(%0, %1) : (f32, f32) -> vector<2xf32>
    "func.return"(%2) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<6xi8>, sym_name = "from_elements_float8_to_i8_conversion"}> ({
    %14 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f8E4M3FN}> : () -> i8
    %15 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f8E4M3FN}> : () -> i8
    %16 = "llvm.mlir.constant"() <{value = -1.000000e+00 : f8E4M3FN}> : () -> i8
    %17 = "llvm.mlir.constant"() <{value = 3.250000e+00 : f8E4M3FN}> : () -> i8
    %18 = "llvm.mlir.constant"() <{value = 0x7F : f8E4M3FN}> : () -> i8
    %19 = "llvm.mlir.constant"() <{value = 0xFF : f8E4M3FN}> : () -> i8
    %20 = "vector.from_elements"(%14, %15, %16, %17, %18, %19) : (i8, i8, i8, i8, i8, i8) -> vector<6xi8>
    "func.return"(%20) : (vector<6xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<6xi16>, sym_name = "from_elements_float16_to_i16_conversion"}> ({
    %7 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f16}> : () -> i16
    %8 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f16}> : () -> i16
    %9 = "llvm.mlir.constant"() <{value = -1.000000e+00 : f16}> : () -> i16
    %10 = "llvm.mlir.constant"() <{value = 3.140630e+00 : f16}> : () -> i16
    %11 = "llvm.mlir.constant"() <{value = 6.550400e+04 : f16}> : () -> i16
    %12 = "llvm.mlir.constant"() <{value = -6.550400e+04 : f16}> : () -> i16
    %13 = "vector.from_elements"(%7, %8, %9, %10, %11, %12) : (i16, i16, i16, i16, i16, i16) -> vector<6xi16>
    "func.return"(%13) : (vector<6xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<6xi64>, sym_name = "from_elements_f64_to_i64_conversion"}> ({
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f64}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = -1.000000e+00 : f64}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 3.140000e+00 : f64}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = 1.7976931348623157E+308 : f64}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = -1.7976931348623157E+308 : f64}> : () -> i64
    %6 = "vector.from_elements"(%0, %1, %2, %3, %4, %5) : (i64, i64, i64, i64, i64, i64) -> vector<6xi64>
    "func.return"(%6) : (vector<6xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<1xi8>, sym_name = "from_elements_i1_to_i8_conversion"}> ({
    %0 = "llvm.mlir.constant"() <{value = false}> : () -> i8
    %1 = "vector.from_elements"(%0) : (i8) -> vector<1xi8>
    "func.return"(%1) : (vector<1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xi64>, sym_name = "from_elements_index_to_i64_conversion"}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %3 = "vector.from_elements"(%0, %1, %2) : (i64, i64, i64) -> vector<3xi64>
    "func.return"(%3) : (vector<3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> vector<2xi32>, sym_name = "transpose_from_elements_1d"}> ({
  ^bb0(%arg18: i32, %arg19: i32):
    %4 = "vector.from_elements"(%arg18, %arg19) : (i32, i32) -> vector<2xi32>
    %5 = "vector.transpose"(%4) <{permutation = array<i64: 0>}> : (vector<2xi32>) -> vector<2xi32>
    "func.return"(%5) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i32) -> vector<3x2xi32>, sym_name = "transpose_from_elements_2d"}> ({
  ^bb0(%arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32, %arg16: i32, %arg17: i32):
    %2 = "vector.from_elements"(%arg12, %arg13, %arg14, %arg15, %arg16, %arg17) : (i32, i32, i32, i32, i32, i32) -> vector<2x3xi32>
    %3 = "vector.transpose"(%2) <{permutation = array<i64: 1, 0>}> : (vector<2x3xi32>) -> vector<3x2xi32>
    "func.return"(%3) : (vector<3x2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> vector<2x2x3xi32>, sym_name = "transpose_from_elements_3d"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32):
    %0 = "vector.from_elements"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11) : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> vector<2x3x2xi32>
    %1 = "vector.transpose"(%0) <{permutation = array<i64: 0, 2, 1>}> : (vector<2x3x2xi32>) -> vector<2x2x3xi32>
    "func.return"(%1) : (vector<2x2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> vector<4xi8>, sym_name = "negative_insert_llvm_undef"}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.mlir.undef"() : () -> vector<4xi8>
    %1 = "vector.insert"(%arg0, %0) <{static_position = array<i64: 0>}> : (i8, vector<4xi8>) -> vector<4xi8>
    "func.return"(%1) : (vector<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<4x8xf32>, sym_name = "insert_scalar_poison"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %1 = "vector.insert"(%0, %arg0) <{static_position = array<i64: 2, 3>}> : (f32, vector<4x8xf32>) -> vector<4x8xf32>
    "func.return"(%1) : (vector<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x8xf32>) -> vector<4x8xf32>, sym_name = "insert_vector_poison"}> ({
  ^bb0(%arg0: vector<4x8xf32>):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> vector<8xf32>
    %1 = "vector.insert"(%0, %arg0) <{static_position = array<i64: 2>}> : (vector<8xf32>, vector<4x8xf32>) -> vector<4x8xf32>
    "func.return"(%1) : (vector<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>, f32) -> vector<4x5xf32>, sym_name = "insert_scalar_poison_idx"}> ({
  ^bb0(%arg0: vector<4x5xf32>, %arg1: f32):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: -1, 0>}> : (f32, vector<4x5xf32>) -> vector<4x5xf32>
    "func.return"(%0) : (vector<4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>, vector<5xf32>) -> vector<4x5xf32>, sym_name = "insert_vector_poison_idx"}> ({
  ^bb0(%arg0: vector<4x5xf32>, %arg1: vector<5xf32>):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: -1>}> : (vector<5xf32>, vector<4x5xf32>) -> vector<4x5xf32>
    "func.return"(%0) : (vector<4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>, vector<5xf32>) -> vector<4x5xf32>, sym_name = "insert_vector_poison_idx_non_cst"}> ({
  ^bb0(%arg0: vector<4x5xf32>, %arg1: vector<5xf32>):
    %0 = "arith.constant"() <{value = -1 : index}> : () -> index
    %1 = "vector.insert"(%arg1, %arg0, %0) <{static_position = array<i64: -9223372036854775808>}> : (vector<5xf32>, vector<4x5xf32>, index) -> vector<4x5xf32>
    "func.return"(%1) : (vector<4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5xf32>, vector<5xf32>) -> vector<4x5xf32>, sym_name = "no_fold_insert_scalar_idx_oob"}> ({
  ^bb0(%arg0: vector<4x5xf32>, %arg1: vector<5xf32>):
    %0 = "arith.constant"() <{value = -2 : index}> : () -> index
    %1 = "vector.insert"(%arg1, %arg0, %0) <{static_position = array<i64: -9223372036854775808>}> : (vector<5xf32>, vector<4x5xf32>, index) -> vector<4x5xf32>
    "func.return"(%1) : (vector<4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x5x8xf32>, vector<8xf32>) -> vector<4x5x8xf32>, sym_name = "insert_multiple_poison_idx"}> ({
  ^bb0(%arg0: vector<4x5x8xf32>, %arg1: vector<8xf32>):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: -1, -1>}> : (vector<8xf32>, vector<4x5x8xf32>) -> vector<4x5x8xf32>
    "func.return"(%0) : (vector<4x5x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x1x2x1x1x4xi32>) -> vector<4xi32>, sym_name = "contiguous_extract_strided_slices_to_extract_sizes_and_outer_source_dims_overlap"}> ({
  ^bb0(%arg0: vector<8x1x2x1x1x4xi32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0, 0, 0, 0, 0], sizes = [1, 1, 1, 1, 1, 4], strides = [1, 1, 1, 1, 1, 1]}> : (vector<8x1x2x1x1x4xi32>) -> vector<1x1x1x1x1x4xi32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x1x1x1x4xi32>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x2x4xi32>) -> vector<4xi32>, sym_name = "contiguous_extract_strided_slices_to_extract_sizes_and_outer_source_dims_no_overlap"}> ({
  ^bb0(%arg0: vector<8x2x4xi32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<8x2x4xi32>) -> vector<1x1x4xi32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x4xi32>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x1x2x1x1x4xi32>) -> vector<1x4xi32>, sym_name = "contiguous_extract_strided_slices_to_extract_shorter_size_list"}> ({
  ^bb0(%arg0: vector<8x1x2x1x1x4xi32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0, 0, 0, 0], sizes = [1, 1, 1, 1, 1], strides = [1, 1, 1, 1, 1]}> : (vector<8x1x2x1x1x4xi32>) -> vector<1x1x1x1x1x4xi32>
    %1 = "vector.shape_cast"(%0) : (vector<1x1x1x1x1x4xi32>) -> vector<1x4xi32>
    "func.return"(%1) : (vector<1x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x1x2x1x1x4xi32>) -> vector<8x1x1x1x1x4xi32>, sym_name = "contiguous_extract_strided_slices_to_extract_failure_non_unit_outer_size"}> ({
  ^bb0(%arg0: vector<8x1x2x1x1x4xi32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0, 0, 0, 0, 0], sizes = [8, 1, 1, 1, 1, 4], strides = [1, 1, 1, 1, 1, 1]}> : (vector<8x1x2x1x1x4xi32>) -> vector<8x1x1x1x1x4xi32>
    "func.return"(%0) : (vector<8x1x1x1x1x4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x1x2x1x1x4xi32>) -> vector<1x1x1x1x1x2xi32>, sym_name = "contiguous_extract_strided_slices_to_extract_failure_non_full_size"}> ({
  ^bb0(%arg0: vector<8x1x2x1x1x4xi32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0, 0, 0, 0, 0], sizes = [1, 1, 1, 1, 1, 2], strides = [1, 1, 1, 1, 1, 1]}> : (vector<8x1x2x1x1x4xi32>) -> vector<1x1x1x1x1x2xi32>
    "func.return"(%0) : (vector<1x1x1x1x1x2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x1x2x1x1x4xi32>) -> vector<1x1x2x1x1x1xi32>, sym_name = "contiguous_extract_strided_slices_to_extract_failure_non_full_inner_size"}> ({
  ^bb0(%arg0: vector<8x1x2x1x1x4xi32>):
    %0 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0, 0, 0, 0, 0], sizes = [1, 1, 2, 1, 1, 1], strides = [1, 1, 1, 1, 1, 1]}> : (vector<8x1x2x1x1x4xi32>) -> vector<1x1x2x1x1x1xi32>
    "func.return"(%0) : (vector<1x1x2x1x1x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "contiguous_gather"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>}> : () -> vector<16xi32>
    %2 = "vector.gather"(%arg0, %0, %1, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%2) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "contiguous_gather_non_zero_start"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<16xi32>}> : () -> vector<16xi32>
    %2 = "vector.gather"(%arg0, %0, %1, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%2) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, vector<4x4xi1>, vector<4x4xf32>) -> vector<4x4xf32>, sym_name = "contiguous_gather_2d"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: vector<4x4xi1>, %arg2: vector<4x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]]> : vector<4x4xi32>}> : () -> vector<4x4xi32>
    %2 = "vector.gather"(%arg0, %0, %0, %1, %arg1, %arg2) : (memref<?x?xf32>, index, index, vector<4x4xi32>, vector<4x4xi1>, vector<4x4xf32>) -> vector<4x4xf32>
    "func.return"(%2) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xf32>) -> vector<16xf32>, sym_name = "contiguous_gather_const_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>}> : () -> vector<16xi32>
    %2 = "arith.constant"() <{value = dense<true> : vector<16xi1>}> : () -> vector<16xi1>
    %3 = "vector.gather"(%arg0, %0, %1, %2, %arg1) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%3) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "contiguous_gather_step"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.step"() : () -> vector<16xindex>
    %2 = "vector.gather"(%arg0, %0, %1, %arg1, %arg2) : (memref<?xf32>, index, vector<16xindex>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%2) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8xf32>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>, sym_name = "no_fold_contiguous_gather_tensor"}> ({
  ^bb0(%arg0: tensor<8xf32>, %arg1: vector<4xi1>, %arg2: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    %2 = "vector.gather"(%arg0, %0, %1, %arg1, %arg2) : (tensor<8xf32>, index, vector<4xindex>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "gather_broadcast"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<0> : vector<16xi32>}> : () -> vector<16xi32>
    %2 = "vector.gather"(%arg0, %0, %1, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%2) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "contiguous_scatter"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>}> : () -> vector<16xi32>
    "vector.scatter"(%arg0, %0, %1, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xf32>) -> (), sym_name = "contiguous_scatter_const_mask"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>}> : () -> vector<16xi32>
    %2 = "vector.constant_mask"() <{mask_dim_sizes = array<i64: 16>}> : () -> vector<16xi1>
    "vector.scatter"(%arg0, %0, %1, %2, %arg1) : (memref<?xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "contiguous_scatter_step"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.step"() : () -> vector<16xindex>
    "vector.scatter"(%arg0, %0, %1, %arg1, %arg2) : (memref<?xf32>, index, vector<16xindex>, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16xf32>, vector<16xi1>, vector<16xf32>) -> tensor<16xf32>, sym_name = "no_fold_contiguous_scatter_tensor"}> ({
  ^bb0(%arg0: tensor<16xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>}> : () -> vector<16xi32>
    %2 = "vector.scatter"(%arg0, %0, %1, %arg1, %arg2) : (tensor<16xf32>, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> tensor<16xf32>
    "func.return"(%2) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xindex>, vector<16xf32>) -> (), sym_name = "scatter_memref_all_false"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xindex>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<false> : vector<16xi1>}> : () -> vector<16xi1>
    "vector.scatter"(%arg0, %0, %arg1, %1, %arg2) : (memref<?xf32>, index, vector<16xindex>, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16xf32>, vector<16xindex>, vector<16xf32>) -> tensor<16xf32>, sym_name = "scatter_tensor_all_false"}> ({
  ^bb0(%arg0: tensor<16xf32>, %arg1: vector<16xindex>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = dense<false> : vector<16xi1>}> : () -> vector<16xi1>
    %2 = "vector.scatter"(%arg0, %0, %arg1, %1, %arg2) : (tensor<16xf32>, index, vector<16xindex>, vector<16xi1>, vector<16xf32>) -> tensor<16xf32>
    "func.return"(%2) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32x1xi32>) -> i32, sym_name = "fold_extract_constant_indices"}> ({
  ^bb0(%arg0: vector<32x1xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.extract"(%arg0, %0, %0) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<32x1xi32>, index, index) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1xi32>) -> vector<4x1xi32>, sym_name = "fold_insert_constant_indices"}> ({
  ^bb0(%arg0: vector<4x1xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "vector.insert"(%1, %arg0, %0, %0) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (i32, vector<4x1xi32>, index, index) -> vector<4x1xi32>
    "func.return"(%2) : (vector<4x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xf32>, f32, index) -> vector<4x4xf32>, sym_name = "fold_insert_use_chain"}> ({
  ^bb0(%arg0: vector<4x4xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: -9223372036854775808, 0>}> : (f32, vector<4x4xf32>, index) -> vector<4x4xf32>
    %1 = "vector.insert"(%arg1, %0, %arg2) <{static_position = array<i64: -9223372036854775808, 0>}> : (f32, vector<4x4xf32>, index) -> vector<4x4xf32>
    %2 = "vector.insert"(%arg1, %1, %arg2) <{static_position = array<i64: -9223372036854775808, 0>}> : (f32, vector<4x4xf32>, index) -> vector<4x4xf32>
    "func.return"(%2) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "no_fold_insert_use_chain_mismatch_static_position"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "vector.insert"(%arg1, %arg0) <{static_position = array<i64: 0>}> : (f32, vector<4xf32>) -> vector<4xf32>
    %1 = "vector.insert"(%arg1, %0) <{static_position = array<i64: 1>}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

