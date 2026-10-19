module {
  gpu.module @kernels {
    gpu.func @foo(%arg0: index, %arg1: memref<?xf32>) -> f32 {
      %0 = memref.load %arg1[%arg0] : memref<?xf32>
      gpu.return %0 : f32
    }
  }
}

