"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<i32>, sym_name = "bitcast_f32_to_i32_vector_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.bitcast"(%arg0) : (vector<f32>) -> vector<i32>
    "func.return"(%0) : (vector<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> vector<16xi32>, sym_name = "bitcast_f32_to_i32_vector"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.bitcast"(%arg0) : (vector<16xf32>) -> vector<16xi32>
    "func.return"(%0) : (vector<16xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> vector<[16]xi32>, sym_name = "bitcast_f32_to_i32_vector_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "vector.bitcast"(%arg0) : (vector<[16]xf32>) -> vector<[16]xi32>
    "func.return"(%0) : (vector<[16]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<64xi8>) -> vector<16xf32>, sym_name = "bitcast_i8_to_f32_vector"}> ({
  ^bb0(%arg0: vector<64xi8>):
    %0 = "vector.bitcast"(%arg0) : (vector<64xi8>) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[64]xi8>) -> vector<[16]xf32>, sym_name = "bitcast_i8_to_f32_vector_scalable"}> ({
  ^bb0(%arg0: vector<[64]xi8>):
    %0 = "vector.bitcast"(%arg0) : (vector<[64]xi8>) -> vector<[16]xf32>
    "func.return"(%0) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xindex>) -> vector<128xi8>, sym_name = "bitcast_index_to_i8_vector"}> ({
  ^bb0(%arg0: vector<16xindex>):
    %0 = "vector.bitcast"(%arg0) : (vector<16xindex>) -> vector<128xi8>
    "func.return"(%0) : (vector<128xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xindex>) -> vector<[128]xi8>, sym_name = "bitcast_index_to_i8_vector_scalable"}> ({
  ^bb0(%arg0: vector<[16]xindex>):
    %0 = "vector.bitcast"(%arg0) : (vector<[16]xindex>) -> vector<[128]xi8>
    "func.return"(%0) : (vector<[128]xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<f32>, sym_name = "broadcast_vec0d_from_vec0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.broadcast"(%arg0) : (vector<f32>) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf32>, sym_name = "broadcast_vec1d_from_vec1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<2xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>) -> vector<[2]xf32>, sym_name = "broadcast_vec1d_from_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>):
    %0 = "vector.broadcast"(%arg0) : (vector<[2]xf32>) -> vector<[2]xf32>
    "func.return"(%0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "broadcast_vec0d_from_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.broadcast"(%arg0) : (f32) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "broadcast_vec1d_from_scalar"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "vector.broadcast"(%arg1) : (f32) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>, f32) -> vector<[4]xf32>, sym_name = "broadcast_scalable_vec1d_from_scalar"}> ({
  ^bb0(%arg1: vector<[4]xf32>, %arg2: f32):
    %1 = "vector.broadcast"(%arg2) : (f32) -> vector<[4]xf32>
    "func.return"(%1) : (vector<[4]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<f32>) -> vector<3xf32>, sym_name = "shuffle_0D_direct"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.shuffle"(%arg0, %arg0) <{mask = array<i64: 0, 1, 0>}> : (vector<f32>, vector<f32>) -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "shuffle_1D_direct"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<2xindex>) -> vector<2xindex>, sym_name = "shuffle_1D_index_direct"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<2xindex>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, 1>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
    "func.return"(%0) : (vector<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<4xf32>, sym_name = "shuffle_poison_mask"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 0, -1, 3, -1>}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<3xf32>) -> vector<5xf32>, sym_name = "shuffle_1D"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<3xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 4, 3, 2, 1, 0>}> : (vector<2xf32>, vector<3xf32>) -> vector<5xf32>
    "func.return"(%0) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x4xf32>, vector<2x4xf32>) -> vector<3x4xf32>, sym_name = "shuffle_2D"}> ({
  ^bb0(%arg0: vector<1x4xf32>, %arg1: vector<2x4xf32>):
    %0 = "vector.shuffle"(%arg0, %arg1) <{mask = array<i64: 1, 0, 2>}> : (vector<1x4xf32>, vector<2x4xf32>) -> vector<3x4xf32>
    "func.return"(%0) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "extract_scalar_from_vec_1d_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 15>}> : (vector<16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 15>}> : (vector<[16]xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> vector<1xf32>, sym_name = "extract_vec_1e_from_vec_1d_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 15>}> : (vector<16xf32>) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> vector<1xf32>, sym_name = "extract_vec_1e_from_vec_1d_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 15>}> : (vector<[16]xf32>) -> vector<1xf32>
    "func.return"(%0) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xindex>) -> index, sym_name = "extract_scalar_from_vec_1d_index"}> ({
  ^bb0(%arg0: vector<16xindex>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 15>}> : (vector<16xindex>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xindex>) -> index, sym_name = "extract_scalar_from_vec_1d_index_scalable"}> ({
  ^bb0(%arg0: vector<[16]xindex>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 15>}> : (vector<[16]xindex>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> vector<3x16xf32>, sym_name = "extract_vec_2d_from_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x3x16xf32>) -> vector<3x16xf32>
    "func.return"(%0) : (vector<3x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x[16]xf32>) -> vector<3x[16]xf32>, sym_name = "extract_vec_2d_from_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<4x3x[16]xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<4x3x[16]xf32>) -> vector<3x[16]xf32>
    "func.return"(%0) : (vector<3x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> vector<16xf32>, sym_name = "extract_vec_1d_from_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0>}> : (vector<4x3x16xf32>) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x[16]xf32>) -> vector<[16]xf32>, sym_name = "extract_vec_1d_from_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<4x3x[16]xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0>}> : (vector<4x3x[16]xf32>) -> vector<[16]xf32>
    "func.return"(%0) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> f32, sym_name = "extract_scalar_from_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0, 0>}> : (vector<4x3x16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x[16]xf32>) -> f32, sym_name = "extract_scalar_from_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<4x3x[16]xf32>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0, 0>}> : (vector<4x3x[16]xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_dynamic_idx"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<16xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808>}> : (vector<[16]xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_inner_dynamic_idx"}> ({
  ^bb0(%arg2: vector<1x16xf32>, %arg3: index):
    %1 = "vector.extract"(%arg2, %arg3) <{static_position = array<i64: 0, -9223372036854775808>}> : (vector<1x16xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x[16]xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_inner_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<1x[16]xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: 0, -9223372036854775808>}> : (vector<1x[16]xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_outer_dynamic_idx"}> ({
  ^bb0(%arg2: vector<1x16xf32>, %arg3: index):
    %1 = "vector.extract"(%arg2, %arg3) <{static_position = array<i64: -9223372036854775808, 0>}> : (vector<1x16xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x[16]xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_outer_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<1x[16]xf32>, %arg1: index):
    %0 = "vector.extract"(%arg0, %arg1) <{static_position = array<i64: -9223372036854775808, 0>}> : (vector<1x[16]xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<index>) -> index, sym_name = "extract_scalar_from_vec_0d_index"}> ({
  ^bb0(%arg0: vector<index>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64>}> : (vector<index>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32x1xf32>) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_dynamic_idxs_compile_time_const"}> ({
  ^bb0(%arg0: vector<32x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.extract"(%arg0, %0, %0) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<32x1xf32>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<f32>) -> vector<f32>, sym_name = "insert_scalar_into_vec_0d"}> ({
  ^bb0(%arg0: f32, %arg1: vector<f32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64>}> : (f32, vector<f32>) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> vector<4xf32>, sym_name = "insert_scalar_into_vec_1d_f32"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3>}> : (f32, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "insert_scalar_into_vec_1d_f32_scalable"}> ({
  ^bb0(%arg0: f32, %arg1: vector<[4]xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3>}> : (f32, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%0) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, vector<4xindex>) -> vector<4xindex>, sym_name = "insert_scalar_into_vec_1d_index"}> ({
  ^bb0(%arg0: index, %arg1: vector<4xindex>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3>}> : (index, vector<4xindex>) -> vector<4xindex>
    "func.return"(%0) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, vector<[4]xindex>) -> vector<[4]xindex>, sym_name = "insert_scalar_into_vec_1d_index_scalable"}> ({
  ^bb0(%arg0: index, %arg1: vector<[4]xindex>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3>}> : (index, vector<[4]xindex>) -> vector<[4]xindex>
    "func.return"(%0) : (vector<[4]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf32>, vector<4x8x16xf32>) -> vector<4x8x16xf32>, sym_name = "insert_vec_2d_into_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<8x16xf32>, %arg1: vector<4x8x16xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3>}> : (vector<8x16xf32>, vector<4x8x16xf32>) -> vector<4x8x16xf32>
    "func.return"(%0) : (vector<4x8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x[16]xf32>, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>, sym_name = "insert_vec_2d_into_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<8x[16]xf32>, %arg1: vector<4x8x[16]xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3>}> : (vector<8x[16]xf32>, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>
    "func.return"(%0) : (vector<4x8x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<4x8x16xf32>) -> vector<4x8x16xf32>, sym_name = "insert_vec_1d_into_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<4x8x16xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3, 7>}> : (vector<16xf32>, vector<4x8x16xf32>) -> vector<4x8x16xf32>
    "func.return"(%0) : (vector<4x8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>, sym_name = "insert_vec_1d_into_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: vector<4x8x[16]xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3, 7>}> : (vector<[16]xf32>, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>
    "func.return"(%0) : (vector<4x8x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4x8x16xf32>) -> vector<4x8x16xf32>, sym_name = "insert_scalar_into_vec_3d_f32"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4x8x16xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3, 7, 15>}> : (f32, vector<4x8x16xf32>) -> vector<4x8x16xf32>
    "func.return"(%0) : (vector<4x8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>, sym_name = "insert_scalar_into_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4x8x[16]xf32>):
    %0 = "vector.insert"(%arg0, %arg1) <{static_position = array<i64: 3, 7, 15>}> : (f32, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>
    "func.return"(%0) : (vector<4x8x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32, index) -> vector<16xf32>, sym_name = "insert_scalar_into_vec_1d_f32_dynamic_idx"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<16xf32>, index) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32, index) -> vector<[16]xf32>, sym_name = "insert_scalar_into_vec_1d_f32_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: -9223372036854775808>}> : (f32, vector<[16]xf32>, index) -> vector<[16]xf32>
    "func.return"(%0) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16xf32>, f32, index) -> vector<1x16xf32>, sym_name = "insert_scalar_into_vec_2d_f32_dynamic_idx"}> ({
  ^bb0(%arg0: vector<1x16xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: 0, -9223372036854775808>}> : (f32, vector<1x16xf32>, index) -> vector<1x16xf32>
    "func.return"(%0) : (vector<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x[16]xf32>, f32, index) -> vector<1x[16]xf32>, sym_name = "insert_scalar_into_vec_2d_f32_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<1x[16]xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: 0, -9223372036854775808>}> : (f32, vector<1x[16]xf32>, index) -> vector<1x[16]xf32>
    "func.return"(%0) : (vector<1x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x16xf32>, f32, index) -> vector<2x16xf32>, sym_name = "insert_scalar_into_vec_2d_f32_dynamic_idx_fail"}> ({
  ^bb0(%arg0: vector<2x16xf32>, %arg1: f32, %arg2: index):
    %0 = "vector.insert"(%arg1, %arg0, %arg2) <{static_position = array<i64: -9223372036854775808, 0>}> : (f32, vector<2x16xf32>, index) -> vector<2x16xf32>
    "func.return"(%0) : (vector<2x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x1xf32>) -> vector<4x1xf32>, sym_name = "insert_scalar_from_vec_2d_f32_dynamic_idxs_compile_time_const"}> ({
  ^bb0(%arg0: vector<4x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "vector.insert"(%1, %arg0, %0, %0) <{static_position = array<i64: -9223372036854775808, -9223372036854775808>}> : (f32, vector<4x1xf32>, index, index) -> vector<4x1xf32>
    "func.return"(%2) : (vector<4x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8x8xf32>) -> memref<vector<8x8x8xf32>>, sym_name = "type_cast_f32"}> ({
  ^bb0(%arg0: memref<8x8x8xf32>):
    %0 = "vector.type_cast"(%arg0) : (memref<8x8x8xf32>) -> memref<vector<8x8x8xf32>>
    "func.return"(%0) : (memref<vector<8x8x8xf32>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8x8xindex>) -> memref<vector<8x8x8xindex>>, sym_name = "type_cast_index"}> ({
  ^bb0(%arg0: memref<8x8x8xindex>):
    %0 = "vector.type_cast"(%arg0) : (memref<8x8x8xindex>) -> memref<vector<8x8x8xindex>>
    "func.return"(%0) : (memref<vector<8x8x8xindex>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8x8xf32, 3>) -> memref<vector<8x8x8xf32>, 3>, sym_name = "type_cast_non_zero_addrspace"}> ({
  ^bb0(%arg0: memref<8x8x8xf32, 3>):
    %0 = "vector.type_cast"(%arg0) : (memref<8x8x8xf32, 3>) -> memref<vector<8x8x8xf32>, 3>
    "func.return"(%0) : (memref<vector<8x8x8xf32>, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> (), sym_name = "print_scalar_i64"}> ({
  ^bb0(%arg0: i64):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (ui64) -> (), sym_name = "print_scalar_ui64"}> ({
  ^bb0(%arg0: ui64):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (ui64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "print_scalar_index"}> ({
  ^bb0(%arg0: index):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "print_scalar_f32"}> ({
  ^bb0(%arg0: f32):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "print_scalar_f64"}> ({
  ^bb0(%arg0: f64):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (f64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "print_string"}> ({
    "vector.print"() <{punctuation = #vector.punctuation<newline>, stringLiteral = "Hello, World!"}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> f32, sym_name = "reduce_0d_f32"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf16>) -> f16, sym_name = "reduce_f16"}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xf16>) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf16>) -> f16, sym_name = "reduce_f16_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf16>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xf16>) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> f32, sym_name = "reduce_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf64>) -> f64, sym_name = "reduce_f64"}> ({
  ^bb0(%arg0: vector<16xf64>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xf64>) -> f64
    "func.return"(%0) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf64>) -> f64, sym_name = "reduce_f64_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf64>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xf64>) -> f64
    "func.return"(%0) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi8>) -> i8, sym_name = "reduce_i8"}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xi8>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi8>) -> i8, sym_name = "reduce_i8_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi8>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xi8>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_mul_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_mul_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_mul_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_mul_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fmaximum_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maximumf>}> : (vector<16xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fmaximum_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maximumf>}> : (vector<[16]xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fminimum_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minimumf>}> : (vector<16xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fminimum_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minimumf>}> : (vector<[16]xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fmax_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxnumf>}> : (vector<16xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fmax_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxnumf>}> : (vector<[16]xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fmin_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minnumf>}> : (vector<16xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fmin_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minnumf>}> : (vector<[16]xf32>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_minui_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_minui_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_minui_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_minui_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_maxui_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_maxui_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_maxui_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_maxui_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_minsi_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_minsi_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_minsi_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_minsi_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_maxsi_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_maxsi_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_maxsi_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_maxsi_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_and_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<and>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_and_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<and>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_and_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<and>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_and_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<and>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_or_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<or>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_or_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<or>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_or_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<or>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_or_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<or>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_xor_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<xor>}> : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_xor_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<xor>}> : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_xor_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<xor>}> : (vector<16xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_xor_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "vector.reduction"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<xor>}> : (vector<[16]xi32>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi64>) -> i64, sym_name = "reduce_i64"}> ({
  ^bb0(%arg0: vector<16xi64>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xi64>) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi64>) -> i64, sym_name = "reduce_i64_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi64>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xi64>) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xindex>) -> index, sym_name = "reduce_index"}> ({
  ^bb0(%arg0: vector<16xindex>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xindex>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xindex>) -> index, sym_name = "reduce_index_scalable"}> ({
  ^bb0(%arg0: vector<[16]xindex>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xindex>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<f32>, sym_name = "transpose_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64>}> : (vector<f32>) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<[8]xf32>
    "func.return"(%0) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) <{nontemporal = true}> : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) <{nontemporal = true}> : (memref<200x100xf32>, index, index) -> vector<[8]xf32>
    "func.return"(%0) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<8xindex>, sym_name = "load_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xindex>, index, index) -> vector<8xindex>
    "func.return"(%0) : (vector<8xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<[8]xindex>, sym_name = "load_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xindex>, index, index) -> vector<[8]xindex>
    "func.return"(%0) : (vector<[8]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<f32>, sym_name = "load_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) : (memref<200x100xf32>, index, index) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "vector.load"(%arg0, %arg1, %arg2) <{alignment = 8 : i64}> : (memref<200x100xf32>, index, index) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<[4]xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) <{nontemporal = true}> : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    "vector.store"(%0, %arg0, %arg1, %arg2) <{nontemporal = true}> : (vector<[4]xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<11> : vector<4xindex>}> : () -> vector<4xindex>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<4xindex>, memref<200x100xindex>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<11> : vector<[4]xindex>}> : () -> vector<[4]xindex>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<[4]xindex>, memref<200x100xindex>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<1.100000e+01> : vector<f32>}> : () -> vector<f32>
    "vector.store"(%0, %arg0, %arg1, %arg2) : (vector<f32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index, vector<4xf32>) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index, %arg3: vector<4xf32>):
    "vector.store"(%arg3, %arg0, %arg1, %arg2) <{alignment = 8 : i64}> : (vector<4xf32>, memref<200x100xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "masked_load"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[16]xi1>, vector<[16]xf32>) -> vector<[16]xf32>, sym_name = "masked_load_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<[16]xi1>, vector<[16]xf32>) -> vector<[16]xf32>
    "func.return"(%1) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<16xi1>, vector<16xindex>) -> vector<16xindex>, sym_name = "masked_load_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<16xi1>, %arg2: vector<16xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg1, %arg2) : (memref<?xindex>, index, vector<16xi1>, vector<16xindex>) -> vector<16xindex>
    "func.return"(%1) : (vector<16xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[16]xi1>, vector<[16]xindex>) -> vector<[16]xindex>, sym_name = "masked_load_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.maskedload"(%arg0, %0, %arg1, %arg2) : (memref<?xindex>, index, vector<[16]xi1>, vector<[16]xindex>) -> vector<[16]xindex>
    "func.return"(%1) : (vector<[16]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>, index) -> vector<16xf32>, sym_name = "masked_load_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>, %arg3: index):
    %0 = "vector.maskedload"(%arg0, %arg3, %arg1, %arg2) <{alignment = 2 : i64}> : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "masked_store"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.maskedstore"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[16]xi1>, vector<[16]xf32>) -> (), sym_name = "masked_store_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.maskedstore"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<[16]xi1>, vector<[16]xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<16xi1>, vector<16xindex>) -> (), sym_name = "masked_store_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<16xi1>, %arg2: vector<16xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.maskedstore"(%arg0, %0, %arg1, %arg2) : (memref<?xindex>, index, vector<16xi1>, vector<16xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[16]xi1>, vector<[16]xindex>) -> (), sym_name = "masked_store_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.maskedstore"(%arg0, %0, %arg1, %arg2) : (memref<?xindex>, index, vector<[16]xi1>, vector<[16]xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>, index) -> (), sym_name = "masked_store_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>, %arg3: index):
    "vector.maskedstore"(%arg0, %arg3, %arg1, %arg2) <{alignment = 2 : i64}> : (memref<?xf32>, index, vector<16xi1>, vector<16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>, sym_name = "gather_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    "func.return"(%1) : (vector<[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 1>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather_global_memory"}> ({
  ^bb0(%arg0: memref<?xf32, 1>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32, 1>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 1>, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>, sym_name = "gather_global_memory_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, 1>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32, 1>, index, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    "func.return"(%1) : (vector<[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<3xindex>, vector<3xi1>, vector<3xindex>) -> vector<3xindex>, sym_name = "gather_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<3xindex>, %arg2: vector<3xi1>, %arg3: vector<3xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xindex>, index, vector<3xindex>, vector<3xi1>, vector<3xindex>) -> vector<3xindex>
    "func.return"(%1) : (vector<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[3]xindex>, vector<[3]xi1>, vector<[3]xindex>) -> vector<[3]xindex>, sym_name = "gather_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[3]xindex>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xindex>, index, vector<[3]xindex>, vector<[3]xi1>, vector<[3]xindex>) -> vector<[3]xindex>
    "func.return"(%1) : (vector<[3]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>, vector<4xi32>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>, sym_name = "gather_1d_from_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %0, %arg1, %arg2, %arg3) : (memref<4x4xf32>, index, index, vector<4xi32>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32>, vector<[4]xi32>, vector<[4]xi1>, vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "gather_1d_from_2d_scalable"}> ({
  ^bb0(%arg0: memref<4x?xf32>, %arg1: vector<[4]xi32>, %arg2: vector<[4]xi1>, %arg3: vector<[4]xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %0, %arg1, %arg2, %arg3) : (memref<4x?xf32>, index, index, vector<[4]xi32>, vector<[4]xi1>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%1) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>, index) -> vector<3xf32>, sym_name = "gather_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>, %arg4: index):
    %0 = "vector.gather"(%arg0, %arg4, %arg1, %arg2, %arg3) <{alignment = 8 : i64}> : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> (), sym_name = "scatter"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> (), sym_name = "scatter_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xf32>, index, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<3xindex>, vector<3xi1>, vector<3xindex>) -> (), sym_name = "scatter_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<3xindex>, %arg2: vector<3xi1>, %arg3: vector<3xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xindex>, index, vector<3xindex>, vector<3xi1>, vector<3xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[3]xindex>, vector<[3]xi1>, vector<[3]xindex>) -> (), sym_name = "scatter_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[3]xindex>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %arg1, %arg2, %arg3) : (memref<?xindex>, index, vector<[3]xindex>, vector<[3]xi1>, vector<[3]xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>, vector<4xi32>, vector<4xi1>, vector<4xf32>) -> (), sym_name = "scatter_1d_into_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %0, %arg1, %arg2, %arg3) : (memref<4x4xf32>, index, index, vector<4xi32>, vector<4xi1>, vector<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32>, vector<[4]xi32>, vector<[4]xi1>, vector<[4]xf32>) -> (), sym_name = "scatter_1d_into_2d_scalable"}> ({
  ^bb0(%arg0: memref<4x?xf32>, %arg1: vector<[4]xi32>, %arg2: vector<[4]xi1>, %arg3: vector<[4]xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    "vector.scatter"(%arg0, %0, %0, %arg1, %arg2, %arg3) : (memref<4x?xf32>, index, index, vector<[4]xi32>, vector<[4]xi1>, vector<[4]xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>, index) -> (), sym_name = "scatter_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>, %arg4: index):
    "vector.scatter"(%arg0, %arg4, %arg1, %arg2, %arg3) <{alignment = 8 : i64}> : (memref<?xf32>, index, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<11xi1>, vector<11xf32>) -> vector<11xf32>, sym_name = "expand_load_op"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<11xi1>, %arg2: vector<11xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.expandload"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<11xi1>, vector<11xf32>) -> vector<11xf32>
    "func.return"(%1) : (vector<11xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>) -> vector<11xindex>, sym_name = "expand_load_op_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.expandload"(%arg0, %0, %arg1, %arg2) : (memref<?xindex>, index, vector<11xi1>, vector<11xindex>) -> vector<11xindex>
    "func.return"(%1) : (vector<11xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>, index) -> vector<11xindex>, sym_name = "expand_load_op_with_alignment"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>, %arg3: index):
    %0 = "vector.expandload"(%arg0, %arg3, %arg1, %arg2) <{alignment = 8 : i64}> : (memref<?xindex>, index, vector<11xi1>, vector<11xindex>) -> vector<11xindex>
    "func.return"(%0) : (vector<11xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<11xi1>, vector<11xf32>) -> (), sym_name = "compress_store_op"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<11xi1>, %arg2: vector<11xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.compressstore"(%arg0, %0, %arg1, %arg2) : (memref<?xf32>, index, vector<11xi1>, vector<11xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>) -> (), sym_name = "compress_store_op_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.compressstore"(%arg0, %0, %arg1, %arg2) : (memref<?xindex>, index, vector<11xi1>, vector<11xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>, index) -> (), sym_name = "compress_store_op_with_alignment"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>, %arg3: index):
    "vector.compressstore"(%arg0, %arg3, %arg1, %arg2) <{alignment = 8 : i64}> : (memref<?xindex>, index, vector<11xi1>, vector<11xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "scalable_insert"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<[4]xf32>):
    %0 = "vector.scalable.insert"(%arg0, %arg1) <{pos = 0 : i64}> : (vector<4xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %1 = "vector.scalable.insert"(%arg0, %0) <{pos = 4 : i64}> : (vector<4xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%1) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<8xf32>, sym_name = "scalable_extract"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "vector.scalable.extract"(%arg0) <{pos = 0 : i64}> : (vector<[4]xf32>) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i8>, vector<i8>) -> vector<2xi8>, sym_name = "interleave_0d"}> ({
  ^bb0(%arg0: vector<i8>, %arg1: vector<i8>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<i8>, vector<i8>) -> vector<2xi8>
    "func.return"(%0) : (vector<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<8xf32>) -> vector<16xf32>, sym_name = "interleave_1d"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xf32>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<8xf32>, vector<8xf32>) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>, vector<[4]xi32>) -> vector<[8]xi32>, sym_name = "interleave_1d_scalable"}> ({
  ^bb0(%arg0: vector<[4]xi32>, %arg1: vector<[4]xi32>):
    %0 = "vector.interleave"(%arg0, %arg1) : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[8]xi32>
    "func.return"(%0) : (vector<[8]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<2xi32>, vector<2xi32>), sym_name = "deinterleave_1d"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0:2 = "vector.deinterleave"(%arg0) : (vector<4xi32>) -> (vector<2xi32>, vector<2xi32>)
    "func.return"(%0#0, %0#1) : (vector<2xi32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> (vector<[2]xi32>, vector<[2]xi32>), sym_name = "deinterleave_1d_scalable"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0:2 = "vector.deinterleave"(%arg0) : (vector<[4]xi32>) -> (vector<[2]xi32>, vector<[2]xi32>)
    "func.return"(%0#0, %0#1) : (vector<[2]xi32>, vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> vector<3xf32>, sym_name = "from_elements_1d"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "vector.from_elements"(%arg0, %arg1, %arg0) : (f32, f32, f32) -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "from_elements_0d"}> ({
  ^bb0(%arg0: f32):
    %0 = "vector.from_elements"(%arg0) : (f32) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32, f32, f32), sym_name = "to_elements_no_dead_elements"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0:4 = "vector.to_elements"(%arg0) : (vector<4xf32>) -> (f32, f32, f32, f32)
    "func.return"(%0#0, %0#1, %0#2, %0#3) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32), sym_name = "to_elements_dead_elements"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0:4 = "vector.to_elements"(%arg0) : (vector<4xf32>) -> (f32, f32, f32, f32)
    "func.return"(%0#1, %0#3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[4]xindex>, sym_name = "step_scalable"}> ({
    %0 = "vector.step"() : () -> vector<[4]xindex>
    "func.return"(%0) : (vector<[4]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

