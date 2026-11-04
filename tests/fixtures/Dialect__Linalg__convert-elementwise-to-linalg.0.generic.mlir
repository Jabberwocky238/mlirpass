#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>) -> tensor<f32>, sym_name = "addf_rank0"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<f32>, tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "addf_rank1"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "exp"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>, sym_name = "select"}> ({
  ^bb0(%arg0: tensor<i1>, %arg1: tensor<i32>, %arg2: tensor<i32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg2, %arg1) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i1, %arg4: i32, %arg5: i32, %arg6: i32):
      %1 = "arith.select"(%arg3, %arg4, %arg5) : (i1, i32, i32) -> i32
      "linalg.yield"(%1) : (i32) -> ()
    }) : (tensor<i1>, tensor<i32>, tensor<i32>, tensor<i32>) -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>) -> tensor<i1>, sym_name = "cmpf"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
    %0 = "tensor.empty"() : () -> tensor<i1>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i1):
      %2 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%2) : (i1) -> ()
    }) : (tensor<f32>, tensor<f32>, tensor<i1>) -> tensor<i1>
    "func.return"(%1) : (tensor<i1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3, d4, d5)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x?x?x8x2x?xf32>, tensor<4x?x?x8x2x?xf32>) -> tensor<4x?x?x8x2x?xi1>, sym_name = "cmpf"}> ({
  ^bb0(%arg0: tensor<4x?x?x8x2x?xf32>, %arg1: tensor<4x?x?x8x2x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<4x?x?x8x2x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<4x?x?x8x2x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 5 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<4x?x?x8x2x?xf32>, index) -> index
    %6 = "tensor.empty"(%1, %3, %5) : (index, index, index) -> tensor<4x?x?x8x2x?xi1>
    %7 = "linalg.generic"(%arg0, %arg1, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i1):
      %8 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%8) : (i1) -> ()
    }) : (tensor<4x?x?x8x2x?xf32>, tensor<4x?x?x8x2x?xf32>, tensor<4x?x?x8x2x?xi1>) -> tensor<4x?x?x8x2x?xi1>
    "func.return"(%7) : (tensor<4x?x?x8x2x?xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "scalar_plus_tensor"}> ({
  ^bb0(%arg0: f32, %arg1: tensor<?x?xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg1) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %1 = "test.elementwise_mappable"(%arg2, %arg3) : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, tensor<?x?xf32>, f32) -> tensor<?x?xf32>, sym_name = "scalar_tensor_scalar"}> ({
  ^bb0(%arg2: f32, %arg3: tensor<?x?xf32>, %arg4: f32):
    %1 = "linalg.generic"(%arg2, %arg3, %arg3) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %4 = "test.elementwise_mappable"(%arg8, %arg9) : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "linalg.generic"(%arg4, %1, %1) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
      %3 = "test.elementwise_mappable"(%arg5, %arg6) : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "negative_scalar_only_eltwise"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

