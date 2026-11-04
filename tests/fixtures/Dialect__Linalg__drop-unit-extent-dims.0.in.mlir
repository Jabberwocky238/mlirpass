#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> ()>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1x?xf32>, f32, tensor<?x1x?x1x?xf32>) -> tensor<?x1x?x1x?xf32>, sym_name = "drop_one_trip_loops"}> ({
  ^bb0(%arg0: tensor<?x1x?xf32>, %arg1: f32, %arg2: tensor<?x1x?x1x?xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (tensor<?x1x?xf32>, f32, tensor<?x1x?x1x?xf32>) -> tensor<?x1x?x1x?xf32>
    "func.return"(%0) : (tensor<?x1x?x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> ()>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x1xf32>, f32, tensor<1x1x?x1x1xf32>) -> tensor<1x1x?x1x1xf32>, sym_name = "drop_one_trip_loops_all_ones"}> ({
  ^bb0(%arg0: tensor<1x1x1xf32>, %arg1: f32, %arg2: tensor<1x1x?x1x1xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (tensor<1x1x1xf32>, f32, tensor<1x1x?x1x1xf32>) -> tensor<1x1x?x1x1xf32>
    "func.return"(%0) : (tensor<1x1x?x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1x?xi32>, tensor<?x1x?x1x?xi32>) -> tensor<?x1x?x1x?xi32>, sym_name = "drop_one_trip_loops_indexed"}> ({
  ^bb0(%arg0: tensor<?x1x?xi32>, %arg1: tensor<?x1x?x1x?xi32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: i32):
      %1 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %2 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %3 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %4 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %5 = "linalg.index"() <{dim = 4 : i64}> : () -> index
      %6 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.subi"(%6, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.subi"(%7, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%8, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.index_cast"(%9) : (index) -> i32
      %11 = "arith.addi"(%10, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%11) : (i32) -> ()
    }) : (tensor<?x1x?xi32>, tensor<?x1x?x1x?xi32>) -> tensor<?x1x?x1x?xi32>
    "func.return"(%0) : (tensor<?x1x?x1x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1xf32>) -> tensor<1x1xf32>, sym_name = "drop_all_loops"}> ({
  ^bb0(%arg0: tensor<1x1xf32>):
    %0 = "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<1x1xf32>, tensor<1x1xf32>) -> tensor<1x1xf32>
    "func.return"(%0) : (tensor<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1xi32>) -> tensor<1x1xi32>, sym_name = "drop_all_loops_indexed"}> ({
  ^bb0(%arg0: tensor<1x1xi32>):
    %0 = "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      %1 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %2 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %3 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.index_cast"(%3) : (index) -> i32
      %5 = "arith.addi"(%4, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%5) : (i32) -> ()
    }) : (tensor<1x1xi32>, tensor<1x1xi32>) -> tensor<1x1xi32>
    "func.return"(%0) : (tensor<1x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (0, d0)>
#map1 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5xf32>, tensor<5xf32>) -> tensor<5xf32>, sym_name = "leading_dim_1_canonicalization"}> ({
  ^bb0(%arg0: tensor<1x5xf32>, %arg1: tensor<5xf32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<1x5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<5xf32>, tensor<5x5xf32>) -> tensor<5x5xf32>, sym_name = "broadcast_test"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<5xf32>, %arg2: tensor<5x5xf32>):
    %0 = "tensor.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 5>}> : (tensor<5xf32>) -> tensor<1x5xf32>
    %1 = "tensor.expand_shape"(%arg1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 5, 1>}> : (tensor<5xf32>) -> tensor<5x1xf32>
    %2 = "linalg.generic"(%0, %1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %3 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<1x5xf32>, tensor<5x1xf32>, tensor<5x5xf32>) -> tensor<5x5xf32>
    "func.return"(%2) : (tensor<5x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (0, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "broadcast_scalar"}> ({
  ^bb0(%arg0: tensor<1x1xf32>, %arg1: tensor<?x?xf32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<1x1xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<2x5xf32>, sym_name = "fold_unit_dim_tensor_reshape_op"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x2x5xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) {i64} : (tensor<5xf32>, tensor<1x2x5xf32>) -> tensor<1x2x5xf32>
    %2 = "tensor.collapse_shape"(%1) <{reassociation = [[0, 1], [2]]}> : (tensor<1x2x5xf32>) -> tensor<2x5xf32>
    "func.return"(%2) : (tensor<2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1000xf32>) -> tensor<1xf32>, sym_name = "fold_unit_dim_for_empty_tensor"}> ({
  ^bb0(%arg0: tensor<1x1000xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<1xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<1xf32>) -> tensor<1xf32>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %4 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<1x1000xf32>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"(%3) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x?x?x1x1xf32>, index, index, index, index, index, index) -> (tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x1x?x1x1xf32>), sym_name = "fold_slice"}> ({
  ^bb0(%arg0: tensor<1x?x?x1x?x1x1xf32>, %arg1: tensor<1x?x?x?x?x1x1xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "tensor.extract_slice"(%arg0, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808, 0, -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808, 1, -9223372036854775808, 1, 1>, static_strides = array<i64: 1, 1, 1, 1, 1, 1, 1>}> : (tensor<1x?x?x1x?x1x1xf32>, index, index, index, index, index, index) -> tensor<1x?x?x1x?x1x1xf32>
    %1 = "tensor.extract_slice"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, 0, -9223372036854775808, 0, 0, -9223372036854775808, 0>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808, 1, -9223372036854775808, 1, 1>, static_strides = array<i64: 1, 1, 1, 1, 1, 1, 1>}> : (tensor<1x?x?x?x?x1x1xf32>, index, index, index, index, index, index) -> tensor<1x?x?x1x?x1x1xf32>
    "func.return"(%0, %1) : (tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x1x?x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x1x?xf32>) -> tensor<1x?xf32>, sym_name = "unit_dim_for_reduction"}> ({
  ^bb0(%arg0: tensor<1x?x1x?xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<1x?x1x?xf32>, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<1x?xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<1x?xf32>) -> tensor<1x?xf32>
    %5 = "linalg.generic"(%arg0, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %6 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<1x?x1x?xf32>, tensor<1x?xf32>) -> tensor<1x?xf32>
    "func.return"(%5) : (tensor<1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x1x1xf32>) -> tensor<1x1xf32>, sym_name = "unit_dim_for_both_reduction"}> ({
  ^bb0(%arg0: tensor<1x?x1x1xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "tensor.empty"() : () -> tensor<1x1xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<1x1xf32>) -> tensor<1x1xf32>
    %4 = "linalg.generic"(%arg0, %3) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %5 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<1x?x1x1xf32>, tensor<1x1xf32>) -> tensor<1x1xf32>
    "func.return"(%4) : (tensor<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1x?x1xf32>) -> tensor<?x1xf32>, sym_name = "unit_dim_for_reduction_inner"}> ({
  ^bb0(%arg0: tensor<?x1x?x1xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x1x?x1xf32>, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<?x1xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<?x1xf32>) -> tensor<?x1xf32>
    %5 = "linalg.generic"(%arg0, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %6 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<?x1x?x1xf32>, tensor<?x1xf32>) -> tensor<?x1xf32>
    "func.return"(%5) : (tensor<?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x3xf32>) -> tensor<1x1xf32>, sym_name = "slice_unit_dims"}> ({
  ^bb0(%arg0: tensor<1x3xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 2>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<1x3xf32>) -> tensor<1x1xf32>
    "func.return"(%0) : (tensor<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x3x1x3xf32>) -> tensor<1x3x3xf32>, sym_name = "rank_reduced_extract_slice"}> ({
  ^bb0(%arg0: tensor<1x1x3x1x3xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0, 0>, static_sizes = array<i64: 1, 1, 3, 1, 3>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (tensor<1x1x3x1x3xf32>) -> tensor<1x3x3xf32>
    "func.return"(%0) : (tensor<1x3x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x3xf32>, tensor<1x1xf32>) -> tensor<1x3xf32>, sym_name = "insert_slice_unit_dims"}> ({
  ^bb0(%arg0: tensor<1x3xf32>, %arg1: tensor<1x1xf32>):
    %0 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 2>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<1x1xf32>, tensor<1x3xf32>) -> tensor<1x3xf32>
    "func.return"(%0) : (tensor<1x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x3x1x3xf32>, tensor<1x3x3xf32>) -> tensor<1x1x3x1x3xf32>, sym_name = "rank_reduced_insert_slice"}> ({
  ^bb0(%arg0: tensor<1x1x3x1x3xf32>, %arg1: tensor<1x3x3xf32>):
    %0 = "tensor.insert_slice"(%arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0, 0>, static_sizes = array<i64: 1, 1, 3, 1, 3>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (tensor<1x3x3xf32>, tensor<1x1x3x1x3xf32>) -> tensor<1x1x3x1x3xf32>
    "func.return"(%0) : (tensor<1x1x3x1x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> ()>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x1x?xf32>, f32, memref<?x1x?x1x?xf32>) -> memref<?x1x?x1x?xf32>, sym_name = "drop_one_trip_loops"}> ({
  ^bb0(%arg0: memref<?x1x?xf32>, %arg1: f32, %arg2: memref<?x1x?x1x?xf32>):
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (memref<?x1x?xf32>, f32, memref<?x1x?x1x?xf32>) -> ()
    "func.return"(%arg2) : (memref<?x1x?x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x1x?xi32>, memref<?x1x?x1x?xi32>) -> memref<?x1x?x1x?xi32>, sym_name = "drop_one_trip_loops_indexed"}> ({
  ^bb0(%arg0: memref<?x1x?xi32>, %arg1: memref<?x1x?x1x?xi32>):
    "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: i32):
      %0 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %1 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %2 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %3 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %4 = "linalg.index"() <{dim = 4 : i64}> : () -> index
      %5 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.subi"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.subi"(%6, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.addi"(%7, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i32
      %10 = "arith.addi"(%9, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%10) : (i32) -> ()
    }) : (memref<?x1x?xi32>, memref<?x1x?x1x?xi32>) -> ()
    "func.return"(%arg1) : (memref<?x1x?x1x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xf32>) -> memref<1x1xf32>, sym_name = "drop_all_loops"}> ({
  ^bb0(%arg0: memref<1x1xf32>):
    "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<1x1xf32>, memref<1x1xf32>) -> ()
    "func.return"(%arg0) : (memref<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xi32>) -> memref<1x1xi32>, sym_name = "drop_all_loops_indexed"}> ({
  ^bb0(%arg0: memref<1x1xi32>):
    "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      %0 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %1 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %2 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.index_cast"(%2) : (index) -> i32
      %4 = "arith.addi"(%3, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%4) : (i32) -> ()
    }) : (memref<1x1xi32>, memref<1x1xi32>) -> ()
    "func.return"(%arg0) : (memref<1x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (0, d0)>
#map1 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x5xf32>, memref<5xf32>) -> memref<5xf32>, sym_name = "leading_dim_1_canonicalization"}> ({
  ^bb0(%arg0: memref<1x5xf32>, %arg1: memref<5xf32>):
    "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<1x5xf32>, memref<5xf32>) -> ()
    "func.return"(%arg1) : (memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, memref<5xf32>, memref<5x5xf32>) -> memref<5x5xf32>, sym_name = "broadcast_test"}> ({
  ^bb0(%arg0: memref<5xf32>, %arg1: memref<5xf32>, %arg2: memref<5x5xf32>):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 5>}> : (memref<5xf32>) -> memref<1x5xf32>
    %1 = "memref.expand_shape"(%arg1) <{reassociation = [[0, 1]], static_output_shape = array<i64: 5, 1>}> : (memref<5xf32>) -> memref<5x1xf32>
    "linalg.generic"(%0, %1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %2 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (memref<1x5xf32>, memref<5x1xf32>, memref<5x5xf32>) -> ()
    "func.return"(%arg2) : (memref<5x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (0, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xf32>, memref<?x?xf32>) -> memref<?x?xf32>, sym_name = "broadcast_scalar"}> ({
  ^bb0(%arg0: memref<1x1xf32>, %arg1: memref<?x?xf32>):
    "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_fn", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<1x1xf32>, memref<?x?xf32>) -> ()
    "func.return"(%arg1) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>) -> memref<2x5xf32>, sym_name = "fold_unit_dim_memref_reshape_op"}> ({
  ^bb0(%arg0: memref<5xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x2x5xf32>
    "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) {i64} : (memref<5xf32>, memref<1x2x5xf32>) -> ()
    %1 = "memref.collapse_shape"(%0) <{reassociation = [[0, 1], [2]]}> : (memref<1x2x5xf32>) -> memref<2x5xf32>
    "func.return"(%1) : (memref<2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1000xf32>) -> memref<1xf32>, sym_name = "fold_unit_dim_for_init_memref"}> ({
  ^bb0(%arg0: memref<1x1000xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf32>
    "linalg.generic"(%arg0, %1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %2 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (memref<1x1000xf32>, memref<1xf32>) -> ()
    "func.return"(%1) : (memref<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> ()>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d1, d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x1x?xf32, strided<[?, 1, 1]>>, f32, memref<?x1x?x1x?xf32>) -> memref<?x1x?x1x?xf32>, sym_name = "input_stays_same"}> ({
  ^bb0(%arg0: memref<?x1x?xf32, strided<[?, 1, 1]>>, %arg1: f32, %arg2: memref<?x1x?x1x?xf32>):
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (memref<?x1x?xf32, strided<[?, 1, 1]>>, f32, memref<?x1x?x1x?xf32>) -> ()
    "func.return"(%arg2) : (memref<?x1x?x1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
#map2 = affine_map<(d0, d1) -> (d0)>
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8xf32, #sparse>, tensor<8xf32>) -> tensor<8xf32>, sym_name = "sparse_case"}> ({
  ^bb0(%arg0: tensor<8x8xf32, #sparse>, %arg1: tensor<8xf32>):
    %0 = "tensor.empty"() : () -> tensor<8xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.addf"(%arg4, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<8x8xf32, #sparse>, tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    "func.return"(%1) : (tensor<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4x2xf32>, sym_name = "parallel_insert_slice"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.empty"() : () -> tensor<4x2xf32>
    %4 = "scf.forall"(%1, %0, %3) <{operandSegmentSizes = array<i32: 0, 2, 0, 1>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: tensor<4x2xf32>):
      %5 = "tensor.empty"() : () -> tensor<1x1xf32>
      %6 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, tensor<1x1xf32>) -> tensor<1x1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%6, %arg2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<1x1xf32>, tensor<4x2xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, tensor<4x2xf32>) -> tensor<4x2xf32>
    "func.return"(%4) : (tensor<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xf32, 3>) -> memref<1x1xf32, 3>, sym_name = "drop_all_loops"}> ({
  ^bb0(%arg0: memref<1x1xf32, 3>):
    "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], library_call = "some_external_func", operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<1x1xf32, 3>, memref<1x1xf32, 3>) -> ()
    "func.return"(%arg0) : (memref<1x1xf32, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x3x1x1xf32>) -> tensor<1x2x3x1x3xf32>, sym_name = "drop_unit_pad_dims"}> ({
  ^bb0(%arg0: tensor<1x1x3x1x1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.pad"(%arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, 0, 0, -9223372036854775808, 2>, static_low = array<i64: 0, 1, 0, -9223372036854775808, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<1x1x3x1x1xf32>, index, index) -> tensor<1x2x3x1x3xf32>
    "func.return"(%2) : (tensor<1x2x3x1x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>) -> tensor<1x?xf32>, sym_name = "drop_unit_pad_dynamic_dims"}> ({
  ^bb0(%arg0: tensor<1x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 6>, static_low = array<i64: 0, 5>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<1x?xf32>) -> tensor<1x?xf32>
    "func.return"(%2) : (tensor<1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x3x1x1xf32>, f32) -> tensor<1x2x3x1x3xf32>, sym_name = "do_not_drop_non_constant_padding"}> ({
  ^bb0(%arg0: tensor<1x1x3x1x1xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.pad"(%arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 1>, static_high = array<i64: 0, 0, 0, -9223372036854775808, 2>, static_low = array<i64: 0, 1, 0, -9223372036854775808, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
      %2 = "arith.index_cast"(%arg4) : (index) -> i64
      %3 = "arith.sitofp"(%2) : (i64) -> f32
      %4 = "arith.addf"(%arg1, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "tensor.yield"(%4) : (f32) -> ()
    }) : (tensor<1x1x3x1x1xf32>, index, index) -> tensor<1x2x3x1x3xf32>
    "func.return"(%1) : (tensor<1x2x3x1x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x383x128xf32>) -> tensor<1x384x128xf32>, sym_name = "drop_known_unit_constant_low_high"}> ({
  ^bb0(%arg0: tensor<1x383x128xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.pad"(%arg0, %0, %1, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 1, 3, 3>, static_high = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (tensor<1x383x128xf32>, index, index, index, index, index, index) -> tensor<1x384x128xf32>
    "func.return"(%3) : (tensor<1x384x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?xf32>) -> tensor<1x16xf32>, sym_name = "drop_unit_dim_mixed_static_dynamic"}> ({
  ^bb0(%arg0: tensor<1x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "tensor.pad"(%arg0, %0, %1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (tensor<1x?xf32>, index, index, index, index) -> tensor<1x16xf32>
    "func.return"(%3) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1 + d4, d2 + d5, d6)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d4, d5, d6, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x1xf32>, index) -> tensor<?x1x61x1xf32>, sym_name = "drop_unit_dim_corresponding_to_dynamic_dim"}> ({
  ^bb0(%arg0: tensor<1x?x?x1xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = dense<1.000000e+00> : tensor<1x1x1x1xf32>}> : () -> tensor<1x1x1x1xf32>
    %1 = "tensor.empty"(%arg1) : (index) -> tensor<?x1x61x1xf32>
    %2 = "linalg.generic"(%arg0, %0, %1) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %3 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.addf"(%arg4, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<1x?x?x1xf32>, tensor<1x1x1x1xf32>, tensor<?x1x61x1xf32>) -> tensor<?x1x61x1xf32>
    "func.return"(%2) : (tensor<?x1x61x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d4, d2 + d5, d3 + d6)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d1, d4, d5, d6)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x61x1x1xf32>, tensor<48x61x1x1xf32>, tensor<1x48x1x1xf32>) -> tensor<1x48x1x1xf32>, sym_name = "drop_unit_dim_binary_expr"}> ({
  ^bb0(%arg0: tensor<1x61x1x1xf32>, %arg1: tensor<48x61x1x1xf32>, %arg2: tensor<1x48x1x1xf32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %1 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.addf"(%arg5, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<1x61x1x1xf32>, tensor<48x61x1x1xf32>, tensor<1x48x1x1xf32>) -> tensor<1x48x1x1xf32>
    "func.return"(%0) : (tensor<1x48x1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x10xf32>) -> tensor<1x?xf32>, sym_name = "no_fold_empty_tensor_dim_out_of_bounds"}> ({
  ^bb0(%arg0: tensor<1x?x10xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 7 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<1x?x10xf32>, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<1x?xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<1x?xf32>) -> tensor<1x?xf32>
    "func.return"(%4) : (tensor<1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x10xf32>) -> tensor<1x?xf32>, sym_name = "fold_empty_tensor_dim_op"}> ({
  ^bb0(%arg0: tensor<1x?x10xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "index.constant"() <{value = 2 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<1x?x10xf32>, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<1x?xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<1x?xf32>) -> tensor<1x?xf32>
    "func.return"(%4) : (tensor<1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

