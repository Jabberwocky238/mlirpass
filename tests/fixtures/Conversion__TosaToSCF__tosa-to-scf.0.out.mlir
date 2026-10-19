module {
  func.func @while_test(%arg0: tensor<i32>) -> tensor<i32> {
    %0 = scf.while (%arg1 = %arg0) : (tensor<i32>) -> tensor<i32> {
      %1 = "tosa.const"() <{values = dense<3> : tensor<i32>}> : () -> tensor<i32>
      %2 = tosa.greater_equal %1, %arg1 : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %extracted = tensor.extract %2[] : tensor<i1>
      scf.condition(%extracted) %arg1 : tensor<i32>
    } do {
    ^bb0(%arg1: tensor<i32>):
      %1 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
      %2 = tosa.add %arg1, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
      scf.yield %2 : tensor<i32>
    }
    return %0 : tensor<i32>
  }
}

// -----
module {
  func.func @if_test(%arg0: tensor<f32>, %arg1: tensor<f32>, %arg2: tensor<i1>) -> tensor<f32> {
    %extracted = tensor.extract %arg2[] : tensor<i1>
    %0 = scf.if %extracted -> (tensor<f32>) {
      scf.yield %arg0 : tensor<f32>
    } else {
      scf.yield %arg1 : tensor<f32>
    }
    return %0 : tensor<f32>
  }
}

// -----
module {
  func.func @scatter_test(%arg0: tensor<3x7x5xi32>, %arg1: tensor<3x6xi32>, %arg2: tensor<3x6x5xi32>) -> tensor<3x7x5xi32> {
    %c0 = arith.constant 0 : index
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c6 = arith.constant 6 : index
    %c2 = arith.constant 2 : index
    %c5 = arith.constant 5 : index
    %c0_0 = arith.constant 0 : index
    %c1_1 = arith.constant 1 : index
    %0 = scf.for %arg3 = %c0_0 to %c3 step %c1_1 iter_args(%arg4 = %arg0) -> (tensor<3x7x5xi32>) {
      %1 = scf.for %arg5 = %c0_0 to %c6 step %c1_1 iter_args(%arg6 = %arg4) -> (tensor<3x7x5xi32>) {
        %extracted = tensor.extract %arg1[%arg3, %arg5] : tensor<3x6xi32>
        %2 = arith.index_cast %extracted : i32 to index
        %extracted_slice = tensor.extract_slice %arg2[%arg3, %arg5, %c0_0] [%c1_1, %c1_1, %c5] [%c1_1, %c1_1, %c1_1] : tensor<3x6x5xi32> to tensor<?x?x?xi32>
        %inserted_slice = tensor.insert_slice %extracted_slice into %arg6[%arg3, %2, %c0_0] [%c1_1, %c1_1, %c5] [%c1_1, %c1_1, %c1_1] : tensor<?x?x?xi32> into tensor<3x7x5xi32>
        scf.yield %inserted_slice : tensor<3x7x5xi32>
      }
      scf.yield %1 : tensor<3x7x5xi32>
    }
    return %0 : tensor<3x7x5xi32>
  }
}

