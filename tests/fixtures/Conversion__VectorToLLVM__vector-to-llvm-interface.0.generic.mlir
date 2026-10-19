"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<i32>, sym_name = "bitcast_f32_to_i32_vector_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.bitcast"(%0) : (vector<1xf32>) -> vector<1xi32>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (vector<1xi32>) -> vector<i32>
    "func.return"(%2) : (vector<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> vector<16xi32>, sym_name = "bitcast_f32_to_i32_vector"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.bitcast"(%arg0) : (vector<16xf32>) -> vector<16xi32>
    "func.return"(%0) : (vector<16xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> vector<[16]xi32>, sym_name = "bitcast_f32_to_i32_vector_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "llvm.bitcast"(%arg0) : (vector<[16]xf32>) -> vector<[16]xi32>
    "func.return"(%0) : (vector<[16]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<64xi8>) -> vector<16xf32>, sym_name = "bitcast_i8_to_f32_vector"}> ({
  ^bb0(%arg0: vector<64xi8>):
    %0 = "llvm.bitcast"(%arg0) : (vector<64xi8>) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[64]xi8>) -> vector<[16]xf32>, sym_name = "bitcast_i8_to_f32_vector_scalable"}> ({
  ^bb0(%arg0: vector<[64]xi8>):
    %0 = "llvm.bitcast"(%arg0) : (vector<[64]xi8>) -> vector<[16]xf32>
    "func.return"(%0) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xindex>) -> vector<128xi8>, sym_name = "bitcast_index_to_i8_vector"}> ({
  ^bb0(%arg0: vector<16xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<16xindex>) -> vector<16xi64>
    %1 = "llvm.bitcast"(%0) : (vector<16xi64>) -> vector<128xi8>
    "func.return"(%1) : (vector<128xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xindex>) -> vector<[128]xi8>, sym_name = "bitcast_index_to_i8_vector_scalable"}> ({
  ^bb0(%arg0: vector<[16]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<[16]xindex>) -> vector<[16]xi64>
    %1 = "llvm.bitcast"(%0) : (vector<[16]xi64>) -> vector<[128]xi8>
    "func.return"(%1) : (vector<[128]xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<f32>, sym_name = "broadcast_vec0d_from_vec0d"}> ({
  ^bb0(%arg0: vector<f32>):
    "func.return"(%arg0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf32>, sym_name = "broadcast_vec1d_from_vec1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    "func.return"(%arg0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[2]xf32>) -> vector<[2]xf32>, sym_name = "broadcast_vec1d_from_vec1d_scalable"}> ({
  ^bb0(%arg0: vector<[2]xf32>):
    "func.return"(%arg0) : (vector<[2]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "broadcast_vec0d_from_scalar"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<1xf32>, f32, i32) -> vector<1xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<1xf32>) -> vector<f32>
    "func.return"(%3) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f32) -> vector<4xf32>, sym_name = "broadcast_vec1d_from_scalar"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.insertelement"(%0, %arg1, %1) : (vector<4xf32>, f32, i32) -> vector<4xf32>
    %3 = "llvm.shufflevector"(%2, %0) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>, f32) -> vector<[4]xf32>, sym_name = "broadcast_scalable_vec1d_from_scalar"}> ({
  ^bb0(%arg1: vector<[4]xf32>, %arg2: f32):
    %2 = "llvm.mlir.poison"() : () -> vector<[4]xf32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %arg2, %3) : (vector<[4]xf32>, f32, i32) -> vector<[4]xf32>
    %5 = "llvm.shufflevector"(%4, %2) <{mask = array<i32: 0, 0, 0, 0>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%5) : (vector<[4]xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<f32>) -> vector<3xf32>, sym_name = "shuffle_0D_direct"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.shufflevector"(%0, %0) <{mask = array<i32: 0, 1, 0>}> : (vector<1xf32>, vector<1xf32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "shuffle_1D_direct"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    "func.return"(%arg0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<2xindex>) -> vector<2xindex>, sym_name = "shuffle_1D_index_direct"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<2xindex>):
    "func.return"(%arg0) : (vector<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>) -> vector<4xf32>, sym_name = "shuffle_poison_mask"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):
    %0 = "llvm.shufflevector"(%arg0, %arg1) <{mask = array<i32: 0, -1, 3, -1>}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<3xf32>) -> vector<5xf32>, sym_name = "shuffle_1D"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<3xf32>):
    %0 = "llvm.mlir.poison"() : () -> vector<5xf32>
    %1 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %2 = "llvm.extractelement"(%arg1, %1) : (vector<3xf32>, i64) -> f32
    %3 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %4 = "llvm.insertelement"(%0, %2, %3) : (vector<5xf32>, f32, i64) -> vector<5xf32>
    %5 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %6 = "llvm.extractelement"(%arg1, %5) : (vector<3xf32>, i64) -> f32
    %7 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %8 = "llvm.insertelement"(%4, %6, %7) : (vector<5xf32>, f32, i64) -> vector<5xf32>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %10 = "llvm.extractelement"(%arg1, %9) : (vector<3xf32>, i64) -> f32
    %11 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %12 = "llvm.insertelement"(%8, %10, %11) : (vector<5xf32>, f32, i64) -> vector<5xf32>
    %13 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %14 = "llvm.extractelement"(%arg0, %13) : (vector<2xf32>, i64) -> f32
    %15 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %16 = "llvm.insertelement"(%12, %14, %15) : (vector<5xf32>, f32, i64) -> vector<5xf32>
    %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %18 = "llvm.extractelement"(%arg0, %17) : (vector<2xf32>, i64) -> f32
    %19 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %20 = "llvm.insertelement"(%16, %18, %19) : (vector<5xf32>, f32, i64) -> vector<5xf32>
    "func.return"(%20) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x4xf32>, vector<2x4xf32>) -> vector<3x4xf32>, sym_name = "shuffle_2D"}> ({
  ^bb0(%arg0: vector<1x4xf32>, %arg1: vector<2x4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<2x4xf32>) -> !llvm.array<2 x vector<4xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x4xf32>) -> !llvm.array<1 x vector<4xf32>>
    %2 = "llvm.mlir.poison"() : () -> !llvm.array<3 x vector<4xf32>>
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %4 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.array<3 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %5 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<4xf32>>) -> vector<4xf32>
    %6 = "llvm.insertvalue"(%4, %5) <{position = array<i64: 1>}> : (!llvm.array<3 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<2 x vector<4xf32>>) -> vector<4xf32>
    %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 2>}> : (!llvm.array<3 x vector<4xf32>>, vector<4xf32>) -> !llvm.array<3 x vector<4xf32>>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (!llvm.array<3 x vector<4xf32>>) -> vector<3x4xf32>
    "func.return"(%9) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "extract_scalar_from_vec_1d_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<16xf32>, i64) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<[16]xf32>, i64) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> vector<1xf32>, sym_name = "extract_vec_1e_from_vec_1d_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<16xf32>, i64) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (f32) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> vector<1xf32>, sym_name = "extract_vec_1e_from_vec_1d_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<[16]xf32>, i64) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%1) : (f32) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xindex>) -> index, sym_name = "extract_scalar_from_vec_1d_index"}> ({
  ^bb0(%arg0: vector<16xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<16xindex>) -> vector<16xi64>
    %1 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %2 = "llvm.extractelement"(%0, %1) : (vector<16xi64>, i64) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xindex>) -> index, sym_name = "extract_scalar_from_vec_1d_index_scalable"}> ({
  ^bb0(%arg0: vector<[16]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<[16]xindex>) -> vector<[16]xi64>
    %1 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %2 = "llvm.extractelement"(%0, %1) : (vector<[16]xi64>, i64) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> vector<3x16xf32>, sym_name = "extract_vec_2d_from_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3x16xf32>) -> !llvm.array<4 x array<3 x vector<16xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<16xf32>>>) -> !llvm.array<3 x vector<16xf32>>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!llvm.array<3 x vector<16xf32>>) -> vector<3x16xf32>
    "func.return"(%2) : (vector<3x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x[16]xf32>) -> vector<3x[16]xf32>, sym_name = "extract_vec_2d_from_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<4x3x[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3x[16]xf32>) -> !llvm.array<4 x array<3 x vector<[16]xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x array<3 x vector<[16]xf32>>>) -> !llvm.array<3 x vector<[16]xf32>>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!llvm.array<3 x vector<[16]xf32>>) -> vector<3x[16]xf32>
    "func.return"(%2) : (vector<3x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> vector<16xf32>, sym_name = "extract_vec_1d_from_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3x16xf32>) -> !llvm.array<4 x array<3 x vector<16xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<3 x vector<16xf32>>>) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x[16]xf32>) -> vector<[16]xf32>, sym_name = "extract_vec_1d_from_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<4x3x[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3x[16]xf32>) -> !llvm.array<4 x array<3 x vector<[16]xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<3 x vector<[16]xf32>>>) -> vector<[16]xf32>
    "func.return"(%1) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x16xf32>) -> f32, sym_name = "extract_scalar_from_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<4x3x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3x16xf32>) -> !llvm.array<4 x array<3 x vector<16xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<3 x vector<16xf32>>>) -> vector<16xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%1, %2) : (vector<16xf32>, i64) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3x[16]xf32>) -> f32, sym_name = "extract_scalar_from_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<4x3x[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3x[16]xf32>) -> !llvm.array<4 x array<3 x vector<[16]xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0, 0>}> : (!llvm.array<4 x array<3 x vector<[16]xf32>>>) -> vector<[16]xf32>
    %2 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%1, %2) : (vector<[16]xf32>, i64) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_dynamic_idx"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<16xf32>, i64) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_1d_f32_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<[16]xf32>, i64) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_inner_dynamic_idx"}> ({
  ^bb0(%arg2: vector<1x16xf32>, %arg3: index):
    %4 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %5 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<1x16xf32>) -> !llvm.array<1 x vector<16xf32>>
    %6 = "llvm.extractvalue"(%5) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<16xf32>>) -> vector<16xf32>
    %7 = "llvm.extractelement"(%6, %4) : (vector<16xf32>, i64) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x[16]xf32>, index) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_inner_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<1x[16]xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x[16]xf32>) -> !llvm.array<1 x vector<[16]xf32>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<[16]xf32>>) -> vector<[16]xf32>
    %3 = "llvm.extractelement"(%2, %0) : (vector<[16]xf32>, i64) -> f32
    "func.return"(%3) : (f32) -> ()
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
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<index>) -> vector<1xi64>
    %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "llvm.extractelement"(%0, %1) : (vector<1xi64>, i64) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (i64) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32x1xf32>) -> f32, sym_name = "extract_scalar_from_vec_2d_f32_dynamic_idxs_compile_time_const"}> ({
  ^bb0(%arg0: vector<32x1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<32x1xf32>) -> !llvm.array<32 x vector<1xf32>>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<32 x vector<1xf32>>) -> vector<1xf32>
    %3 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %4 = "llvm.extractelement"(%2, %3) : (vector<1xf32>, i64) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<f32>) -> vector<f32>, sym_name = "insert_scalar_into_vec_0d"}> ({
  ^bb0(%arg0: f32, %arg1: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<1xf32>, f32, i64) -> vector<1xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<1xf32>) -> vector<f32>
    "func.return"(%3) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> vector<4xf32>, sym_name = "insert_scalar_into_vec_1d_f32"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %1 = "llvm.insertelement"(%arg1, %arg0, %0) : (vector<4xf32>, f32, i64) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "insert_scalar_into_vec_1d_f32_scalable"}> ({
  ^bb0(%arg0: f32, %arg1: vector<[4]xf32>):
    %0 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %1 = "llvm.insertelement"(%arg1, %arg0, %0) : (vector<[4]xf32>, f32, i64) -> vector<[4]xf32>
    "func.return"(%1) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, vector<4xindex>) -> vector<4xindex>, sym_name = "insert_scalar_into_vec_1d_index"}> ({
  ^bb0(%arg0: index, %arg1: vector<4xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4xindex>) -> vector<4xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %3 = "llvm.insertelement"(%0, %1, %2) : (vector<4xi64>, i64, i64) -> vector<4xi64>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<4xi64>) -> vector<4xindex>
    "func.return"(%4) : (vector<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, vector<[4]xindex>) -> vector<[4]xindex>, sym_name = "insert_scalar_into_vec_1d_index_scalable"}> ({
  ^bb0(%arg0: index, %arg1: vector<[4]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<[4]xindex>) -> vector<[4]xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %3 = "llvm.insertelement"(%0, %1, %2) : (vector<[4]xi64>, i64, i64) -> vector<[4]xi64>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<[4]xi64>) -> vector<[4]xindex>
    "func.return"(%4) : (vector<[4]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x16xf32>, vector<4x8x16xf32>) -> vector<4x8x16xf32>, sym_name = "insert_vec_2d_into_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<8x16xf32>, %arg1: vector<4x8x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x8x16xf32>) -> !llvm.array<4 x array<8 x vector<16xf32>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<8x16xf32>) -> !llvm.array<8 x vector<16xf32>>
    %2 = "llvm.insertvalue"(%0, %1) <{position = array<i64: 3>}> : (!llvm.array<4 x array<8 x vector<16xf32>>>, !llvm.array<8 x vector<16xf32>>) -> !llvm.array<4 x array<8 x vector<16xf32>>>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.array<4 x array<8 x vector<16xf32>>>) -> vector<4x8x16xf32>
    "func.return"(%3) : (vector<4x8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x[16]xf32>, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>, sym_name = "insert_vec_2d_into_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<8x[16]xf32>, %arg1: vector<4x8x[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x8x[16]xf32>) -> !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<8x[16]xf32>) -> !llvm.array<8 x vector<[16]xf32>>
    %2 = "llvm.insertvalue"(%0, %1) <{position = array<i64: 3>}> : (!llvm.array<4 x array<8 x vector<[16]xf32>>>, !llvm.array<8 x vector<[16]xf32>>) -> !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.array<4 x array<8 x vector<[16]xf32>>>) -> vector<4x8x[16]xf32>
    "func.return"(%3) : (vector<4x8x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<4x8x16xf32>) -> vector<4x8x16xf32>, sym_name = "insert_vec_1d_into_vec_3d_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<4x8x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x8x16xf32>) -> !llvm.array<4 x array<8 x vector<16xf32>>>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 3, 7>}> : (!llvm.array<4 x array<8 x vector<16xf32>>>, vector<16xf32>) -> !llvm.array<4 x array<8 x vector<16xf32>>>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!llvm.array<4 x array<8 x vector<16xf32>>>) -> vector<4x8x16xf32>
    "func.return"(%2) : (vector<4x8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>, sym_name = "insert_vec_1d_into_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: vector<4x8x[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x8x[16]xf32>) -> !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %1 = "llvm.insertvalue"(%0, %arg0) <{position = array<i64: 3, 7>}> : (!llvm.array<4 x array<8 x vector<[16]xf32>>>, vector<[16]xf32>) -> !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %2 = "builtin.unrealized_conversion_cast"(%1) : (!llvm.array<4 x array<8 x vector<[16]xf32>>>) -> vector<4x8x[16]xf32>
    "func.return"(%2) : (vector<4x8x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4x8x16xf32>) -> vector<4x8x16xf32>, sym_name = "insert_scalar_into_vec_3d_f32"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4x8x16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x8x16xf32>) -> !llvm.array<4 x array<8 x vector<16xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 7>}> : (!llvm.array<4 x array<8 x vector<16xf32>>>) -> vector<16xf32>
    %2 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %3 = "llvm.insertelement"(%1, %arg0, %2) : (vector<16xf32>, f32, i64) -> vector<16xf32>
    %4 = "llvm.insertvalue"(%0, %3) <{position = array<i64: 3, 7>}> : (!llvm.array<4 x array<8 x vector<16xf32>>>, vector<16xf32>) -> !llvm.array<4 x array<8 x vector<16xf32>>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<4 x array<8 x vector<16xf32>>>) -> vector<4x8x16xf32>
    "func.return"(%5) : (vector<4x8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4x8x[16]xf32>) -> vector<4x8x[16]xf32>, sym_name = "insert_scalar_into_vec_3d_f32_scalable"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4x8x[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x8x[16]xf32>) -> !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 7>}> : (!llvm.array<4 x array<8 x vector<[16]xf32>>>) -> vector<[16]xf32>
    %2 = "llvm.mlir.constant"() <{value = 15 : i64}> : () -> i64
    %3 = "llvm.insertelement"(%1, %arg0, %2) : (vector<[16]xf32>, f32, i64) -> vector<[16]xf32>
    %4 = "llvm.insertvalue"(%0, %3) <{position = array<i64: 3, 7>}> : (!llvm.array<4 x array<8 x vector<[16]xf32>>>, vector<[16]xf32>) -> !llvm.array<4 x array<8 x vector<[16]xf32>>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<4 x array<8 x vector<[16]xf32>>>) -> vector<4x8x[16]xf32>
    "func.return"(%5) : (vector<4x8x[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32, index) -> vector<16xf32>, sym_name = "insert_scalar_into_vec_1d_f32_dynamic_idx"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "llvm.insertelement"(%arg0, %arg1, %0) : (vector<16xf32>, f32, i64) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32, index) -> vector<[16]xf32>, sym_name = "insert_scalar_into_vec_1d_f32_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "llvm.insertelement"(%arg0, %arg1, %0) : (vector<[16]xf32>, f32, i64) -> vector<[16]xf32>
    "func.return"(%1) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16xf32>, f32, index) -> vector<1x16xf32>, sym_name = "insert_scalar_into_vec_2d_f32_dynamic_idx"}> ({
  ^bb0(%arg0: vector<1x16xf32>, %arg1: f32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x16xf32>) -> !llvm.array<1 x vector<16xf32>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<16xf32>>) -> vector<16xf32>
    %3 = "llvm.insertelement"(%2, %arg1, %0) : (vector<16xf32>, f32, i64) -> vector<16xf32>
    %4 = "llvm.insertvalue"(%1, %3) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<16xf32>>, vector<16xf32>) -> !llvm.array<1 x vector<16xf32>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<1 x vector<16xf32>>) -> vector<1x16xf32>
    "func.return"(%5) : (vector<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x[16]xf32>, f32, index) -> vector<1x[16]xf32>, sym_name = "insert_scalar_into_vec_2d_f32_dynamic_idx_scalable"}> ({
  ^bb0(%arg0: vector<1x[16]xf32>, %arg1: f32, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1x[16]xf32>) -> !llvm.array<1 x vector<[16]xf32>>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<[16]xf32>>) -> vector<[16]xf32>
    %3 = "llvm.insertelement"(%2, %arg1, %0) : (vector<[16]xf32>, f32, i64) -> vector<[16]xf32>
    %4 = "llvm.insertvalue"(%1, %3) <{position = array<i64: 0>}> : (!llvm.array<1 x vector<[16]xf32>>, vector<[16]xf32>) -> !llvm.array<1 x vector<[16]xf32>>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!llvm.array<1 x vector<[16]xf32>>) -> vector<1x[16]xf32>
    "func.return"(%5) : (vector<1x[16]xf32>) -> ()
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
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x1xf32>) -> !llvm.array<4 x vector<1xf32>>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<1xf32>>) -> vector<1xf32>
    %4 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "llvm.insertelement"(%3, %2, %4) : (vector<1xf32>, f32, i64) -> vector<1xf32>
    %6 = "llvm.insertvalue"(%0, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<1xf32>>, vector<1xf32>) -> !llvm.array<4 x vector<1xf32>>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!llvm.array<4 x vector<1xf32>>) -> vector<4x1xf32>
    "func.return"(%7) : (vector<4x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8x8xf32>) -> memref<vector<8x8x8xf32>>, sym_name = "type_cast_f32"}> ({
  ^bb0(%arg0: memref<8x8x8xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<8x8x8xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %3 = "llvm.insertvalue"(%1, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %5 = "llvm.insertvalue"(%3, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<vector<8x8x8xf32>>
    "func.return"(%8) : (memref<vector<8x8x8xf32>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8x8xindex>) -> memref<vector<8x8x8xindex>>, sym_name = "type_cast_index"}> ({
  ^bb0(%arg0: memref<8x8x8xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<8x8x8xindex>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %3 = "llvm.insertvalue"(%1, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %5 = "llvm.insertvalue"(%3, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<vector<8x8x8xindex>>
    "func.return"(%8) : (memref<vector<8x8x8xindex>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8x8xf32, 3>) -> memref<vector<8x8x8xf32>, 3>, sym_name = "type_cast_non_zero_addrspace"}> ({
  ^bb0(%arg0: memref<8x8x8xf32, 3>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<8x8x8xf32, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr<3>
    %3 = "llvm.insertvalue"(%1, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr<3>
    %5 = "llvm.insertvalue"(%3, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (!llvm.struct<(ptr<3>, ptr<3>, i64)>) -> memref<vector<8x8x8xf32>, 3>
    "func.return"(%8) : (memref<vector<8x8x8xf32>, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printI64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> (), sym_name = "print_scalar_i64"}> ({
  ^bb0(%arg0: i64):
    "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printI64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printU64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (ui64) -> (), sym_name = "print_scalar_ui64"}> ({
  ^bb0(%arg0: ui64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (ui64) -> i64
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printU64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "printU64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "print_scalar_index"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printU64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "printF32", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "print_scalar_f32"}> ({
  ^bb0(%arg0: f32):
    "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printF32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f32) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "printNewline", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f64)>, linkage = #llvm.linkage<external>, sym_name = "printF64", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> (), sym_name = "print_scalar_f64"}> ({
  ^bb0(%arg0: f64):
    "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printF64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (f64) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printNewline, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "printString", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<14 x i8>, linkage = #llvm.linkage<private>, sym_name = "vector_print_str", value = dense<[72, 101, 108, 108, 111, 44, 32, 87, 111, 114, 108, 100, 33, 0]> : tensor<14xi8>, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "print_string"}> ({
    %0 = "llvm.mlir.addressof"() <{global_name = @vector_print_str}> : () -> !llvm.ptr
    %1 = "llvm.getelementptr"(%0) <{elem_type = !llvm.array<14 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @printString, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> f32, sym_name = "reduce_0d_f32"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "llvm.intr.vector.reduce.fadd"(%1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<1xf32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf16>) -> f16, sym_name = "reduce_f16"}> ({
  ^bb0(%arg0: vector<16xf16>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f16, vector<16xf16>) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf16>) -> f16, sym_name = "reduce_f16_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf16>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f16, vector<[16]xf16>) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<16xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>) -> f32, sym_name = "reduce_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<[16]xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf64>) -> f64, sym_name = "reduce_f64"}> ({
  ^bb0(%arg0: vector<16xf64>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, vector<16xf64>) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf64>) -> f64, sym_name = "reduce_f64_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf64>):
    %0 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, vector<[16]xf64>) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi8>) -> i8, sym_name = "reduce_i8"}> ({
  ^bb0(%arg0: vector<16xi8>):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi8>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi8>) -> i8, sym_name = "reduce_i8_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi8>):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi8>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.add"(%arg1, %0) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.add"(%arg1, %0) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_mul_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_mul_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_mul_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.mul"(%arg1, %0) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_mul_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.mul"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.mul"(%arg1, %0) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fmaximum_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fmaximum"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf32>) -> f32
    %1 = "llvm.intr.maximum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fmaximum_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fmaximum"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[16]xf32>) -> f32
    %1 = "llvm.intr.maximum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fminimum_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fminimum"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf32>) -> f32
    %1 = "llvm.intr.minimum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fminimum_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fminimum"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[16]xf32>) -> f32
    %1 = "llvm.intr.minimum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fmax_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fmax"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf32>) -> f32
    %1 = "llvm.intr.maxnum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fmax_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fmax"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[16]xf32>) -> f32
    %1 = "llvm.intr.maxnum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, f32) -> f32, sym_name = "reduce_fmin_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fmin"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<16xf32>) -> f32
    %1 = "llvm.intr.minnum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, f32) -> f32, sym_name = "reduce_fmin_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: f32):
    %0 = "llvm.intr.vector.reduce.fmin"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[16]xf32>) -> f32
    %1 = "llvm.intr.minnum"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_minui_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_minui_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_minui_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 7 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_minui_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 7 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_maxui_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_maxui_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_maxui_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 9 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_maxui_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 9 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_minsi_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_minsi_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_minsi_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_minsi_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_maxsi_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_maxsi_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_maxsi_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_maxsi_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %2 = "llvm.select"(%1, %arg1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_and_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_and_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_and_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.and"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_and_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.and"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_or_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_or_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_or_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.or"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_or_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.or"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>) -> i32, sym_name = "reduce_xor_i32"}> ({
  ^bb0(%arg0: vector<16xi32>):
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<16xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>) -> i32, sym_name = "reduce_xor_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>):
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<[16]xi32>) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi32>, i32) -> i32, sym_name = "reduce_xor_acc_i32"}> ({
  ^bb0(%arg0: vector<16xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<16xi32>) -> i32
    %1 = "llvm.xor"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi32>, i32) -> i32, sym_name = "reduce_xor_acc_i32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi32>, %arg1: i32):
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<[16]xi32>) -> i32
    %1 = "llvm.xor"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xi64>) -> i64, sym_name = "reduce_i64"}> ({
  ^bb0(%arg0: vector<16xi64>):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<16xi64>) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xi64>) -> i64, sym_name = "reduce_i64_scalable"}> ({
  ^bb0(%arg0: vector<[16]xi64>):
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<[16]xi64>) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xindex>) -> index, sym_name = "reduce_index"}> ({
  ^bb0(%arg0: vector<16xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<16xindex>) -> vector<16xi64>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<16xi64>) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xindex>) -> index, sym_name = "reduce_index_scalable"}> ({
  ^bb0(%arg0: vector<[16]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<[16]xindex>) -> vector<[16]xi64>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<[16]xi64>) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> vector<f32>, sym_name = "transpose_0d"}> ({
  ^bb0(%arg0: vector<f32>):
    "func.return"(%arg0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[8]xf32>
    "func.return"(%8) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<[8]xf32>, sym_name = "load_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[8]xf32>
    "func.return"(%8) : (vector<[8]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<8xindex>, sym_name = "load_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<8xi64>) -> vector<8xindex>
    "func.return"(%9) : (vector<8xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> vector<[8]xindex>, sym_name = "load_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<[8]xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<[8]xi64>) -> vector<[8]xindex>
    "func.return"(%9) : (vector<[8]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<f32>, sym_name = "load_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<1xf32>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<1xf32>) -> vector<f32>
    "func.return"(%9) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> vector<8xf32>, sym_name = "load_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<[4]xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_nontemporal_scalable"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %6 = "llvm.mul"(%1, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.getelementptr"(%4, %7) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%3, %8) <{alignment = 4 : i64, nontemporal, ordering = 0 : i64}> : (vector<[4]xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<11> : vector<4xindex>}> : () -> vector<4xindex>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<4xindex>) -> vector<4xi64>
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %7 = "llvm.mul"(%1, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.getelementptr"(%5, %8) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%4, %9) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<4xi64>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xindex>, index, index) -> (), sym_name = "store_index_scalable"}> ({
  ^bb0(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xindex>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<11> : vector<[4]xindex>}> : () -> vector<[4]xindex>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<[4]xindex>) -> vector<[4]xi64>
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %7 = "llvm.mul"(%1, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.getelementptr"(%5, %8) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%4, %9) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<[4]xi64>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index) -> (), sym_name = "store_0d"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "arith.constant"() <{value = dense<1.100000e+01> : vector<f32>}> : () -> vector<f32>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<f32>) -> vector<1xf32>
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %7 = "llvm.mul"(%1, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.getelementptr"(%5, %8) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%4, %9) <{alignment = 4 : i64, ordering = 0 : i64}> : (vector<1xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<200x100xf32>, index, index, vector<4xf32>) -> (), sym_name = "store_with_alignment"}> ({
  ^bb0(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index, %arg3: vector<4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<200x100xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg3, %7) <{alignment = 8 : i64, ordering = 0 : i64}> : (vector<4xf32>, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "masked_load"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.intr.masked.load"(%4, %arg1, %arg2) <{alignment = 4 : i32}> : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%5) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[16]xi1>, vector<[16]xf32>) -> vector<[16]xf32>, sym_name = "masked_load_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.intr.masked.load"(%4, %arg1, %arg2) <{alignment = 4 : i32}> : (!llvm.ptr, vector<[16]xi1>, vector<[16]xf32>) -> vector<[16]xf32>
    "func.return"(%5) : (vector<[16]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<16xi1>, vector<16xindex>) -> vector<16xindex>, sym_name = "masked_load_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<16xi1>, %arg2: vector<16xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<16xindex>) -> vector<16xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.intr.masked.load"(%5, %arg1, %0) <{alignment = 8 : i32}> : (!llvm.ptr, vector<16xi1>, vector<16xi64>) -> vector<16xi64>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (vector<16xi64>) -> vector<16xindex>
    "func.return"(%7) : (vector<16xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[16]xi1>, vector<[16]xindex>) -> vector<[16]xindex>, sym_name = "masked_load_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<[16]xindex>) -> vector<[16]xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.intr.masked.load"(%5, %arg1, %0) <{alignment = 8 : i32}> : (!llvm.ptr, vector<[16]xi1>, vector<[16]xi64>) -> vector<[16]xi64>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (vector<[16]xi64>) -> vector<[16]xindex>
    "func.return"(%7) : (vector<[16]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>, index) -> vector<16xf32>, sym_name = "masked_load_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.intr.masked.load"(%3, %arg1, %arg2) <{alignment = 2 : i32}> : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%4) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>) -> (), sym_name = "masked_store"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%arg2, %4, %arg1) <{alignment = 4 : i32}> : (vector<16xf32>, !llvm.ptr, vector<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[16]xi1>, vector<[16]xf32>) -> (), sym_name = "masked_store_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%arg2, %4, %arg1) <{alignment = 4 : i32}> : (vector<[16]xf32>, !llvm.ptr, vector<[16]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<16xi1>, vector<16xindex>) -> (), sym_name = "masked_store_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<16xi1>, %arg2: vector<16xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<16xindex>) -> vector<16xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%0, %5, %arg1) <{alignment = 8 : i32}> : (vector<16xi64>, !llvm.ptr, vector<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[16]xi1>, vector<[16]xindex>) -> (), sym_name = "masked_store_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[16]xi1>, %arg2: vector<[16]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<[16]xindex>) -> vector<[16]xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%0, %5, %arg1) <{alignment = 8 : i32}> : (vector<[16]xi64>, !llvm.ptr, vector<[16]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<16xi1>, vector<16xf32>, index) -> (), sym_name = "masked_store_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.store"(%arg2, %3, %arg1) <{alignment = 2 : i32}> : (vector<16xf32>, !llvm.ptr, vector<16xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    %6 = "llvm.intr.masked.gather"(%5, %arg2, %arg3) <{alignment = 4 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%6) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>, sym_name = "gather_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>
    %6 = "llvm.intr.masked.gather"(%5, %arg2, %arg3) <{alignment = 4 : i32}> : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    "func.return"(%6) : (vector<[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 1>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>, sym_name = "gather_global_memory"}> ({
  ^bb0(%arg0: memref<?xf32, 1>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, vector<3xi32>) -> vector<3x!llvm.ptr<1>>
    %6 = "llvm.intr.masked.gather"(%5, %arg2, %arg3) <{alignment = 4 : i32}> : (vector<3x!llvm.ptr<1>>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%6) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, 1>, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>, sym_name = "gather_global_memory_scalable"}> ({
  ^bb0(%arg0: memref<?xf32, 1>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, vector<[3]xi32>) -> vector<[3]x!llvm.ptr<1>>
    %6 = "llvm.intr.masked.gather"(%5, %arg2, %arg3) <{alignment = 4 : i32}> : (vector<[3]x!llvm.ptr<1>>, vector<[3]xi1>, vector<[3]xf32>) -> vector<[3]xf32>
    "func.return"(%6) : (vector<[3]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<3xindex>, vector<3xi1>, vector<3xindex>) -> vector<3xindex>, sym_name = "gather_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<3xindex>, %arg2: vector<3xi1>, %arg3: vector<3xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<3xindex>) -> vector<3xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<3xindex>) -> vector<3xi64>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %4) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi64>) -> vector<3x!llvm.ptr>
    %8 = "llvm.intr.masked.gather"(%7, %arg2, %0) <{alignment = 8 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xi64>) -> vector<3xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<3xi64>) -> vector<3xindex>
    "func.return"(%9) : (vector<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[3]xindex>, vector<[3]xi1>, vector<[3]xindex>) -> vector<[3]xindex>, sym_name = "gather_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[3]xindex>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<[3]xindex>) -> vector<[3]xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<[3]xindex>) -> vector<[3]xi64>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %4) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[3]xi64>) -> vector<[3]x!llvm.ptr>
    %8 = "llvm.intr.masked.gather"(%7, %arg2, %0) <{alignment = 8 : i32}> : (vector<[3]x!llvm.ptr>, vector<[3]xi1>, vector<[3]xi64>) -> vector<[3]xi64>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<[3]xi64>) -> vector<[3]xindex>
    "func.return"(%9) : (vector<[3]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>, vector<4xi32>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>, sym_name = "gather_1d_from_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x4xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %5 = "llvm.mul"(%2, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.getelementptr"(%7, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<4xi32>) -> vector<4x!llvm.ptr>
    %9 = "llvm.intr.masked.gather"(%8, %arg2, %arg3) <{alignment = 4 : i32}> : (vector<4x!llvm.ptr>, vector<4xi1>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%9) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32>, vector<[4]xi32>, vector<[4]xi1>, vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "gather_1d_from_2d_scalable"}> ({
  ^bb0(%arg0: memref<4x?xf32>, %arg1: vector<[4]xi32>, %arg2: vector<[4]xi1>, %arg3: vector<[4]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%2, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.getelementptr"(%7, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[4]xi32>) -> vector<[4]x!llvm.ptr>
    %9 = "llvm.intr.masked.gather"(%8, %arg2, %arg3) <{alignment = 4 : i32}> : (vector<[4]x!llvm.ptr>, vector<[4]xi1>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%9) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>, index) -> vector<3xf32>, sym_name = "gather_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>, %arg4: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    %5 = "llvm.intr.masked.gather"(%4, %arg2, %arg3) <{alignment = 8 : i32}> : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%5) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>) -> (), sym_name = "scatter"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %5, %arg2) <{alignment = 4 : i32}> : (vector<3xf32>, vector<3x!llvm.ptr>, vector<3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<[3]xi32>, vector<[3]xi1>, vector<[3]xf32>) -> (), sym_name = "scatter_scalable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<[3]xi32>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[3]xi32>) -> vector<[3]x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %5, %arg2) <{alignment = 4 : i32}> : (vector<[3]xf32>, vector<[3]x!llvm.ptr>, vector<[3]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<3xindex>, vector<3xi1>, vector<3xindex>) -> (), sym_name = "scatter_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<3xindex>, %arg2: vector<3xi1>, %arg3: vector<3xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<3xindex>) -> vector<3xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<3xindex>) -> vector<3xi64>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %4) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi64>) -> vector<3x!llvm.ptr>
    "llvm.intr.masked.scatter"(%0, %7, %arg2) <{alignment = 8 : i32}> : (vector<3xi64>, vector<3x!llvm.ptr>, vector<3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<[3]xindex>, vector<[3]xi1>, vector<[3]xindex>) -> (), sym_name = "scatter_index_scalable"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<[3]xindex>, %arg2: vector<[3]xi1>, %arg3: vector<[3]xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<[3]xindex>) -> vector<[3]xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<[3]xindex>) -> vector<[3]xi64>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %4) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[3]xi64>) -> vector<[3]x!llvm.ptr>
    "llvm.intr.masked.scatter"(%0, %7, %arg2) <{alignment = 8 : i32}> : (vector<[3]xi64>, vector<[3]x!llvm.ptr>, vector<[3]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>, vector<4xi32>, vector<4xi1>, vector<4xf32>) -> (), sym_name = "scatter_1d_into_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: vector<4xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x4xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %5 = "llvm.mul"(%2, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.getelementptr"(%7, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<4xi32>) -> vector<4x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %8, %arg2) <{alignment = 4 : i32}> : (vector<4xf32>, vector<4x!llvm.ptr>, vector<4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32>, vector<[4]xi32>, vector<[4]xi1>, vector<[4]xf32>) -> (), sym_name = "scatter_1d_into_2d_scalable"}> ({
  ^bb0(%arg0: memref<4x?xf32>, %arg1: vector<[4]xi32>, %arg2: vector<[4]xi1>, %arg3: vector<[4]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%2, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.getelementptr"(%7, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<[4]xi32>) -> vector<[4]x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %8, %arg2) <{alignment = 4 : i32}> : (vector<[4]xf32>, vector<[4]x!llvm.ptr>, vector<[4]xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<3xi32>, vector<3xi1>, vector<3xf32>, index) -> (), sym_name = "scatter_with_alignment"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>, %arg4: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %arg1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>
    "llvm.intr.masked.scatter"(%arg3, %4, %arg2) <{alignment = 8 : i32}> : (vector<3xf32>, vector<3x!llvm.ptr>, vector<3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<11xi1>, vector<11xf32>) -> vector<11xf32>, sym_name = "expand_load_op"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<11xi1>, %arg2: vector<11xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.intr.masked.expandload"(%4, %arg1, %arg2) : (!llvm.ptr, vector<11xi1>, vector<11xf32>) -> vector<11xf32>
    "func.return"(%5) : (vector<11xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>) -> vector<11xindex>, sym_name = "expand_load_op_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<11xindex>) -> vector<11xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.intr.masked.expandload"(%5, %arg1, %0) : (!llvm.ptr, vector<11xi1>, vector<11xi64>) -> vector<11xi64>
    %7 = "builtin.unrealized_conversion_cast"(%6) : (vector<11xi64>) -> vector<11xindex>
    "func.return"(%7) : (vector<11xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>, index) -> vector<11xindex>, sym_name = "expand_load_op_with_alignment"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<11xindex>) -> vector<11xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.intr.masked.expandload"(%4, %arg1, %0) <{arg_attrs = [{llvm.align = 8 : i64}, {}, {}]}> : (!llvm.ptr, vector<11xi1>, vector<11xi64>) -> vector<11xi64>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (vector<11xi64>) -> vector<11xindex>
    "func.return"(%6) : (vector<11xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<11xi1>, vector<11xf32>) -> (), sym_name = "compress_store_op"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<11xi1>, %arg2: vector<11xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.compressstore"(%arg2, %4, %arg1) : (vector<11xf32>, !llvm.ptr, vector<11xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>) -> (), sym_name = "compress_store_op_index"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<11xindex>) -> vector<11xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.compressstore"(%0, %5, %arg1) : (vector<11xi64>, !llvm.ptr, vector<11xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>, vector<11xi1>, vector<11xindex>, index) -> (), sym_name = "compress_store_op_with_alignment"}> ({
  ^bb0(%arg0: memref<?xindex>, %arg1: vector<11xi1>, %arg2: vector<11xindex>, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<11xindex>) -> vector<11xi64>
    %1 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.masked.compressstore"(%0, %4, %arg1) <{arg_attrs = [{}, {llvm.align = 8 : i64}, {}]}> : (vector<11xi64>, !llvm.ptr, vector<11xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "scalable_insert"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<[4]xf32>):
    %0 = "llvm.intr.vector.insert"(%arg1, %arg0) <{pos = 0 : i64}> : (vector<[4]xf32>, vector<4xf32>) -> vector<[4]xf32>
    %1 = "llvm.intr.vector.insert"(%0, %arg0) <{pos = 4 : i64}> : (vector<[4]xf32>, vector<4xf32>) -> vector<[4]xf32>
    "func.return"(%1) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<8xf32>, sym_name = "scalable_extract"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "llvm.intr.vector.extract"(%arg0) <{pos = 0 : i64}> : (vector<[4]xf32>) -> vector<8xf32>
    "func.return"(%0) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i8>, vector<i8>) -> vector<2xi8>, sym_name = "interleave_0d"}> ({
  ^bb0(%arg0: vector<i8>, %arg1: vector<i8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<i8>) -> vector<1xi8>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i8>) -> vector<1xi8>
    %2 = "llvm.shufflevector"(%1, %0) <{mask = array<i32: 0, 1>}> : (vector<1xi8>, vector<1xi8>) -> vector<2xi8>
    "func.return"(%2) : (vector<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf32>, vector<8xf32>) -> vector<16xf32>, sym_name = "interleave_1d"}> ({
  ^bb0(%arg0: vector<8xf32>, %arg1: vector<8xf32>):
    %0 = "llvm.shufflevector"(%arg0, %arg1) <{mask = array<i32: 0, 8, 1, 9, 2, 10, 3, 11, 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<16xf32>
    "func.return"(%0) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>, vector<[4]xi32>) -> vector<[8]xi32>, sym_name = "interleave_1d_scalable"}> ({
  ^bb0(%arg0: vector<[4]xi32>, %arg1: vector<[4]xi32>):
    %0 = "llvm.intr.vector.interleave2"(%arg0, %arg1) : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[8]xi32>
    "func.return"(%0) : (vector<[8]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<2xi32>, vector<2xi32>), sym_name = "deinterleave_1d"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "llvm.mlir.poison"() : () -> vector<4xi32>
    %1 = "llvm.shufflevector"(%arg0, %0) <{mask = array<i32: 0, 2>}> : (vector<4xi32>, vector<4xi32>) -> vector<2xi32>
    %2 = "llvm.shufflevector"(%arg0, %0) <{mask = array<i32: 1, 3>}> : (vector<4xi32>, vector<4xi32>) -> vector<2xi32>
    "func.return"(%1, %2) : (vector<2xi32>, vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> (vector<[2]xi32>, vector<[2]xi32>), sym_name = "deinterleave_1d_scalable"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "llvm.intr.vector.deinterleave2"(%arg0) : (vector<[4]xi32>) -> !llvm.struct<(vector<[2]xi32>, vector<[2]xi32>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(vector<[2]xi32>, vector<[2]xi32>)>) -> vector<[2]xi32>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(vector<[2]xi32>, vector<[2]xi32>)>) -> vector<[2]xi32>
    "func.return"(%1, %2) : (vector<[2]xi32>, vector<[2]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> vector<3xf32>, sym_name = "from_elements_1d"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<3xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<3xf32>, f32, i64) -> vector<3xf32>
    %3 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %4 = "llvm.insertelement"(%2, %arg1, %3) : (vector<3xf32>, f32, i64) -> vector<3xf32>
    %5 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %6 = "llvm.insertelement"(%4, %arg0, %5) : (vector<3xf32>, f32, i64) -> vector<3xf32>
    "func.return"(%6) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> vector<f32>, sym_name = "from_elements_0d"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.poison"() : () -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "llvm.insertelement"(%0, %arg0, %1) : (vector<1xf32>, f32, i64) -> vector<1xf32>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (vector<1xf32>) -> vector<f32>
    "func.return"(%3) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32, f32, f32), sym_name = "to_elements_no_dead_elements"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<4xf32>, i64) -> f32
    %2 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%arg0, %2) : (vector<4xf32>, i64) -> f32
    %4 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %5 = "llvm.extractelement"(%arg0, %4) : (vector<4xf32>, i64) -> f32
    %6 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %7 = "llvm.extractelement"(%arg0, %6) : (vector<4xf32>, i64) -> f32
    "func.return"(%1, %3, %5, %7) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (f32, f32), sym_name = "to_elements_dead_elements"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "llvm.extractelement"(%arg0, %0) : (vector<4xf32>, i64) -> f32
    %2 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %3 = "llvm.extractelement"(%arg0, %2) : (vector<4xf32>, i64) -> f32
    "func.return"(%1, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<[4]xindex>, sym_name = "step_scalable"}> ({
    %0 = "llvm.intr.stepvector"() : () -> vector<[4]xi64>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<[4]xi64>) -> vector<[4]xindex>
    "func.return"(%1) : (vector<[4]xindex>) -> ()
  }) : () -> ()
}) : () -> ()

