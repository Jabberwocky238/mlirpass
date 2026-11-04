module {
  func.func @dim_out_of_bounds(%arg0: memref<7x8xf32>) -> index {
    %c7 = arith.constant 7 : index
    %dim = memref.dim %arg0, %c7 : memref<7x8xf32>
    return %dim : index
  }
}

// -----
module {
  func.func @dim_out_of_bounds_2(%arg0: index, %arg1: index) -> index {
    %c7 = arith.constant 7 : index
    %c5 = arith.constant 5 : index
    %0 = bufferization.alloc_tensor(%c5, %c5) : tensor<?x?xf32>
    %dim = tensor.dim %0, %c7 : tensor<?x?xf32>
    return %dim : index
  }
}

// -----
module {
  func.func @dynamic_dim_of_transpose_op(%arg0: tensor<1x2x?x8xi8>) -> index {
    %c2 = arith.constant 2 : index
    %dim = tensor.dim %arg0, %c2 : tensor<1x2x?x8xi8>
    return %dim : index
  }
}

// -----
module {
  func.func @static_dim_of_transpose_op(%arg0: tensor<1x100x?x8xi8>) -> index {
    %c100 = arith.constant 100 : index
    return %c100 : index
  }
}

// -----
module {
  func.func @dim_of_memref_expand_shape(%arg0: memref<?x8xi32>) -> index {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x8xi32>
    return %dim : index
  }
}

// -----
module {
  func.func @iter_to_init_arg_loop_like(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %0 = scf.forall (%arg2) in (%dim) shared_outs(%arg3 = %arg1) -> (tensor<?x?xf32>) {
      %dim_0 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
      %extracted_slice = tensor.extract_slice %arg1[%arg2, 0] [1, %dim_0] [1, 1] : tensor<?x?xf32> to tensor<1x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %extracted_slice into %arg3[%arg2, 0] [1, %dim_0] [1, 1] : tensor<1x?xf32> into tensor<?x?xf32>
      }
    }
    return %0 : tensor<?x?xf32>
  }
}

// -----
module {
  func.func @dim_of_assume_alignment_static(%arg0: memref<2x3xf32>) -> (index, index) {
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    return %c2, %c3 : index, index
  }
}

// -----
module {
  func.func @dim_of_assume_alignment_dynamic(%arg0: memref<4x?xf32>) -> (index, index) {
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg0, %c1 : memref<4x?xf32>
    return %c4, %dim : index, index
  }
}

