module {
  func.func @known_oob_load(%arg0: memref<4xf32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
}

// -----
module {
  func.func @known_oob_load_2d(%arg0: memref<4x4xf32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
}

// -----
module {
  func.func @known_oob_load_2d_on_last(%arg0: memref<4x4xf32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
}

// -----
module {
  func.func @known_oob_load_index(%arg0: memref<4xf32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
}

// -----
module {
  func.func @known_oob_load_sgproffset(%arg0: memref<4xf32>) -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
}

// -----
module {
  func.func @unknown_load(%arg0: memref<4xf32>, %arg1: i32) -> f32 {
    %c4_i32 = arith.constant 4 : i32
    %0 = amdgpu.raw_buffer_load %arg0[%arg1] sgprOffset %c4_i32 : memref<4xf32>, i32 -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @unknown_load_sgproffset(%arg0: memref<4xf32>, %arg1: i32) -> f32 {
    %c4_i32 = arith.constant 4 : i32
    %0 = amdgpu.raw_buffer_load %arg0[%c4_i32] sgprOffset %arg1 : memref<4xf32>, i32 -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @unranked(%arg0: memref<?xf32>) -> f32 {
    %c4_i32 = arith.constant 4 : i32
    %0 = amdgpu.raw_buffer_load %arg0[%c4_i32] : memref<?xf32>, i32 -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @no_oob_check(%arg0: memref<4xf32>) -> f32 {
    %c4_i32 = arith.constant 4 : i32
    %0 = amdgpu.raw_buffer_load {boundsCheck = false} %arg0[%c4_i32] : memref<4xf32>, i32 -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @in_bounds_overall(%arg0: memref<4x4xf32>) -> f32 {
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %0 = amdgpu.raw_buffer_load %arg0[%c0_i32, %c15_i32] : memref<4x4xf32>, i32, i32 -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @dead_store(%arg0: memref<4xf32>, %arg1: f32) {
    return
  }
}

// -----
module {
  func.func @dead_atomic_add(%arg0: memref<4xf32>, %arg1: f32) {
    return
  }
}

// -----
module {
  func.func @fold_gather_to_lds_of_cast(%arg0: memref<128x72xf32, 1>, %arg1: memref<64x64xf32, 3>) {
    %c0 = arith.constant 0 : index
    amdgpu.gather_to_lds %arg0[%c0, %c0], %arg1[%c0, %c0] : f32, memref<128x72xf32, 1>, memref<64x64xf32, 3>
    return
  }
}

// -----
module {
  func.func @fold_gather_to_lds_of_cast_dest(%arg0: memref<128x72xf32, 1>, %arg1: memref<64x64xf32, 3>) {
    %c0 = arith.constant 0 : index
    amdgpu.gather_to_lds %arg0[%c0, %c0], %arg1[%c0, %c0] : f32, memref<128x72xf32, 1>, memref<64x64xf32, 3>
    return
  }
}

// -----
module {
  func.func @scaled_mfma(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<2x1x8x1xf8E8M0FNU>, %arg3: vector<2x1x8x1xf8E8M0FNU>) -> (vector<4xf32>, vector<4xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %0 = vector.shape_cast %arg2 : vector<2x1x8x1xf8E8M0FNU> to vector<16xf8E8M0FNU>
    %1 = vector.extract_strided_slice %0 {offsets = [0], sizes = [4], strides = [1]} : vector<16xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %2 = vector.shape_cast %arg3 : vector<2x1x8x1xf8E8M0FNU> to vector<16xf8E8M0FNU>
    %3 = vector.extract_strided_slice %2 {offsets = [4], sizes = [4], strides = [1]} : vector<16xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %4 = amdgpu.scaled_mfma 16x16x128 (%1[3] * %arg0) * (%3[2] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    %5 = vector.shape_cast %arg2 : vector<2x1x8x1xf8E8M0FNU> to vector<16xf8E8M0FNU>
    %6 = vector.extract_strided_slice %5 {offsets = [8], sizes = [4], strides = [1]} : vector<16xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %7 = vector.shape_cast %arg3 : vector<2x1x8x1xf8E8M0FNU> to vector<16xf8E8M0FNU>
    %8 = vector.extract_strided_slice %7 {offsets = [12], sizes = [4], strides = [1]} : vector<16xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %9 = amdgpu.scaled_mfma 16x16x128 (%6[1] * %arg0) * (%8[0] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    return %4, %9 : vector<4xf32>, vector<4xf32>
  }
}

// -----
module {
  func.func @scaled_mfma_less_than_4(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<2xf8E8M0FNU>, %arg3: vector<2xf8E8M0FNU>) -> vector<4xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant dense<5.877470e-39> : vector<4xf8E8M0FNU>
    %0 = vector.extract %arg2[0] : f8E8M0FNU from vector<2xf8E8M0FNU>
    %1 = vector.insert %0, %cst_0 [0] : f8E8M0FNU into vector<4xf8E8M0FNU>
    %2 = vector.extract %arg3[1] : f8E8M0FNU from vector<2xf8E8M0FNU>
    %3 = vector.insert %2, %cst_0 [0] : f8E8M0FNU into vector<4xf8E8M0FNU>
    %4 = amdgpu.scaled_mfma 16x16x128 (%1[0] * %arg0) * (%3[0] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    return %4 : vector<4xf32>
  }
}

// -----
module {
  func.func @scaled_mfma_ugly_shapes(%arg0: vector<32xf4E2M1FN>, %arg1: vector<32xf4E2M1FN>, %arg2: vector<5x5xf8E8M0FNU>, %arg3: vector<7x23xf8E8M0FNU>) -> (vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %0 = vector.shape_cast %arg2 : vector<5x5xf8E8M0FNU> to vector<25xf8E8M0FNU>
    %1 = vector.extract_strided_slice %0 {offsets = [20], sizes = [4], strides = [1]} : vector<25xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %2 = vector.shape_cast %arg3 : vector<7x23xf8E8M0FNU> to vector<161xf8E8M0FNU>
    %3 = vector.extract_strided_slice %2 {offsets = [157], sizes = [4], strides = [1]} : vector<161xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %4 = amdgpu.scaled_mfma 16x16x128 (%1[0] * %arg0) * (%3[3] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    %5 = vector.shape_cast %arg2 : vector<5x5xf8E8M0FNU> to vector<25xf8E8M0FNU>
    %6 = vector.extract_strided_slice %5 {offsets = [20], sizes = [4], strides = [1]} : vector<25xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %7 = vector.shape_cast %arg3 : vector<7x23xf8E8M0FNU> to vector<161xf8E8M0FNU>
    %8 = vector.extract_strided_slice %7 {offsets = [156], sizes = [4], strides = [1]} : vector<161xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %9 = amdgpu.scaled_mfma 16x16x128 (%6[1] * %arg0) * (%8[3] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    %10 = vector.shape_cast %arg2 : vector<5x5xf8E8M0FNU> to vector<25xf8E8M0FNU>
    %11 = vector.extract_strided_slice %10 {offsets = [20], sizes = [4], strides = [1]} : vector<25xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %12 = vector.shape_cast %arg3 : vector<7x23xf8E8M0FNU> to vector<161xf8E8M0FNU>
    %13 = vector.extract_strided_slice %12 {offsets = [156], sizes = [4], strides = [1]} : vector<161xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %14 = amdgpu.scaled_mfma 16x16x128 (%11[2] * %arg0) * (%13[2] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    %15 = vector.shape_cast %arg2 : vector<5x5xf8E8M0FNU> to vector<25xf8E8M0FNU>
    %16 = vector.extract_strided_slice %15 {offsets = [20], sizes = [4], strides = [1]} : vector<25xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %17 = vector.shape_cast %arg3 : vector<7x23xf8E8M0FNU> to vector<161xf8E8M0FNU>
    %18 = vector.extract_strided_slice %17 {offsets = [156], sizes = [4], strides = [1]} : vector<161xf8E8M0FNU> to vector<4xf8E8M0FNU>
    %19 = amdgpu.scaled_mfma 16x16x128 (%16[3] * %arg0) * (%18[1] * %arg1) + %cst : vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, vector<32xf4E2M1FN>, vector<4xf32>
    return %4, %9, %14, %19 : vector<4xf32>, vector<4xf32>, vector<4xf32>, vector<4xf32>
  }
}

// -----
module {
  func.func @fuse_memory_counter_wait() {
    amdgpu.memory_counter_wait load(1) store(2) ds(2) exp(1) tensor(0)
    return
  }
  func.func @fuse_memory_counter_wait_different_counters() {
    amdgpu.memory_counter_wait load(1) store(2) ds(3) exp(4)
    return
  }
  func.func private @use()
  func.func @fuse_memory_counter_wait_not_adjacent() {
    amdgpu.memory_counter_wait load(1) store(2) ds(3) exp(4)
    call @use() : () -> ()
    amdgpu.memory_counter_wait load(4) store(3) ds(2) exp(1)
    return
  }
}

// -----
module {
  func.func @erase_barriers() {
    amdgpu.lds_barrier
    return
  }
}

