#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<50x91xf32>, tensor<91xf32>, tensor<50x1280xf32>, tensor<1280x91xf32>) -> tensor<50x91xf32>, sym_name = "eliminate_tensor_empty"}> ({
  ^bb0(%arg1: tensor<50x91xf32>, %arg2: tensor<91xf32>, %arg3: tensor<50x1280xf32>, %arg4: tensor<1280x91xf32>):
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<50x91xf32>
    %3 = "linalg.fill"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<50x91xf32>) -> tensor<50x91xf32>
    %4 = "linalg.matmul"(%arg3, %arg4, %3) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %7 = "arith.mulf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg10, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<50x1280xf32>, tensor<1280x91xf32>, tensor<50x91xf32>) -> tensor<50x91xf32>
    %5 = "linalg.generic"(%arg2, %4, %arg1) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
      %6 = "arith.addf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<91xf32>, tensor<50x91xf32>, tensor<50x91xf32>) -> tensor<50x91xf32>
    "func.return"(%5) : (tensor<50x91xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.structured.eliminate_empty_tensors"(%0) : (!transform.any_op) -> ()
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.linalg.erase_unnecessary_inputs"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<56xf32>, sym_name = "collapse_shape_prevents_reuse"}> ({
  ^bb0(%arg1: f32):
    %1 = "tensor.empty"() : () -> tensor<56xf32>
    %2 = "tensor.empty"() : () -> tensor<56x1xf32>
    %3 = "linalg.fill"(%arg1, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<56x1xf32>) -> tensor<56x1xf32>
    %4 = "tensor.collapse_shape"(%3) <{reassociation = [[0, 1]]}> : (tensor<56x1xf32>) -> tensor<56xf32>
    %5 = "linalg.generic"(%4, %1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<56xf32>, tensor<56xf32>) -> tensor<56xf32>
    "func.return"(%5) : (tensor<56xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.structured.eliminate_empty_tensors"(%0) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<56x?xf32>, sym_name = "collapse_cast_prevents_reuse"}> ({
  ^bb0(%arg1: f32):
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<56x?xf32>
    %3 = "tensor.empty"() : () -> tensor<56x1xf32>
    %4 = "linalg.fill"(%arg1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<56x1xf32>) -> tensor<56x1xf32>
    %5 = "tensor.cast"(%4) : (tensor<56x1xf32>) -> tensor<56x?xf32>
    %6 = "linalg.generic"(%5, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<56x?xf32>, tensor<56x?xf32>) -> tensor<56x?xf32>
    "func.return"(%6) : (tensor<56x?xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.structured.eliminate_empty_tensors"(%0) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

