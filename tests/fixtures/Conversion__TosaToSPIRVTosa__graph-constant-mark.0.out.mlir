module {
  func.func @large_const() -> tensor<17xi32> {
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 0 : i32} : () -> tensor<17xi32>
    return %0 : tensor<17xi32>
  }
}

// -----
module {
  func.func @small_const() -> tensor<16xi32> {
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : tensor<16xi32>}> : () -> tensor<16xi32>
    return %0 : tensor<16xi32>
  }
}

// -----
module {
  func.func @large_const_shape() -> !tosa.shape<33> {
    %0 = tosa.const_shape  {grapharm.graph_constant_id = 0 : i32, values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]> : tensor<33xindex>} : () -> !tosa.shape<33>
    return %0 : !tosa.shape<33>
  }
}

// -----
module {
  func.func @small_const_shape() -> !tosa.shape<32> {
    %0 = tosa.const_shape  {values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]> : tensor<32xindex>} : () -> !tosa.shape<32>
    return %0 : !tosa.shape<32>
  }
}

// -----
module {
  func.func @mixed_large_constants() -> (tensor<17xi32>, tensor<18xi32>, !tosa.shape<33>) {
    %0 = "tosa.const"() <{values = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : tensor<17xi32>}> {grapharm.graph_constant_id = 0 : i32} : () -> tensor<17xi32>
    %1 = "tosa.const"() <{values = dense<[20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37]> : tensor<18xi32>}> {grapharm.graph_constant_id = 1 : i32} : () -> tensor<18xi32>
    %2 = tosa.const_shape  {grapharm.graph_constant_id = 2 : i32, values = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]> : tensor<33xindex>} : () -> !tosa.shape<33>
    return %0, %1, %2 : tensor<17xi32>, tensor<18xi32>, !tosa.shape<33>
  }
}

