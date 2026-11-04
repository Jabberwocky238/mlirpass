#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @buffer_forwarding_conflict(%arg0: tensor<?xf32> {bufferization.buffer_layout = affine_map<(d0) -> (d0)>, bufferization.writable = true}, %arg1: index) -> (tensor<?xf32>, tensor<?xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0] [%arg1] [1] : tensor<?xf32> to tensor<?xf32>
    %0 = tensor.empty(%arg1) : tensor<?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %1 into %arg0[0] [%arg1] [1] : tensor<?xf32> into tensor<?xf32>
    %inserted_slice_0 = tensor.insert_slice %1 into %arg0[42] [%arg1] [1] : tensor<?xf32> into tensor<?xf32>
    return %inserted_slice, %inserted_slice_0 : tensor<?xf32>, tensor<?xf32>
  }
  func.func @buffer_forwarding_no_conflict(%arg0: tensor<?xf32> {bufferization.buffer_layout = affine_map<(d0) -> (d0)>, bufferization.writable = true}, %arg1: index) -> tensor<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[42] [%arg1] [1] : tensor<?xf32> to tensor<?xf32>
    %0 = tensor.empty(%arg1) : tensor<?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
    %inserted_slice = tensor.insert_slice %1 into %arg0[42] [%arg1] [1] : tensor<?xf32> into tensor<?xf32>
    return %inserted_slice : tensor<?xf32>
  }
  func.func @insertion_point_inside_loop(%arg0: tensor<?xf32>, %arg1: index) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c5 = arith.constant 5 : index
    %0 = tensor.empty() : tensor<5xf32>
    %1 = scf.for %arg2 = %c0 to %arg1 step %c5 iter_args(%arg3 = %arg0) -> (tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg3[%arg2] [5] [1] : tensor<?xf32> to tensor<5xf32>
      %2 = arith.index_cast %arg2 : index to i32
      %3 = arith.sitofp %2 : i32 to f32
      %4 = linalg.fill ins(%3 : f32) outs(%extracted_slice : tensor<5xf32>) -> tensor<5xf32>
      %inserted_slice = tensor.insert_slice %4 into %arg3[%arg2] [5] [1] : tensor<5xf32> into tensor<?xf32>
      scf.yield %inserted_slice : tensor<?xf32>
    }
    return %1 : tensor<?xf32>
  }
  func.func @insertion_point_outside_loop(%arg0: tensor<?xf32>, %arg1: index, %arg2: index) -> tensor<?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c5 = arith.constant 5 : index
    %0 = tensor.empty() : tensor<5xf32>
    %1 = scf.for %arg3 = %c0 to %arg1 step %c5 iter_args(%arg4 = %arg0) -> (tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg4[%arg2] [5] [1] : tensor<?xf32> to tensor<5xf32>
      %2 = arith.index_cast %arg3 : index to i32
      %3 = arith.sitofp %2 : i32 to f32
      %4 = linalg.fill ins(%3 : f32) outs(%extracted_slice : tensor<5xf32>) -> tensor<5xf32>
      %inserted_slice = tensor.insert_slice %4 into %arg4[%arg2] [5] [1] : tensor<5xf32> into tensor<?xf32>
      scf.yield %inserted_slice : tensor<?xf32>
    }
    return %1 : tensor<?xf32>
  }
  func.func @shape_mismatch(%arg0: tensor<5x6x128xf32>) -> tensor<5x6x128xf32> {
    %cst = arith.constant 8.000000e+00 : f32
    %0 = tensor.empty() : tensor<128xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<128xf32>) -> tensor<128xf32>
    %expanded = tensor.expand_shape %1 [[0, 1, 2]] output_shape [1, 1, 128] : tensor<128xf32> into tensor<1x1x128xf32>
    %inserted_slice = tensor.insert_slice %expanded into %arg0[2, 3, 0] [1, 1, 128] [1, 1, 1] : tensor<1x1x128xf32> into tensor<5x6x128xf32>
    return %inserted_slice : tensor<5x6x128xf32>
  }
  func.func @cast(%arg0: tensor<256xf32>) -> tensor<256xf32> {
    %cst = arith.constant 8.000000e+00 : f32
    %c128 = arith.constant 128 : index
    %extracted_slice = tensor.extract_slice %arg0[2] [128] [1] : tensor<256xf32> to tensor<128xf32>
    %cast = tensor.cast %extracted_slice : tensor<128xf32> to tensor<?xf32>
    %0 = tensor.empty(%c128) : tensor<?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%cast : tensor<?xf32>) -> tensor<?xf32>
    %cast_0 = tensor.cast %1 : tensor<?xf32> to tensor<128xf32>
    %inserted_slice = tensor.insert_slice %cast_0 into %arg0[2] [128] [1] : tensor<128xf32> into tensor<256xf32>
    return %inserted_slice : tensor<256xf32>
  }
  func.func @parallel_insert_slice(%arg0: tensor<?xf32> {bufferization.buffer_layout = affine_map<(d0) -> (d0)>, bufferization.writable = true}, %arg1: index) -> tensor<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c512 = arith.constant 512 : index
    %0 = scf.forall (%arg2) in (%c512) shared_outs(%arg3 = %arg0) -> (tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg3[42] [%arg1] [1] : tensor<?xf32> to tensor<?xf32>
      %1 = tensor.empty(%arg1) : tensor<?xf32>
      %2 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %2 into %arg3[42] [%arg1] [1] : tensor<?xf32> into tensor<?xf32>
      }
    }
    return %0 : tensor<?xf32>
  }
  func.func @eleminate_multiple_ops(%arg0: tensor<?xf32> {bufferization.buffer_layout = affine_map<(d0) -> (d0)>}, %arg1: index, %arg2: i1) -> tensor<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = scf.if %arg2 -> (tensor<?xf32>) {
      %extracted_slice = tensor.extract_slice %arg0[42] [%arg1] [1] : tensor<?xf32> to tensor<?xf32>
      %1 = tensor.empty(%arg1) : tensor<?xf32>
      %2 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
      scf.yield %2 : tensor<?xf32>
    } else {
      %extracted_slice = tensor.extract_slice %arg0[42] [%arg1] [1] : tensor<?xf32> to tensor<?xf32>
      %1 = tensor.empty(%arg1) : tensor<?xf32>
      %2 = linalg.fill ins(%cst_0 : f32) outs(%extracted_slice : tensor<?xf32>) -> tensor<?xf32>
      scf.yield %2 : tensor<?xf32>
    }
    %inserted_slice = tensor.insert_slice %0 into %arg0[42] [%arg1] [1] : tensor<?xf32> into tensor<?xf32>
    return %inserted_slice : tensor<?xf32>
  }
  func.func @regression_do_not_eliminate_non_empty(%arg0: tensor<10xf32>, %arg1: tensor<10xf32>) -> tensor<10xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0] [5] [1] : tensor<10xf32> to tensor<5xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg1[1] [5] [1] : tensor<5xf32> into tensor<10xf32>
    return %inserted_slice : tensor<10xf32>
  }
  func.func @regression_insert_of_bbarg(%arg0: tensor<5xf32>, %arg1: tensor<10xf32>) -> tensor<10xf32> {
    %inserted_slice = tensor.insert_slice %arg0 into %arg1[2] [5] [1] : tensor<5xf32> into tensor<10xf32>
    return %inserted_slice : tensor<10xf32>
  }
  func.func @regression_eliminate_equivalent_only(%arg0: index, %arg1: index, %arg2: tensor<?x16xi8>) -> tensor<?x16xi8> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c16 = arith.constant 16 : index
    %0 = tensor.empty(%arg0) : tensor<?x8xi32>
    %extracted_slice = tensor.extract_slice %0[0, 0] [%arg1, 8] [1, 1] : tensor<?x8xi32> to tensor<?x8xi32>
    %1 = scf.for %arg3 = %c0 to %c16 step %c8 iter_args(%arg4 = %arg2) -> (tensor<?x16xi8>) {
      %inserted_slice = tensor.insert_slice %extracted_slice into %0[0, 0] [%arg0, 8] [1, 1] : tensor<?x8xi32> into tensor<?x8xi32>
      %extracted_slice_0 = tensor.extract_slice %arg4[%arg1, %arg1] [%arg0, 8] [1, 1] : tensor<?x16xi8> to tensor<?x8xi8>
      %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%inserted_slice : tensor<?x8xi32>) outs(%extracted_slice_0 : tensor<?x8xi8>) {
      ^bb0(%in: i32, %out: i8):
        %3 = arith.trunci %in : i32 to i8
        linalg.yield %3 : i8
      } -> tensor<?x8xi8>
      %inserted_slice_1 = tensor.insert_slice %2 into %arg4[%arg1, %arg3] [%arg0, 8] [1, 1] : tensor<?x8xi8> into tensor<?x16xi8>
      scf.yield %inserted_slice_1 : tensor<?x16xi8>
    }
    return %1 : tensor<?x16xi8>
  }
  func.func @regression_multiple_insertion_points(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %0 = tensor.empty() : tensor<2x5xf32>
    %cst = arith.constant 5.500000e+00 : f32
    %1 = "test.foo"() : () -> index
    %2 = "test.bar"() : () -> index
    %extracted_slice = tensor.extract_slice %arg0[%1, %2] [2, 5] [1, 1] : tensor<?x?xf32> to tensor<2x5xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<2x5xf32>) -> tensor<2x5xf32>
    %inserted_slice = tensor.insert_slice %3 into %arg0[%1, %2] [2, 5] [1, 1] : tensor<2x5xf32> into tensor<?x?xf32>
    return %inserted_slice : tensor<?x?xf32>
  }
  func.func @materialize_in_destination(%arg0: tensor<5xf32>, %arg1: f32) -> tensor<5xf32> {
    %0 = tensor.empty() : tensor<5xf32>
    %1 = linalg.fill ins(%arg1 : f32) outs(%arg0 : tensor<5xf32>) -> tensor<5xf32>
    %2 = bufferization.materialize_in_destination %1 in %arg0 : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    return %2 : tensor<5xf32>
  }
  func.func @materialize_in_destination_buffer(%arg0: memref<5xf32>, %arg1: f32) {
    %0 = bufferization.to_tensor %arg0 restrict writable : memref<5xf32> to tensor<5xf32>
    %1 = tensor.empty() : tensor<5xf32>
    %2 = linalg.fill ins(%arg1 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    bufferization.materialize_in_destination %2 in writable %arg0 : (tensor<5xf32>, memref<5xf32>) -> ()
    return
  }
  func.func @linalg_copy(%arg0: tensor<5xf32>, %arg1: f32) -> tensor<5xf32> {
    %0 = tensor.empty() : tensor<5xf32>
    %1 = linalg.fill ins(%arg1 : f32) outs(%arg0 : tensor<5xf32>) -> tensor<5xf32>
    %2 = linalg.copy ins(%1 : tensor<5xf32>) outs(%arg0 : tensor<5xf32>) -> tensor<5xf32>
    return %2 : tensor<5xf32>
  }
  func.func @linalg_copy_empty() -> tensor<26xi32> {
    %0 = tensor.empty() : tensor<26xi32>
    %1 = linalg.copy ins(%0 : tensor<26xi32>) outs(%0 : tensor<26xi32>) -> tensor<26xi32>
    return %1 : tensor<26xi32>
  }
  func.func @multiple_materialize_in_destination_buffer(%arg0: memref<5xf32>, %arg1: f32, %arg2: f32, %arg3: i1) {
    %0 = tensor.empty() : tensor<5xf32>
    %1 = linalg.fill ins(%arg1 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    %2 = bufferization.to_tensor %arg0 restrict writable : memref<5xf32> to tensor<5xf32>
    %3 = tensor.empty() : tensor<5xf32>
    %4 = linalg.fill ins(%arg2 : f32) outs(%2 : tensor<5xf32>) -> tensor<5xf32>
    %5 = scf.if %arg3 -> (tensor<5xf32>) {
      scf.yield %1 : tensor<5xf32>
    } else {
      scf.yield %4 : tensor<5xf32>
    }
    bufferization.materialize_in_destination %5 in writable %arg0 : (tensor<5xf32>, memref<5xf32>) -> ()
    return
  }
  func.func @eliminate_all_empty_tensors() -> tensor<5x6x128xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<5x6x64xf32>
    %1 = tensor.empty() : tensor<5x6x128xf32>
    %extracted_slice = tensor.extract_slice %1[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %3 = tensor.empty() : tensor<5x6x64xf32>
    %inserted_slice = tensor.insert_slice %2 into %1[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    %extracted_slice_1 = tensor.extract_slice %inserted_slice[0, 0, 64] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %4 = linalg.fill ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %inserted_slice_2 = tensor.insert_slice %4 into %inserted_slice[0, 0, 64] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    return %inserted_slice_2 : tensor<5x6x128xf32>
  }
  func.func @eliminate_concatenated_empty_tensors() -> tensor<5x6x128xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<5x6x128xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %1 = tensor.empty() : tensor<5x6x64xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %3 = tensor.empty() : tensor<5x6x64xf32>
    %inserted_slice = tensor.insert_slice %2 into %0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    %extracted_slice_1 = tensor.extract_slice %inserted_slice[0, 0, 64] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %4 = linalg.fill ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %inserted_slice_2 = tensor.insert_slice %4 into %inserted_slice[0, 0, 64] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    return %inserted_slice_2 : tensor<5x6x128xf32>
  }
  func.func @multi_use_of_the_same_tensor_empty() -> tensor<5x6x128xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<5x6x128xf32>
    %extracted_slice = tensor.extract_slice %0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %1 = tensor.empty() : tensor<5x6x64xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %inserted_slice = tensor.insert_slice %2 into %0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    %extracted_slice_1 = tensor.extract_slice %inserted_slice[0, 0, 64] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %3 = linalg.fill ins(%cst_0 : f32) outs(%extracted_slice_1 : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %inserted_slice_2 = tensor.insert_slice %3 into %inserted_slice[0, 0, 64] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    return %inserted_slice_2 : tensor<5x6x128xf32>
  }
  func.func @multi_use_of_the_same_tensor_empty_creates_non_existent_read(%arg0: tensor<5x6x128xf32>, %arg1: tensor<5x6x64xf32>) -> (tensor<5x6x128xf32>, tensor<5x6x64xf32>) {
    %cst = arith.constant 1.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %0 = tensor.empty() : tensor<5x6x64xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%extracted_slice : tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %2 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel", "parallel", "parallel"]} ins(%0 : tensor<5x6x64xf32>) outs(%arg1 : tensor<5x6x64xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %in : f32
      linalg.yield %3 : f32
    } -> tensor<5x6x64xf32>
    %inserted_slice = tensor.insert_slice %1 into %arg0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    return %inserted_slice, %2 : tensor<5x6x128xf32>, tensor<5x6x64xf32>
  }
  func.func @direct_use_of_tensor_empty(%arg0: tensor<5x6x128xf32>) -> tensor<5x6x128xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x128xf32> to tensor<5x6x64xf32>
    %0 = tensor.empty() : tensor<5x6x64xf32>
    %inserted_slice = tensor.insert_slice %extracted_slice into %arg0[0, 0, 0] [5, 6, 64] [1, 1, 1] : tensor<5x6x64xf32> into tensor<5x6x128xf32>
    return %inserted_slice : tensor<5x6x128xf32>
  }
  func.func @move_dependent_arith_op(%arg0: tensor<10xf32> {bufferization.buffer_layout = affine_map<(d0) -> (d0)>, bufferization.writable = true}, %arg1: index, %arg2: f32) -> tensor<10xf32> {
    %0 = tensor.empty() : tensor<5xf32>
    %c5 = arith.constant 5 : index
    %1 = arith.addi %arg1, %c5 : index
    %extracted_slice = tensor.extract_slice %arg0[%1] [5] [1] : tensor<10xf32> to tensor<5xf32>
    %2 = linalg.fill ins(%arg2 : f32) outs(%extracted_slice : tensor<5xf32>) -> tensor<5xf32>
    %inserted_slice = tensor.insert_slice %2 into %arg0[%1] [5] [1] : tensor<5xf32> into tensor<10xf32>
    return %inserted_slice : tensor<10xf32>
  }
  func.func @side_effecting_op_blocks_movement(%arg0: tensor<10xf32> {bufferization.buffer_layout = affine_map<(d0) -> (d0)>, bufferization.writable = true}, %arg1: memref<index>, %arg2: f32) -> tensor<10xf32> {
    %0 = tensor.empty() : tensor<5xf32>
    %1 = linalg.fill ins(%arg2 : f32) outs(%0 : tensor<5xf32>) -> tensor<5xf32>
    %2 = memref.load %arg1[] : memref<index>
    %inserted_slice = tensor.insert_slice %1 into %arg0[%2] [5] [1] : tensor<5xf32> into tensor<10xf32>
    return %inserted_slice : tensor<10xf32>
  }
}

