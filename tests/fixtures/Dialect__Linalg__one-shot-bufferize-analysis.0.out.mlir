#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @not_elementwise(%arg0: tensor<5x6xf32> {bufferization.access = "read-write"}) -> tensor<5x6xf32> {
    %cst = arith.constant 5.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [1, 6] [1, 1] {__inplace_operands_attr__ = ["false"]} : tensor<5x6xf32> to tensor<6xf32>
    %0 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice : tensor<6xf32>) outs(%arg0 : tensor<5x6xf32>) attrs =  {__inplace_operands_attr__ = ["true", "true"]} {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    } -> tensor<5x6xf32>
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<5x6xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func @elementwise_no_conflict_4(%arg0: tensor<8x32x32x32xf32> {bufferization.access = "read-write"}, %arg1: tensor<32x32x32xf32> {bufferization.access = "read"}) -> tensor<8x32x32x32xf32> {
    %cst = arith.constant dense<3.000000e-02> : tensor<32x32x32xf32>
    %cst_0 = arith.constant dense<6.000000e-01> : tensor<32xf32>
    %cst_1 = arith.constant 0.000000e+00 : f32
    %0 = scf.forall (%arg2, %arg3) in (8, 32) shared_outs(%arg4 = %arg0) -> (tensor<8x32x32x32xf32>) {
      %extracted_slice = tensor.extract_slice %arg4[%arg2, %arg3, 0, 0] [1, 1, 32, 32] [1, 1, 1, 1] {__inplace_operands_attr__ = ["true", "none", "none"]} : tensor<8x32x32x32xf32> to tensor<32x32xf32>
      %1 = linalg.fill {__inplace_operands_attr__ = ["none", "true"]} ins(%cst_1 : f32) outs(%extracted_slice : tensor<32x32xf32>) -> tensor<32x32xf32>
      %2 = linalg.batch_reduce_matmul {__inplace_operands_attr__ = ["true", "true", "true"]} ins(%arg1, %cst : tensor<32x32x32xf32>, tensor<32x32x32xf32>) outs(%1 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %3 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%2, %cst_0 : tensor<32x32xf32>, tensor<32xf32>) outs(%extracted_slice : tensor<32x32xf32>) attrs =  {__inplace_operands_attr__ = ["true", "true", "true"]} {
      ^bb0(%in: f32, %in_2: f32, %out: f32):
        %5 = arith.addf %in, %in_2 : f32
        linalg.yield %5 : f32
      } -> tensor<32x32xf32>
      %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%3 : tensor<32x32xf32>) outs(%extracted_slice : tensor<32x32xf32>) attrs =  {__inplace_operands_attr__ = ["true", "true"]} {
      ^bb0(%in: f32, %out: f32):
        %5 = arith.maximumf %in, %cst_1 : f32
        linalg.yield %5 : f32
      } -> tensor<32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %4 into %arg4[%arg2, %arg3, 0, 0] [1, 1, 32, 32] [1, 1, 1, 1] {__inplace_operands_attr__ = ["true", "true", "none", "none"]} : tensor<32x32xf32> into tensor<8x32x32x32xf32>
      }
    } {__inplace_operands_attr__ = ["true"]}
    return {__equivalent_func_args__ = [0], __inplace_operands_attr__ = ["true"]} %0 : tensor<8x32x32x32xf32>
  }
}

// -----
module {
  func.func private @f(tensor<32x1xf32> {bufferization.access = "read-write"})
  func.func @elementwise_access_regression(%arg0: i32, %arg1: tensor<32x1xf32> {bufferization.access = "read"}, %arg2: tensor<32x1xf32> {bufferization.access = "read"}) {
    %cst = arith.constant 0.000000e+00 : f32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = tensor.empty() : tensor<32x1xf32>
    %1 = linalg.fill {__inplace_operands_attr__ = ["none", "false"]} ins(%cst : f32) outs(%0 : tensor<32x1xf32>) -> tensor<32x1xf32>
    scf.for %arg3 = %c0_i32 to %arg0 step %c1_i32  : i32 {
      %mapped = linalg.map { arith.subf } ins(%1, %arg1 : tensor<32x1xf32>, tensor<32x1xf32>) outs(%0 : tensor<32x1xf32>) {__inplace_operands_attr__ = ["true", "true", "true"]}
      %2 = tensor.empty() : tensor<32x1xf32>
      %mapped_0 = linalg.map { arith.subf } ins(%mapped, %arg2 : tensor<32x1xf32>, tensor<32x1xf32>) outs(%2 : tensor<32x1xf32>) {__inplace_operands_attr__ = ["true", "true", "true"]}
      func.call @f(%mapped_0) {__inplace_operands_attr__ = ["true"]} : (tensor<32x1xf32>) -> ()
    }
    return
  }
}

