module {
  func.func @basic(%arg0: memref<f32>) {
    %0 = "test.source"() : () -> memref<f32>
    memref.copy %0, %arg0 : memref<f32> to memref<f32>
    return
  }
  func.func @presence_of_existing_arguments(%arg0: memref<1xf32>, %arg1: memref<2xf32>) {
    %0 = "test.source"() : () -> memref<2xf32>
    memref.copy %0, %arg1 : memref<2xf32> to memref<2xf32>
    return
  }
  func.func @multiple_results(%arg0: memref<1xf32>, %arg1: memref<2xf32>) {
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    memref.copy %0#0, %arg0 : memref<1xf32> to memref<1xf32>
    memref.copy %0#1, %arg1 : memref<2xf32> to memref<2xf32>
    return
  }
}

