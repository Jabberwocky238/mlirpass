"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "empty_tensor_static_dim"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 6 : index}> : () -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<4x5x?xf32>
    %4 = "tensor.dim"(%3, %1) : (tensor<4x5x?xf32>, index) -> index
    %5 = "tensor.dim"(%3, %0) : (tensor<4x5x?xf32>, index) -> index
    "func.return"(%4, %5) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "empty_tensor_dynamic_dim"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "tensor.empty"(%arg0) : (index) -> tensor<4x5x?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<4x5x?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "empty_tensor_dynamic_dim2"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.empty"(%arg0, %arg1) : (index, index) -> tensor<?x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0 + d1, d1 - d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (index, index), sym_name = "remove_dim_result_uses"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %5 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%5, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> index, sym_name = "remove_dim_result_uses_outs"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %3 = "tensor.empty"(%2, %arg1) : (index, index) -> tensor<?x?xf32>
    %4 = "linalg.generic"(%arg0, %3) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %5 = "tensor.dim"(%4, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (index, index, index, index), sym_name = "remove_dim_result_uses_sequence"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "linalg.matmul"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %10 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %11 = "arith.addf"(%arg8, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x?xf32>, index) -> index
    %5 = "linalg.generic"(%arg0, %arg1, %2) <{indexing_maps = [#map3, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %8 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %9 = "arith.addf"(%8, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %6 = "tensor.dim"(%5, %0) : (tensor<?x?xf32>, index) -> index
    %7 = "tensor.dim"(%5, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%3, %4, %6, %7) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> (index, index), sym_name = "keep_result_dim_uses_sequence2"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %3 = "tensor.empty"(%2, %arg1) : (index, index) -> tensor<?x?xf32>
    %4 = "linalg.generic"(%arg0, %3) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %5 = "tensor.dim"(%4, %0) : (tensor<?x?xf32>, index) -> index
    %6 = "tensor.dim"(%4, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%5, %6) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> (index, index), sym_name = "empty_tensor_dim_of_linalg_result"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0:2 = "linalg.generic"(%arg0, %arg0, %arg1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      "linalg.yield"(%arg2, %arg2) : (f32, f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%0#0, %1) : (tensor<?xf32>, index) -> index
    %3 = "tensor.dim"(%0#1, %1) : (tensor<?xf32>, index) -> index
    "func.return"(%2, %3) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6x5x?xf32>, index) -> (index, index, index), sym_name = "dim_reshape_expansion"}> ({
  ^bb0(%arg0: tensor<6x5x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.expand_shape"(%arg0, %arg1) <{reassociation = [[0, 1], [2], [3, 4, 5]], static_output_shape = array<i64: 2, 3, 5, 4, -9223372036854775808, 7>}> : (tensor<6x5x?xf32>, index) -> tensor<2x3x5x4x?x7xf32>
    %4 = "tensor.dim"(%3, %0) : (tensor<2x3x5x4x?x7xf32>, index) -> index
    %5 = "tensor.dim"(%3, %1) : (tensor<2x3x5x4x?x7xf32>, index) -> index
    %6 = "tensor.dim"(%3, %2) : (tensor<2x3x5x4x?x7xf32>, index) -> index
    "func.return"(%4, %5, %6) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x5x4x?x7xf32>) -> (index, index), sym_name = "dim_reshape_collapse"}> ({
  ^bb0(%arg0: tensor<2x3x5x4x?x7xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2], [3, 4, 5]]}> : (tensor<2x3x5x4x?x7xf32>) -> tensor<6x5x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<6x5x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<6x5x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?x?xf32>, index, index, f32) -> (index, index, index), sym_name = "dim_of_pad_op"}> ({
  ^bb0(%arg0: tensor<2x?x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 4 : index}> : () -> index
    %5 = "arith.constant"() <{value = 5 : index}> : () -> index
    %6 = "tensor.pad"(%arg0, %3, %arg1, %4, %5, %arg2) <{operandSegmentSizes = array<i32: 1, 3, 2>, static_high = array<i64: 7, -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: index, %arg6: index):
      "tensor.yield"(%arg3) : (f32) -> ()
    }) : (tensor<2x?x?xf32>, index, index, index, index, index) -> tensor<?x?x?xf32>
    %7 = "tensor.dim"(%6, %0) : (tensor<?x?x?xf32>, index) -> index
    %8 = "tensor.dim"(%6, %1) : (tensor<?x?x?xf32>, index) -> index
    %9 = "tensor.dim"(%6, %2) : (tensor<?x?x?xf32>, index) -> index
    "func.return"(%7, %8, %9) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x16x?xf32>, tensor<2x?x?xf32>) -> (index, index, index), sym_name = "dim_of_softmax_op"}> ({
  ^bb0(%arg0: tensor<?x16x?xf32>, %arg1: tensor<2x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "linalg.softmax"(%arg0, %arg1) <{dimension = 2 : i64}> : (tensor<?x16x?xf32>, tensor<2x?x?xf32>) -> tensor<2x?x?xf32>
    %4 = "tensor.dim"(%3, %0) : (tensor<2x?x?xf32>, index) -> index
    %5 = "tensor.dim"(%3, %1) : (tensor<2x?x?xf32>, index) -> index
    %6 = "tensor.dim"(%3, %2) : (tensor<2x?x?xf32>, index) -> index
    "func.return"(%4, %5, %6) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

