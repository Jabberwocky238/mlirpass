#map = affine_map<()[s0, s1] -> (s0, s1, 128)>
#map1 = affine_map<()[s0, s1, s2] -> (s0, s1 + s2)>
#map2 = affine_map<()[s0, s1] -> (s1)>
#map3 = affine_map<()[s0, s1] -> (s0 ceildiv s1)>
#map4 = affine_map<()[s0, s1] -> (s0, s1, -128)>
#map5 = affine_map<()[s0, s1] -> (s0 ceildiv 128 + s0 ceildiv s1)>
module {
  func.func @apply_simplification_1() -> index {
    %0 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %1 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %2 = affine.min #map()[%0, %1]
    %c2 = arith.constant 2 : index
    return %c2 : index
  }
  func.func @apply_simplification_2() -> index {
    %0 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %1 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %2 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %3 = affine.min #map1()[%0, %1, %2]
    %c4 = arith.constant 4 : index
    return %c4 : index
  }
  func.func @no_simplification_0() -> index {
    %0 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %1 = test.value_with_bounds {max = 64 : index, min = 16 : index}
    %2 = affine.min #map2()[%0, %1]
    %3 = affine.apply #map3()[%2, %0]
    return %3 : index
  }
  func.func @no_simplification_1() -> index {
    %0 = test.value_with_bounds {max = 64 : index, min = 32 : index}
    %1 = test.value_with_bounds {max = 64 : index, min = 16 : index}
    %2 = affine.min #map4()[%0, %1]
    %3 = affine.apply #map5()[%2, %1]
    return %3 : index
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["affine.apply"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.test.make_composed_folded_affine_apply %0 : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

