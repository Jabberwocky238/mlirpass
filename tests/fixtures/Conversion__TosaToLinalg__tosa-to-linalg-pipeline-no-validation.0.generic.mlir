#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>) -> tensor<2x3xf32>, sym_name = "simple_abs"}> ({
  ^bb0(%arg0: tensor<2x3xf32>):
    %0 = "tensor.empty"() : () -> tensor<2x3xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %2 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<2x3xf32>, tensor<2x3xf32>) -> tensor<2x3xf32>
    "func.return"(%1) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

