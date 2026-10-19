"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "known_oob_load"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<4xf32>, i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>) -> f32, sym_name = "known_oob_load_2d"}> ({
  ^bb0(%arg0: memref<4x4xf32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %2 = "amdgpu.raw_buffer_load"(%arg0, %1, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<4x4xf32>, i32, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xf32>) -> f32, sym_name = "known_oob_load_2d_on_last"}> ({
  ^bb0(%arg0: memref<4x4xf32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %2 = "amdgpu.raw_buffer_load"(%arg0, %0, %1) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<4x4xf32>, i32, i32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "known_oob_load_index"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %0) <{boundsCheck = true, indexOffset = 4 : i32, operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<4xf32>, i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> f32, sym_name = "known_oob_load_sgproffset"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "amdgpu.raw_buffer_load"(%arg0, %0, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<4xf32>, i32, i32) -> f32
    "func.return"(%1) : (f32) -> ()
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
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    "amdgpu.raw_buffer_store"(%arg1, %arg0, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (f32, memref<4xf32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>, f32) -> (), sym_name = "dead_atomic_add"}> ({
  ^bb0(%arg0: memref<4xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    "amdgpu.raw_buffer_atomic_fadd"(%arg1, %arg0, %0) <{boundsCheck = true, operandSegmentSizes = array<i32: 1, 1, 1, 0>}> : (f32, memref<4xf32>, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, 1>, memref<64x64xf32, 3>) -> (), sym_name = "fold_gather_to_lds_of_cast"}> ({
  ^bb0(%arg0: memref<128x72xf32, 1>, %arg1: memref<64x64xf32, 3>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.cast"(%arg0) : (memref<128x72xf32, 1>) -> memref<?x?xf32, 1>
    "amdgpu.gather_to_lds"(%1, %0, %0, %arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<?x?xf32, 1>, index, index, memref<64x64xf32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x72xf32, 1>, memref<64x64xf32, 3>) -> (), sym_name = "fold_gather_to_lds_of_cast_dest"}> ({
  ^bb0(%arg0: memref<128x72xf32, 1>, %arg1: memref<64x64xf32, 3>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.cast"(%arg1) : (memref<64x64xf32, 3>) -> memref<?x?xf32, 3>
    "amdgpu.gather_to_lds"(%arg0, %0, %0, %1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 1, 2>, transferType = f32}> : (memref<128x72xf32, 1>, index, index, memref<?x?xf32, 3>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<2x1x8x1xf8E8M0FNU>, vector<2x1x8x1xf8E8M0FNU>) -> (vector<4xf32>, vector<4xf32>), sym_name = "scaled_mfma"}> ({
  ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<2x1x8x1xf8E8M0FNU>, %arg3: vector<2x1x8x1xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.constant"() <{value = dense<5.877470e-39> : vector<4xf8E8M0FNU>}> : () -> vector<4xf8E8M0FNU>
    %2 = "vector.extract"(%arg2) <{static_position = array<i64: 0, 0, 3, 0>}> : (vector<2x1x8x1xf8E8M0FNU>) -> f8E8M0FNU
    %3 = "vector.insert"(%2, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %4 = "vector.extract"(%arg3) <{static_position = array<i64: 0, 0, 6, 0>}> : (vector<2x1x8x1xf8E8M0FNU>) -> f8E8M0FNU
    %5 = "vector.insert"(%4, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %6 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %3, %5) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %7 = "vector.extract"(%arg2) <{static_position = array<i64: 1, 0, 1, 0>}> : (vector<2x1x8x1xf8E8M0FNU>) -> f8E8M0FNU
    %8 = "vector.insert"(%7, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %9 = "vector.extract"(%arg3) <{static_position = array<i64: 1, 0, 4, 0>}> : (vector<2x1x8x1xf8E8M0FNU>) -> f8E8M0FNU
    %10 = "vector.insert"(%9, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %11 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %8, %10) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%6, %11) : (vector<4xf32>, vector<4xf32>) -> ()
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
    %1 = "arith.constant"() <{value = dense<5.877470e-39> : vector<4xf8E8M0FNU>}> : () -> vector<4xf8E8M0FNU>
    %2 = "vector.extract"(%arg2) <{static_position = array<i64: 4, 0>}> : (vector<5x5xf8E8M0FNU>) -> f8E8M0FNU
    %3 = "vector.extract"(%arg2) <{static_position = array<i64: 4, 1>}> : (vector<5x5xf8E8M0FNU>) -> f8E8M0FNU
    %4 = "vector.extract"(%arg2) <{static_position = array<i64: 4, 2>}> : (vector<5x5xf8E8M0FNU>) -> f8E8M0FNU
    %5 = "vector.extract"(%arg2) <{static_position = array<i64: 4, 3>}> : (vector<5x5xf8E8M0FNU>) -> f8E8M0FNU
    %6 = "vector.extract"(%arg3) <{static_position = array<i64: 6, 22>}> : (vector<7x23xf8E8M0FNU>) -> f8E8M0FNU
    %7 = "vector.extract"(%arg3) <{static_position = array<i64: 6, 21>}> : (vector<7x23xf8E8M0FNU>) -> f8E8M0FNU
    %8 = "vector.extract"(%arg3) <{static_position = array<i64: 6, 20>}> : (vector<7x23xf8E8M0FNU>) -> f8E8M0FNU
    %9 = "vector.extract"(%arg3) <{static_position = array<i64: 6, 19>}> : (vector<7x23xf8E8M0FNU>) -> f8E8M0FNU
    %10 = "vector.insert"(%2, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %11 = "vector.insert"(%3, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %12 = "vector.insert"(%4, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %13 = "vector.insert"(%5, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %14 = "vector.insert"(%6, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %15 = "vector.insert"(%7, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %16 = "vector.insert"(%8, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %17 = "vector.insert"(%9, %1) <{static_position = array<i64: 0>}> : (f8E8M0FNU, vector<4xf8E8M0FNU>) -> vector<4xf8E8M0FNU>
    %18 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %10, %14) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %19 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %11, %15) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %20 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %12, %16) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    %21 = "amdgpu.scaled_mfma"(%arg0, %arg1, %0, %13, %17) <{k = 128 : i32, m = 16 : i32, n = 16 : i32, scalesIdxA = 0 : i32, scalesIdxB = 0 : i32}> : (vector<32xf4E2M1FN>, vector<32xf4E2M1FN>, vector<4xf32>, vector<4xf8E8M0FNU>, vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%18, %19, %20, %21) : (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "fuse_memory_counter_wait"}> ({
    "amdgpu.memory_counter_wait"() <{ds = 3 : i32, exp = 4 : i32, load = 1 : i32, store = 2 : i32, tensor = 5 : i32}> : () -> ()
    "amdgpu.memory_counter_wait"() <{ds = 2 : i32, exp = 1 : i32, load = 4 : i32, store = 3 : i32, tensor = 0 : i32}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "fuse_memory_counter_wait_different_counters"}> ({
    "amdgpu.memory_counter_wait"() <{load = 1 : i32, store = 2 : i32}> : () -> ()
    "amdgpu.memory_counter_wait"() <{ds = 3 : i32, exp = 4 : i32}> : () -> ()
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
    "amdgpu.lds_barrier"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

