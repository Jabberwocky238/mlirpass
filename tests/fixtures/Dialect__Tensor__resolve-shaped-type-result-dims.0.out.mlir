module {
  func.func @insert_slice(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg1, %c0 : tensor<?x?x?xf32>
    %dim_0 = tensor.dim %arg1, %c1 : tensor<?x?x?xf32>
    %dim_1 = tensor.dim %arg1, %c2 : tensor<?x?x?xf32>
    return %dim, %dim_0, %dim_1 : index, index, index
  }
}

// -----
module {
  func.func @extract_slice(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index) -> (index, index, index) {
    return %arg1, %arg2, %arg3 : index, index, index
  }
}

// -----
module {
  func.func @extract_slice_rank_reduced_1(%arg0: tensor<?x?x?xf32>, %arg1: index) -> index {
    return %arg1 : index
  }
}

// -----
module {
  func.func @extract_slice_rank_reduced_2(%arg0: tensor<?x?x?xf32>, %arg1: index) -> index {
    return %arg1 : index
  }
}

// -----
module {
  func.func @extract_slice_rank_reduced_3(%arg0: tensor<?x?x?xf32>, %arg1: index) -> index {
    return %arg1 : index
  }
}

// -----
module {
  func.func @extract_slice_rank_reduced_4(%arg0: tensor<?x?x?xf32>, %arg1: index) -> index {
    return %arg1 : index
  }
}

// -----
module {
  func.func @extract_slice_rank_reduced_5(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index) -> (index, index) {
    return %arg1, %arg2 : index, index
  }
}

// -----
module {
  func.func @extract_slice_rank_reduced_6(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index) -> (index, index) {
    return %arg1, %arg2 : index, index
  }
}

// -----
module {
  func.func @collapse_shape() -> index {
    %c154 = arith.constant 154 : index
    return %c154 : index
  }
}

