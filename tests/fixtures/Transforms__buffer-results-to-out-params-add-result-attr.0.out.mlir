module {
  func.func private @basic(%arg0: memref<f32> {bufferize.result}) {
    %0 = "test.source"() : () -> memref<f32>
    memref.copy %0, %arg0 : memref<f32> to memref<f32>
    return
  }
}

// -----
module {
  func.func private @multiple_results(%arg0: memref<1xf32> {bufferize.result}, %arg1: memref<2xf32> {bufferize.result}) {
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    memref.copy %0#0, %arg0 : memref<1xf32> to memref<1xf32>
    memref.copy %0#1, %arg1 : memref<2xf32> to memref<2xf32>
    return
  }
}

