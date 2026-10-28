module {
  func.func @matmul_outer_product_to_fma(%arg0: vector<1x1xf32>, %arg1: vector<1x64xf32>, %arg2: vector<1x64xf32>) -> vector<1x64xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x64xf32> to vector<64xf32>
    %1 = vector.shape_cast %arg0 : vector<1x1xf32> to vector<1xf32>
    %2 = vector.shape_cast %arg1 : vector<1x64xf32> to vector<64xf32>
    %3 = vector.broadcast %1 : vector<1xf32> to vector<64xf32>
    %4 = vector.fma %3, %2, %0 : vector<64xf32>
    %5 = vector.shape_cast %4 : vector<64xf32> to vector<1x64xf32>
    return %5 : vector<1x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_fma_bcst_B(%arg0: vector<64x1xf32>, %arg1: vector<1x1xf32>, %arg2: vector<64x1xf32>) -> vector<64x1xf32> {
    %0 = vector.shape_cast %arg2 : vector<64x1xf32> to vector<64xf32>
    %1 = vector.shape_cast %arg0 : vector<64x1xf32> to vector<64xf32>
    %2 = vector.shape_cast %arg1 : vector<1x1xf32> to vector<1xf32>
    %3 = vector.broadcast %2 : vector<1xf32> to vector<64xf32>
    %4 = vector.fma %1, %3, %0 : vector<64xf32>
    %5 = vector.shape_cast %4 : vector<64xf32> to vector<64x1xf32>
    return %5 : vector<64x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_to_fma(%arg0: vector<1x1x1xf32>, %arg1: vector<1x1x64xf32>, %arg2: vector<1x1x64xf32>) -> vector<1x1x64xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x1x64xf32> to vector<64xf32>
    %1 = vector.shape_cast %arg0 : vector<1x1x1xf32> to vector<1xf32>
    %2 = vector.shape_cast %arg1 : vector<1x1x64xf32> to vector<64xf32>
    %3 = vector.broadcast %1 : vector<1xf32> to vector<64xf32>
    %4 = vector.fma %3, %2, %0 : vector<64xf32>
    %5 = vector.shape_cast %4 : vector<64xf32> to vector<1x1x64xf32>
    return %5 : vector<1x1x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_to_fma_bcst_B(%arg0: vector<1x64x1xf32>, %arg1: vector<1x1x1xf32>, %arg2: vector<1x64x1xf32>) -> vector<1x64x1xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x64x1xf32> to vector<64xf32>
    %1 = vector.shape_cast %arg0 : vector<1x64x1xf32> to vector<64xf32>
    %2 = vector.shape_cast %arg1 : vector<1x1x1xf32> to vector<1xf32>
    %3 = vector.broadcast %2 : vector<1xf32> to vector<64xf32>
    %4 = vector.fma %1, %3, %0 : vector<64xf32>
    %5 = vector.shape_cast %4 : vector<64xf32> to vector<1x64x1xf32>
    return %5 : vector<1x64x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_fma(%arg0: vector<1x1x1xf32>, %arg1: vector<1x1x64xf32>, %arg2: vector<1x64xf32>) -> vector<1x64xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x64xf32> to vector<64xf32>
    %1 = vector.shape_cast %arg0 : vector<1x1x1xf32> to vector<1xf32>
    %2 = vector.shape_cast %arg1 : vector<1x1x64xf32> to vector<64xf32>
    %3 = vector.broadcast %1 : vector<1xf32> to vector<64xf32>
    %4 = vector.fma %3, %2, %0 : vector<64xf32>
    %5 = vector.shape_cast %4 : vector<64xf32> to vector<1x64xf32>
    return %5 : vector<1x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_fma_bcst_B(%arg0: vector<1x64x1xf32>, %arg1: vector<1x1x1xf32>, %arg2: vector<64x1xf32>) -> vector<64x1xf32> {
    %0 = vector.shape_cast %arg2 : vector<64x1xf32> to vector<64xf32>
    %1 = vector.shape_cast %arg0 : vector<1x64x1xf32> to vector<64xf32>
    %2 = vector.shape_cast %arg1 : vector<1x1x1xf32> to vector<1xf32>
    %3 = vector.broadcast %2 : vector<1xf32> to vector<64xf32>
    %4 = vector.fma %1, %3, %0 : vector<64xf32>
    %5 = vector.shape_cast %4 : vector<64xf32> to vector<64x1xf32>
    return %5 : vector<64x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
module {
  func.func @negative_non_unit_batch_dim(%arg0: vector<3x1x1xf32>, %arg1: vector<3x1x64xf32>, %arg2: vector<3x1x64xf32>) -> vector<3x1x64xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<3x1x1xf32>, vector<3x1x64xf32> into vector<3x1x64xf32>
    return %0 : vector<3x1x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_non_unit_batch_reduce_dim(%arg0: vector<3x1x1xf32>, %arg1: vector<3x1x64xf32>, %arg2: vector<1x64xf32>) -> vector<1x64xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<3x1x1xf32>, vector<3x1x64xf32> into vector<1x64xf32>
    return %0 : vector<1x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_invalid_kind(%arg0: vector<1x1xf32>, %arg1: vector<1x64xf32>, %arg2: vector<1x64xf32>) -> vector<1x64xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<mul>} %arg0, %arg1, %arg2 : vector<1x1xf32>, vector<1x64xf32> into vector<1x64xf32>
    return %0 : vector<1x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
module {
  func.func @negative_accumulator_type(%arg0: vector<1x1x1xf32>, %arg1: vector<1x1x64xf32>, %arg2: vector<1x1x64xi32>) -> vector<1x1x64xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1xf32>, vector<1x1x64xf32> into vector<1x1x64xi32>
    return %0 : vector<1x1x64xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

