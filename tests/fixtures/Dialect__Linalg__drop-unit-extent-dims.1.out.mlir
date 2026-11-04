#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> ()>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @drop_one_trip_loops(%arg0: tensor<?x1x?xf32>, %arg1: f32, %arg2: tensor<?x1x?x1x?xf32>) -> tensor<?x1x?x1x?xf32> {
    %c4 = arith.constant 4 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x1x?xf32>
    %dim_0 = tensor.dim %arg0, %c2 : tensor<?x1x?xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [%dim, 1, %dim_0] [1, 1, 1] : tensor<?x1x?xf32> to tensor<?x?xf32>
    %dim_1 = tensor.dim %arg2, %c0 : tensor<?x1x?x1x?xf32>
    %dim_2 = tensor.dim %arg2, %c2 : tensor<?x1x?x1x?xf32>
    %dim_3 = tensor.dim %arg2, %c4 : tensor<?x1x?x1x?xf32>
    %extracted_slice_4 = tensor.extract_slice %arg2[0, 0, 0, 0, 0] [%dim_1, 1, %dim_2, 1, %dim_3] [1, 1, 1, 1, 1] : tensor<?x1x?x1x?xf32> to tensor<?x?x?xf32>
    %0 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %arg1 : tensor<?x?xf32>, f32) outs(%extracted_slice_4 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_5: f32, %out: f32):
      linalg.yield %in_5 : f32
    } -> tensor<?x?x?xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg2[0, 0, 0, 0, 0] [%dim_1, 1, %dim_2, 1, %dim_3] [1, 1, 1, 1, 1] : tensor<?x?x?xf32> into tensor<?x1x?x1x?xf32>
    return %inserted_slice : tensor<?x1x?x1x?xf32>
  }
}

// -----
#map = affine_map<(d0) -> ()>
#map1 = affine_map<(d0) -> (d0)>
module {
  func.func @drop_one_trip_loops_all_ones(%arg0: tensor<1x1x1xf32>, %arg1: f32, %arg2: tensor<1x1x?x1x1xf32>) -> tensor<1x1x?x1x1xf32> {
    %c2 = arith.constant 2 : index
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [1, 1, 1] [1, 1, 1] : tensor<1x1x1xf32> to tensor<f32>
    %dim = tensor.dim %arg2, %c2 : tensor<1x1x?x1x1xf32>
    %extracted_slice_0 = tensor.extract_slice %arg2[0, 0, 0, 0, 0] [1, 1, %dim, 1, 1] [1, 1, 1, 1, 1] : tensor<1x1x?x1x1xf32> to tensor<?xf32>
    %0 = linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["parallel"]} ins(%extracted_slice, %arg1 : tensor<f32>, f32) outs(%extracted_slice_0 : tensor<?xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      linalg.yield %in_1 : f32
    } -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg2[0, 0, 0, 0, 0] [1, 1, %dim, 1, 1] [1, 1, 1, 1, 1] : tensor<?xf32> into tensor<1x1x?x1x1xf32>
    return %inserted_slice : tensor<1x1x?x1x1xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @drop_one_trip_loops_indexed(%arg0: tensor<?x1x?xi32>, %arg1: tensor<?x1x?x1x?xi32>) -> tensor<?x1x?x1x?xi32> {
    %c4 = arith.constant 4 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x1x?xi32>
    %dim_0 = tensor.dim %arg0, %c2 : tensor<?x1x?xi32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [%dim, 1, %dim_0] [1, 1, 1] : tensor<?x1x?xi32> to tensor<?x?xi32>
    %dim_1 = tensor.dim %arg1, %c0 : tensor<?x1x?x1x?xi32>
    %dim_2 = tensor.dim %arg1, %c2 : tensor<?x1x?x1x?xi32>
    %dim_3 = tensor.dim %arg1, %c4 : tensor<?x1x?x1x?xi32>
    %extracted_slice_4 = tensor.extract_slice %arg1[0, 0, 0, 0, 0] [%dim_1, 1, %dim_2, 1, %dim_3] [1, 1, 1, 1, 1] : tensor<?x1x?x1x?xi32> to tensor<?x?x?xi32>
    %0 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?xi32>) outs(%extracted_slice_4 : tensor<?x?x?xi32>) {
    ^bb0(%in: i32, %out: i32):
      %1 = linalg.index 0 : index
      %2 = linalg.index 1 : index
      %3 = linalg.index 2 : index
      %4 = arith.addi %1, %2 : index
      %5 = arith.addi %4, %3 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.addi %6, %in : i32
      linalg.yield %7 : i32
    } -> tensor<?x?x?xi32>
    %inserted_slice = tensor.insert_slice %0 into %arg1[0, 0, 0, 0, 0] [%dim_1, 1, %dim_2, 1, %dim_3] [1, 1, 1, 1, 1] : tensor<?x?x?xi32> into tensor<?x1x?x1x?xi32>
    return %inserted_slice : tensor<?x1x?x1x?xi32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @drop_all_loops(%arg0: tensor<1x1xf32>) -> tensor<1x1xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 1] [1, 1] : tensor<1x1xf32> to tensor<f32>
    %0 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%extracted_slice : tensor<f32>) outs(%extracted_slice : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<f32>
    %inserted_slice = tensor.insert_slice %0 into %arg0[0, 0] [1, 1] [1, 1] : tensor<f32> into tensor<1x1xf32>
    return %inserted_slice : tensor<1x1xf32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @drop_all_loops_indexed(%arg0: tensor<1x1xi32>) -> tensor<1x1xi32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 1] [1, 1] : tensor<1x1xi32> to tensor<i32>
    %0 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%extracted_slice : tensor<i32>) outs(%extracted_slice : tensor<i32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    } -> tensor<i32>
    %inserted_slice = tensor.insert_slice %0 into %arg0[0, 0] [1, 1] [1, 1] : tensor<i32> into tensor<1x1xi32>
    return %inserted_slice : tensor<1x1xi32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @leading_dim_1_canonicalization(%arg0: tensor<1x5xf32>, %arg1: tensor<5xf32>) -> tensor<5xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 5] [1, 1] : tensor<1x5xf32> to tensor<5xf32>
    %0 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%extracted_slice : tensor<5xf32>) outs(%arg1 : tensor<5xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<5xf32>
    return %0 : tensor<5xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @broadcast_test(%arg0: tensor<5xf32>, %arg1: tensor<5xf32>, %arg2: tensor<5x5xf32>) -> tensor<5x5xf32> {
    %expanded = tensor.expand_shape %arg0 [[0, 1]] output_shape [1, 5] : tensor<5xf32> into tensor<1x5xf32>
    %expanded_0 = tensor.expand_shape %arg1 [[0, 1]] output_shape [5, 1] : tensor<5xf32> into tensor<5x1xf32>
    %extracted_slice = tensor.extract_slice %expanded[0, 0] [1, 5] [1, 1] : tensor<1x5xf32> to tensor<5xf32>
    %extracted_slice_1 = tensor.extract_slice %expanded_0[0, 0] [5, 1] [1, 1] : tensor<5x1xf32> to tensor<5xf32>
    %0 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_1 : tensor<5xf32>, tensor<5xf32>) outs(%arg2 : tensor<5x5xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %1 = arith.addf %in, %in_2 : f32
      linalg.yield %1 : f32
    } -> tensor<5x5xf32>
    return %0 : tensor<5x5xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @broadcast_scalar(%arg0: tensor<1x1xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 1] [1, 1] : tensor<1x1xf32> to tensor<f32>
    %0 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice : tensor<f32>) outs(%arg1 : tensor<?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x?xf32>
    return %0 : tensor<?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @fold_unit_dim_tensor_reshape_op(%arg0: tensor<5xf32>) -> tensor<2x5xf32> {
    %0 = tensor.empty() : tensor<1x2x5xf32>
    %1 = tensor.empty() : tensor<2x5xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<5xf32>) outs(%1 : tensor<2x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x5xf32>
    %inserted_slice = tensor.insert_slice %2 into %0[0, 0, 0] [1, 2, 5] [1, 1, 1] : tensor<2x5xf32> into tensor<1x2x5xf32>
    %collapsed = tensor.collapse_shape %inserted_slice [[0, 1], [2]] : tensor<1x2x5xf32> into tensor<2x5xf32>
    return %collapsed : tensor<2x5xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @fold_unit_dim_for_empty_tensor(%arg0: tensor<1x1000xf32>) -> tensor<1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1xf32>) -> tensor<1xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 1000] [1, 1] : tensor<1x1000xf32> to tensor<1000xf32>
    %extracted_slice_0 = tensor.extract_slice %1[0] [1] [1] : tensor<1xf32> to tensor<f32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction"]} ins(%extracted_slice : tensor<1000xf32>) outs(%extracted_slice_0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<f32>
    %inserted_slice = tensor.insert_slice %2 into %1[0] [1] [1] : tensor<f32> into tensor<1xf32>
    return %inserted_slice : tensor<1xf32>
  }
}

// -----
module {
  func.func @fold_slice(%arg0: tensor<1x?x?x1x?x1x1xf32>, %arg1: tensor<1x?x?x?x?x1x1xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index) -> (tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x1x?x1x1xf32>) {
    %extracted_slice = tensor.extract_slice %arg0[0, %arg2, %arg3, 0, %arg4, 0, 0] [1, %arg5, %arg6, 1, %arg7, 1, 1] [1, 1, 1, 1, 1, 1, 1] : tensor<1x?x?x1x?x1x1xf32> to tensor<1x?x?x1x?x1x1xf32>
    %extracted_slice_0 = tensor.extract_slice %arg1[%arg2, 0, %arg3, 0, 0, %arg4, 0] [1, %arg5, %arg6, 1, %arg7, 1, 1] [1, 1, 1, 1, 1, 1, 1] : tensor<1x?x?x?x?x1x1xf32> to tensor<1x?x?x1x?x1x1xf32>
    return %extracted_slice, %extracted_slice_0 : tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x1x?x1x1xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @unit_dim_for_reduction(%arg0: tensor<1x?x1x?xf32>) -> tensor<1x?xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f32
    %c3 = arith.constant 3 : index
    %dim = tensor.dim %arg0, %c3 : tensor<1x?x1x?xf32>
    %0 = tensor.empty(%dim) : tensor<1x?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x?xf32>) -> tensor<1x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<1x?x1x?xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0] [1, %dim_0, 1, %dim] [1, 1, 1, 1] : tensor<1x?x1x?xf32> to tensor<?x?xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [1, %dim] [1, 1] : tensor<1x?xf32> to tensor<?xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction"]} ins(%extracted_slice : tensor<?x?xf32>) outs(%extracted_slice_1 : tensor<?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %2 into %1[0, 0] [1, %dim] [1, 1] : tensor<?xf32> into tensor<1x?xf32>
    return %inserted_slice : tensor<1x?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @unit_dim_for_both_reduction(%arg0: tensor<1x?x1x1xf32>) -> tensor<1x1xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %dim = tensor.dim %arg0, %c1 : tensor<1x?x1x1xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0] [1, %dim, 1, 1] [1, 1, 1, 1] : tensor<1x?x1x1xf32> to tensor<?xf32>
    %extracted_slice_0 = tensor.extract_slice %1[0, 0] [1, 1] [1, 1] : tensor<1x1xf32> to tensor<1xf32>
    %2 = tensor.empty() : tensor<1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%extracted_slice, %extracted_slice_0 : tensor<?xf32>, tensor<1xf32>) outs(%2 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %4 = arith.addf %in, %in_1 : f32
      linalg.yield %4 : f32
    } -> tensor<1xf32>
    %inserted_slice = tensor.insert_slice %3 into %1[0, 0] [1, 1] [1, 1] : tensor<1xf32> into tensor<1x1xf32>
    return %inserted_slice : tensor<1x1xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @unit_dim_for_reduction_inner(%arg0: tensor<?x1x?x1xf32>) -> tensor<?x1xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f32
    %c2 = arith.constant 2 : index
    %dim = tensor.dim %arg0, %c2 : tensor<?x1x?x1xf32>
    %0 = tensor.empty(%dim) : tensor<?x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x1xf32>) -> tensor<?x1xf32>
    %dim_0 = tensor.dim %arg0, %c0 : tensor<?x1x?x1xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0] [%dim_0, 1, %dim, 1] [1, 1, 1, 1] : tensor<?x1x?x1xf32> to tensor<?x?xf32>
    %extracted_slice_1 = tensor.extract_slice %1[0, 0] [%dim, 1] [1, 1] : tensor<?x1xf32> to tensor<?xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction"]} ins(%extracted_slice : tensor<?x?xf32>) outs(%extracted_slice_1 : tensor<?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %2 into %1[0, 0] [%dim, 1] [1, 1] : tensor<?xf32> into tensor<?x1xf32>
    return %inserted_slice : tensor<?x1xf32>
  }
}

// -----
module {
  func.func @slice_unit_dims(%arg0: tensor<1x3xf32>) -> tensor<1x1xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 2] [1, 1] [1, 1] : tensor<1x3xf32> to tensor<1x1xf32>
    return %extracted_slice : tensor<1x1xf32>
  }
}

// -----
module {
  func.func @rank_reduced_extract_slice(%arg0: tensor<1x1x3x1x3xf32>) -> tensor<1x3x3xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0, 0] [1, 1, 3, 1, 3] [1, 1, 1, 1, 1] : tensor<1x1x3x1x3xf32> to tensor<1x3x3xf32>
    return %extracted_slice : tensor<1x3x3xf32>
  }
}

// -----
module {
  func.func @insert_slice_unit_dims(%arg0: tensor<1x3xf32>, %arg1: tensor<1x1xf32>) -> tensor<1x3xf32> {
    %inserted_slice = tensor.insert_slice %arg1 into %arg0[0, 2] [1, 1] [1, 1] : tensor<1x1xf32> into tensor<1x3xf32>
    return %inserted_slice : tensor<1x3xf32>
  }
}

// -----
module {
  func.func @rank_reduced_insert_slice(%arg0: tensor<1x1x3x1x3xf32>, %arg1: tensor<1x3x3xf32>) -> tensor<1x1x3x1x3xf32> {
    %inserted_slice = tensor.insert_slice %arg1 into %arg0[0, 0, 0, 0, 0] [1, 1, 3, 1, 3] [1, 1, 1, 1, 1] : tensor<1x3x3xf32> into tensor<1x1x3x1x3xf32>
    return %inserted_slice : tensor<1x1x3x1x3xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> ()>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @drop_one_trip_loops(%arg0: memref<?x1x?xf32>, %arg1: f32, %arg2: memref<?x1x?x1x?xf32>) -> memref<?x1x?x1x?xf32> {
    %c4 = arith.constant 4 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x1x?xf32>
    %dim_0 = memref.dim %arg0, %c2 : memref<?x1x?xf32>
    %subview = memref.subview %arg0[0, 0, 0] [%dim, 1, %dim_0] [1, 1, 1] : memref<?x1x?xf32> to memref<?x?xf32, strided<[?, 1]>>
    %dim_1 = memref.dim %arg2, %c0 : memref<?x1x?x1x?xf32>
    %dim_2 = memref.dim %arg2, %c2 : memref<?x1x?x1x?xf32>
    %dim_3 = memref.dim %arg2, %c4 : memref<?x1x?x1x?xf32>
    %subview_4 = memref.subview %arg2[0, 0, 0, 0, 0] [%dim_1, 1, %dim_2, 1, %dim_3] [1, 1, 1, 1, 1] : memref<?x1x?x1x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
    linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %arg1 : memref<?x?xf32, strided<[?, 1]>>, f32) outs(%subview_4 : memref<?x?x?xf32, strided<[?, ?, 1]>>) {
    ^bb0(%in: f32, %in_5: f32, %out: f32):
      linalg.yield %in_5 : f32
    }
    return %arg2 : memref<?x1x?x1x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @drop_one_trip_loops_indexed(%arg0: memref<?x1x?xi32>, %arg1: memref<?x1x?x1x?xi32>) -> memref<?x1x?x1x?xi32> {
    %c4 = arith.constant 4 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x1x?xi32>
    %dim_0 = memref.dim %arg0, %c2 : memref<?x1x?xi32>
    %subview = memref.subview %arg0[0, 0, 0] [%dim, 1, %dim_0] [1, 1, 1] : memref<?x1x?xi32> to memref<?x?xi32, strided<[?, 1]>>
    %dim_1 = memref.dim %arg1, %c0 : memref<?x1x?x1x?xi32>
    %dim_2 = memref.dim %arg1, %c2 : memref<?x1x?x1x?xi32>
    %dim_3 = memref.dim %arg1, %c4 : memref<?x1x?x1x?xi32>
    %subview_4 = memref.subview %arg1[0, 0, 0, 0, 0] [%dim_1, 1, %dim_2, 1, %dim_3] [1, 1, 1, 1, 1] : memref<?x1x?x1x?xi32> to memref<?x?x?xi32, strided<[?, ?, 1]>>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?xi32, strided<[?, 1]>>) outs(%subview_4 : memref<?x?x?xi32, strided<[?, ?, 1]>>) {
    ^bb0(%in: i32, %out: i32):
      %0 = linalg.index 0 : index
      %1 = linalg.index 1 : index
      %2 = linalg.index 2 : index
      %3 = arith.addi %0, %1 : index
      %4 = arith.addi %3, %2 : index
      %5 = arith.index_cast %4 : index to i32
      %6 = arith.addi %5, %in : i32
      linalg.yield %6 : i32
    }
    return %arg1 : memref<?x1x?x1x?xi32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @drop_all_loops(%arg0: memref<1x1xf32>) -> memref<1x1xf32> {
    %subview = memref.subview %arg0[0, 0] [1, 1] [1, 1] : memref<1x1xf32> to memref<f32, strided<[]>>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%subview : memref<f32, strided<[]>>) outs(%subview : memref<f32, strided<[]>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    return %arg0 : memref<1x1xf32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @drop_all_loops_indexed(%arg0: memref<1x1xi32>) -> memref<1x1xi32> {
    %subview = memref.subview %arg0[0, 0] [1, 1] [1, 1] : memref<1x1xi32> to memref<i32, strided<[]>>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%subview : memref<i32, strided<[]>>) outs(%subview : memref<i32, strided<[]>>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    }
    return %arg0 : memref<1x1xi32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @leading_dim_1_canonicalization(%arg0: memref<1x5xf32>, %arg1: memref<5xf32>) -> memref<5xf32> {
    %subview = memref.subview %arg0[0, 0] [1, 5] [1, 1] : memref<1x5xf32> to memref<5xf32, strided<[1]>>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%subview : memref<5xf32, strided<[1]>>) outs(%arg1 : memref<5xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    return %arg1 : memref<5xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @broadcast_test(%arg0: memref<5xf32>, %arg1: memref<5xf32>, %arg2: memref<5x5xf32>) -> memref<5x5xf32> {
    %expand_shape = memref.expand_shape %arg0 [[0, 1]] output_shape [1, 5] : memref<5xf32> into memref<1x5xf32>
    %expand_shape_0 = memref.expand_shape %arg1 [[0, 1]] output_shape [5, 1] : memref<5xf32> into memref<5x1xf32>
    %subview = memref.subview %expand_shape[0, 0] [1, 5] [1, 1] : memref<1x5xf32> to memref<5xf32, strided<[1]>>
    %subview_1 = memref.subview %expand_shape_0[0, 0] [5, 1] [1, 1] : memref<5x1xf32> to memref<5xf32, strided<[1]>>
    linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%subview, %subview_1 : memref<5xf32, strided<[1]>>, memref<5xf32, strided<[1]>>) outs(%arg2 : memref<5x5xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %0 = arith.addf %in, %in_2 : f32
      linalg.yield %0 : f32
    }
    return %arg2 : memref<5x5xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @broadcast_scalar(%arg0: memref<1x1xf32>, %arg1: memref<?x?xf32>) -> memref<?x?xf32> {
    %subview = memref.subview %arg0[0, 0] [1, 1] [1, 1] : memref<1x1xf32> to memref<f32, strided<[]>>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%subview : memref<f32, strided<[]>>) outs(%arg1 : memref<?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    return %arg1 : memref<?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @fold_unit_dim_memref_reshape_op(%arg0: memref<5xf32>) -> memref<2x5xf32> {
    %alloc = memref.alloc() : memref<1x2x5xf32>
    %subview = memref.subview %alloc[0, 0, 0] [1, 2, 5] [1, 1, 1] : memref<1x2x5xf32> to memref<2x5xf32, strided<[5, 1]>>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<5xf32>) outs(%subview : memref<2x5xf32, strided<[5, 1]>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %collapse_shape = memref.collapse_shape %alloc [[0, 1], [2]] : memref<1x2x5xf32> into memref<2x5xf32>
    return %collapse_shape : memref<2x5xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @fold_unit_dim_for_init_memref(%arg0: memref<1x1000xf32>) -> memref<1xf32> {
    %alloc = memref.alloc() : memref<1xf32>
    %subview = memref.subview %arg0[0, 0] [1, 1000] [1, 1] : memref<1x1000xf32> to memref<1000xf32, strided<[1]>>
    %subview_0 = memref.subview %alloc[0] [1] [1] : memref<1xf32> to memref<f32, strided<[]>>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction"]} ins(%subview : memref<1000xf32, strided<[1]>>) outs(%subview_0 : memref<f32, strided<[]>>) {
    ^bb0(%in: f32, %out: f32):
      %0 = arith.addf %in, %out : f32
      linalg.yield %0 : f32
    }
    return %alloc : memref<1xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> ()>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
module {
  func.func @input_stays_same(%arg0: memref<?x1x?xf32, strided<[?, 1, 1]>>, %arg1: f32, %arg2: memref<?x1x?x1x?xf32>) -> memref<?x1x?x1x?xf32> {
    linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"], library_call = "some_external_func"} ins(%arg0, %arg1 : memref<?x1x?xf32, strided<[?, 1, 1]>>, f32) outs(%arg2 : memref<?x1x?x1x?xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      linalg.yield %in_0 : f32
    }
    return %arg2 : memref<?x1x?x1x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
#map2 = affine_map<(d0, d1) -> (d0)>
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
module {
  func.func @sparse_case(%arg0: tensor<8x8xf32, #sparse>, %arg1: tensor<8xf32>) -> tensor<8xf32> {
    %0 = tensor.empty() : tensor<8xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction"]} ins(%arg0, %arg1 : tensor<8x8xf32, #sparse>, tensor<8xf32>) outs(%0 : tensor<8xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.mulf %in, %in_0 : f32
      %3 = arith.addf %out, %2 : f32
      linalg.yield %3 : f32
    } -> tensor<8xf32>
    return %1 : tensor<8xf32>
  }
}

// -----
module {
  func.func @parallel_insert_slice() -> tensor<4x2xf32> {
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<4x2xf32>
    %1 = scf.forall (%arg0, %arg1) in (%c4, %c2) shared_outs(%arg2 = %0) -> (tensor<4x2xf32>) {
      %2 = tensor.empty() : tensor<1x1xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x1xf32>) -> tensor<1x1xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %3 into %arg2[%arg0, %arg1] [1, 1] [1, 1] : tensor<1x1xf32> into tensor<4x2xf32>
      }
    }
    return %1 : tensor<4x2xf32>
  }
}

// -----
#map = affine_map<() -> ()>
module {
  func.func @drop_all_loops(%arg0: memref<1x1xf32, 3>) -> memref<1x1xf32, 3> {
    %subview = memref.subview %arg0[0, 0] [1, 1] [1, 1] : memref<1x1xf32, 3> to memref<f32, strided<[]>, 3>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%subview : memref<f32, strided<[]>, 3>) outs(%subview : memref<f32, strided<[]>, 3>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    return %arg0 : memref<1x1xf32, 3>
  }
}

// -----
module {
  func.func @drop_unit_pad_dims(%arg0: tensor<1x1x3x1x1xf32>) -> tensor<1x2x3x1x3xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0, 0] [1, 1, 3, 1, 1] [1, 1, 1, 1, 1] : tensor<1x1x3x1x1xf32> to tensor<1x3x1xf32>
    %padded = tensor.pad %extracted_slice low[1, 0, 0] high[0, 0, 2] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      tensor.yield %cst : f32
    } : tensor<1x3x1xf32> to tensor<2x3x3xf32>
    %0 = tensor.empty() : tensor<1x2x3x1x3xf32>
    %inserted_slice = tensor.insert_slice %padded into %0[0, 0, 0, 0, 0] [1, 2, 3, 1, 3] [1, 1, 1, 1, 1] : tensor<2x3x3xf32> into tensor<1x2x3x1x3xf32>
    return %inserted_slice : tensor<1x2x3x1x3xf32>
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 11)>
module {
  func.func @drop_unit_pad_dynamic_dims(%arg0: tensor<1x?xf32>) -> tensor<1x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<1x?xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, %dim] [1, 1] : tensor<1x?xf32> to tensor<?xf32>
    %padded = tensor.pad %extracted_slice low[5] high[6] {
    ^bb0(%arg1: index):
      tensor.yield %cst : f32
    } : tensor<?xf32> to tensor<?xf32>
    %0 = affine.apply #map()[%dim]
    %1 = tensor.empty(%0) : tensor<1x?xf32>
    %inserted_slice = tensor.insert_slice %padded into %1[0, 0] [1, %0] [1, 1] : tensor<?xf32> into tensor<1x?xf32>
    return %inserted_slice : tensor<1x?xf32>
  }
}

// -----
module {
  func.func @do_not_drop_non_constant_padding(%arg0: tensor<1x1x3x1x1xf32>, %arg1: f32) -> tensor<1x2x3x1x3xf32> {
    %c0 = arith.constant 0 : index
    %padded = tensor.pad %arg0 low[0, 1, 0, %c0, 0] high[0, 0, 0, %c0, 2] {
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
      %0 = arith.index_cast %arg4 : index to i64
      %1 = arith.sitofp %0 : i64 to f32
      %2 = arith.addf %arg1, %1 : f32
      tensor.yield %2 : f32
    } : tensor<1x1x3x1x1xf32> to tensor<1x2x3x1x3xf32>
    return %padded : tensor<1x2x3x1x3xf32>
  }
}

// -----
module {
  func.func @drop_known_unit_constant_low_high(%arg0: tensor<1x383x128xf32>) -> tensor<1x384x128xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [1, 383, 128] [1, 1, 1] : tensor<1x383x128xf32> to tensor<383x128xf32>
    %padded = tensor.pad %extracted_slice low[1, 0] high[0, 0] {
    ^bb0(%arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<383x128xf32> to tensor<384x128xf32>
    %0 = tensor.empty() : tensor<1x384x128xf32>
    %inserted_slice = tensor.insert_slice %padded into %0[0, 0, 0] [1, 384, 128] [1, 1, 1] : tensor<384x128xf32> into tensor<1x384x128xf32>
    return %inserted_slice : tensor<1x384x128xf32>
  }
}

// -----
module {
  func.func @drop_unit_dim_mixed_static_dynamic(%arg0: tensor<1x?xf32>) -> tensor<1x16xf32> {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = tensor.dim %arg0, %c1 : tensor<1x?xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, %dim] [1, 1] : tensor<1x?xf32> to tensor<?xf32>
    %padded = tensor.pad %extracted_slice low[1] high[0] {
    ^bb0(%arg1: index):
      tensor.yield %cst : f32
    } : tensor<?xf32> to tensor<16xf32>
    %0 = tensor.empty() : tensor<1x16xf32>
    %inserted_slice = tensor.insert_slice %padded into %0[0, 0] [1, 16] [1, 1] : tensor<16xf32> into tensor<1x16xf32>
    return %inserted_slice : tensor<1x16xf32>
  }
}

// -----
#map = affine_map<(d0) -> (0, d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @drop_unit_dim_corresponding_to_dynamic_dim(%arg0: tensor<1x?x?x1xf32>, %arg1: index) -> tensor<?x1x61x1xf32> {
    %cst = arith.constant dense<1.000000e+00> : tensor<f32>
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %0 = tensor.empty(%arg1) : tensor<?x1x61x1xf32>
    %dim = tensor.dim %arg0, %c1 : tensor<1x?x?x1xf32>
    %dim_0 = tensor.dim %arg0, %c2 : tensor<1x?x?x1xf32>
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0] [1, %dim, %dim_0, 1] [1, 1, 1, 1] : tensor<1x?x?x1xf32> to tensor<?x?xf32>
    %1 = tensor.empty(%arg1) : tensor<?x61xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1, #map, #map], iterator_types = ["parallel"]} ins(%extracted_slice, %cst, %1 : tensor<?x?xf32>, tensor<f32>, tensor<?x61xf32>) outs(%1 : tensor<?x61xf32>) {
    ^bb0(%in: f32, %in_1: f32, %in_2: f32, %out: f32):
      %3 = arith.mulf %in, %in_1 : f32
      %4 = arith.addf %in_2, %3 : f32
      linalg.yield %4 : f32
    } -> tensor<?x61xf32>
    %inserted_slice = tensor.insert_slice %2 into %0[0, 0, 0, 0] [%arg1, 1, 61, 1] [1, 1, 1, 1] : tensor<?x61xf32> into tensor<?x1x61x1xf32>
    return %inserted_slice : tensor<?x1x61x1xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @drop_unit_dim_binary_expr(%arg0: tensor<1x61x1x1xf32>, %arg1: tensor<48x61x1x1xf32>, %arg2: tensor<1x48x1x1xf32>) -> tensor<1x48x1x1xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0, 0] [1, 61, 1, 1] [1, 1, 1, 1] : tensor<1x61x1x1xf32> to tensor<61xf32>
    %extracted_slice_0 = tensor.extract_slice %arg1[0, 0, 0, 0] [48, 61, 1, 1] [1, 1, 1, 1] : tensor<48x61x1x1xf32> to tensor<48x61xf32>
    %extracted_slice_1 = tensor.extract_slice %arg2[0, 0, 0, 0] [1, 48, 1, 1] [1, 1, 1, 1] : tensor<1x48x1x1xf32> to tensor<48xf32>
    %0 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction"]} ins(%extracted_slice, %extracted_slice_0 : tensor<61xf32>, tensor<48x61xf32>) outs(%extracted_slice_1 : tensor<48xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %1 = arith.mulf %in, %in_2 : f32
      %2 = arith.addf %out, %1 : f32
      linalg.yield %2 : f32
    } -> tensor<48xf32>
    %inserted_slice = tensor.insert_slice %0 into %arg2[0, 0, 0, 0] [1, 48, 1, 1] [1, 1, 1, 1] : tensor<48xf32> into tensor<1x48x1x1xf32>
    return %inserted_slice : tensor<1x48x1x1xf32>
  }
}

// -----
module {
  func.func @no_fold_empty_tensor_dim_out_of_bounds(%arg0: tensor<1x?x10xf32>) -> tensor<1x?xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %c7 = arith.constant 7 : index
    %dim = tensor.dim %arg0, %c7 : tensor<1x?x10xf32>
    %0 = tensor.empty(%dim) : tensor<1x?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x?xf32>) -> tensor<1x?xf32>
    return %1 : tensor<1x?xf32>
  }
}

// -----
module {
  func.func @fold_empty_tensor_dim_op(%arg0: tensor<1x?x10xf32>) -> tensor<1x?xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x10xf32>
    %cast = tensor.cast %0 : tensor<1x10xf32> to tensor<1x?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%cast : tensor<1x?xf32>) -> tensor<1x?xf32>
    return %1 : tensor<1x?xf32>
  }
}

