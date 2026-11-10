module {
  func.func @min_f32(%arg0: f32, %arg1: f32) -> f32 {
    %alloca = memref.alloca() : memref<f32>
    memref.store %arg1, %alloca[] : memref<f32>
    %alloca_0 = memref.alloca() : memref<f32>
    memref.store %arg0, %alloca_0[] : memref<f32>
    %0 = memref.load %alloca_0[] : memref<f32>
    %1 = memref.load %alloca[] : memref<f32>
    %2 = arith.minimumf %0, %1 : f32
    return %2 : f32
  }
  func.func @min_f64(%arg0: f64, %arg1: f64) -> f64 {
    %alloca = memref.alloca() : memref<f64>
    memref.store %arg1, %alloca[] : memref<f64>
    %alloca_0 = memref.alloca() : memref<f64>
    memref.store %arg0, %alloca_0[] : memref<f64>
    %0 = memref.load %alloca_0[] : memref<f64>
    %1 = memref.load %alloca[] : memref<f64>
    %2 = arith.minimumf %0, %1 : f64
    return %2 : f64
  }
}

