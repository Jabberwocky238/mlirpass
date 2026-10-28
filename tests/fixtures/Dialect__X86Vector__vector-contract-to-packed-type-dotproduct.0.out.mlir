module {
  func.func @brgemm_to_bf16dp(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x16xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg1 : vector<1x1x16x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86vector.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<1x16xf32>
    return %7 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_bf16dp_bcst_B(%arg0: vector<1x16x1x2xbf16>, %arg1: vector<1x1x1x2xbf16>, %arg2: vector<16x1xf32>) -> vector<16x1xf32> {
    %0 = vector.shape_cast %arg2 : vector<16x1xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg0 : vector<1x16x1x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg1 : vector<1x1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86vector.avx512.dot %0, %1, %5 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<16x1xf32>
    return %7 : vector<16x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_int8dp(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x8x4xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x8xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg1 : vector<1x1x8x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86vector.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x8xi32>
    return %7 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_bf16dp(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x1x16xf32>) -> vector<1x1x16xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x1x16xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg1 : vector<1x1x16x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86vector.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<1x1x16xf32>
    return %7 : vector<1x1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_int8dp(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x8x4xi8>, %arg2: vector<1x1x8xi32>) -> vector<1x1x8xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x1x8xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg1 : vector<1x1x8x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86vector.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x1x8xi32>
    return %7 : vector<1x1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_int8dp_bcst_B(%arg0: vector<1x8x1x4xi8>, %arg1: vector<1x1x1x4xi8>, %arg2: vector<1x8x1xi32>) -> vector<1x8x1xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x8x1xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg0 : vector<1x8x1x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg1 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86vector.avx.dot.i8 %0, %1, %5 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x8x1xi32>
    return %7 : vector<1x8x1xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_bf16dp(%arg0: vector<1x1x2xbf16>, %arg1: vector<1x16x2xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x16xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg1 : vector<1x16x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg0 : vector<1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86vector.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<1x16xf32>
    return %7 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_bf16dp_bcst_B(%arg0: vector<16x1x2xbf16>, %arg1: vector<1x1x2xbf16>, %arg2: vector<16x1xf32>) -> vector<16x1xf32> {
    %0 = vector.shape_cast %arg2 : vector<16x1xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg0 : vector<16x1x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg1 : vector<1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86vector.avx512.dot %0, %1, %5 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<16x1xf32>
    return %7 : vector<16x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_int8dp(%arg0: vector<1x1x4xi8>, %arg1: vector<1x8x4xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x8xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg1 : vector<1x8x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86vector.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x8xi32>
    return %7 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_invalid_vc_kind(%arg0: vector<1x1x2xbf16>, %arg1: vector<1x16x2xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<mul>} %arg0, %arg1, %arg2 : vector<1x1x2xbf16>, vector<1x16x2xbf16> into vector<1x16xf32>
    return %0 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
module {
  func.func @negative_false_vnni_bf16(%arg0: vector<1x1x1x4xbf16>, %arg1: vector<1x1x16x4xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16> into vector<1x16xf32>
    return %0 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
module {
  func.func @negative_false_vnni_int8(%arg0: vector<1x1x1x2xi8>, %arg1: vector<1x1x8x2xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xi8>, vector<1x1x8x2xi8> into vector<1x8xi32>
    return %0 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_batch_dimension(%arg0: vector<3x1x1x2xbf16>, %arg1: vector<3x1x16x2xbf16>, %arg2: vector<3x1x16xf32>) -> vector<3x1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<3x1x1x2xbf16>, vector<3x1x16x2xbf16> into vector<3x1x16xf32>
    return %0 : vector<3x1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
module {
  func.func @negative_brgemm_dimension(%arg0: vector<2x1x1x4xi8>, %arg1: vector<2x1x8x4xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<2x1x1x4xi8>, vector<2x1x8x4xi8> into vector<1x8xi32>
    return %0 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_float_acc_type(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x1x16xbf16>) -> vector<1x1x16xbf16> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16> into vector<1x1x16xbf16>
    return %0 : vector<1x1x16xbf16>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_int_acc_type(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x8x4xi8>, %arg2: vector<1x1x8xi8>) -> vector<1x1x8xi8> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xi8>, vector<1x1x8x4xi8> into vector<1x1x8xi8>
    return %0 : vector<1x1x8xi8>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_wrong_vnni_blocking_factor_bf16(%arg0: vector<1x1x1x4xbf16>, %arg1: vector<1x1x16x4xbf16>, %arg2: vector<1x1x16xbf16>) -> vector<1x1x16xbf16> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16> into vector<1x1x16xbf16>
    return %0 : vector<1x1x16xbf16>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
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
  func.func @negative_brgemm_not_vnni(%arg0: vector<1x1x1xbf16>, %arg1: vector<1x1x32xbf16>, %arg2: vector<1x32xf32>) -> vector<1x32xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1xbf16>, vector<1x1x32xbf16> into vector<1x32xf32>
    return %0 : vector<1x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_wrong_vector_shape_int8(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x16x4xi8>, %arg2: vector<1x1x16xi32>) -> vector<1x1x16xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xi8>, vector<1x1x16x4xi8> into vector<1x1x16xi32>
    return %0 : vector<1x1x16xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_wrong_vector_shape_bf16(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x32x2xbf16>, %arg2: vector<1x1x32xf32>) -> vector<1x1x32xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xbf16>, vector<1x1x32x2xbf16> into vector<1x1x32xf32>
    return %0 : vector<1x1x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

