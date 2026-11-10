module {
  func.func @abs_f32(%arg0: f32) -> f32 {
    %alloca = memref.alloca() : memref<f32>
    memref.store %arg0, %alloca[] : memref<f32>
    %0 = memref.load %alloca[] : memref<f32>
    %1 = math.absf %0 : f32
    return %1 : f32
  }
  func.func @abs_f64(%arg0: f64) -> f64 {
    %alloca = memref.alloca() : memref<f64>
    memref.store %arg0, %alloca[] : memref<f64>
    %0 = memref.load %alloca[] : memref<f64>
    %1 = math.absf %0 : f64
    return %1 : f64
  }
}

