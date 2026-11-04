module {
  func.func @dim(%arg0: tensor<*xf32>, %arg1: index) -> index {
    %0 = bufferization.to_buffer %arg0 : tensor<*xf32> to memref<*xf32>
    %dim = memref.dim %0, %arg1 : memref<*xf32>
    return %dim : index
  }
}

// -----
module {
  func.func @rank(%arg0: tensor<*xf32>) -> index {
    %0 = bufferization.to_buffer %arg0 : tensor<*xf32> to memref<*xf32>
    %1 = memref.rank %0 : memref<*xf32>
    return %1 : index
  }
}

// -----
module {
  func.func @tensor.cast(%arg0: tensor<?xindex>) -> tensor<2xindex> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xindex> to memref<?xindex>
    %cast = memref.cast %0 : memref<?xindex> to memref<2xindex>
    %1 = bufferization.to_tensor %cast : memref<2xindex> to tensor<2xindex>
    return %1 : tensor<2xindex>
  }
}

// -----
module {
  func.func @tensor.cast_from_unranked(%arg0: tensor<*xf32>) -> tensor<2xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<*xf32> to memref<*xf32>
    %cast = memref.cast %0 : memref<*xf32> to memref<2xf32, strided<[?], offset: ?>>
    %1 = bufferization.to_tensor %cast : memref<2xf32, strided<[?], offset: ?>> to tensor<2xf32>
    return %1 : tensor<2xf32>
  }
}

// -----
module {
  func.func @tensor.cast_to_unranked(%arg0: tensor<2xf32>) -> tensor<*xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<2xf32> to memref<2xf32>
    %cast = memref.cast %0 : memref<2xf32> to memref<*xf32>
    %1 = bufferization.to_tensor %cast : memref<*xf32> to tensor<*xf32>
    return %1 : tensor<*xf32>
  }
}

// -----
module {
  func.func @tensor.empty() -> tensor<5xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %0 = bufferization.to_tensor %alloc : memref<5xf32> to tensor<5xf32>
    return %0 : tensor<5xf32>
  }
}

// -----
module {
  func.func @tensor.extract(%arg0: tensor<?xf32>, %arg1: index) -> f32 {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32>
    %1 = memref.load %0[%arg1] : memref<?xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @tensor.from_elements_0d(%arg0: index) -> tensor<index> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<index>
    memref.store %arg0, %alloc[] : memref<index>
    %0 = bufferization.to_tensor %alloc : memref<index> to tensor<index>
    return %0 : tensor<index>
  }
}

// -----
module {
  func.func @tensor.from_elements_1d(%arg0: index, %arg1: index) -> tensor<2xindex> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2xindex>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    memref.store %arg0, %alloc[%c0] : memref<2xindex>
    memref.store %arg1, %alloc[%c1] : memref<2xindex>
    %0 = bufferization.to_tensor %alloc : memref<2xindex> to tensor<2xindex>
    return %0 : tensor<2xindex>
  }
}

// -----
module {
  func.func @tensor.from_elements_2d(%arg0: index, %arg1: index) -> tensor<3x2xindex> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3x2xindex>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    memref.store %arg0, %alloc[%c0, %c0] : memref<3x2xindex>
    memref.store %arg1, %alloc[%c0, %c1] : memref<3x2xindex>
    memref.store %arg0, %alloc[%c1, %c0] : memref<3x2xindex>
    memref.store %arg1, %alloc[%c1, %c1] : memref<3x2xindex>
    memref.store %arg0, %alloc[%c2, %c0] : memref<3x2xindex>
    memref.store %arg1, %alloc[%c2, %c1] : memref<3x2xindex>
    %0 = bufferization.to_tensor %alloc : memref<3x2xindex> to tensor<3x2xindex>
    return %0 : tensor<3x2xindex>
  }
}

// -----
module {
  func.func @tensor.from_elements_3d(%arg0: f32) -> tensor<3x2x2xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %cst_1 = arith.constant 3.000000e+00 : f32
    %cst_2 = arith.constant 4.000000e+00 : f32
    %cst_3 = arith.constant 5.000000e+00 : f32
    %cst_4 = arith.constant 6.000000e+00 : f32
    %cst_5 = arith.constant 7.000000e+00 : f32
    %cst_6 = arith.constant 8.000000e+00 : f32
    %cst_7 = arith.constant 9.000000e+00 : f32
    %cst_8 = arith.constant 1.000000e+01 : f32
    %cst_9 = arith.constant 1.100000e+01 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3x2x2xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    memref.store %arg0, %alloc[%c0, %c0, %c0] : memref<3x2x2xf32>
    memref.store %cst, %alloc[%c0, %c0, %c1] : memref<3x2x2xf32>
    memref.store %cst_0, %alloc[%c0, %c1, %c0] : memref<3x2x2xf32>
    memref.store %cst_1, %alloc[%c0, %c1, %c1] : memref<3x2x2xf32>
    memref.store %cst_2, %alloc[%c1, %c0, %c0] : memref<3x2x2xf32>
    memref.store %cst_3, %alloc[%c1, %c0, %c1] : memref<3x2x2xf32>
    memref.store %cst_4, %alloc[%c1, %c1, %c0] : memref<3x2x2xf32>
    memref.store %cst_5, %alloc[%c1, %c1, %c1] : memref<3x2x2xf32>
    memref.store %cst_6, %alloc[%c2, %c0, %c0] : memref<3x2x2xf32>
    memref.store %cst_7, %alloc[%c2, %c0, %c1] : memref<3x2x2xf32>
    memref.store %cst_8, %alloc[%c2, %c1, %c0] : memref<3x2x2xf32>
    memref.store %cst_9, %alloc[%c2, %c1, %c1] : memref<3x2x2xf32>
    %0 = bufferization.to_tensor %alloc : memref<3x2x2xf32> to tensor<3x2x2xf32>
    return %0 : tensor<3x2x2xf32>
  }
}

// -----
module {
  func.func @tensor.generate(%arg0: tensor<*xf32>, %arg1: index) -> tensor<?xindex> {
    %0 = bufferization.to_buffer %arg0 : tensor<*xf32> to memref<*xf32>
    %alloc = memref.alloc(%arg1) {alignment = 64 : i64} : memref<?xindex>
    %1 = bufferization.to_tensor %alloc : memref<?xindex> to tensor<?xindex>
    %mapped = linalg.map outs(%1 : tensor<?xindex>)
      (%init: index) {
        %2 = linalg.index 0 : index
        %dim = memref.dim %0, %2 : memref<*xf32>
        linalg.yield %dim : index
      }
    return %mapped : tensor<?xindex>
  }
}

// -----
module {
  func.func @tensor.generate_static_and_dynamic(%arg0: index) -> tensor<16x?xindex> {
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<16x?xindex>
    %0 = bufferization.to_tensor %alloc : memref<16x?xindex> to tensor<16x?xindex>
    %mapped = linalg.map outs(%0 : tensor<16x?xindex>)
      (%init: index) {
        %1 = linalg.index 0 : index
        %2 = linalg.index 1 : index
        %3 = arith.addi %1, %2 : index
        linalg.yield %3 : index
      }
    return %mapped : tensor<16x?xindex>
  }
}

// -----
module {
  func.func @tensor.generate_unknown_ops_in_body(%arg0: index) -> tensor<?xindex> {
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xindex>
    %0 = bufferization.to_tensor %alloc : memref<?xindex> to tensor<?xindex>
    %mapped = linalg.map outs(%0 : tensor<?xindex>)
      (%init: index) {
        %1 = "test.source"() : () -> index
        linalg.yield %1 : index
      }
    return %mapped : tensor<?xindex>
  }
}

// -----
module {
  func.func @tensor.extract_slice(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index) -> tensor<?x10xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %subview = memref.subview %0[5, %arg2] [%arg1, 10] [1, 1] : memref<?x?xf32> to memref<?x10xf32, strided<[?, 1], offset: ?>>
    %1 = bufferization.to_tensor %subview : memref<?x10xf32, strided<[?, 1], offset: ?>> to tensor<?x10xf32>
    return %1 : tensor<?x10xf32>
  }
}

// -----
module {
  func.func @tensor.extract_slice_rank_reducing(%arg0: tensor<?x10x?xf32>, %arg1: index, %arg2: index) -> tensor<?x15xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x10x?xf32> to memref<?x10x?xf32>
    %subview = memref.subview %0[5, %arg1, 10] [%arg2, 1, 15] [1, 1, 1] : memref<?x10x?xf32> to memref<?x15xf32, strided<[?, 1], offset: ?>>
    %1 = bufferization.to_tensor %subview : memref<?x15xf32, strided<[?, 1], offset: ?>> to tensor<?x15xf32>
    return %1 : tensor<?x15xf32>
  }
}

// -----
module {
  func.func @tensor.insert_slice(%arg0: tensor<?x?xf32>, %arg1: tensor<?x10xf32>, %arg2: index, %arg3: index) -> tensor<?x?xf32> {
    %0 = bufferization.to_buffer %arg1 : tensor<?x10xf32> to memref<?x10xf32>
    %1 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %1, %c0 : memref<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %1, %c1 : memref<?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    memref.copy %1, %alloc : memref<?x?xf32> to memref<?x?xf32>
    %subview = memref.subview %alloc[%arg2, 5] [%arg3, 10] [1, 1] : memref<?x?xf32> to memref<?x10xf32, strided<[?, 1], offset: ?>>
    memref.copy %0, %subview : memref<?x10xf32> to memref<?x10xf32, strided<[?, 1], offset: ?>>
    %2 = bufferization.to_tensor %alloc : memref<?x?xf32> to tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @tensor.insert_slice_rank_reducing_1(%arg0: tensor<?x?xf32>, %arg1: tensor<f32>, %arg2: index, %arg3: index) -> tensor<?x?xf32> {
    %0 = bufferization.to_buffer %arg1 : tensor<f32> to memref<f32>
    %1 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %1, %c0 : memref<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %1, %c1 : memref<?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    memref.copy %1, %alloc : memref<?x?xf32> to memref<?x?xf32>
    %subview = memref.subview %alloc[%arg2, %arg3] [1, 1] [1, 1] : memref<?x?xf32> to memref<f32, strided<[], offset: ?>>
    memref.copy %0, %subview : memref<f32> to memref<f32, strided<[], offset: ?>>
    %2 = bufferization.to_tensor %alloc : memref<?x?xf32> to tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @tensor.insert_slice_rank_reducing_2(%arg0: tensor<?x?x?x?x?x?x?xf32>, %arg1: tensor<2x1x4x1x1xf32>, %arg2: index) -> tensor<?x?x?x?x?x?x?xf32> {
    %0 = bufferization.to_buffer %arg1 : tensor<2x1x4x1x1xf32> to memref<2x1x4x1x1xf32>
    %1 = bufferization.to_buffer %arg0 : tensor<?x?x?x?x?x?x?xf32> to memref<?x?x?x?x?x?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %1, %c0 : memref<?x?x?x?x?x?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %1, %c1 : memref<?x?x?x?x?x?x?xf32>
    %c2 = arith.constant 2 : index
    %dim_1 = memref.dim %1, %c2 : memref<?x?x?x?x?x?x?xf32>
    %c3 = arith.constant 3 : index
    %dim_2 = memref.dim %1, %c3 : memref<?x?x?x?x?x?x?xf32>
    %c4 = arith.constant 4 : index
    %dim_3 = memref.dim %1, %c4 : memref<?x?x?x?x?x?x?xf32>
    %c5 = arith.constant 5 : index
    %dim_4 = memref.dim %1, %c5 : memref<?x?x?x?x?x?x?xf32>
    %c6 = arith.constant 6 : index
    %dim_5 = memref.dim %1, %c6 : memref<?x?x?x?x?x?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0, %dim_1, %dim_2, %dim_3, %dim_4, %dim_5) {alignment = 64 : i64} : memref<?x?x?x?x?x?x?xf32>
    memref.copy %1, %alloc : memref<?x?x?x?x?x?x?xf32> to memref<?x?x?x?x?x?x?xf32>
    %subview = memref.subview %alloc[%arg2, %arg2, %arg2, %arg2, %arg2, %arg2, %arg2] [1, 2, 1, 4, 1, 1, 1] [1, 1, 1, 1, 1, 1, 1] : memref<?x?x?x?x?x?x?xf32> to memref<2x1x4x1x1xf32, strided<[?, ?, ?, ?, ?], offset: ?>>
    memref.copy %0, %subview : memref<2x1x4x1x1xf32> to memref<2x1x4x1x1xf32, strided<[?, ?, ?, ?, ?], offset: ?>>
    %2 = bufferization.to_tensor %alloc : memref<?x?x?x?x?x?x?xf32> to tensor<?x?x?x?x?x?x?xf32>
    return %2 : tensor<?x?x?x?x?x?x?xf32>
  }
}

// -----
module {
  func.func @tensor.insert(%arg0: tensor<5xf32>, %arg1: index, %arg2: f32) -> tensor<5xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<5xf32> to memref<5xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %0, %alloc : memref<5xf32> to memref<5xf32>
    memref.store %arg2, %alloc[%arg1] : memref<5xf32>
    %1 = bufferization.to_tensor %alloc : memref<5xf32> to tensor<5xf32>
    return %1 : tensor<5xf32>
  }
}

// -----
module {
  func.func @tensor.expand_shape(%arg0: tensor<?x10xf32>, %arg1: index) -> tensor<2x?x10xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x10xf32> to memref<?x10xf32>
    %expand_shape = memref.expand_shape %0 [[0, 1], [2]] output_shape [2, %arg1, 10] : memref<?x10xf32> into memref<2x?x10xf32>
    %1 = bufferization.to_tensor %expand_shape : memref<2x?x10xf32> to tensor<2x?x10xf32>
    return %1 : tensor<2x?x10xf32>
  }
}

// -----
module {
  func.func @tensor.expand_shape_of_slice(%arg0: tensor<?x20xf32>, %arg1: index, %arg2: index, %arg3: index) -> tensor<?x7x2x5xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x20xf32> to memref<?x20xf32>
    %subview = memref.subview %0[%arg1, 5] [%arg2, 10] [1, 1] : memref<?x20xf32> to memref<?x10xf32, strided<[20, 1], offset: ?>>
    %expand_shape = memref.expand_shape %subview [[0, 1], [2, 3]] output_shape [%arg3, 7, 2, 5] : memref<?x10xf32, strided<[20, 1], offset: ?>> into memref<?x7x2x5xf32, strided<[140, 20, 5, 1], offset: ?>>
    %1 = bufferization.to_tensor %expand_shape : memref<?x7x2x5xf32, strided<[140, 20, 5, 1], offset: ?>> to tensor<?x7x2x5xf32>
    return %1 : tensor<?x7x2x5xf32>
  }
}

// -----
module {
  func.func @tensor.expand_shape_of_scalar_slice(%arg0: tensor<?xf32>, %arg1: index, %arg2: index) -> tensor<1xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?xf32> to memref<?xf32>
    %subview = memref.subview %0[%arg1] [1] [1] : memref<?xf32> to memref<f32, strided<[], offset: ?>>
    %expand_shape = memref.expand_shape %subview [] output_shape [1] : memref<f32, strided<[], offset: ?>> into memref<1xf32, strided<[1], offset: ?>>
    %1 = bufferization.to_tensor %expand_shape : memref<1xf32, strided<[1], offset: ?>> to tensor<1xf32>
    return %1 : tensor<1xf32>
  }
}

// -----
module {
  func.func @tensor.expand_shape_multiple_dynamic_indices(%arg0: tensor<?x256xf32>, %arg1: index, %arg2: index, %arg3: index) -> tensor<?x?x?x256xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x256xf32> to memref<?x256xf32>
    %expand_shape = memref.expand_shape %0 [[0, 1, 2], [3]] output_shape [%arg1, %arg2, %arg3, 256] : memref<?x256xf32> into memref<?x?x?x256xf32>
    %1 = bufferization.to_tensor %expand_shape : memref<?x?x?x256xf32> to tensor<?x?x?x256xf32>
    return %1 : tensor<?x?x?x256xf32>
  }
}

// -----
module {
  func.func @tensor.collapse_shape(%arg0: tensor<2x?x?xf32>) -> tensor<?x?xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<2x?x?xf32> to memref<2x?x?xf32>
    %collapse_shape = memref.collapse_shape %0 [[0, 1], [2]] : memref<2x?x?xf32> into memref<?x?xf32>
    %1 = bufferization.to_tensor %collapse_shape : memref<?x?xf32> to tensor<?x?xf32>
    return %1 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @tensor.collapse_shape_to_scalar(%arg0: tensor<1x1x1xf32>) -> tensor<f32> {
    %0 = bufferization.to_buffer %arg0 : tensor<1x1x1xf32> to memref<1x1x1xf32>
    %collapse_shape = memref.collapse_shape %0 [] : memref<1x1x1xf32> into memref<f32>
    %1 = bufferization.to_tensor %collapse_shape : memref<f32> to tensor<f32>
    return %1 : tensor<f32>
  }
}

// -----
module {
  func.func @tensor.collapse_shape_of_slice(%arg0: tensor<2xi32>) -> tensor<i32> {
    %0 = bufferization.to_buffer %arg0 : tensor<2xi32> to memref<2xi32>
    %subview = memref.subview %0[1] [1] [1] : memref<2xi32> to memref<1xi32, strided<[1], offset: 1>>
    %collapse_shape = memref.collapse_shape %subview [] : memref<1xi32, strided<[1], offset: 1>> into memref<i32, strided<[], offset: 1>>
    %1 = bufferization.to_tensor %collapse_shape : memref<i32, strided<[], offset: 1>> to tensor<i32>
    return %1 : tensor<i32>
  }
}

// -----
module {
  func.func @tensor.collapse_shape_of_slice2(%arg0: tensor<?x?x?x?xi64>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> tensor<87x63648xi64> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x?x?x?xi64> to memref<?x?x?x?xi64>
    %subview = memref.subview %0[%arg1, %arg2, %arg3, %arg4] [87, 78, 68, 12] [1, 1, 1, 1] : memref<?x?x?x?xi64> to memref<87x78x68x12xi64, strided<[?, ?, ?, 1], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<87x78x68x12xi64>
    memref.copy %subview, %alloc : memref<87x78x68x12xi64, strided<[?, ?, ?, 1], offset: ?>> to memref<87x78x68x12xi64>
    %collapse_shape = memref.collapse_shape %alloc [[0], [1, 2, 3]] : memref<87x78x68x12xi64> into memref<87x63648xi64>
    %1 = bufferization.to_tensor %collapse_shape : memref<87x63648xi64> to tensor<87x63648xi64>
    return %1 : tensor<87x63648xi64>
  }
}

// -----
module {
  func.func @tensor.collapse_shape_of_slice3(%arg0: tensor<1x2xf32>) -> tensor<1xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<1x2xf32> to memref<1x2xf32>
    %subview = memref.subview %0[0, 0] [1, 1] [1, 1] : memref<1x2xf32> to memref<1x1xf32, strided<[2, 1]>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<1x1xf32, strided<[2, 1]>> into memref<1xf32, strided<[2]>>
    %1 = bufferization.to_tensor %collapse_shape : memref<1xf32, strided<[2]>> to tensor<1xf32>
    return %1 : tensor<1xf32>
  }
}

// -----
module {
  func.func @tensor.collapse_shape_of_slice4(%arg0: tensor<?x2x4xf32>, %arg1: index, %arg2: index) -> tensor<8xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x2x4xf32> to memref<?x2x4xf32>
    %subview = memref.subview %0[0, 0, %arg1] [4, 2, 1] [1, 1, 1] : memref<?x2x4xf32> to memref<4x2x1xf32, strided<[8, 4, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1, 2]] : memref<4x2x1xf32, strided<[8, 4, 1], offset: ?>> into memref<8xf32, strided<[4], offset: ?>>
    %1 = bufferization.to_tensor %collapse_shape : memref<8xf32, strided<[4], offset: ?>> to tensor<8xf32>
    return %1 : tensor<8xf32>
  }
}

// -----
module {
  func.func @tensor.collapse_shape_of_slice5(%arg0: tensor<2x2x2xi64>) -> tensor<4xi64> {
    %0 = bufferization.to_buffer %arg0 : tensor<2x2x2xi64> to memref<2x2x2xi64>
    %subview = memref.subview %0[0, 0, 0] [2, 1, 2] [1, 1, 1] : memref<2x2x2xi64> to memref<2x1x2xi64, strided<[4, 2, 1]>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2x1x2xi64>
    memref.copy %subview, %alloc : memref<2x1x2xi64, strided<[4, 2, 1]>> to memref<2x1x2xi64>
    %collapse_shape = memref.collapse_shape %alloc [[0, 1, 2]] : memref<2x1x2xi64> into memref<4xi64>
    %1 = bufferization.to_tensor %collapse_shape : memref<4xi64> to tensor<4xi64>
    return %1 : tensor<4xi64>
  }
}

// -----
module {
  func.func @tensor.reshape(%arg0: tensor<?x10xf32>) -> tensor<2x2x5xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x10xf32> to memref<?x10xf32>
    %c2_i64 = arith.constant 2 : i64
    %c5_i64 = arith.constant 5 : i64
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3xi64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    memref.store %c2_i64, %alloc[%c0] : memref<3xi64>
    memref.store %c2_i64, %alloc[%c1] : memref<3xi64>
    memref.store %c5_i64, %alloc[%c2] : memref<3xi64>
    %reshape = memref.reshape %0(%alloc) : (memref<?x10xf32>, memref<3xi64>) -> memref<2x2x5xf32>
    %1 = bufferization.to_tensor %reshape : memref<2x2x5xf32> to tensor<2x2x5xf32>
    return %1 : tensor<2x2x5xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 + 5)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 + 10)>
module {
  func.func @tensor.pad(%arg0: tensor<?x10xindex>, %arg1: index, %arg2: index, %arg3: index) -> tensor<?x?xindex> {
    %0 = bufferization.to_buffer %arg0 : tensor<?x10xindex> to memref<?x10xindex>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %0, %c0 : memref<?x10xindex>
    %c5 = arith.constant 5 : index
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %0, %c1 : memref<?x10xindex>
    %1 = affine.apply #map()[%dim, %arg2]
    %2 = affine.apply #map1()[%arg1, %arg3]
    %alloc = memref.alloc(%1, %2) {alignment = 64 : i64} : memref<?x?xindex>
    %3 = bufferization.to_tensor %alloc : memref<?x?xindex> to tensor<?x?xindex>
    %mapped = linalg.map outs(%3 : tensor<?x?xindex>)
      (%init: index) {
        %6 = linalg.index 0 : index
        %7 = linalg.index 1 : index
        %8 = arith.muli %6, %7 : index
        linalg.yield %8 : index
      }
    %4 = bufferization.to_buffer %mapped : tensor<?x?xindex> to memref<?x?xindex>
    %subview = memref.subview %4[5, %arg1] [%dim, 10] [1, 1] : memref<?x?xindex> to memref<?x10xindex, strided<[?, 1], offset: ?>>
    memref.copy %0, %subview : memref<?x10xindex> to memref<?x10xindex, strided<[?, 1], offset: ?>>
    %5 = bufferization.to_tensor %4 : memref<?x?xindex> to tensor<?x?xindex>
    return %5 : tensor<?x?xindex>
  }
}

// -----
module {
  func.func @tensor.splat(%arg0: f32) -> tensor<10x2x4xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x2x4xf32>
    %0 = bufferization.to_tensor %alloc : memref<10x2x4xf32> to tensor<10x2x4xf32>
    %mapped = linalg.map outs(%0 : tensor<10x2x4xf32>)
      (%init: f32) {
        linalg.yield %arg0 : f32
      }
    return %mapped : tensor<10x2x4xf32>
  }
}

// -----
module {
  func.func @tensor.splat_other(%arg0: !test.memref_element) -> tensor<10x2x4x!test.memref_element> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x2x4x!test.memref_element>
    %0 = bufferization.to_tensor %alloc : memref<10x2x4x!test.memref_element> to tensor<10x2x4x!test.memref_element>
    %mapped = linalg.map outs(%0 : tensor<10x2x4x!test.memref_element>)
      (%init: !test.memref_element) {
        linalg.yield %arg0 : !test.memref_element
      }
    return %mapped : tensor<10x2x4x!test.memref_element>
  }
}

// -----
module {
  func.func @tensor.concat(%arg0: tensor<8xf32>) -> tensor<16xf32> {
    %0 = bufferization.to_buffer %arg0 : tensor<8xf32> to memref<8xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<16xf32>
    %subview = memref.subview %alloc[0] [8] [1] : memref<16xf32> to memref<8xf32, strided<[1]>>
    memref.copy %0, %subview : memref<8xf32> to memref<8xf32, strided<[1]>>
    %subview_0 = memref.subview %alloc[8] [8] [1] : memref<16xf32> to memref<8xf32, strided<[1], offset: 8>>
    memref.copy %0, %subview_0 : memref<8xf32> to memref<8xf32, strided<[1], offset: 8>>
    %1 = bufferization.to_tensor %alloc : memref<16xf32> to tensor<16xf32>
    return %1 : tensor<16xf32>
  }
}

// -----
module {
  func.func @tensor.concat_different_shapes(%arg0: tensor<8x4xf32>, %arg1: tensor<8x5xf32>) -> tensor<8x9xf32> {
    %0 = bufferization.to_buffer %arg1 : tensor<8x5xf32> to memref<8x5xf32>
    %1 = bufferization.to_buffer %arg0 : tensor<8x4xf32> to memref<8x4xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<8x9xf32>
    %subview = memref.subview %alloc[0, 0] [8, 4] [1, 1] : memref<8x9xf32> to memref<8x4xf32, strided<[9, 1]>>
    memref.copy %1, %subview : memref<8x4xf32> to memref<8x4xf32, strided<[9, 1]>>
    %subview_0 = memref.subview %alloc[0, 4] [8, 5] [1, 1] : memref<8x9xf32> to memref<8x5xf32, strided<[9, 1], offset: 4>>
    memref.copy %0, %subview_0 : memref<8x5xf32> to memref<8x5xf32, strided<[9, 1], offset: 4>>
    %2 = bufferization.to_tensor %alloc : memref<8x9xf32> to tensor<8x9xf32>
    return %2 : tensor<8x9xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @tensor.concat_dynamic(%arg0: tensor<8x?xf32>, %arg1: tensor<8x?xf32>) -> tensor<8x?xf32> {
    %0 = bufferization.to_buffer %arg1 : tensor<8x?xf32> to memref<8x?xf32>
    %1 = bufferization.to_buffer %arg0 : tensor<8x?xf32> to memref<8x?xf32>
    %c1 = arith.constant 1 : index
    %dim = memref.dim %1, %c1 : memref<8x?xf32>
    %dim_0 = memref.dim %0, %c1 : memref<8x?xf32>
    %2 = affine.apply #map()[%dim, %dim_0]
    %alloc = memref.alloc(%2) {alignment = 64 : i64} : memref<8x?xf32>
    %subview = memref.subview %alloc[0, 0] [8, %dim] [1, 1] : memref<8x?xf32> to memref<8x?xf32, strided<[?, 1]>>
    memref.copy %1, %subview : memref<8x?xf32> to memref<8x?xf32, strided<[?, 1]>>
    %subview_1 = memref.subview %alloc[0, %dim] [8, %dim_0] [1, 1] : memref<8x?xf32> to memref<8x?xf32, strided<[?, 1], offset: ?>>
    memref.copy %0, %subview_1 : memref<8x?xf32> to memref<8x?xf32, strided<[?, 1], offset: ?>>
    %3 = bufferization.to_tensor %alloc : memref<8x?xf32> to tensor<8x?xf32>
    return %3 : tensor<8x?xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @tensor.concat_dynamic_nonconcat_dim(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %0 = bufferization.to_buffer %arg1 : tensor<?x?xf32> to memref<?x?xf32>
    %1 = bufferization.to_buffer %arg0 : tensor<?x?xf32> to memref<?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %1, %c0 : memref<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %1, %c1 : memref<?x?xf32>
    %dim_1 = memref.dim %0, %c1 : memref<?x?xf32>
    %2 = affine.apply #map()[%dim_0, %dim_1]
    %alloc = memref.alloc(%dim, %2) {alignment = 64 : i64} : memref<?x?xf32>
    %dim_2 = memref.dim %alloc, %c0 : memref<?x?xf32>
    %subview = memref.subview %alloc[0, 0] [%dim_2, %dim_0] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
    memref.copy %1, %subview : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
    %subview_3 = memref.subview %alloc[0, %dim_0] [%dim_2, %dim_1] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
    memref.copy %0, %subview_3 : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
    %3 = bufferization.to_tensor %alloc : memref<?x?xf32> to tensor<?x?xf32>
    return %3 : tensor<?x?xf32>
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @tensor.concat_mixed_dynamic_static(%arg0: tensor<8x?xf32>, %arg1: tensor<8x?xf32>, %arg2: tensor<8x2xf32>) -> tensor<8x10xf32> {
    %0 = bufferization.to_buffer %arg2 : tensor<8x2xf32> to memref<8x2xf32>
    %1 = bufferization.to_buffer %arg1 : tensor<8x?xf32> to memref<8x?xf32>
    %2 = bufferization.to_buffer %arg0 : tensor<8x?xf32> to memref<8x?xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<8x10xf32>
    %c1 = arith.constant 1 : index
    %dim = memref.dim %2, %c1 : memref<8x?xf32>
    %subview = memref.subview %alloc[0, 0] [8, %dim] [1, 1] : memref<8x10xf32> to memref<8x?xf32, strided<[10, 1]>>
    memref.copy %2, %subview : memref<8x?xf32> to memref<8x?xf32, strided<[10, 1]>>
    %dim_0 = memref.dim %1, %c1 : memref<8x?xf32>
    %subview_1 = memref.subview %alloc[0, %dim] [8, %dim_0] [1, 1] : memref<8x10xf32> to memref<8x?xf32, strided<[10, 1], offset: ?>>
    memref.copy %1, %subview_1 : memref<8x?xf32> to memref<8x?xf32, strided<[10, 1], offset: ?>>
    %3 = affine.apply #map()[%dim, %dim_0]
    %subview_2 = memref.subview %alloc[0, %3] [8, 2] [1, 1] : memref<8x10xf32> to memref<8x2xf32, strided<[10, 1], offset: ?>>
    memref.copy %0, %subview_2 : memref<8x2xf32> to memref<8x2xf32, strided<[10, 1], offset: ?>>
    %4 = bufferization.to_tensor %alloc : memref<8x10xf32> to tensor<8x10xf32>
    return %4 : tensor<8x10xf32>
  }
}

// -----
module {
  func.func @tensor.splat_dynamic(%arg0: f32, %arg1: index, %arg2: index) -> tensor<?x3x?xf32> {
    %alloc = memref.alloc(%arg1, %arg2) {alignment = 64 : i64} : memref<?x3x?xf32>
    %0 = bufferization.to_tensor %alloc : memref<?x3x?xf32> to tensor<?x3x?xf32>
    %mapped = linalg.map outs(%0 : tensor<?x3x?xf32>)
      (%init: f32) {
        linalg.yield %arg0 : f32
      }
    return %mapped : tensor<?x3x?xf32>
  }
}

// -----
module {
  func.func @parallel_insert_slice_copy_before_write(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>) {
    %0 = bufferization.to_buffer %arg0 : tensor<4xf32> to memref<4xf32>
    %c4 = arith.constant 4 : index
    %1 = scf.forall (%arg2) in (%c4) shared_outs(%arg3 = %arg1) -> (tensor<4xf32>) {
      %2 = bufferization.to_buffer %arg3 : tensor<4xf32> to memref<4xf32>
      %subview = memref.subview %0[%arg2] [1] [1] : memref<4xf32> to memref<1xf32, strided<[1], offset: ?>>
      %subview_0 = memref.subview %2[%arg2] [1] [1] : memref<4xf32> to memref<1xf32, strided<[1], offset: ?>>
      memref.copy %subview, %subview_0 : memref<1xf32, strided<[1], offset: ?>> to memref<1xf32, strided<[1], offset: ?>>
      scf.forall.in_parallel {
      }
    }
    return
  }
}

// -----
module {
}

