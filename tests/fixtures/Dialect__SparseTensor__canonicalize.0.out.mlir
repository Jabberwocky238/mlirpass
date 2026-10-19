#sparse = #sparse_tensor.encoding<{ map = (d0, d1, d2) -> (d0 : dense, d1 : loose_compressed(nonunique), d2 : singleton) }>
module {
  func.func @sparse_slice_canonicalize(%arg0: tensor<?x?x?xf32, #sparse>, %arg1: index, %arg2: index) -> tensor<?x?x?xf32, #sparse> {
    %extracted_slice = tensor.extract_slice %arg0[0, %arg1, 1] [4, 1, %arg2] [1, 1, 1] : tensor<?x?x?xf32, #sparse> to tensor<4x1x?xf32, #sparse>
    %cast = tensor.cast %extracted_slice : tensor<4x1x?xf32, #sparse> to tensor<?x?x?xf32, #sparse>
    return %cast : tensor<?x?x?xf32, #sparse>
  }
}

// -----
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
module {
  func.func @sparse_iterate_canonicalize(%arg0: tensor<?x?xf64, #sparse>) {
    %0 = sparse_tensor.extract_iteration_space %arg0 lvls = 0 to 2 : tensor<?x?xf64, #sparse> -> !sparse_tensor.iter_space<#sparse, lvls = 0 to 2>
    sparse_tensor.iterate %arg2 in %0 at(_, %arg1) : !sparse_tensor.iter_space<#sparse, lvls = 0 to 2>  {
      "test.op"(%arg1) : (index) -> ()
    }
    return
  }
}

