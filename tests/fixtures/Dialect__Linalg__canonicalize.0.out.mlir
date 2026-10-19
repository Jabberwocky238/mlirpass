module {
  func.func @memref_cast(%arg0: index, %arg1: index) -> memref<?x?xf32> {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc(%arg1) : memref<?xi8>
    %view = memref.view %alloc[%c0][] : memref<?xi8> to memref<16x16xf32>
    %cast = memref.cast %view : memref<16x16xf32> to memref<?x?xf32>
    linalg.matmul ins(%view, %view : memref<16x16xf32>, memref<16x16xf32>) outs(%view : memref<16x16xf32>)
    return %cast : memref<?x?xf32>
  }
}

// -----
module {
  func.func @dce_zero_memref(%arg0: memref<0xf32>, %arg1: tensor<0xf32>) -> tensor<0xf32> {
    return %arg1 : tensor<0xf32>
  }
}

// -----
module {
  func.func @dce_self_linalg_copy(%arg0: memref<?xf32>) {
    return
  }
}

// -----
module {
  func.func @tensor.cast(%arg0: tensor<3x4xf32>, %arg1: tensor<4x?xf32>, %arg2: tensor<3x?xf32>) -> tensor<3x?xf32> {
    %0 = linalg.matmul ins(%arg0, %arg1 : tensor<3x4xf32>, tensor<4x?xf32>) outs(%arg2 : tensor<3x?xf32>) -> tensor<3x?xf32>
    return %0 : tensor<3x?xf32>
  }
}

// -----
module {
  func.func @tensor.cast.unranked(%arg0: tensor<*xf32>, %arg1: tensor<*xf32>, %arg2: tensor<*xf32>) -> tensor<*xf32> {
    %cast = tensor.cast %arg0 : tensor<*xf32> to tensor<?x?xf32>
    %cast_0 = tensor.cast %arg1 : tensor<*xf32> to tensor<?x?xf32>
    %cast_1 = tensor.cast %arg2 : tensor<*xf32> to tensor<?x?xf32>
    %0 = linalg.matmul ins(%cast, %cast_0 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%cast_1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %cast_2 = tensor.cast %0 : tensor<?x?xf32> to tensor<*xf32>
    return %cast_2 : tensor<*xf32>
  }
}

// -----
module {
  func.func @linalg_effects(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: memref<?x?xf32>, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>) {
    linalg.matmul ins(%arg3, %arg4 : memref<?x?xf32>, memref<?x?xf32>) outs(%arg5 : memref<?x?xf32>)
    return
  }
}

// -----
module {
  func.func @remove_no_op(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>) {
    return %arg1, %arg0 : tensor<?x?x?xf32>, tensor<?x?x?xf32>
  }
}

// -----
module {
  func.func @remove_no_op_mismatched_types(%arg0: tensor<?x?x?xf32>) -> tensor<1x2x3xf32> {
    %cast = tensor.cast %arg0 : tensor<?x?x?xf32> to tensor<1x2x3xf32>
    return %cast : tensor<1x2x3xf32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @cant_fold_to_tensor_cast(%arg0: f32) -> tensor<f32> {
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%arg0 : f32) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<f32>
    return %1 : tensor<f32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @keep_not_noop(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<?x?xf32>) outs(%0 : tensor<?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %cst : f32
    } -> tensor<?x?xf32>
    return %1 : tensor<?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @keep_not_noop(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %1:2 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%0, %0 : tensor<?x?xf32>, tensor<?x?xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32, %out_2: f32):
      linalg.yield %cst, %in_1 : f32, f32
    } -> (tensor<?x?xf32>, tensor<?x?xf32>)
    return %1#0, %1#1 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @dead_linalg_tensor(%arg0: tensor<7x7xi32>, %arg1: tensor<7x7xf32>, %arg2: tensor<?x?xf32>, %arg3: index) {
    return
  }
}

// -----
module {
  func.func @propagate_casts(%arg0: tensor<?x?xf32>, %arg1: f32, %arg2: index, %arg3: index) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = tensor.empty() : tensor<21x42xf32>
    %1 = linalg.fill ins(%arg1 : f32) outs(%0 : tensor<21x42xf32>) -> tensor<21x42xf32>
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %1[%arg2, %arg3] [%dim, %dim_0] [1, 1] : tensor<?x?xf32> into tensor<21x42xf32>
    %cast = tensor.cast %inserted_slice : tensor<21x42xf32> to tensor<?x?xf32>
    return %cast : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @self_copy(%arg0: memref<2x3x?x4xf32>) {
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @fold_linalg_index_tensor_static(%arg0: tensor<4x16xi32>, %arg1: tensor<1x16xi32>, %arg2: tensor<4x1xi32>) -> tensor<4x1xi32> {
    %0 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0, %arg1 : tensor<4x16xi32>, tensor<1x16xi32>) outs(%arg2 : tensor<4x1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %1 = linalg.index 0 : index
      %2 = linalg.index 2 : index
      %3 = arith.addi %1, %2 : index
      %4 = arith.index_cast %3 : index to i32
      linalg.yield %4 : i32
    } -> tensor<4x1xi32>
    return %0 : tensor<4x1xi32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d1)>
module {
  func.func @fold_linalg_index_tensor_dynamic(%arg0: tensor<?x1xi32>, %arg1: tensor<?x1xi32>) -> tensor<?x1xi32> {
    %0 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<?x1xi32>) outs(%arg1 : tensor<?x1xi32>) {
    ^bb0(%in: i32, %out: i32):
      %1 = linalg.index 0 : index
      %2 = arith.index_cast %1 : index to i32
      linalg.yield %2 : i32
    } -> tensor<?x1xi32>
    return %0 : tensor<?x1xi32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d1)>
module {
  func.func @fold_linalg_index_memref(%arg0: memref<1x?xi32>, %arg1: memref<1x?xi32>) {
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<1x?xi32>) outs(%arg1 : memref<1x?xi32>) {
    ^bb0(%in: i32, %out: i32):
      %0 = linalg.index 1 : index
      %1 = arith.index_cast %0 : index to i32
      linalg.yield %1 : i32
    }
    return
  }
}

// -----
module {
  func.func @fold_fill_reshape() -> tensor<6x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x2x3x4xf32>
    %collapsed = tensor.collapse_shape %0 [[0, 1, 2], [3]] : tensor<1x2x3x4xf32> into tensor<6x4xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%collapsed : tensor<6x4xf32>) -> tensor<6x4xf32>
    return %1 : tensor<6x4xf32>
  }
}

// -----
module {
  func.func @fold_fill_reshape_dynamic(%arg0: tensor<?x?x?x?x?xf32>) -> tensor<?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2], [3, 4]] : tensor<?x?x?x?x?xf32> into tensor<?x?xf32>
    %0 = linalg.fill ins(%cst : f32) outs(%collapsed : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @fold_fill_extract(%arg0: i1) -> i1 {
    return %arg0 : i1
  }
}

// -----
module {
  func.func @fill_pack() -> tensor<24x32x16x16xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<24x32x16x16xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<24x32x16x16xf32>) -> tensor<24x32x16x16xf32>
    return %1 : tensor<24x32x16x16xf32>
  }
}

// -----
module {
  func.func @fill_pack_general() -> tensor<1x1x8x4x4x8xi32> {
    %c0_i32 = arith.constant 0 : i32
    %alloc = memref.alloc() : memref<1x1x8x4x4x8xi32>
    %0 = bufferization.to_tensor %alloc restrict writable : memref<1x1x8x4x4x8xi32> to tensor<1x1x8x4x4x8xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<1x1x8x4x4x8xi32>) -> tensor<1x1x8x4x4x8xi32>
    return %1 : tensor<1x1x8x4x4x8xi32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 ceildiv 16)>
module {
  func.func @dynamic_fill_pack(%arg0: tensor<?x?xf32>) -> tensor<?x?x16x16xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = affine.apply #map()[%dim]
    %1 = affine.apply #map()[%dim_0]
    %2 = tensor.empty(%0, %1) : tensor<?x?x16x16xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x?x16x16xf32>) -> tensor<?x?x16x16xf32>
    return %3 : tensor<?x?x16x16xf32>
  }
}

// -----
module {
  func.func @fold_self_copy(%arg0: memref<4x16xf32>) {
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @no_fold_fill_like_memref(%arg0: memref<4x16xf32>, %arg1: f32) {
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<4x16xf32>) outs(%arg0 : memref<4x16xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %arg1 : f32
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @no_fold_fill_like_tensor(%arg0: tensor<4x16xf32>, %arg1: f32) -> tensor<4x16xf32> {
    %0 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<4x16xf32>) outs(%arg0 : tensor<4x16xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %arg1 : f32
    } -> tensor<4x16xf32>
    return %0 : tensor<4x16xf32>
  }
  func.func @fold_static_pad_fill() -> tensor<412x276xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<412x276xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<412x276xf32>) -> tensor<412x276xf32>
    return %1 : tensor<412x276xf32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 9)>
#map1 = affine_map<()[s0] -> (s0 + 10)>
#map2 = affine_map<()[s0] -> (s0 + 23)>
#map3 = affine_map<()[s0, s1] -> (s0 + s1 + 32)>
module {
  func.func @fold_dynamic_pad_fill(%arg0: tensor<8x?x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> tensor<?x?x?x?xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = affine.apply #map()[%arg1]
    %dim = tensor.dim %arg0, %c1 : tensor<8x?x16x32xf32>
    %1 = affine.apply #map1()[%dim]
    %2 = affine.apply #map2()[%arg3]
    %3 = affine.apply #map3()[%arg2, %arg4]
    %4 = tensor.empty(%0, %1, %2, %3) : tensor<?x?x?x?xf32>
    %5 = linalg.fill ins(%cst : f32) outs(%4 : tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    return %5 : tensor<?x?x?x?xf32>
  }
}

// -----
module {
  func.func @no_fold_pad_fill_value_mismatch() -> tensor<412x276xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<400x273xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<400x273xf32>) -> tensor<400x273xf32>
    %padded = tensor.pad %1 low[4, 1] high[8, 2] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst_0 : f32
    } : tensor<400x273xf32> to tensor<412x276xf32>
    return %padded : tensor<412x276xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @static_input_without_cast(%arg0: tensor<2x3x4xf32>, %arg1: tensor<?x?x?xf32>) -> tensor<2x3x4xf32> {
    %0 = tensor.empty() : tensor<2x3x4xf32>
    %cast = tensor.cast %arg1 : tensor<?x?x?xf32> to tensor<2x3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %cast : tensor<2x3x4xf32>, tensor<2x3x4xf32>) outs(%0 : tensor<2x3x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<2x3x4xf32>
    return %1 : tensor<2x3x4xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @static_input_with_cast(%arg0: tensor<2x3x4xf32>, %arg1: tensor<?x?x?xf32>) -> tensor<2x3x4xf32> {
    %0 = tensor.empty() : tensor<2x3x4xf32>
    %cast = tensor.cast %arg1 : tensor<?x?x?xf32> to tensor<2x3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %cast : tensor<2x3x4xf32>, tensor<2x3x4xf32>) outs(%0 : tensor<2x3x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<2x3x4xf32>
    return %1 : tensor<2x3x4xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @static_output_with_cast(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<2x3x4xf32>) -> tensor<2x3x4xf32> {
    %0 = tensor.empty() : tensor<2x3x4xf32>
    %cast = tensor.cast %arg0 : tensor<?x?x?xf32> to tensor<2x3x4xf32>
    %cast_0 = tensor.cast %arg1 : tensor<?x?x?xf32> to tensor<2x3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%cast, %cast_0 : tensor<2x3x4xf32>, tensor<2x3x4xf32>) outs(%0 : tensor<2x3x4xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %2 = arith.addf %in, %in_1 : f32
      linalg.yield %2 : f32
    } -> tensor<2x3x4xf32>
    return %1 : tensor<2x3x4xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @cast_source(%arg0: tensor<2x3x4xf32>, %arg1: tensor<2x3x4xf32>) -> tensor<2x3x4xf32> {
    %0 = tensor.empty() : tensor<2x3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<2x3x4xf32>, tensor<2x3x4xf32>) outs(%0 : tensor<2x3x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<2x3x4xf32>
    return %1 : tensor<2x3x4xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @cast_dest(%arg0: tensor<?x?x?xf32>, %arg1: tensor<1x?x?xf32>, %arg2: index, %arg3: index, %arg4: index) -> tensor<?x?x?xf32> {
    %cast = tensor.cast %arg0 : tensor<?x?x?xf32> to tensor<1x?x?xf32>
    %0 = tensor.empty(%arg3, %arg4) : tensor<1x?x?xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%cast, %arg1 : tensor<1x?x?xf32>, tensor<1x?x?xf32>) outs(%0 : tensor<1x?x?xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %2 = arith.subf %in, %in_1 : f32
      linalg.yield %2 : f32
    } -> tensor<1x?x?xf32>
    %cast_0 = tensor.cast %1 : tensor<1x?x?xf32> to tensor<?x?x?xf32>
    return %cast_0 : tensor<?x?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
module {
  func.func @static_shape_inference_with_encoding(%arg0: tensor<?x?xf32, #sparse>, %arg1: tensor<?x?xf32>) -> tensor<3x4xf32> {
    %0 = tensor.empty() : tensor<3x4xf32>
    %cast = tensor.cast %arg0 : tensor<?x?xf32, #sparse> to tensor<3x4xf32, #sparse>
    %cast_0 = tensor.cast %arg1 : tensor<?x?xf32> to tensor<3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%cast, %cast_0 : tensor<3x4xf32, #sparse>, tensor<3x4xf32>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %2 = arith.addf %in, %in_1 : f32
      linalg.yield %2 : f32
    } -> tensor<3x4xf32>
    return %1 : tensor<3x4xf32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
module {
  func.func @insert_pad_into_fill(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> tensor<8x384x384xf32> {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<8x384x384xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %2 = affine.apply #map()[%arg2]
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_1 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %1[%arg1, %2, 2] [%dim, %dim_0, %dim_1] [1, 1, 1] : tensor<?x?x?xf32> into tensor<8x384x384xf32>
    return %inserted_slice : tensor<8x384x384xf32>
  }
}

// -----
module {
  func.func @multi_insert_pad_into_fill(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index) -> tensor<8x384x384xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<8x384x384xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %inserted_slice = tensor.insert_slice %arg1 into %1[%arg2, 0, 0] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_0 = tensor.insert_slice %arg1 into %inserted_slice[0, 128, %arg2] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_1 = tensor.insert_slice %arg0 into %inserted_slice_0[1, 2, 256] [7, 123, 124] [1, 1, 1] : tensor<7x123x124xf32> into tensor<8x384x384xf32>
    return %inserted_slice_1 : tensor<8x384x384xf32>
  }
}

// -----
module {
  func.func @multi_insert_pad_into_fill_overlap(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index) -> tensor<8x384x384xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[1, 2, 0] high[0, 3, 4] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index):
      tensor.yield %cst : f32
    } : tensor<7x123x124xf32> to tensor<8x128x128xf32>
    %0 = tensor.empty() : tensor<8x384x384xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %inserted_slice = tensor.insert_slice %arg1 into %1[%arg2, 0, 0] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_0 = tensor.insert_slice %arg1 into %inserted_slice[0, 0, 129] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_1 = tensor.insert_slice %padded into %inserted_slice_0[0, 0, 256] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    return %inserted_slice_1 : tensor<8x384x384xf32>
  }
}

// -----
module {
  func.func @multi_insert_pad_into_fill_overlap(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index) -> tensor<8x384x384xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[1, 2, 0] high[0, 3, 4] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index):
      tensor.yield %cst : f32
    } : tensor<7x123x124xf32> to tensor<8x128x128xf32>
    %0 = tensor.empty() : tensor<8x384x384xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %inserted_slice = tensor.insert_slice %arg1 into %1[0, 0, %arg2] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_0 = tensor.insert_slice %arg1 into %inserted_slice[0, 128, 255] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_1 = tensor.insert_slice %padded into %inserted_slice_0[0, 0, 256] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    return %inserted_slice_1 : tensor<8x384x384xf32>
  }
}

// -----
module {
  func.func @multi_insert_pad_into_fill(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index) -> tensor<8x384x384xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<8x384x384xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %inserted_slice = tensor.insert_slice %arg1 into %1[0, 0, %arg2] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_0 = tensor.insert_slice %arg1 into %inserted_slice[0, 1, %arg2] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_1 = tensor.insert_slice %arg0 into %inserted_slice_0[1, 258, 256] [7, 123, 124] [1, 1, 1] : tensor<7x123x124xf32> into tensor<8x384x384xf32>
    return %inserted_slice_1 : tensor<8x384x384xf32>
  }
}

// -----
module {
  func.func @multi_insert_pad_into_fill_mismatch(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index) -> tensor<8x384x384xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %padded = tensor.pad %arg0 low[1, 2, 0] high[0, 3, 4] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index):
      tensor.yield %cst : f32
    } : tensor<7x123x124xf32> to tensor<8x128x128xf32>
    %0 = tensor.empty() : tensor<8x384x384xf32>
    %1 = linalg.fill ins(%cst_0 : f32) outs(%0 : tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %inserted_slice = tensor.insert_slice %arg1 into %1[%arg2, 0, 0] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_1 = tensor.insert_slice %arg1 into %inserted_slice[0, 128, %arg2] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    %inserted_slice_2 = tensor.insert_slice %padded into %inserted_slice_1[0, 0, 256] [8, 128, 128] [1, 1, 1] : tensor<8x128x128xf32> into tensor<8x384x384xf32>
    return %inserted_slice_2 : tensor<8x384x384xf32>
  }
}

// -----
module {
  func.func @fold_linalgop_with_cast_consumer(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>) -> (tensor<4x8xf32>, tensor<?x?xf32>) {
    %cast = tensor.cast %arg2 : tensor<?x?xf32> to tensor<4x8xf32>
    %cast_0 = tensor.cast %arg0 : tensor<?x?xf32> to tensor<4x?xf32>
    %cast_1 = tensor.cast %arg1 : tensor<?x?xf32> to tensor<?x8xf32>
    %0 = linalg.matmul ins(%cast_0, %cast_1 : tensor<4x?xf32>, tensor<?x8xf32>) outs(%cast : tensor<4x8xf32>) -> tensor<4x8xf32>
    %cast_2 = tensor.cast %0 : tensor<4x8xf32> to tensor<?x?xf32>
    return %0, %cast_2 : tensor<4x8xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func private @some_use(tensor<4x8xf32>)
  func.func @linalgop_with_cond_cast_consumer(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: i1) -> tensor<?x?xf32> {
    %0 = linalg.matmul ins(%arg0, %arg1 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%arg2 : tensor<?x?xf32>) -> tensor<?x?xf32>
    scf.if %arg3 {
      %cast = tensor.cast %0 : tensor<?x?xf32> to tensor<4x8xf32>
      func.call @some_use(%cast) : (tensor<4x8xf32>) -> ()
    }
    return %0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @fold_conv_op_with_cast_consumer(%arg0: tensor<?x?x?x?xf32>, %arg1: tensor<?x?x?x?xf32>, %arg2: tensor<?x?x?x?xf32>) -> (tensor<4x8x12x16xf32>, tensor<?x?x?x?xf32>) {
    %cast = tensor.cast %arg2 : tensor<?x?x?x?xf32> to tensor<4x8x12x16xf32>
    %0 = linalg.conv_2d_nchw_fchw ins(%arg0, %arg1 : tensor<?x?x?x?xf32>, tensor<?x?x?x?xf32>) outs(%cast : tensor<4x8x12x16xf32>) -> tensor<4x8x12x16xf32>
    %cast_0 = tensor.cast %0 : tensor<4x8x12x16xf32> to tensor<?x?x?x?xf32>
    return %0, %cast_0 : tensor<4x8x12x16xf32>, tensor<?x?x?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1, d0)>
module {
  func.func @fold_multi_use_generic_op_with_consumer(%arg0: tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<2x3x4xf32>) {
    %0 = tensor.empty() : tensor<2x3x4xf32>
    %cast = tensor.cast %arg0 : tensor<?x?x?xf32> to tensor<4x3x2xf32>
    %1 = tensor.empty() : tensor<3x2x4xf32>
    %2:2 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%cast : tensor<4x3x2xf32>) outs(%1, %0 : tensor<3x2x4xf32>, tensor<2x3x4xf32>) {
    ^bb0(%in: f32, %out: f32, %out_1: f32):
      linalg.yield %in, %in : f32, f32
    } -> (tensor<3x2x4xf32>, tensor<2x3x4xf32>)
    %cast_0 = tensor.cast %2#0 : tensor<3x2x4xf32> to tensor<?x?x?xf32>
    return %cast_0, %2#1 : tensor<?x?x?xf32>, tensor<2x3x4xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @identity_buffer(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : memref<?xf32>) outs(%arg1 : memref<?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    return
  }
}

// -----
module {
  func.func @erase_non_identity_noop(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    return %arg0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @dedeplicate_regression_test(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>) {
    return
  }
}

// -----
module {
  func.func @dead_softmax(%arg0: tensor<16x64x256xf32>) -> tensor<16x64x256xf32> {
    return %arg0 : tensor<16x64x256xf32>
  }
}

// -----
module {
  func.func @canonicalize_dim_of_dest_style_op(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %1 = linalg.copy ins(%arg0 : tensor<?x?xf32>) outs(%0 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %3 = linalg.copy ins(%1 : tensor<?x?xf32>) outs(%2 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %3 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @canonicalize_fill_to_copy_input(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.fill ins(%cst : f32) outs(%arg1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @canonicalize_fill_to_copy_dest(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %0 = linalg.copy ins(%arg1 : tensor<?x?xf32>) outs(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @canonicalize_fill_to_transpose_input(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.fill ins(%cst : f32) outs(%arg1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @broadcast_same_shape(%arg0: tensor<2x3xf32>, %arg1: tensor<2x3xf32>) -> tensor<2x3xf32> {
    return %arg0 : tensor<2x3xf32>
  }
}

// -----
module {
  func.func @broadcast_broadcast_fold(%arg0: tensor<2xf32>, %arg1: tensor<2x3xf32>, %arg2: tensor<2x3x4xf32>) -> tensor<2x3x4xf32> {
    %broadcasted = linalg.broadcast ins(%arg0 : tensor<2xf32>) outs(%arg2 : tensor<2x3x4xf32>) dimensions = [1, 2] 
    return %broadcasted : tensor<2x3x4xf32>
  }
}

// -----
module {
  func.func @broadcast_broadcast_fold(%arg0: tensor<2xf32>, %arg1: tensor<2x4xf32>, %arg2: tensor<2x3x4xf32>) -> tensor<2x3x4xf32> {
    %broadcasted = linalg.broadcast ins(%arg0 : tensor<2xf32>) outs(%arg2 : tensor<2x3x4xf32>) dimensions = [1, 2] 
    return %broadcasted : tensor<2x3x4xf32>
  }
}

// -----
module {
  func.func @transpose_1d(%arg0: tensor<16xf32>, %arg1: tensor<16xf32>) -> tensor<16xf32> {
    return %arg0 : tensor<16xf32>
  }
}

// -----
module {
  func.func @transpose_identity_perm(%arg0: tensor<16x32x64xf32>, %arg1: tensor<16x32x64xf32>) -> tensor<16x32x64xf32> {
    return %arg0 : tensor<16x32x64xf32>
  }
}

// -----
module {
  func.func @transpose_transpose_cancel(%arg0: tensor<5x4x3xf32>, %arg1: tensor<4x3x5xf32>, %arg2: tensor<5x4x3xf32>) -> tensor<5x4x3xf32> {
    return %arg0 : tensor<5x4x3xf32>
  }
}

// -----
module {
  func.func @transpose_transpose_fold(%arg0: tensor<5x4x3xf32>, %arg1: tensor<4x3x5xf32>, %arg2: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %transposed = linalg.transpose ins(%arg0 : tensor<5x4x3xf32>) outs(%arg2 : tensor<3x4x5xf32>) permutation = [2, 1, 0] 
    return %transposed : tensor<3x4x5xf32>
  }
}

// -----
module {
  func.func @broadcast_transpose_fold(%arg0: tensor<2x4x5xf32>, %arg1: tensor<1x2x3x4x5x6xf32>, %arg2: tensor<1x6x2x3x5x4xf32>) -> tensor<1x6x2x3x5x4xf32> {
    %0 = tensor.empty() : tensor<2x5x4xf32>
    %transposed = linalg.transpose ins(%arg0 : tensor<2x4x5xf32>) outs(%0 : tensor<2x5x4xf32>) permutation = [0, 2, 1] 
    %broadcasted = linalg.broadcast ins(%transposed : tensor<2x5x4xf32>) outs(%arg2 : tensor<1x6x2x3x5x4xf32>) dimensions = [0, 3, 1] 
    return %broadcasted : tensor<1x6x2x3x5x4xf32>
  }
}

// -----
module {
  func.func @broadcast_transpose_fold_dynamic(%arg0: tensor<?x?x5xf32>, %arg1: tensor<1x?x3x?x5x6xf32>, %arg2: tensor<1x3x?x6x5x?xf32>) -> tensor<1x3x?x6x5x?xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x5xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?x5xf32>
    %0 = tensor.empty(%dim_0, %dim) : tensor<?x5x?xf32>
    %transposed = linalg.transpose ins(%arg0 : tensor<?x?x5xf32>) outs(%0 : tensor<?x5x?xf32>) permutation = [1, 2, 0] 
    %broadcasted = linalg.broadcast ins(%transposed : tensor<?x5x?xf32>) outs(%arg2 : tensor<1x3x?x6x5x?xf32>) dimensions = [0, 1, 3] 
    return %broadcasted : tensor<1x3x?x6x5x?xf32>
  }
}

// -----
module {
  func.func @broadcast_transpose_fold_2dim(%arg0: tensor<2xf32>, %arg1: tensor<2x4xf32>, %arg2: tensor<4x2xf32>) -> tensor<4x2xf32> {
    %broadcasted = linalg.broadcast ins(%arg0 : tensor<2xf32>) outs(%arg2 : tensor<4x2xf32>) dimensions = [0] 
    return %broadcasted : tensor<4x2xf32>
  }
}

// -----
module {
  func.func @concats_of_fill(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> tensor<5x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty(%arg0, %arg1) : tensor<5x?x?xf32>
    %1 = tensor.empty(%arg2, %arg3) : tensor<5x?x?xf32>
    %concat = tensor.concat dim(1) %0, %1 : (tensor<5x?x?xf32>, tensor<5x?x?xf32>) -> tensor<5x?x?xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%concat : tensor<5x?x?xf32>) -> tensor<5x?x?xf32>
    return %2 : tensor<5x?x?xf32>
  }
}

// -----
module {
  func.func @transpose_buffer(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
    linalg.transpose ins(%arg0 : memref<?xf32>) outs(%arg1 : memref<?xf32>) permutation = [0] 
    return
  }
}

// -----
module {
  func.func @recursive_effect(%arg0: tensor<1xf32>) {
    %cst = arith.constant dense<0.000000e+00> : tensor<1xf32>
    %mapped = linalg.map ins(%arg0 : tensor<1xf32>) outs(%cst : tensor<1xf32>)
      (%in: f32, %init: f32) {
        vector.print %in : f32
        linalg.yield %in : f32
      }
    return
  }
}

// -----
module {
  func.func @fold_pack_constant_splat(%arg0: tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32> {
    %cst = arith.constant dense<1.000000e-01> : tensor<4x8x8x32xf32>
    return %cst : tensor<4x8x8x32xf32>
  }
}

// -----
module {
  func.func @fold_padding_value_pack_constant_splat(%arg0: tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32> {
    %cst = arith.constant dense<1.000000e-01> : tensor<4x8x8x32xf32>
    return %cst : tensor<4x8x8x32xf32>
  }
}

// -----
module {
  func.func @nofold_padding_value_pack_constant_splat(%arg0: tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<1.000000e-01> : tensor<63x127xf32>
    %pack = linalg.pack %cst_0 padding_value(%cst : f32) outer_dims_perm = [1, 0] inner_dims_pos = [0, 1] inner_tiles = [8, 32] into %arg0 : tensor<63x127xf32> -> tensor<4x8x8x32xf32>
    return %pack : tensor<4x8x8x32xf32>
  }
}

// -----
module {
  func.func @fold_padding_value_pack(%arg0: tensor<1200x500000xf32>) -> tensor<31250x1200x16x1xf32> {
    %0 = tensor.empty() : tensor<31250x1200x16x1xf32>
    %pack = linalg.pack %arg0 outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [16, 1] into %0 : tensor<1200x500000xf32> -> tensor<31250x1200x16x1xf32>
    return %pack : tensor<31250x1200x16x1xf32>
  }
}

// -----
module {
  func.func @infer_src_shape_pack(%arg0: tensor<?x?x?x?xf32>, %arg1: tensor<10x20x30x40x16xf32>) -> tensor<10x20x30x40x16xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cast = tensor.cast %arg0 : tensor<?x?x?x?xf32> to tensor<40x20x?x30xf32>
    %pack = linalg.pack %cast padding_value(%cst : f32) outer_dims_perm = [2, 1, 3, 0] inner_dims_pos = [2] inner_tiles = [16] into %arg1 : tensor<40x20x?x30xf32> -> tensor<10x20x30x40x16xf32>
    return %pack : tensor<10x20x30x40x16xf32>
  }
}

// -----
module {
  func.func @infer_dest_shape_pack(%arg0: tensor<30x20x?x10xf32>, %arg1: tensor<?x?x?x?x16xf32>) -> tensor<?x?x?x?x16xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cast = tensor.cast %arg1 : tensor<?x?x?x?x16xf32> to tensor<?x20x10x30x16xf32>
    %pack = linalg.pack %arg0 padding_value(%cst : f32) outer_dims_perm = [2, 1, 3, 0] inner_dims_pos = [2] inner_tiles = [16] into %cast : tensor<30x20x?x10xf32> -> tensor<?x20x10x30x16xf32>
    %cast_0 = tensor.cast %pack : tensor<?x20x10x30x16xf32> to tensor<?x?x?x?x16xf32>
    return %cast_0 : tensor<?x?x?x?x16xf32>
  }
}

// -----
module {
  func.func @no_infer_pack_shape(%arg0: tensor<?x32x100xf32>, %arg1: index) -> tensor<32x7x?x16x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty(%arg1) : tensor<32x7x?x16x1xf32>
    %pack = linalg.pack %arg0 padding_value(%cst : f32) outer_dims_perm = [1, 2, 0] inner_dims_pos = [2, 0] inner_tiles = [16, 1] into %0 : tensor<?x32x100xf32> -> tensor<32x7x?x16x1xf32>
    return %pack : tensor<32x7x?x16x1xf32>
  }
}

// -----
module {
  func.func @fold_padding_value_pack_negative1(%arg0: tensor<1200x499999xf32>) -> tensor<31250x1200x16x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<31250x1200x16x1xf32>
    %pack = linalg.pack %arg0 padding_value(%cst : f32) outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [16, 1] into %0 : tensor<1200x499999xf32> -> tensor<31250x1200x16x1xf32>
    return %pack : tensor<31250x1200x16x1xf32>
  }
}

// -----
module {
  func.func @fold_padding_value_pack_negative2(%arg0: tensor<1200x?xf32>, %arg1: tensor<?x1200x16x1xf32>) -> tensor<?x1200x16x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %pack = linalg.pack %arg0 padding_value(%cst : f32) outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [16, 1] into %arg1 : tensor<1200x?xf32> -> tensor<?x1200x16x1xf32>
    return %pack : tensor<?x1200x16x1xf32>
  }
}

// -----
module {
  func.func @fold_padding_value_pack_negative3(%arg0: tensor<1200x500000xf32>, %arg1: tensor<?x1200x?x1xf32>, %arg2: index) -> tensor<?x1200x?x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %pack = linalg.pack %arg0 padding_value(%cst : f32) outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [%arg2, 1] into %arg1 : tensor<1200x500000xf32> -> tensor<?x1200x?x1xf32>
    return %pack : tensor<?x1200x?x1xf32>
  }
}

// -----
module {
  func.func @fold_unpack_constant_splat(%arg0: tensor<128x256xf32>) -> tensor<128x256xf32> {
    %cst = arith.constant dense<1.000000e-01> : tensor<128x256xf32>
    return %cst : tensor<128x256xf32>
  }
}

// -----
module {
  func.func @infer_dest_shape_unpack(%arg0: tensor<10x20x30x40x16xf32>, %arg1: tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32> {
    %cast = tensor.cast %arg1 : tensor<?x?x?x?xf32> to tensor<40x20x?x30xf32>
    %unpack = linalg.unpack %arg0 outer_dims_perm = [2, 1, 3, 0] inner_dims_pos = [2] inner_tiles = [16] into %cast : tensor<10x20x30x40x16xf32> -> tensor<40x20x?x30xf32>
    %cast_0 = tensor.cast %unpack : tensor<40x20x?x30xf32> to tensor<?x?x?x?xf32>
    return %cast_0 : tensor<?x?x?x?xf32>
  }
}

// -----
module {
  func.func @infer_src_shape_unpack(%arg0: tensor<?x?x?x?x16xf32>, %arg1: tensor<30x20x?x10xf32>) -> tensor<30x20x?x10xf32> {
    %cast = tensor.cast %arg0 : tensor<?x?x?x?x16xf32> to tensor<?x20x10x30x16xf32>
    %unpack = linalg.unpack %cast outer_dims_perm = [2, 1, 3, 0] inner_dims_pos = [2] inner_tiles = [16] into %arg1 : tensor<?x20x10x30x16xf32> -> tensor<30x20x?x10xf32>
    return %unpack : tensor<30x20x?x10xf32>
  }
}

// -----
module {
  func.func @no_infer_unpack_shape(%arg0: tensor<32x7x?x16x1xf32>, %arg1: index) -> tensor<?x32x100xf32> {
    %0 = tensor.empty(%arg1) : tensor<?x32x100xf32>
    %unpack = linalg.unpack %arg0 outer_dims_perm = [1, 2, 0] inner_dims_pos = [2, 0] inner_tiles = [16, 1] into %0 : tensor<32x7x?x16x1xf32> -> tensor<?x32x100xf32>
    return %unpack : tensor<?x32x100xf32>
  }
}

// -----
module {
  func.func @unpack_pack(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    return %arg0 : tensor<128x128xf32>
  }
}

// -----
module {
  func.func @unpack_pack(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = tensor.empty() : tensor<16x16x8x8xf32>
    %pack = linalg.pack %arg0 inner_dims_pos = [1, 0] inner_tiles = [8, 8] into %0 : tensor<128x128xf32> -> tensor<16x16x8x8xf32>
    %1 = tensor.empty() : tensor<128x128xf32>
    %unpack = linalg.unpack %pack inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %1 : tensor<16x16x8x8xf32> -> tensor<128x128xf32>
    return %unpack : tensor<128x128xf32>
  }
}

// -----
module {
  func.func @unpack_pack(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = tensor.empty() : tensor<16x16x8x8xf32>
    %pack = linalg.pack %arg0 outer_dims_perm = [1, 0] inner_dims_pos = [1, 0] inner_tiles = [8, 8] into %0 : tensor<128x128xf32> -> tensor<16x16x8x8xf32>
    %1 = tensor.empty() : tensor<128x128xf32>
    %unpack = linalg.unpack %pack inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %1 : tensor<16x16x8x8xf32> -> tensor<128x128xf32>
    return %unpack : tensor<128x128xf32>
  }
}

// -----
module {
  func.func @unpack_pack(%arg0: tensor<128x128xf32>, %arg1: index, %arg2: index) -> tensor<128x128xf32> {
    return %arg0 : tensor<128x128xf32>
  }
}

// -----
module {
  func.func @unpack_pack_with_padding_no_canonicalization(%arg0: tensor<256x512xbf16>) -> tensor<224x512xbf16> {
    %0 = tensor.empty() : tensor<4x16x64x32xbf16>
    %1 = tensor.empty() : tensor<224x512xbf16>
    %pack = linalg.pack %arg0 outer_dims_perm = [0, 1] inner_dims_pos = [0, 1] inner_tiles = [64, 32] into %0 : tensor<256x512xbf16> -> tensor<4x16x64x32xbf16>
    %unpack = linalg.unpack %pack inner_dims_pos = [0, 1] inner_tiles = [64, 32] into %1 : tensor<4x16x64x32xbf16> -> tensor<224x512xbf16>
    return %unpack : tensor<224x512xbf16>
  }
}

// -----
module {
  func.func @pack_unpack(%arg0: tensor<16x16x?x?xf32>, %arg1: index, %arg2: index) -> tensor<16x16x?x?xf32> {
    return %arg0 : tensor<16x16x?x?xf32>
  }
}

// -----
module {
  func.func @pack_unpack(%arg0: tensor<16x16x8x8xf32>) -> tensor<16x16x8x8xf32> {
    return %arg0 : tensor<16x16x8x8xf32>
  }
}

// -----
module {
  func.func @pack_unpack_same_tiles(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index) -> tensor<?x?x?x?xf32> {
    return %arg0 : tensor<?x?x?x?xf32>
  }
}

// -----
module {
  func.func @pack_unpack_different_tiles(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index) -> tensor<?x?x?x?xf32> {
    %0 = tensor.empty(%arg1, %arg2) : tensor<?x?xf32>
    %unpack = linalg.unpack %arg0 inner_dims_pos = [0, 1] inner_tiles = [%arg7, %arg8] into %0 : tensor<?x?x?x?xf32> -> tensor<?x?xf32>
    %1 = tensor.empty(%arg3, %arg4, %arg5, %arg6) : tensor<?x?x?x?xf32>
    %pack = linalg.pack %unpack inner_dims_pos = [0, 1] inner_tiles = [%arg8, %arg7] into %1 : tensor<?x?xf32> -> tensor<?x?x?x?xf32>
    return %pack : tensor<?x?x?x?xf32>
  }
}

// -----
module {
  func.func @pack_unpack_dynamic_with_padding(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: f32) -> tensor<?x?x?x?xf32> {
    %0 = tensor.empty(%arg1, %arg2) : tensor<?x?xf32>
    %unpack = linalg.unpack %arg0 inner_dims_pos = [0, 1] inner_tiles = [%arg7, %arg8] into %0 : tensor<?x?x?x?xf32> -> tensor<?x?xf32>
    %1 = tensor.empty(%arg3, %arg4, %arg5, %arg6) : tensor<?x?x?x?xf32>
    %pack = linalg.pack %unpack padding_value(%arg9 : f32) inner_dims_pos = [0, 1] inner_tiles = [%arg7, %arg8] into %1 : tensor<?x?xf32> -> tensor<?x?x?x?xf32>
    return %pack : tensor<?x?x?x?xf32>
  }
}

// -----
module {
  func.func @pack_outer_dims_unpack_no_outer_dims(%arg0: tensor<16x16x?x?xf32>, %arg1: index, %arg2: index) -> tensor<16x16x?x?xf32> {
    return %arg0 : tensor<16x16x?x?xf32>
  }
}

// -----
module {
  func.func @pack_no_outer_dims_unpack_outer_dims(%arg0: tensor<16x16x?x?xf32>, %arg1: index, %arg2: index) -> tensor<16x16x?x?xf32> {
    return %arg0 : tensor<16x16x?x?xf32>
  }
}

// -----
module {
  func.func @fold_cast_pack_dynamic_tile_size(%arg0: tensor<1x1x8x1xi32>, %arg1: tensor<7x?xi32>, %arg2: i32) -> tensor<1x1x8x1xi32> {
    %pack = linalg.pack %arg1 padding_value(%arg2 : i32) inner_dims_pos = [0, 1] inner_tiles = [8, 1] into %arg0 {test_attr} : tensor<7x?xi32> -> tensor<1x1x8x1xi32>
    return %pack : tensor<1x1x8x1xi32>
  }
}

// -----
module {
  func.func @infer_and_fold_pack_unpack_same_tiles(%arg0: tensor<10x20x4x4xf32>) -> tensor<10x20x4x4xf32> {
    return %arg0 : tensor<10x20x4x4xf32>
  }
}

// -----
module {
  func.func @pack_dont_drop_attributes(%arg0: tensor<?x?x?xf16>, %arg1: tensor<128x?x100x16x1xf16>) -> tensor<128x?x100x16x1xf16> {
    %cst = arith.constant 0.000000e+00 : f16
    %cast = tensor.cast %arg0 : tensor<?x?x?xf16> to tensor<128x?x?xf16>
    %pack = linalg.pack %cast padding_value(%cst : f16) outer_dims_perm = [0, 1, 2] inner_dims_pos = [1, 2] inner_tiles = [16, 1] into %arg1 {test_attr} : tensor<128x?x?xf16> -> tensor<128x?x100x16x1xf16>
    return %pack : tensor<128x?x100x16x1xf16>
  }
}

// -----
module {
  func.func @fold_dst_style_ops_into_unpack(%arg0: tensor<?x?x16x64xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %unpack = linalg.unpack %arg0 inner_dims_pos = [0, 1] inner_tiles = [16, 64] into %arg1 : tensor<?x?x16x64xf32> -> tensor<?x?xf32>
    return %unpack : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @fold_cast_unpack_dynamic_tile_size(%arg0: tensor<1x1x8x1xi32>, %arg1: tensor<7x?xi32>) -> tensor<7x?xi32> {
    %unpack = linalg.unpack %arg0 inner_dims_pos = [0, 1] inner_tiles = [8, 1] into %arg1 {test_attr} : tensor<1x1x8x1xi32> -> tensor<7x?xi32>
    return %unpack : tensor<7x?xi32>
  }
}

// -----
module {
  func.func @fold_extract_slice_into_unpack_slicing_trailing_dim(%arg0: tensor<28x2x1x16x16xf32>, %arg1: tensor<28x28x15xf32>) -> tensor<28x28x10xf32> {
    %extracted_slice = tensor.extract_slice %arg1[0, 0, 0] [28, 28, 10] [1, 1, 1] : tensor<28x28x15xf32> to tensor<28x28x10xf32>
    %unpack = linalg.unpack %arg0 outer_dims_perm = [0, 1, 2] inner_dims_pos = [1, 2] inner_tiles = [16, 16] into %extracted_slice : tensor<28x2x1x16x16xf32> -> tensor<28x28x10xf32>
    return %unpack : tensor<28x28x10xf32>
  }
}

// -----
module {
  func.func @fold_extract_slice_into_unpack_slicing_dim_1(%arg0: tensor<28x2x1x16x16xf32>, %arg1: tensor<28x28x15xf32>) -> tensor<28x17x15xf32> {
    %extracted_slice = tensor.extract_slice %arg1[0, 0, 0] [28, 17, 15] [1, 1, 1] : tensor<28x28x15xf32> to tensor<28x17x15xf32>
    %unpack = linalg.unpack %arg0 inner_dims_pos = [1, 2] inner_tiles = [16, 16] into %extracted_slice : tensor<28x2x1x16x16xf32> -> tensor<28x17x15xf32>
    return %unpack : tensor<28x17x15xf32>
  }
}

// -----
module {
  func.func @no_fold_extract_slice_into_unpack_artificial_padding(%arg0: tensor<28x2x1x16x16xf32>, %arg1: tensor<28x28x15xf32>) -> tensor<28x16x15xf32> {
    %unpack = linalg.unpack %arg0 inner_dims_pos = [1, 2] inner_tiles = [16, 16] into %arg1 : tensor<28x2x1x16x16xf32> -> tensor<28x28x15xf32>
    %extracted_slice = tensor.extract_slice %unpack[0, 0, 0] [28, 16, 15] [1, 1, 1] : tensor<28x28x15xf32> to tensor<28x16x15xf32>
    return %extracted_slice : tensor<28x16x15xf32>
  }
}

// -----
module {
  func.func @no_fold_extract_slice_into_unpack_dynamic(%arg0: tensor<28x2x?x16x16xf32>, %arg1: tensor<28x32x?xf32>, %arg2: index) -> tensor<28x28x?xf32> {
    %unpack = linalg.unpack %arg0 outer_dims_perm = [0, 1, 2] inner_dims_pos = [1, 2] inner_tiles = [16, 16] into %arg1 : tensor<28x2x?x16x16xf32> -> tensor<28x32x?xf32>
    %extracted_slice = tensor.extract_slice %unpack[0, 0, 0] [28, 28, %arg2] [1, 1, 1] : tensor<28x32x?xf32> to tensor<28x28x?xf32>
    return %extracted_slice : tensor<28x28x?xf32>
  }
}

// -----
module {
  func.func @no_fold_extract_slice_into_unpack_rank_reducing(%arg0: tensor<28x2x16xf32>, %arg1: tensor<28x32xf32>) -> tensor<28xf32> {
    %unpack = linalg.unpack %arg0 outer_dims_perm = [0, 1] inner_dims_pos = [1] inner_tiles = [16] into %arg1 : tensor<28x2x16xf32> -> tensor<28x32xf32>
    %extracted_slice = tensor.extract_slice %unpack[0, 0] [1, 28] [1, 1] : tensor<28x32xf32> to tensor<28xf32>
    return %extracted_slice : tensor<28xf32>
  }
}

// -----
module {
  func.func @no_fold_extract_slice_into_unpack_non_zero_offset(%arg0: tensor<28x2x16xf32>, %arg1: tensor<28x32xf32>) -> tensor<28x28xf32> {
    %unpack = linalg.unpack %arg0 outer_dims_perm = [0, 1] inner_dims_pos = [1] inner_tiles = [16] into %arg1 : tensor<28x2x16xf32> -> tensor<28x32xf32>
    %extracted_slice = tensor.extract_slice %unpack[0, 1] [28, 28] [1, 1] : tensor<28x32xf32> to tensor<28x28xf32>
    return %extracted_slice : tensor<28x28xf32>
  }
}

