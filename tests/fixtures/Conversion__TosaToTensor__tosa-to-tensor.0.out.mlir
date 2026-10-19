module {
}

// -----
module {
  func.func @test_reshape_0d_same_s2s_explicit(%arg0: tensor<f32>) -> tensor<f32> {
    %0 = tosa.const_shape  {values = dense<> : tensor<0xindex>} : () -> !tosa.shape<0>
    return %arg0 : tensor<f32>
  }
}

// -----
module {
  func.func @test_reshape_0d_up_s2d_auto(%arg0: tensor<f32>) -> tensor<?xf32> {
    %0 = tosa.const_shape  {values = dense<-1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %expanded = tensor.expand_shape %arg0 [] output_shape [1] : tensor<f32> into tensor<1xf32>
    %cast = tensor.cast %expanded : tensor<1xf32> to tensor<?xf32>
    return %cast : tensor<?xf32>
  }
}

// -----
module {
  func.func @test_reshape_0d_up_s2d_explicit(%arg0: tensor<f32>) -> tensor<?xf32> {
    %0 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %expanded = tensor.expand_shape %arg0 [] output_shape [1] : tensor<f32> into tensor<1xf32>
    %cast = tensor.cast %expanded : tensor<1xf32> to tensor<?xf32>
    return %cast : tensor<?xf32>
  }
}

// -----
module {
  func.func @test_reshape_0d_up_s2s_auto(%arg0: tensor<f32>) -> tensor<1xf32> {
    %0 = tosa.const_shape  {values = dense<-1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %expanded = tensor.expand_shape %arg0 [] output_shape [1] : tensor<f32> into tensor<1xf32>
    return %expanded : tensor<1xf32>
  }
}

// -----
module {
  func.func @test_reshape_0d_up_s2s_explicit(%arg0: tensor<f32>) -> tensor<1xf32> {
    %0 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %expanded = tensor.expand_shape %arg0 [] output_shape [1] : tensor<f32> into tensor<1xf32>
    return %expanded : tensor<1xf32>
  }
}

// -----
module {
  func.func @test_reshape_1d_down_d2s_explicit(%arg0: tensor<?xf32>) -> tensor<f32> {
    %0 = tosa.const_shape  {values = dense<> : tensor<0xindex>} : () -> !tosa.shape<0>
    %cast = tensor.cast %arg0 : tensor<?xf32> to tensor<1xf32>
    %collapsed = tensor.collapse_shape %cast [] : tensor<1xf32> into tensor<f32>
    return %collapsed : tensor<f32>
  }
}

// -----
module {
  func.func @test_reshape_1d_down_s2s_explicit(%arg0: tensor<1xf32>) -> tensor<f32> {
    %0 = tosa.const_shape  {values = dense<> : tensor<0xindex>} : () -> !tosa.shape<0>
    %collapsed = tensor.collapse_shape %arg0 [] : tensor<1xf32> into tensor<f32>
    return %collapsed : tensor<f32>
  }
}

// -----
module {
  func.func @test_reshape_1d_up_d2d_auto(%arg0: tensor<?xf32>) -> tensor<2x?xf32> {
    %0 = tosa.const_shape  {values = dense<[2, -1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %c2 = arith.constant 2 : index
    %1 = arith.divsi %dim, %c2 : index
    %expanded = tensor.expand_shape %arg0 [[0, 1]] output_shape [2, %1] : tensor<?xf32> into tensor<2x?xf32>
    return %expanded : tensor<2x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_1d_up_s2s_explicit(%arg0: tensor<6xf32>) -> tensor<2x3xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %expanded = tensor.expand_shape %arg0 [[0, 1]] output_shape [2, 3] : tensor<6xf32> into tensor<2x3xf32>
    return %expanded : tensor<2x3xf32>
  }
}

// -----
module {
  func.func @test_reshape_2d_down_d2d_auto(%arg0: tensor<2x?xf32>) -> tensor<?xf32> {
    %0 = tosa.const_shape  {values = dense<-1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1]] : tensor<2x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c1 = arith.constant 1 : index
    return %collapsed : tensor<?xf32>
  }
}

// -----
module {
  func.func @test_reshape_2d_down_s2s_explicit(%arg0: tensor<2x3xf32>) -> tensor<6xf32> {
    %0 = tosa.const_shape  {values = dense<6> : tensor<1xindex>} : () -> !tosa.shape<1>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1]] : tensor<2x3xf32> into tensor<6xf32>
    return %collapsed : tensor<6xf32>
  }
}

// -----
module {
  func.func @test_reshape_2d_same_d2d_auto(%arg0: tensor<?x2xf32>) -> tensor<2x?xf32> {
    %0 = tosa.const_shape  {values = dense<[2, -1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1]] : tensor<?x2xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c2 = arith.constant 2 : index
    %1 = arith.divsi %dim, %c2 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1]] output_shape [2, %1] : tensor<?xf32> into tensor<2x?xf32>
    return %expanded : tensor<2x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_2d_same_s2d_auto(%arg0: tensor<2x4xf32>) -> tensor<?x2xf32> {
    %0 = tosa.const_shape  {values = dense<[-1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1]] : tensor<2x4xf32> into tensor<8xf32>
    %expanded = tensor.expand_shape %collapsed [[0, 1]] output_shape [4, 2] : tensor<8xf32> into tensor<4x2xf32>
    %cast = tensor.cast %expanded : tensor<4x2xf32> to tensor<?x2xf32>
    return %cast : tensor<?x2xf32>
  }
}

// -----
module {
  func.func @test_reshape_2d_same_s2d_explicit(%arg0: tensor<2x4xf32>) -> tensor<?x2xf32> {
    %0 = tosa.const_shape  {values = dense<[4, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1]] : tensor<2x4xf32> into tensor<8xf32>
    %expanded = tensor.expand_shape %collapsed [[0, 1]] output_shape [4, 2] : tensor<8xf32> into tensor<4x2xf32>
    %cast = tensor.cast %expanded : tensor<4x2xf32> to tensor<?x2xf32>
    return %cast : tensor<?x2xf32>
  }
}

// -----
module {
  func.func @test_reshape_2d_same_s2s_explicit(%arg0: tensor<3x2xf32>) -> tensor<2x3xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1]] : tensor<3x2xf32> into tensor<6xf32>
    %expanded = tensor.expand_shape %collapsed [[0, 1]] output_shape [2, 3] : tensor<6xf32> into tensor<2x3xf32>
    return %expanded : tensor<2x3xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2d_auto_empty(%arg0: tensor<3x2x?xf32>) -> tensor<?x?x?xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 3, -1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<3x2x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c0_0 = arith.constant 0 : index
    %1 = arith.divsi %dim, %c0_0 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [0, 3, %1] : tensor<?xf32> into tensor<0x3x?xf32>
    %cast = tensor.cast %expanded : tensor<0x3x?xf32> to tensor<?x?x?xf32>
    return %cast : tensor<?x?x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2d_auto(%arg0: tensor<2x?x?xf32>) -> tensor<?x?x?xf32> {
    %0 = tosa.const_shape  {values = dense<[2, -1, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<2x?x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c8 = arith.constant 8 : index
    %1 = arith.divsi %dim, %c8 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [2, %1, 4] : tensor<?xf32> into tensor<2x?x4xf32>
    %cast = tensor.cast %expanded : tensor<2x?x4xf32> to tensor<?x?x?xf32>
    return %cast : tensor<?x?x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2d_auto_identity(%arg0: tensor<?x3x4xf32>) -> tensor<2x3x?xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3, -1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<?x3x4xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c6 = arith.constant 6 : index
    %1 = arith.divsi %dim, %c6 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [2, 3, %1] : tensor<?xf32> into tensor<2x3x?xf32>
    return %expanded : tensor<2x3x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2d_explicit_empty(%arg0: tensor<3x2x?xf32>) -> tensor<?x?x?xf32> {
    %0 = tosa.const_shape  {values = dense<[0, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<3x2x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c6 = arith.constant 6 : index
    %1 = arith.divsi %dim, %c6 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [%1, 3, 2] : tensor<?xf32> into tensor<?x3x2xf32>
    %cast = tensor.cast %expanded : tensor<?x3x2xf32> to tensor<?x?x?xf32>
    return %cast : tensor<?x?x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2d_explicit(%arg0: tensor<?x?x?xf32>) -> tensor<?x?x?xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<?x?x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c12 = arith.constant 12 : index
    %1 = arith.divsi %dim, %c12 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [%1, 3, 4] : tensor<?xf32> into tensor<?x3x4xf32>
    %cast = tensor.cast %expanded : tensor<?x3x4xf32> to tensor<?x?x?xf32>
    return %cast : tensor<?x?x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2d_explicit_identity(%arg0: tensor<?x3x4xf32>) -> tensor<2x3x?xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<?x3x4xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c12 = arith.constant 12 : index
    %1 = arith.divsi %dim, %c12 : index
    %cast = tensor.cast %arg0 : tensor<?x3x4xf32> to tensor<2x3x?xf32>
    return %cast : tensor<2x3x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2s_auto(%arg0: tensor<?x?x?xf32>) -> tensor<2x3x4xf32> {
    %0 = tosa.const_shape  {values = dense<[2, -1, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<?x?x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c8 = arith.constant 8 : index
    %1 = arith.divsi %dim, %c8 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [2, %1, 4] : tensor<?xf32> into tensor<2x?x4xf32>
    %cast = tensor.cast %expanded : tensor<2x?x4xf32> to tensor<2x3x4xf32>
    return %cast : tensor<2x3x4xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_d2s_explicit(%arg0: tensor<?x?x?xf32>) -> tensor<2x3x4xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<?x?x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c12 = arith.constant 12 : index
    %1 = arith.divsi %dim, %c12 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [%1, 3, 4] : tensor<?xf32> into tensor<?x3x4xf32>
    %cast = tensor.cast %expanded : tensor<?x3x4xf32> to tensor<2x3x4xf32>
    return %cast : tensor<2x3x4xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_same_s2s_explicit_identity(%arg0: tensor<2x3x4xf32>) -> tensor<2x3x4xf32> {
    %0 = tosa.const_shape  {values = dense<[2, 3, 4]> : tensor<3xindex>} : () -> !tosa.shape<3>
    return %arg0 : tensor<2x3x4xf32>
  }
}

// -----
module {
  func.func @test_reshape_3d_up_d2s_explicit(%arg0: tensor<?x?x?xf32>) -> tensor<1x3x2x1xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 3, 2, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<?x?x?xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c6 = arith.constant 6 : index
    %1 = arith.divsi %dim, %c6 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2, 3]] output_shape [%1, 3, 2, 1] : tensor<?xf32> into tensor<?x3x2x1xf32>
    %cast = tensor.cast %expanded : tensor<?x3x2x1xf32> to tensor<1x3x2x1xf32>
    return %cast : tensor<1x3x2x1xf32>
  }
}

// -----
module {
  func.func @test_reshape_4d_down_d2s_explicit(%arg0: tensor<?x?x?x?xf32>) -> tensor<f32> {
    %0 = tosa.const_shape  {values = dense<> : tensor<0xindex>} : () -> !tosa.shape<0>
    %cast = tensor.cast %arg0 : tensor<?x?x?x?xf32> to tensor<1x1x1x1xf32>
    %collapsed = tensor.collapse_shape %cast [] : tensor<1x1x1x1xf32> into tensor<f32>
    return %collapsed : tensor<f32>
  }
}

// -----
module {
  func.func @test_reshape_5d_down_d2d_auto(%arg0: tensor<?x?x?x2x3xf32>) -> tensor<?x2x3xf32> {
    %0 = tosa.const_shape  {values = dense<[-1, 2, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2, 3, 4]] : tensor<?x?x?x2x3xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c6 = arith.constant 6 : index
    %1 = arith.divsi %dim, %c6 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [%1, 2, 3] : tensor<?xf32> into tensor<?x2x3xf32>
    return %expanded : tensor<?x2x3xf32>
  }
}

// -----
module {
  func.func @test_reshape_6d_down_d2d_auto(%arg0: tensor<1x2x?x5x7x11xf32>) -> tensor<?x5x77xf32> {
    %0 = tosa.const_shape  {values = dense<[-1, 5, 77]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2, 3, 4, 5]] : tensor<1x2x?x5x7x11xf32> into tensor<?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %collapsed, %c0 : tensor<?xf32>
    %c385 = arith.constant 385 : index
    %1 = arith.divsi %dim, %c385 : index
    %expanded = tensor.expand_shape %collapsed [[0, 1, 2]] output_shape [%1, 5, 77] : tensor<?xf32> into tensor<?x5x77xf32>
    return %expanded : tensor<?x5x77xf32>
  }
}

// -----
module {
  func.func @test_reshape_6d_down_s2s_auto(%arg0: tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32> {
    %0 = tosa.const_shape  {values = dense<[6, 5, -1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2], [3], [4, 5]] : tensor<1x2x3x5x7x11xf32> into tensor<6x5x77xf32>
    return %collapsed : tensor<6x5x77xf32>
  }
}

// -----
module {
}

// -----
module {
  func.func @reshape_bug_fix(%arg0: tensor<?xf32>) -> tensor<1x1x1x?xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 1, 1, -1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %c1 = arith.constant 1 : index
    %expanded = tensor.expand_shape %arg0 [[0, 1, 2, 3]] output_shape [1, 1, 1, %dim] : tensor<?xf32> into tensor<1x1x1x?xf32>
    return %expanded : tensor<1x1x1x?xf32>
  }
}

// -----
module {
  func.func @test_reshape_6d_down_s2s_explicit(%arg0: tensor<1x2x3x5x7x11xf32>) -> tensor<6x5x77xf32> {
    %0 = tosa.const_shape  {values = dense<[6, 5, 77]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2], [3], [4, 5]] : tensor<1x2x3x5x7x11xf32> into tensor<6x5x77xf32>
    return %collapsed : tensor<6x5x77xf32>
  }
}

// -----
module {
  func.func @test_reshape_samerank_unsigned(%arg0: tensor<3x2xui8>) -> tensor<2x3xui8> {
    %0 = builtin.unrealized_conversion_cast %arg0 : tensor<3x2xui8> to tensor<3x2xi8>
    %1 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %collapsed = tensor.collapse_shape %0 [[0, 1]] : tensor<3x2xi8> into tensor<6xi8>
    %expanded = tensor.expand_shape %collapsed [[0, 1]] output_shape [2, 3] : tensor<6xi8> into tensor<2x3xi8>
    %2 = builtin.unrealized_conversion_cast %expanded : tensor<2x3xi8> to tensor<2x3xui8>
    return %2 : tensor<2x3xui8>
  }
}

// -----
module {
  func.func @slice(%arg0: tensor<6xf32>) {
    %extracted_slice = tensor.extract_slice %arg0[2] [1] [1] : tensor<6xf32> to tensor<1xf32>
    return
  }
}

// -----
module {
  func.func @slice_dyn(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %c2 = arith.constant 2 : index
    %0 = arith.subi %dim, %c2 : index
    %extracted_slice = tensor.extract_slice %arg0[2] [%0] [1] : tensor<?xf32> to tensor<?xf32>
    return %extracted_slice : tensor<?xf32>
  }
}

// -----
module {
  func.func @pad_float(%arg0: tensor<1x2xf32>) -> tensor<4x9xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 2, 3, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 3.140000e+00 : f32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %padded = tensor.pad %arg0 low[%c1, %c3] high[%c2, %c4] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<1x2xf32> to tensor<4x9xf32>
    return %padded : tensor<4x9xf32>
  }
}

// -----
module {
  func.func @pad_int(%arg0: tensor<1x2xi32>) -> tensor<4x9xi32> {
    %0 = tosa.const_shape  {values = dense<[1, 2, 3, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c0 = arith.constant 0 : index
    %c3_i32 = arith.constant 3 : i32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %padded = tensor.pad %arg0 low[%c1, %c3] high[%c2, %c4] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %c3_i32 : i32
    } : tensor<1x2xi32> to tensor<4x9xi32>
    return %padded : tensor<4x9xi32>
  }
}

// -----
module {
  func.func @pad_quant(%arg0: tensor<1x2xi32>) -> tensor<4x9xi32> {
    %0 = tosa.const_shape  {values = dense<[1, 2, 3, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %padded = tensor.pad %arg0 low[%c1, %c3] high[%c2, %c4] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %c0_i32 : i32
    } : tensor<1x2xi32> to tensor<4x9xi32>
    return %padded : tensor<4x9xi32>
  }
}

// -----
module {
  func.func @pad_float_explicit(%arg0: tensor<1x2xf32>) -> tensor<4x9xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 2, 3, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %cst = arith.constant dense<4.200000e+01> : tensor<1xf32>
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant 4.200000e+01 : f32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %padded = tensor.pad %arg0 low[%c1, %c3] high[%c2, %c4] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %cst_0 : f32
    } : tensor<1x2xf32> to tensor<4x9xf32>
    return %padded : tensor<4x9xf32>
  }
}

// -----
module {
  func.func @pad_dyn_input(%arg0: tensor<?x2xf32>) -> tensor<?x9xf32> {
    %0 = tosa.const_shape  {values = dense<[1, 2, 3, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 3.140000e+00 : f32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %padded = tensor.pad %arg0 low[%c1, %c3] high[%c2, %c4] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<?x2xf32> to tensor<?x9xf32>
    return %padded : tensor<?x9xf32>
  }
}

// -----
module {
  func.func @pad_dyn_padding(%arg0: tensor<1x2xf32>) -> tensor<?x9xf32> {
    %0 = tosa.const_shape  {values = dense<[-1, 2, 3, 4]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %1 = "tosa.const"() <{values = dense<3.140000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 3.140000e+00 : f32
    %c-1 = arith.constant -1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %padded = tensor.pad %arg0 low[%c-1, %c3] high[%c2, %c4] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<1x2xf32> to tensor<?x9xf32>
    return %padded : tensor<?x9xf32>
  }
}

// -----
module {
  func.func @concat(%arg0: tensor<5x1xf32>, %arg1: tensor<6x1xf32>) {
    %c0 = arith.constant 0 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c11 = arith.constant 11 : index
    %0 = tensor.empty() : tensor<11x1xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %0[0, 0] [5, 1] [1, 1] : tensor<5x1xf32> into tensor<11x1xf32>
    %inserted_slice_0 = tensor.insert_slice %arg1 into %inserted_slice[5, 0] [6, 1] [1, 1] : tensor<6x1xf32> into tensor<11x1xf32>
    %c1 = arith.constant 1 : index
    %c1_1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %1 = tensor.empty() : tensor<5x2xf32>
    %inserted_slice_3 = tensor.insert_slice %arg0 into %1[0, 0] [5, 1] [1, 1] : tensor<5x1xf32> into tensor<5x2xf32>
    %inserted_slice_4 = tensor.insert_slice %arg0 into %inserted_slice_3[0, 1] [5, 1] [1, 1] : tensor<5x1xf32> into tensor<5x2xf32>
    return
  }
}

// -----
module {
  func.func @concat_non_axis_dyn(%arg0: tensor<5x?xf32>, %arg1: tensor<6x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<5x?xf32>
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c11 = arith.constant 11 : index
    %0 = tensor.empty(%dim) : tensor<11x?xf32>
    %c1_0 = arith.constant 1 : index
    %dim_1 = tensor.dim %arg0, %c1_0 : tensor<5x?xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %0[0, 0] [5, %dim_1] [1, 1] : tensor<5x?xf32> into tensor<11x?xf32>
    %c1_2 = arith.constant 1 : index
    %dim_3 = tensor.dim %arg1, %c1_2 : tensor<6x?xf32>
    %inserted_slice_4 = tensor.insert_slice %arg1 into %inserted_slice[5, 0] [6, %dim_3] [1, 1] : tensor<6x?xf32> into tensor<11x?xf32>
    return
  }
}

// -----
module {
  func.func @concat_axis_dyn(%arg0: tensor<?x3xf32>, %arg1: tensor<?x3xf32>) {
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0_0 : tensor<?x3xf32>
    %dim_1 = tensor.dim %arg1, %c0 : tensor<?x3xf32>
    %0 = arith.addi %dim, %dim_1 : index
    %1 = tensor.empty(%0) : tensor<?x3xf32>
    %c0_2 = arith.constant 0 : index
    %dim_3 = tensor.dim %arg0, %c0_2 : tensor<?x3xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %1[0, 0] [%dim_3, 3] [1, 1] : tensor<?x3xf32> into tensor<?x3xf32>
    %c0_4 = arith.constant 0 : index
    %dim_5 = tensor.dim %arg1, %c0_4 : tensor<?x3xf32>
    %inserted_slice_6 = tensor.insert_slice %arg1 into %inserted_slice[%dim, 0] [%dim_5, 3] [1, 1] : tensor<?x3xf32> into tensor<?x3xf32>
    return
  }
}

// -----
module {
  func.func @concat_axis_dyn_mixed(%arg0: tensor<?x1xf32>, %arg1: tensor<?x1xf32>, %arg2: tensor<?x1xf32>) {
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0_0 : tensor<?x1xf32>
    %dim_1 = tensor.dim %arg1, %c0 : tensor<?x1xf32>
    %0 = arith.addi %dim, %dim_1 : index
    %dim_2 = tensor.dim %arg2, %c0 : tensor<?x1xf32>
    %1 = arith.addi %0, %dim_2 : index
    %2 = tensor.empty() : tensor<5x1xf32>
    %c0_3 = arith.constant 0 : index
    %dim_4 = tensor.dim %arg0, %c0_3 : tensor<?x1xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %2[0, 0] [%dim_4, 1] [1, 1] : tensor<?x1xf32> into tensor<5x1xf32>
    %c0_5 = arith.constant 0 : index
    %dim_6 = tensor.dim %arg1, %c0_5 : tensor<?x1xf32>
    %inserted_slice_7 = tensor.insert_slice %arg1 into %inserted_slice[%dim, 0] [%dim_6, 1] [1, 1] : tensor<?x1xf32> into tensor<5x1xf32>
    %c0_8 = arith.constant 0 : index
    %dim_9 = tensor.dim %arg2, %c0_8 : tensor<?x1xf32>
    %inserted_slice_10 = tensor.insert_slice %arg2 into %inserted_slice_7[%0, 0] [%dim_9, 1] [1, 1] : tensor<?x1xf32> into tensor<5x1xf32>
    return
  }
}

// -----
module {
  func.func @concat_non_axis_dyn_mixed(%arg0: tensor<?x1xf32>, %arg1: tensor<?x1xf32>, %arg2: tensor<?x1xf32>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x1xf32>
    %c1_0 = arith.constant 1 : index
    %c1_1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c1_2 = arith.constant 1 : index
    %c2_3 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %0 = tensor.empty() : tensor<5x3xf32>
    %c0_4 = arith.constant 0 : index
    %dim_5 = tensor.dim %arg0, %c0_4 : tensor<?x1xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %0[0, 0] [%dim_5, 1] [1, 1] : tensor<?x1xf32> into tensor<5x3xf32>
    %c0_6 = arith.constant 0 : index
    %dim_7 = tensor.dim %arg1, %c0_6 : tensor<?x1xf32>
    %inserted_slice_8 = tensor.insert_slice %arg1 into %inserted_slice[0, 1] [%dim_7, 1] [1, 1] : tensor<?x1xf32> into tensor<5x3xf32>
    %c0_9 = arith.constant 0 : index
    %dim_10 = tensor.dim %arg2, %c0_9 : tensor<?x1xf32>
    %inserted_slice_11 = tensor.insert_slice %arg2 into %inserted_slice_8[0, 2] [%dim_10, 1] [1, 1] : tensor<?x1xf32> into tensor<5x3xf32>
    return
  }
}

// -----
module {
  func.func @pad_variable_pad_const(%arg0: tensor<2x2xi32>, %arg1: tensor<1xi32>) -> tensor<4x5xi32> {
    %0 = tosa.const_shape  {values = dense<[1, 1, 0, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg1[%c0] : tensor<1xi32>
    %c1 = arith.constant 1 : index
    %c1_0 = arith.constant 1 : index
    %c0_1 = arith.constant 0 : index
    %c3 = arith.constant 3 : index
    %padded = tensor.pad %arg0 low[%c1, %c0_1] high[%c1_0, %c3] {
    ^bb0(%arg2: index, %arg3: index):
      tensor.yield %extracted : i32
    } : tensor<2x2xi32> to tensor<4x5xi32>
    return %padded : tensor<4x5xi32>
  }
}

