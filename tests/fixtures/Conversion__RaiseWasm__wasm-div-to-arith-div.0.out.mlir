module {
  func.func @div_i32_si(%arg0: i32, %arg1: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg1, %alloca[] : memref<i32>
    %alloca_0 = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca_0[] : memref<i32>
    %0 = memref.load %alloca_0[] : memref<i32>
    %1 = memref.load %alloca[] : memref<i32>
    %2 = arith.divsi %0, %1 : i32
    return %2 : i32
  }
  func.func @div_i64_si(%arg0: i64, %arg1: i64) -> i64 {
    %alloca = memref.alloca() : memref<i64>
    memref.store %arg1, %alloca[] : memref<i64>
    %alloca_0 = memref.alloca() : memref<i64>
    memref.store %arg0, %alloca_0[] : memref<i64>
    %0 = memref.load %alloca_0[] : memref<i64>
    %1 = memref.load %alloca[] : memref<i64>
    %2 = arith.divsi %0, %1 : i64
    return %2 : i64
  }
  func.func @div_i32_ui(%arg0: i32, %arg1: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg1, %alloca[] : memref<i32>
    %alloca_0 = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca_0[] : memref<i32>
    %0 = memref.load %alloca_0[] : memref<i32>
    %1 = memref.load %alloca[] : memref<i32>
    %2 = arith.divui %0, %1 : i32
    return %2 : i32
  }
  func.func @div_i64_ui(%arg0: i64, %arg1: i64) -> i64 {
    %alloca = memref.alloca() : memref<i64>
    memref.store %arg1, %alloca[] : memref<i64>
    %alloca_0 = memref.alloca() : memref<i64>
    memref.store %arg0, %alloca_0[] : memref<i64>
    %0 = memref.load %alloca_0[] : memref<i64>
    %1 = memref.load %alloca[] : memref<i64>
    %2 = arith.divui %0, %1 : i64
    return %2 : i64
  }
  func.func @div_f32(%arg0: f32, %arg1: f32) -> f32 {
    %alloca = memref.alloca() : memref<f32>
    memref.store %arg1, %alloca[] : memref<f32>
    %alloca_0 = memref.alloca() : memref<f32>
    memref.store %arg0, %alloca_0[] : memref<f32>
    %0 = memref.load %alloca_0[] : memref<f32>
    %1 = memref.load %alloca[] : memref<f32>
    %2 = arith.divf %0, %1 : f32
    return %2 : f32
  }
  func.func @div_f64(%arg0: f64, %arg1: f64) -> f64 {
    %alloca = memref.alloca() : memref<f64>
    memref.store %arg1, %alloca[] : memref<f64>
    %alloca_0 = memref.alloca() : memref<f64>
    memref.store %arg0, %alloca_0[] : memref<f64>
    %0 = memref.load %alloca_0[] : memref<f64>
    %1 = memref.load %alloca[] : memref<f64>
    %2 = arith.divf %0, %1 : f64
    return %2 : f64
  }
}

