"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "known_oob_load"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>) -> f32, sym_name = "known_oob_load_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>) -> f32, sym_name = "known_oob_load_2d_on_last"}> ({
  ^bb0(%arg0: memref<4x4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "known_oob_load_index"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "known_oob_load_sgproffset"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>, i32) -> f32, sym_name = "unknown_load"}> ({
  ^bb0(%arg0: memref<4xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %arg1, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<4xf32>, i32, i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>, i32) -> f32, sym_name = "unknown_load_sgproffset"}> ({
  ^bb0(%arg0: memref<4xf32>, %arg1: i32):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %0, %arg1) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<4xf32>, i32, i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> f32, sym_name = "unranked"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<?xf32>, i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "no_oob_check"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %0) <{boundsCheck = false, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<4xf32>, i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>) -> f32, sym_name = "in_bounds_overall"}> ({
  ^bb0(%arg0: memref<4x4xf32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %2 = "amdgpu.raw_buffer_load"(%arg0, %0, %1) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<4x4xf32>, i32, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>, f32) -> (), sym_name = "dead_store"}> ({
  ^bb0(%arg0: memref<4xf32>, %arg1: f32):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>, f32) -> (), sym_name = "dead_atomic_add"}> ({
  ^bb0(%arg0: memref<4xf32>, %arg1: f32):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, 1>, memref<64x64xf32, 3>) -> (), sym_name = "fold_gather_to_lds_of_cast"}> ({
  ^bb0(%arg0: memref<128x72xf32, 1>, %arg1: memref<64x64xf32, 3>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "amdgpu.gather_to_lds"(%arg0, %0, %0, %arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, 1>, index, index, memref<64x64xf32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, 1>, memref<64x64xf32, 3>) -> (), sym_name = "fold_gather_to_lds_of_cast_dest"}> ({
  ^bb0(%arg0: memref<128x72xf32, 1>, %arg1: memref<64x64xf32, 3>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "amdgpu.gather_to_lds"(%arg0, %0, %0, %arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, 1>, index, index, memref<64x64xf32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<2x1x8x1xf8E8M0FNU>, vector<2x1x8x1xf8E8M0FNU>) -> (vector<4xf32>, vector<4xf32>), sym_name = "scaled_mfma"}> ({
  ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<2x1x8x1xf8E8M0FNU>, %arg3: vector<2x1x8x1xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "vector.shape_cast"(%arg2) : (vector<2x1x8x1xf8E8M0FNU>) -> vector<16xf8E8M0FNU>
    %2 = "vector.extract_strided_slice"(%1) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<16xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %3 = "vector.shape_cast"(%arg3) : (vector<2x1x8x1xf8E8M0FNU>) -> vector<16xf8E8M0FNU>
    %4 = "vector.extract_strided_slice"(%3) <{offsets = [4], sizes = [4], strides = [1]}> : (vector<16xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %5 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %2, %4) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 3 : i32, scalesIdxB = 2 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %6 = "vector.shape_cast"(%arg2) : (vector<2x1x8x1xf8E8M0FNU>) -> vector<16xf8E8M0FNU>
    %7 = "vector.extract_strided_slice"(%6) <{offsets = [8], sizes = [4], strides = [1]}> : (vector<16xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %8 = "vector.shape_cast"(%arg3) : (vector<2x1x8x1xf8E8M0FNU>) -> vector<16xf8E8M0FNU>
    %9 = "vector.extract_strided_slice"(%8) <{offsets = [12], sizes = [4], strides = [1]}> : (vector<16xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %10 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %7, %9) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 1 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%5, %10) : (vector<4xf32>, vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<2xf8E8M0FNU>, vector<2xf8E8M0FNU>) -> vector<4xf32>, sym_name = "scaled_mfma_less_than_4"}> ({
  ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<2xf8E8M0FNU>, %arg3: vector<2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.constant"() <{value = dense<5.877470e-39> : vector<4xf8E8M0FNU>}> : () -> vector<4xf8E8M0FNU>
    %2 = "vector.extract"(%arg2) <{static_position = array<i64: 0>}> : (vector<2xf8E8M0FNU>) -> f8E8M0FNU
    %3 = "vector.insert"(%2, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %4 = "vector.extract"(%arg3) <{static_position = array<i64: 1>}> : (vector<2xf8E8M0FNU>) -> f8E8M0FNU
    %5 = "vector.insert"(%4, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %6 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %3, %5) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%6) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<5x5xf8E8M0FNU>, vector<7x23xf8E8M0FNU>) -> (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>), sym_name = "scaled_mfma_ugly_shapes"}> ({
  ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<5x5xf8E8M0FNU>, %arg3: vector<7x23xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "vector.shape_cast"(%arg2) : (vector<5x5xf8E8M0FNU>) -> vector<25xf8E8M0FNU>
    %2 = "vector.extract_strided_slice"(%1) <{offsets = [20], sizes = [4], strides = [1]}> : (vector<25xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %3 = "vector.shape_cast"(%arg3) : (vector<7x23xf8E8M0FNU>) -> vector<161xf8E8M0FNU>
    %4 = "vector.extract_strided_slice"(%3) <{offsets = [157], sizes = [4], strides = [1]}> : (vector<161xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %5 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %2, %4) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 3 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %6 = "vector.shape_cast"(%arg2) : (vector<5x5xf8E8M0FNU>) -> vector<25xf8E8M0FNU>
    %7 = "vector.extract_strided_slice"(%6) <{offsets = [20], sizes = [4], strides = [1]}> : (vector<25xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %8 = "vector.shape_cast"(%arg3) : (vector<7x23xf8E8M0FNU>) -> vector<161xf8E8M0FNU>
    %9 = "vector.extract_strided_slice"(%8) <{offsets = [156], sizes = [4], strides = [1]}> : (vector<161xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %10 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %7, %9) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 1 : i32, scalesIdxB = 3 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %11 = "vector.shape_cast"(%arg2) : (vector<5x5xf8E8M0FNU>) -> vector<25xf8E8M0FNU>
    %12 = "vector.extract_strided_slice"(%11) <{offsets = [20], sizes = [4], strides = [1]}> : (vector<25xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %13 = "vector.shape_cast"(%arg3) : (vector<7x23xf8E8M0FNU>) -> vector<161xf8E8M0FNU>
    %14 = "vector.extract_strided_slice"(%13) <{offsets = [156], sizes = [4], strides = [1]}> : (vector<161xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %15 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %12, %14) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 2 : i32, scalesIdxB = 2 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %16 = "vector.shape_cast"(%arg2) : (vector<5x5xf8E8M0FNU>) -> vector<25xf8E8M0FNU>
    %17 = "vector.extract_strided_slice"(%16) <{offsets = [20], sizes = [4], strides = [1]}> : (vector<25xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %18 = "vector.shape_cast"(%arg3) : (vector<7x23xf8E8M0FNU>) -> vector<161xf8E8M0FNU>
    %19 = "vector.extract_strided_slice"(%18) <{offsets = [156], sizes = [4], strides = [1]}> : (vector<161xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %20 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %17, %19) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 3 : i32, scalesIdxB = 1 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%5, %10, %15, %20) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "fuse_memory_counter_wait"}> ({
    "amdgpu.memory_counter_wait"() <{ds = 2 : i32, exp = 1 : i32, load = 1 : i32, store = 2 : i32, tensor = 0 : i32}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "fuse_memory_counter_wait_different_counters"}> ({
    "amdgpu.memory_counter_wait"() <{ds = 3 : i32, exp = 4 : i32, load = 1 : i32, store = 2 : i32}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "fuse_memory_counter_wait_not_adjacent"}> ({
    "amdgpu.memory_counter_wait"() <{ds = 3 : i32, exp = 4 : i32, load = 1 : i32, store = 2 : i32}> : () -> ()
    "func.call"() <{callee = @use}> : () -> ()
    "amdgpu.memory_counter_wait"() <{ds = 2 : i32, exp = 1 : i32, load = 4 : i32, store = 3 : i32}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "erase_barriers"}> ({
    "amdgpu.lds_barrier"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

