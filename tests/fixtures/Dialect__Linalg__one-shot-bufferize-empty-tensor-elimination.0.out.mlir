#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @eliminate_tensor_empty(%arg0: tensor<50x91xf32>, %arg1: tensor<91xf32>, %arg2: tensor<50x1280xf32>, %arg3: tensor<1280x91xf32>) -> tensor<50x91xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.fill ins(%cst : f32) outs(%arg0 : tensor<50x91xf32>) -> tensor<50x91xf32>
    %1 = linalg.matmul ins(%arg2, %arg3 : tensor<50x1280xf32>, tensor<1280x91xf32>) outs(%0 : tensor<50x91xf32>) -> tensor<50x91xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<91xf32>) outs(%1 : tensor<50x91xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<50x91xf32>
    return %2 : tensor<50x91xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.structured.eliminate_empty_tensors %0 : !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.linalg.erase_unnecessary_inputs
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @collapse_shape_prevents_reuse(%arg0: f32) -> tensor<56xf32> {
    %0 = tensor.empty() : tensor<56xf32>
    %1 = tensor.empty() : tensor<56x1xf32>
    %2 = linalg.fill ins(%arg0 : f32) outs(%1 : tensor<56x1xf32>) -> tensor<56x1xf32>
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<56x1xf32> into tensor<56xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%collapsed : tensor<56xf32>) outs(%0 : tensor<56xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<56xf32>
    return %3 : tensor<56xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.structured.eliminate_empty_tensors %0 : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @collapse_cast_prevents_reuse(%arg0: f32) -> tensor<56x?xf32> {
    %c1 = arith.constant 1 : index
    %0 = tensor.empty(%c1) : tensor<56x?xf32>
    %1 = tensor.empty() : tensor<56x1xf32>
    %2 = linalg.fill ins(%arg0 : f32) outs(%1 : tensor<56x1xf32>) -> tensor<56x1xf32>
    %cast = tensor.cast %2 : tensor<56x1xf32> to tensor<56x?xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%cast : tensor<56x?xf32>) outs(%0 : tensor<56x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<56x?xf32>
    return %3 : tensor<56x?xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.structured.eliminate_empty_tensors %0 : !transform.any_op
      transform.yield 
    }
  }
}

