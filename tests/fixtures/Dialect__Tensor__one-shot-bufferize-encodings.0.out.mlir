module {
  func.func @from_elements(%arg0: f32, %arg1: f32, %arg2: index) -> tensor<3xf32, 1 : i64> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3xf32, 1>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    memref.store %arg0, %alloc[%c0] : memref<3xf32, 1>
    memref.store %arg0, %alloc[%c1] : memref<3xf32, 1>
    memref.store %arg0, %alloc[%c2] : memref<3xf32, 1>
    memref.store %arg1, %alloc[%arg2] : memref<3xf32, 1>
    %0 = bufferization.to_tensor %alloc : memref<3xf32, 1> to tensor<3xf32, 1 : i64>
    return %0 : tensor<3xf32, 1 : i64>
  }
}

