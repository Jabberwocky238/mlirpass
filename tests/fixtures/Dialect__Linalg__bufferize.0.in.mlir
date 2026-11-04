#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xf32>, sym_name = "basic"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    "func.return"(%0) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "empty_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %2 = "math.exp"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> (tensor<4xf32>, tensor<4xf32>), sym_name = "multiple_results"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0:2 = "linalg.generic"(%arg0, %arg0, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%1, %1) : (f32, f32) -> ()
    }) : (tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> (tensor<4xf32>, tensor<4xf32>)
    "func.return"(%0#0, %0#1) : (tensor<4xf32>, tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "dynamic_results"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0:2 = "linalg.generic"(%arg0, %arg0, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%1, %1) : (f32, f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>)
    "func.return"(%0#0, %0#1) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xvector<3x4xi4>>, tensor<3x2xf32>) -> tensor<3x2xf32>, sym_name = "generic_with_init_tensor"}> ({
  ^bb0(%arg0: tensor<2x3x4xvector<3x4xi4>>, %arg1: tensor<3x2xf32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: vector<3x4xi4>, %arg3: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<2x3x4xvector<3x4xi4>>, tensor<3x2xf32>) -> tensor<3x2xf32>
    "func.return"(%0) : (tensor<3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "bufferize_fill"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<f32>) -> tensor<f32>, sym_name = "bufferize_dot"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<f32>):
    %0 = "linalg.dot"(%arg0, %arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.addf"(%arg4, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map, #map1]} : (tensor<4xf32>, tensor<4xf32>, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x16x32xf32>, tensor<2x16x32xf32>) -> tensor<2x16x32xf32>, sym_name = "bufferize_softmax"}> ({
  ^bb0(%arg0: tensor<2x16x32xf32>, %arg1: tensor<2x16x32xf32>):
    %0 = "linalg.softmax"(%arg0, %arg1) <{dimension = 2 : i64}> : (tensor<2x16x32xf32>, tensor<2x16x32xf32>) -> tensor<2x16x32xf32>
    "func.return"(%0) : (tensor<2x16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

