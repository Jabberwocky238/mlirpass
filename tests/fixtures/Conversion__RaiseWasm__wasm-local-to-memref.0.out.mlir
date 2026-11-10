module {
  func.func @func_0() -> f32 {
    %alloca = memref.alloca() : memref<f32>
    %cst = arith.constant 0.000000e+00 : f32
    memref.store %cst, %alloca[] : memref<f32>
    %alloca_0 = memref.alloca() : memref<f32>
    %cst_1 = arith.constant 0.000000e+00 : f32
    memref.store %cst_1, %alloca_0[] : memref<f32>
    %cst_2 = arith.constant 8.000000e+00 : f32
    memref.store %cst_2, %alloca[] : memref<f32>
    %0 = memref.load %alloca[] : memref<f32>
    %cst_3 = arith.constant 1.200000e+01 : f32
    memref.store %cst_3, %alloca_0[] : memref<f32>
    %1 = arith.addf %0, %cst_3 : f32
    return %1 : f32
  }
  func.func @func_1() -> i32 {
    %alloca = memref.alloca() : memref<i32>
    %c0_i32 = arith.constant 0 : i32
    memref.store %c0_i32, %alloca[] : memref<i32>
    %alloca_0 = memref.alloca() : memref<i32>
    %c0_i32_1 = arith.constant 0 : i32
    memref.store %c0_i32_1, %alloca_0[] : memref<i32>
    %c8_i32 = arith.constant 8 : i32
    memref.store %c8_i32, %alloca[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    %c12_i32 = arith.constant 12 : i32
    memref.store %c12_i32, %alloca_0[] : memref<i32>
    %1 = arith.addi %0, %c12_i32 : i32
    return %1 : i32
  }
  func.func @func_2(%arg0: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca[] : memref<i32>
    %c3_i32 = arith.constant 3 : i32
    memref.store %c3_i32, %alloca[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

