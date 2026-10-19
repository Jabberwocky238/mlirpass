module {
  func.func @no_memref_op(%arg0: memref<f32>) {
    %0 = memref.load %arg0[] : memref<f32>
    return
  }
}

