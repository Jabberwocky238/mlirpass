#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "memref_cast"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "memref.alloc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi8>
    %5 = "memref.view"(%4, %0) : (memref<?xi8>, index) -> memref<16x16xf32>
    %6 = "memref.cast"(%5) : (memref<16x16xf32>) -> memref<?x?xf32>
    "linalg.matmul"(%6, %6, %6) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %7 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg4, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"(%6) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<0xf32>, tensor<0xf32>) -> tensor<0xf32>, sym_name = "dce_zero_memref"}> ({
  ^bb0(%arg0: memref<0xf32>, %arg1: tensor<0xf32>):
    "memref.copy"(%arg0, %arg0) : (memref<0xf32>, memref<0xf32>) -> ()
    %0 = "linalg.generic"(%arg1) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg2: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<0xf32>) -> tensor<0xf32>
    "func.return"(%0) : (tensor<0xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "dce_self_linalg_copy"}> ({
  ^bb0(%arg0: memref<?xf32>):
    "linalg.copy"(%arg0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x4xf32>, tensor<4x?xf32>, tensor<3x?xf32>) -> tensor<3x?xf32>, sym_name = "tensor.cast"}> ({
  ^bb0(%arg0: tensor<3x4xf32>, %arg1: tensor<4x?xf32>, %arg2: tensor<3x?xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<3x4xf32>) -> tensor<?x?xf32>
    %1 = "tensor.cast"(%arg1) : (tensor<4x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.cast"(%arg2) : (tensor<3x?xf32>) -> tensor<?x?xf32>
    %3 = "linalg.matmul"(%0, %1, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %5 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg5, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %4 = "tensor.cast"(%3) : (tensor<?x?xf32>) -> tensor<3x?xf32>
    "func.return"(%4) : (tensor<3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<*xf32>, tensor<*xf32>) -> tensor<*xf32>, sym_name = "tensor.cast.unranked"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<*xf32>, %arg2: tensor<*xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<*xf32>) -> tensor<?x?xf32>
    %1 = "tensor.cast"(%arg1) : (tensor<*xf32>) -> tensor<?x?xf32>
    %2 = "tensor.cast"(%arg2) : (tensor<*xf32>) -> tensor<?x?xf32>
    %3 = "linalg.matmul"(%0, %1, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %5 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg5, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %4 = "tensor.cast"(%3) : (tensor<?x?xf32>) -> tensor<*xf32>
    "func.return"(%4) : (tensor<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "linalg_effects"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: memref<?x?xf32>, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "linalg.matmul"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
      %3 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.addf"(%arg11, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "linalg.matmul"(%arg3, %arg4, %arg5) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %1 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.addf"(%arg8, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>), sym_name = "remove_no_op"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<?x?x?xf32>, index) -> index
    %5 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.empty"(%3, %4, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7:2 = "linalg.generic"(%arg0, %arg1, %6, %6) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg3, %arg2) : (f32, f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    "func.return"(%7#0, %7#1) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<1x2x3xf32>, sym_name = "remove_no_op_mismatched_types"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "tensor.empty"() : () -> tensor<1x2x3xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<1x2x3xf32>) -> tensor<1x2x3xf32>
    "func.return"(%1) : (tensor<1x2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<f32>, sym_name = "cant_fold_to_tensor_cast"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.empty"() : () -> tensor<f32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "keep_not_noop"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %5 = "tensor.empty"(%3, %4) : (index, index) -> tensor<?x?xf32>
    "cf.br"(%2)[^bb1] : (f32) -> ()
  ^bb1(%6: f32):  // pred: ^bb0
    %7 = "linalg.generic"(%arg0, %5) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%7) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "keep_not_noop"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %5 = "tensor.empty"(%3, %4) : (index, index) -> tensor<?x?xf32>
    "cf.br"(%2)[^bb1] : (f32) -> ()
  ^bb1(%6: f32):  // pred: ^bb0
    %7:2 = "linalg.generic"(%arg0, %arg1, %5, %5) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%6, %arg3) : (f32, f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>)
    "func.return"(%7#0, %7#1) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x7xi32>, tensor<7x7xf32>, tensor<?x?xf32>, index) -> (), sym_name = "dead_linalg_tensor"}> ({
  ^bb0(%arg0: tensor<7x7xi32>, %arg1: tensor<7x7xf32>, %arg2: tensor<?x?xf32>, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: i32, %arg11: i32):
      "linalg.yield"(%arg10) : (i32) -> ()
    }) : (i32, tensor<7x7xi32>) -> tensor<7x7xi32>
    %4 = "linalg.matmul"(%arg1, %arg1, %arg1) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
      %7 = "arith.mulf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg9, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<7x7xf32>, tensor<7x7xf32>, tensor<7x7xf32>) -> tensor<7x7xf32>
    %5 = "linalg.generic"(%arg0) <{indexing_maps = [#map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg6: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (tensor<7x7xi32>) -> tensor<7x7xi32>
    %6 = "tensor.pad"(%arg2, %1, %1, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: index):
      "tensor.yield"(%2) : (f32) -> ()
    }) : (tensor<?x?xf32>, index, index, index, index) -> tensor<2x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, f32, index, index) -> tensor<?x?xf32>, sym_name = "propagate_casts"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: f32, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 21 : index}> : () -> index
    %3 = "arith.constant"() <{value = 42 : index}> : () -> index
    %4 = "tensor.empty"(%2, %3) : (index, index) -> tensor<?x?xf32>
    %5 = "linalg.fill"(%arg1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %6 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %7 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %8 = "tensor.insert_slice"(%arg0, %5, %arg2, %arg3, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index, index, index) -> tensor<?x?xf32>
    "func.return"(%8) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3x?x4xf32>) -> (), sym_name = "self_copy"}> ({
  ^bb0(%arg0: memref<2x3x?x4xf32>):
    "memref.copy"(%arg0, %arg0) : (memref<2x3x?x4xf32>, memref<2x3x?x4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x16xi32>, tensor<1x16xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>, sym_name = "fold_linalg_index_tensor_static"}> ({
  ^bb0(%arg0: tensor<4x16xi32>, %arg1: tensor<1x16xi32>, %arg2: tensor<4x1xi32>):
    %0 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %1 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %2 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %3 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %4 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i32
      "linalg.yield"(%6) : (i32) -> ()
    }) : (tensor<4x16xi32>, tensor<1x16xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    "func.return"(%0) : (tensor<4x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xi32>, tensor<?x1xi32>) -> tensor<?x1xi32>, sym_name = "fold_linalg_index_tensor_dynamic"}> ({
  ^bb0(%arg0: tensor<?x1xi32>, %arg1: tensor<?x1xi32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: i32):
      %1 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %2 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %3 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.index_cast"(%3) : (index) -> i32
      "linalg.yield"(%4) : (i32) -> ()
    }) : (tensor<?x1xi32>, tensor<?x1xi32>) -> tensor<?x1xi32>
    "func.return"(%0) : (tensor<?x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x?xi32>, memref<1x?xi32>) -> (), sym_name = "fold_linalg_index_memref"}> ({
  ^bb0(%arg0: memref<1x?xi32>, %arg1: memref<1x?xi32>):
    "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: i32):
      %0 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %1 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %2 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.index_cast"(%2) : (index) -> i32
      "linalg.yield"(%3) : (i32) -> ()
    }) : (memref<1x?xi32>, memref<1x?xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<6x4xf32>, sym_name = "fold_fill_reshape"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<1x2x3x4xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<1x2x3x4xf32>) -> tensor<1x2x3x4xf32>
    %3 = "tensor.collapse_shape"(%2) <{reassociation = [[0, 1, 2], [3]]}> : (tensor<1x2x3x4xf32>) -> tensor<6x4xf32>
    "func.return"(%3) : (tensor<6x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?x?xf32>) -> tensor<?x?xf32>, sym_name = "fold_fill_reshape_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<?x?x?x?x?xf32>) -> tensor<?x?x?x?x?xf32>
    %2 = "tensor.collapse_shape"(%1) <{reassociation = [[0, 1, 2], [3, 4]]}> : (tensor<?x?x?x?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "fold_fill_extract"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<1x2x3x?xi1>
    %3 = "linalg.fill"(%arg0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i1, %arg2: i1):
      "linalg.yield"(%arg1) : (i1) -> ()
    }) : (i1, tensor<1x2x3x?xi1>) -> tensor<1x2x3x?xi1>
    %4 = "tensor.extract"(%3, %0, %0, %0, %0) : (tensor<1x2x3x?xi1>, index, index, index, index) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<24x32x16x16xf32>, sym_name = "fill_pack"}> ({
    %0 = "tensor.empty"() : () -> tensor<384x512xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<24x32x16x16xf32>
    %3 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<384x512xf32>) -> tensor<384x512xf32>
    %4 = "linalg.pack"(%3, %2) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_inner_tiles = array<i64: 16, 16>}> : (tensor<384x512xf32>, tensor<24x32x16x16xf32>) -> tensor<24x32x16x16xf32>
    "func.return"(%4) : (tensor<24x32x16x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x1x8x4x4x8xi32>, sym_name = "fill_pack_general"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1x8x4x4x8xi32>
    %2 = "tensor.empty"() : () -> tensor<1x1x16x64xi32>
    %3 = "tensor.extract_slice"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0, 0>, static_sizes = array<i64: 1, 1, 16, 64>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x1x16x64xi32>) -> tensor<1x1x16x64xi32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      "linalg.yield"(%arg0) : (i32) -> ()
    }) : (i32, tensor<1x1x16x64xi32>) -> tensor<1x1x16x64xi32>
    %5 = "bufferization.to_tensor"(%1) <{restrict, writable}> : (memref<1x1x8x4x4x8xi32>) -> tensor<1x1x8x4x4x8xi32>
    %6 = "linalg.pack"(%4, %5) <{inner_dims_pos = array<i64: 2, 3>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, outer_dims_perm = array<i64: 0, 1, 3, 2>, static_inner_tiles = array<i64: 4, 8>}> : (tensor<1x1x16x64xi32>, tensor<1x1x8x4x4x8xi32>) -> tensor<1x1x8x4x4x8xi32>
    "func.return"(%6) : (tensor<1x1x8x4x4x8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 ceildiv 16)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?x16x16xf32>, sym_name = "dynamic_fill_pack"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %4 = "tensor.dim"(%3, %1) : (tensor<?x?xf32>, index) -> index
    %5 = "tensor.dim"(%3, %2) : (tensor<?x?xf32>, index) -> index
    %6 = "affine.apply"(%4) <{map = #map}> : (index) -> index
    %7 = "affine.apply"(%5) <{map = #map}> : (index) -> index
    %8 = "tensor.empty"(%6, %7) : (index, index) -> tensor<?x?x16x16xf32>
    %9 = "linalg.pack"(%3, %8, %0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_inner_tiles = array<i64: 16, 16>}> : (tensor<?x?xf32>, tensor<?x?x16x16xf32>, f32) -> tensor<?x?x16x16xf32>
    "func.return"(%9) : (tensor<?x?x16x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x16xf32>) -> (), sym_name = "fold_self_copy"}> ({
  ^bb0(%arg0: memref<4x16xf32>):
    "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<4x16xf32>, memref<4x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x16xf32>, f32) -> (), sym_name = "no_fold_fill_like_memref"}> ({
  ^bb0(%arg0: memref<4x16xf32>, %arg1: f32):
    "linalg.generic"(%arg0, %arg0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<4x16xf32>, memref<4x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x16xf32>, f32) -> tensor<4x16xf32>, sym_name = "no_fold_fill_like_tensor"}> ({
  ^bb0(%arg4: tensor<4x16xf32>, %arg5: f32):
    %4 = "linalg.generic"(%arg4, %arg4) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<4x16xf32>, tensor<4x16xf32>) -> tensor<4x16xf32>
    "func.return"(%4) : (tensor<4x16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<412x276xf32>, sym_name = "fold_static_pad_fill"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<400x273xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<400x273xf32>) -> tensor<400x273xf32>
    %3 = "tensor.pad"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 8, 2>, static_low = array<i64: 4, 1>}> ({
    ^bb0(%arg0: index, %arg1: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<400x273xf32>) -> tensor<412x276xf32>
    "func.return"(%3) : (tensor<412x276xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x?x16x32xf32>, index, index, index, index) -> tensor<?x?x?x?xf32>, sym_name = "fold_dynamic_pad_fill"}> ({
  ^bb0(%arg0: tensor<8x?x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<8x?x16x32xf32>) -> tensor<8x?x16x32xf32>
    %2 = "tensor.pad"(%1, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 2>, static_high = array<i64: 1, 2, -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, 8, 7, -9223372036854775808>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index, %arg8: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<8x?x16x32xf32>, index, index, index, index) -> tensor<?x?x?x?xf32>
    "func.return"(%2) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<412x276xf32>, sym_name = "no_fold_pad_fill_value_mismatch"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<400x273xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<400x273xf32>) -> tensor<400x273xf32>
    %4 = "tensor.pad"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 8, 2>, static_low = array<i64: 4, 1>}> ({
    ^bb0(%arg0: index, %arg1: index):
      "tensor.yield"(%1) : (f32) -> ()
    }) : (tensor<400x273xf32>) -> tensor<412x276xf32>
    "func.return"(%4) : (tensor<412x276xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>, tensor<?x?x?xf32>) -> tensor<2x3x4xf32>, sym_name = "static_input_without_cast"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>, %arg1: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<2x3x4xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<2x3x4xf32>, index) -> index
    %5 = "tensor.dim"(%arg0, %2) : (tensor<2x3x4xf32>, index) -> index
    %6 = "tensor.empty"(%3, %4, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "linalg.generic"(%arg0, %arg1, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %9 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<2x3x4xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %8 = "tensor.cast"(%7) : (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>
    "func.return"(%8) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>, tensor<?x?x?xf32>) -> tensor<2x3x4xf32>, sym_name = "static_input_with_cast"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>, %arg1: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<2x3x4xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<2x3x4xf32>, index) -> index
    %5 = "tensor.dim"(%arg0, %2) : (tensor<2x3x4xf32>, index) -> index
    %6 = "tensor.empty"(%3, %4, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "tensor.cast"(%arg1) : (tensor<?x?x?xf32>) -> tensor<2x?x?xf32>
    %8 = "linalg.generic"(%arg0, %7, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %10 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<2x3x4xf32>, tensor<2x?x?xf32>, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %9 = "tensor.cast"(%8) : (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>
    "func.return"(%9) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>, sym_name = "static_output_with_cast"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<2x3x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg2, %0) : (tensor<2x3x4xf32>, index) -> index
    %4 = "tensor.dim"(%arg2, %1) : (tensor<2x3x4xf32>, index) -> index
    %5 = "tensor.dim"(%arg2, %2) : (tensor<2x3x4xf32>, index) -> index
    %6 = "tensor.empty"(%3, %4, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "tensor.cast"(%6) : (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>
    %8 = "tensor.cast"(%arg1) : (tensor<?x?x?xf32>) -> tensor<2x?x?xf32>
    %9 = "linalg.generic"(%arg0, %8, %7) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %10 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<2x?x?xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>
    "func.return"(%9) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>, sym_name = "cast_source"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>, %arg1: tensor<2x3x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<2x3x4xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<2x3x4xf32>, index) -> index
    %5 = "tensor.dim"(%arg0, %2) : (tensor<2x3x4xf32>, index) -> index
    %6 = "tensor.empty"(%3, %4, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "tensor.cast"(%arg0) : (tensor<2x3x4xf32>) -> tensor<2x?x?xf32>
    %8 = "tensor.cast"(%arg1) : (tensor<2x3x4xf32>) -> tensor<2x?x?xf32>
    %9 = "linalg.generic"(%7, %8, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %11 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<2x?x?xf32>, tensor<2x?x?xf32>, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %10 = "tensor.cast"(%9) : (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>
    "func.return"(%10) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<1x?x?xf32>, index, index, index) -> tensor<?x?x?xf32>, sym_name = "cast_dest"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<1x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "tensor.empty"(%arg2, %arg3, %arg4) : (index, index, index) -> tensor<?x?x?xf32>
    %1 = "tensor.cast"(%arg1) : (tensor<1x?x?xf32>) -> tensor<?x?x?xf32>
    %2 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
      %3 = "arith.subf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<1x?x?xf32>, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    "func.return"(%2) : (tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32, #sparse>, tensor<?x?xf32>) -> tensor<3x4xf32>, sym_name = "static_shape_inference_with_encoding"}> ({
  ^bb0(%arg0: tensor<?x?xf32, #sparse>, %arg1: tensor<?x?xf32>):
    %0 = "tensor.empty"() : () -> tensor<3x4xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<?x?xf32, #sparse>, tensor<?x?xf32>, tensor<3x4xf32>) -> tensor<3x4xf32>
    "func.return"(%1) : (tensor<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, index, index) -> tensor<8x384x384xf32>, sym_name = "insert_pad_into_fill"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.pad"(%arg0, %arg1, %arg2, %1, %1, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 3, 3>, static_high = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_low = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg7: index, %arg8: index, %arg9: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<?x?x?xf32>, index, index, index, index, index, index) -> tensor<8x128x128xf32>
    %3 = "tensor.empty"() : () -> tensor<8x384x384xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %5 = "tensor.insert_slice"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 1, 2>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    "func.return"(%5) : (tensor<8x384x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x123x124xf32>, tensor<8x128x128xf32>, index) -> tensor<8x384x384xf32>, sym_name = "multi_insert_pad_into_fill"}> ({
  ^bb0(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 3, 4>, static_low = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<7x123x124xf32>) -> tensor<8x128x128xf32>
    %3 = "tensor.empty"() : () -> tensor<8x384x384xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %5 = "tensor.insert_slice"(%arg1, %4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %6 = "tensor.insert_slice"(%arg1, %5, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 0, 128, -9223372036854775808>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %7 = "tensor.insert_slice"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 256>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    "func.return"(%7) : (tensor<8x384x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x123x124xf32>, tensor<8x128x128xf32>, index) -> tensor<8x384x384xf32>, sym_name = "multi_insert_pad_into_fill_overlap"}> ({
  ^bb0(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 3, 4>, static_low = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<7x123x124xf32>) -> tensor<8x128x128xf32>
    %3 = "tensor.empty"() : () -> tensor<8x384x384xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %5 = "tensor.insert_slice"(%arg1, %4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %6 = "tensor.insert_slice"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 129>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %7 = "tensor.insert_slice"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 256>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    "func.return"(%7) : (tensor<8x384x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x123x124xf32>, tensor<8x128x128xf32>, index) -> tensor<8x384x384xf32>, sym_name = "multi_insert_pad_into_fill_overlap"}> ({
  ^bb0(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 3, 4>, static_low = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<7x123x124xf32>) -> tensor<8x128x128xf32>
    %3 = "tensor.empty"() : () -> tensor<8x384x384xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %5 = "tensor.insert_slice"(%arg1, %4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %6 = "tensor.insert_slice"(%arg1, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 128, 255>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %7 = "tensor.insert_slice"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 256>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    "func.return"(%7) : (tensor<8x384x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x123x124xf32>, tensor<8x128x128xf32>, index) -> tensor<8x384x384xf32>, sym_name = "multi_insert_pad_into_fill"}> ({
  ^bb0(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 3, 4>, static_low = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<7x123x124xf32>) -> tensor<8x128x128xf32>
    %3 = "tensor.empty"() : () -> tensor<8x384x384xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %5 = "tensor.insert_slice"(%arg1, %4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %6 = "tensor.insert_slice"(%arg1, %5, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 0, 1, -9223372036854775808>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %7 = "tensor.insert_slice"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 256, 256>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    "func.return"(%7) : (tensor<8x384x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<7x123x124xf32>, tensor<8x128x128xf32>, index) -> tensor<8x384x384xf32>, sym_name = "multi_insert_pad_into_fill_mismatch"}> ({
  ^bb0(%arg0: tensor<7x123x124xf32>, %arg1: tensor<8x128x128xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.pad"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0>, static_high = array<i64: 0, 3, 4>, static_low = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index):
      "tensor.yield"(%0) : (f32) -> ()
    }) : (tensor<7x123x124xf32>) -> tensor<8x128x128xf32>
    %4 = "tensor.empty"() : () -> tensor<8x384x384xf32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    %6 = "tensor.insert_slice"(%arg1, %5, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %7 = "tensor.insert_slice"(%arg1, %6, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: 0, 128, -9223372036854775808>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>, index) -> tensor<8x384x384xf32>
    %8 = "tensor.insert_slice"(%3, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 256>, static_sizes = array<i64: 8, 128, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<8x128x128xf32>, tensor<8x384x384xf32>) -> tensor<8x384x384xf32>
    "func.return"(%8) : (tensor<8x384x384xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<4x8xf32>, tensor<?x?xf32>), sym_name = "fold_linalgop_with_cast_consumer"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "linalg.matmul"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %2 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.addf"(%arg5, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %1 = "tensor.cast"(%0) : (tensor<?x?xf32>) -> tensor<4x8xf32>
    "func.return"(%1, %0) : (tensor<4x8xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8xf32>) -> (), sym_name = "some_use", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, i1) -> tensor<?x?xf32>, sym_name = "linalgop_with_cond_cast_consumer"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: i1):
    %0 = "linalg.matmul"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %2 = "arith.mulf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.addf"(%arg6, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "scf.if"(%arg3) ({
      %1 = "tensor.cast"(%0) : (tensor<?x?xf32>) -> tensor<4x8xf32>
      "func.call"(%1) <{callee = @some_use}> : (tensor<4x8xf32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d4, d2 + d5, d3 + d6)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d1, d4, d5, d6)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, tensor<?x?x?x?xf32>, tensor<?x?x?x?xf32>) -> (tensor<4x8x12x16xf32>, tensor<?x?x?x?xf32>), sym_name = "fold_conv_op_with_cast_consumer"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>, %arg1: tensor<?x?x?x?xf32>, %arg2: tensor<?x?x?x?xf32>):
    %0 = "linalg.conv_2d_nchw_fchw"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %2 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.addf"(%arg5, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map1, #map2]} : (tensor<?x?x?x?xf32>, tensor<?x?x?x?xf32>, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    %1 = "tensor.cast"(%0) : (tensor<?x?x?x?xf32>) -> tensor<4x8x12x16xf32>
    "func.return"(%1, %0) : (tensor<4x8x12x16xf32>, tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<2x3x4xf32>), sym_name = "fold_multi_use_generic_op_with_consumer"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<?x?x?xf32>, index) -> index
    %5 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.empty"(%4, %5, %3) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "tensor.empty"(%5, %4, %3) : (index, index, index) -> tensor<?x?x?xf32>
    %8:2 = "linalg.generic"(%arg0, %6, %7) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      "linalg.yield"(%arg1, %arg1) : (f32, f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    %9 = "tensor.cast"(%8#1) : (tensor<?x?x?xf32>) -> tensor<2x3x4xf32>
    "func.return"(%8#0, %9) : (tensor<?x?x?xf32>, tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "identity_buffer"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "erase_non_identity_noop"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<4xf32>) -> (), sym_name = "dedeplicate_regression_test"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>):
    %0 = "linalg.generic"(%arg1, %arg1, %arg0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg2: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<4xf32>) -> tensor<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x64x256xf32>) -> tensor<16x64x256xf32>, sym_name = "dead_softmax"}> ({
  ^bb0(%arg0: tensor<16x64x256xf32>):
    %0 = "tensor.empty"() : () -> tensor<16x64x256xf32>
    %1 = "linalg.softmax"(%arg0, %0) <{dimension = 1 : i64}> : (tensor<16x64x256xf32>, tensor<16x64x256xf32>) -> tensor<16x64x256xf32>
    "func.return"(%arg0) : (tensor<16x64x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "canonicalize_dim_of_dest_style_op"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %3 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.empty"(%2, %3) : (index, index) -> tensor<?x?xf32>
    %5 = "linalg.copy"(%arg0, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %6 = "tensor.dim"(%5, %0) : (tensor<?x?xf32>, index) -> index
    %7 = "tensor.dim"(%5, %1) : (tensor<?x?xf32>, index) -> index
    %8 = "tensor.empty"(%6, %7) : (index, index) -> tensor<?x?xf32>
    %9 = "linalg.copy"(%5, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%9) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "canonicalize_fill_to_copy_input"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "linalg.copy"(%1, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "canonicalize_fill_to_copy_dest"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "linalg.copy"(%arg1, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "canonicalize_fill_to_transpose_input"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "linalg.transpose"(%1, %arg1) <{permutation = array<i64: 1, 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, tensor<2x3xf32>) -> tensor<2x3xf32>, sym_name = "broadcast_same_shape"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: tensor<2x3xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<2x3xf32>, tensor<2x3xf32>) -> tensor<2x3xf32>
    "func.return"(%0) : (tensor<2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>, tensor<2x3xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>, sym_name = "broadcast_broadcast_fold"}> ({
  ^bb0(%arg0: tensor<2xf32>, %arg1: tensor<2x3xf32>, %arg2: tensor<2x3x4xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<2xf32>, tensor<2x3xf32>) -> tensor<2x3xf32>
    %1 = "linalg.broadcast"(%0, %arg2) <{dimensions = array<i64: 2>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<2x3xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>, tensor<2x4xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>, sym_name = "broadcast_broadcast_fold"}> ({
  ^bb0(%arg0: tensor<2xf32>, %arg1: tensor<2x4xf32>, %arg2: tensor<2x3x4xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<2xf32>, tensor<2x4xf32>) -> tensor<2x4xf32>
    %1 = "linalg.broadcast"(%0, %arg2) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<2x4xf32>, tensor<2x3x4xf32>) -> tensor<2x3x4xf32>
    "func.return"(%1) : (tensor<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>, sym_name = "transpose_1d"}> ({
  ^bb0(%arg0: tensor<16xf32>, %arg1: tensor<16xf32>):
    %0 = "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
    "func.return"(%0) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x32x64xf32>, tensor<16x32x64xf32>) -> tensor<16x32x64xf32>, sym_name = "transpose_identity_perm"}> ({
  ^bb0(%arg0: tensor<16x32x64xf32>, %arg1: tensor<16x32x64xf32>):
    %0 = "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 0, 1, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<16x32x64xf32>, tensor<16x32x64xf32>) -> tensor<16x32x64xf32>
    "func.return"(%0) : (tensor<16x32x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4x3xf32>, tensor<4x3x5xf32>, tensor<5x4x3xf32>) -> tensor<5x4x3xf32>, sym_name = "transpose_transpose_cancel"}> ({
  ^bb0(%arg0: tensor<5x4x3xf32>, %arg1: tensor<4x3x5xf32>, %arg2: tensor<5x4x3xf32>):
    %0 = "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<5x4x3xf32>, tensor<4x3x5xf32>) -> tensor<4x3x5xf32>
    %1 = "linalg.transpose"(%0, %arg2) <{permutation = array<i64: 2, 0, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<4x3x5xf32>, tensor<5x4x3xf32>) -> tensor<5x4x3xf32>
    "func.return"(%1) : (tensor<5x4x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4x3xf32>, tensor<4x3x5xf32>, tensor<3x4x5xf32>) -> tensor<3x4x5xf32>, sym_name = "transpose_transpose_fold"}> ({
  ^bb0(%arg0: tensor<5x4x3xf32>, %arg1: tensor<4x3x5xf32>, %arg2: tensor<3x4x5xf32>):
    %0 = "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<5x4x3xf32>, tensor<4x3x5xf32>) -> tensor<4x3x5xf32>
    %1 = "linalg.transpose"(%0, %arg2) <{permutation = array<i64: 1, 0, 2>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<4x3x5xf32>, tensor<3x4x5xf32>) -> tensor<3x4x5xf32>
    "func.return"(%1) : (tensor<3x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x4x5xf32>, tensor<1x2x3x4x5x6xf32>, tensor<1x6x2x3x5x4xf32>) -> tensor<1x6x2x3x5x4xf32>, sym_name = "broadcast_transpose_fold"}> ({
  ^bb0(%arg0: tensor<2x4x5xf32>, %arg1: tensor<1x2x3x4x5x6xf32>, %arg2: tensor<1x6x2x3x5x4xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 0, 2, 5>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<2x4x5xf32>, tensor<1x2x3x4x5x6xf32>) -> tensor<1x2x3x4x5x6xf32>
    %1 = "linalg.transpose"(%0, %arg2) <{permutation = array<i64: 0, 5, 1, 2, 4, 3>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<1x2x3x4x5x6xf32>, tensor<1x6x2x3x5x4xf32>) -> tensor<1x6x2x3x5x4xf32>
    "func.return"(%1) : (tensor<1x6x2x3x5x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x5xf32>, tensor<1x?x3x?x5x6xf32>, tensor<1x3x?x6x5x?xf32>) -> tensor<1x3x?x6x5x?xf32>, sym_name = "broadcast_transpose_fold_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x5xf32>, %arg1: tensor<1x?x3x?x5x6xf32>, %arg2: tensor<1x3x?x6x5x?xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 0, 2, 5>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<?x?x5xf32>, tensor<1x?x3x?x5x6xf32>) -> tensor<1x?x3x?x5x6xf32>
    %1 = "linalg.transpose"(%0, %arg2) <{permutation = array<i64: 0, 2, 3, 5, 4, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<1x?x3x?x5x6xf32>, tensor<1x3x?x6x5x?xf32>) -> tensor<1x3x?x6x5x?xf32>
    "func.return"(%1) : (tensor<1x3x?x6x5x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>, tensor<2x4xf32>, tensor<4x2xf32>) -> tensor<4x2xf32>, sym_name = "broadcast_transpose_fold_2dim"}> ({
  ^bb0(%arg0: tensor<2xf32>, %arg1: tensor<2x4xf32>, %arg2: tensor<4x2xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (tensor<2xf32>, tensor<2x4xf32>) -> tensor<2x4xf32>
    %1 = "linalg.transpose"(%0, %arg2) <{permutation = array<i64: 1, 0>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (tensor<2x4xf32>, tensor<4x2xf32>) -> tensor<4x2xf32>
    "func.return"(%1) : (tensor<4x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> tensor<5x?x?xf32>, sym_name = "concats_of_fill"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"(%arg0, %arg1) : (index, index) -> tensor<5x?x?xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<5x?x?xf32>) -> tensor<5x?x?xf32>
    %4 = "tensor.empty"(%arg2, %arg3) : (index, index) -> tensor<5x?x?xf32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<5x?x?xf32>) -> tensor<5x?x?xf32>
    %6 = "tensor.concat"(%3, %5) <{dim = 1 : i64}> : (tensor<5x?x?xf32>, tensor<5x?x?xf32>) -> tensor<5x?x?xf32>
    "func.return"(%6) : (tensor<5x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "transpose_buffer"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> (), sym_name = "recursive_effect"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "linalg.map"(%arg0, %0) ({
    ^bb0(%arg1: f32, %arg2: f32):
      "vector.print"(%arg1) <{punctuation = #vector.punctuation<newline>}> : (f32) -> ()
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32>, sym_name = "fold_pack_constant_splat"}> ({
  ^bb0(%arg0: tensor<4x8x8x32xf32>):
    %0 = "arith.constant"() <{value = dense<1.000000e-01> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %1 = "linalg.pack"(%0, %arg0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 8, 32>}> : (tensor<64x128xf32>, tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32>
    "func.return"(%1) : (tensor<4x8x8x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32>, sym_name = "fold_padding_value_pack_constant_splat"}> ({
  ^bb0(%arg0: tensor<4x8x8x32xf32>):
    %0 = "arith.constant"() <{value = 1.000000e-01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<1.000000e-01> : tensor<63x127xf32>}> : () -> tensor<63x127xf32>
    %2 = "linalg.pack"(%1, %arg0, %0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 8, 32>}> : (tensor<63x127xf32>, tensor<4x8x8x32xf32>, f32) -> tensor<4x8x8x32xf32>
    "func.return"(%2) : (tensor<4x8x8x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x8x8x32xf32>) -> tensor<4x8x8x32xf32>, sym_name = "nofold_padding_value_pack_constant_splat"}> ({
  ^bb0(%arg0: tensor<4x8x8x32xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<1.000000e-01> : tensor<63x127xf32>}> : () -> tensor<63x127xf32>
    %2 = "linalg.pack"(%1, %arg0, %0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 8, 32>}> : (tensor<63x127xf32>, tensor<4x8x8x32xf32>, f32) -> tensor<4x8x8x32xf32>
    "func.return"(%2) : (tensor<4x8x8x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1200x500000xf32>) -> tensor<31250x1200x16x1xf32>, sym_name = "fold_padding_value_pack"}> ({
  ^bb0(%arg0: tensor<1200x500000xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<31250x1200x16x1xf32>
    %2 = "linalg.pack"(%arg0, %1, %0) <{inner_dims_pos = array<i64: 1, 0>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 16, 1>}> : (tensor<1200x500000xf32>, tensor<31250x1200x16x1xf32>, f32) -> tensor<31250x1200x16x1xf32>
    "func.return"(%2) : (tensor<31250x1200x16x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, tensor<10x20x30x40x16xf32>) -> tensor<10x20x30x40x16xf32>, sym_name = "infer_src_shape_pack"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>, %arg1: tensor<10x20x30x40x16xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.pack"(%arg0, %arg1, %0) <{inner_dims_pos = array<i64: 2>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 2, 1, 3, 0>, static_inner_tiles = array<i64: 16>}> : (tensor<?x?x?x?xf32>, tensor<10x20x30x40x16xf32>, f32) -> tensor<10x20x30x40x16xf32>
    "func.return"(%1) : (tensor<10x20x30x40x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<30x20x?x10xf32>, tensor<?x?x?x?x16xf32>) -> tensor<?x?x?x?x16xf32>, sym_name = "infer_dest_shape_pack"}> ({
  ^bb0(%arg0: tensor<30x20x?x10xf32>, %arg1: tensor<?x?x?x?x16xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.pack"(%arg0, %arg1, %0) <{inner_dims_pos = array<i64: 2>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 2, 1, 3, 0>, static_inner_tiles = array<i64: 16>}> : (tensor<30x20x?x10xf32>, tensor<?x?x?x?x16xf32>, f32) -> tensor<?x?x?x?x16xf32>
    "func.return"(%1) : (tensor<?x?x?x?x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x32x100xf32>, index) -> tensor<32x7x?x16x1xf32>, sym_name = "no_infer_pack_shape"}> ({
  ^bb0(%arg0: tensor<?x32x100xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"(%arg1) : (index) -> tensor<32x7x?x16x1xf32>
    %2 = "linalg.pack"(%arg0, %1, %0) <{inner_dims_pos = array<i64: 2, 0>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 1, 2, 0>, static_inner_tiles = array<i64: 16, 1>}> : (tensor<?x32x100xf32>, tensor<32x7x?x16x1xf32>, f32) -> tensor<32x7x?x16x1xf32>
    "func.return"(%2) : (tensor<32x7x?x16x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1200x499999xf32>) -> tensor<31250x1200x16x1xf32>, sym_name = "fold_padding_value_pack_negative1"}> ({
  ^bb0(%arg0: tensor<1200x499999xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<31250x1200x16x1xf32>
    %2 = "linalg.pack"(%arg0, %1, %0) <{inner_dims_pos = array<i64: 1, 0>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 16, 1>}> : (tensor<1200x499999xf32>, tensor<31250x1200x16x1xf32>, f32) -> tensor<31250x1200x16x1xf32>
    "func.return"(%2) : (tensor<31250x1200x16x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1200x?xf32>, tensor<?x1200x16x1xf32>) -> tensor<?x1200x16x1xf32>, sym_name = "fold_padding_value_pack_negative2"}> ({
  ^bb0(%arg0: tensor<1200x?xf32>, %arg1: tensor<?x1200x16x1xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.pack"(%arg0, %arg1, %0) <{inner_dims_pos = array<i64: 1, 0>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 16, 1>}> : (tensor<1200x?xf32>, tensor<?x1200x16x1xf32>, f32) -> tensor<?x1200x16x1xf32>
    "func.return"(%1) : (tensor<?x1200x16x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1200x500000xf32>, tensor<?x1200x?x1xf32>, index) -> tensor<?x1200x?x1xf32>, sym_name = "fold_padding_value_pack_negative3"}> ({
  ^bb0(%arg0: tensor<1200x500000xf32>, %arg1: tensor<?x1200x?x1xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.pack"(%arg0, %arg1, %0, %arg2) <{inner_dims_pos = array<i64: 1, 0>, operandSegmentSizes = array<i32: 1, 1, 1, 1>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: -9223372036854775808, 1>}> : (tensor<1200x500000xf32>, tensor<?x1200x?x1xf32>, f32, index) -> tensor<?x1200x?x1xf32>
    "func.return"(%1) : (tensor<?x1200x?x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x256xf32>) -> tensor<128x256xf32>, sym_name = "fold_unpack_constant_splat"}> ({
  ^bb0(%arg0: tensor<128x256xf32>):
    %0 = "arith.constant"() <{value = dense<1.000000e-01> : tensor<16x8x8x32xf32>}> : () -> tensor<16x8x8x32xf32>
    %1 = "linalg.unpack"(%0, %arg0) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 8, 32>}> : (tensor<16x8x8x32xf32>, tensor<128x256xf32>) -> tensor<128x256xf32>
    "func.return"(%1) : (tensor<128x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x20x30x40x16xf32>, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>, sym_name = "infer_dest_shape_unpack"}> ({
  ^bb0(%arg0: tensor<10x20x30x40x16xf32>, %arg1: tensor<?x?x?x?xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 2>, outer_dims_perm = array<i64: 2, 1, 3, 0>, static_inner_tiles = array<i64: 16>}> : (tensor<10x20x30x40x16xf32>, tensor<?x?x?x?xf32>) -> tensor<?x?x?x?xf32>
    "func.return"(%0) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?x16xf32>, tensor<30x20x?x10xf32>) -> tensor<30x20x?x10xf32>, sym_name = "infer_src_shape_unpack"}> ({
  ^bb0(%arg0: tensor<?x?x?x?x16xf32>, %arg1: tensor<30x20x?x10xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 2>, outer_dims_perm = array<i64: 2, 1, 3, 0>, static_inner_tiles = array<i64: 16>}> : (tensor<?x?x?x?x16xf32>, tensor<30x20x?x10xf32>) -> tensor<30x20x?x10xf32>
    "func.return"(%0) : (tensor<30x20x?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<32x7x?x16x1xf32>, index) -> tensor<?x32x100xf32>, sym_name = "no_infer_unpack_shape"}> ({
  ^bb0(%arg0: tensor<32x7x?x16x1xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"(%arg1) : (index) -> tensor<?x32x100xf32>
    %2 = "linalg.unpack"(%arg0, %1) <{inner_dims_pos = array<i64: 2, 0>, outer_dims_perm = array<i64: 1, 2, 0>, static_inner_tiles = array<i64: 16, 1>}> : (tensor<32x7x?x16x1xf32>, tensor<?x32x100xf32>) -> tensor<?x32x100xf32>
    "func.return"(%2) : (tensor<?x32x100xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>) -> tensor<128x128xf32>, sym_name = "unpack_pack"}> ({
  ^bb0(%arg0: tensor<128x128xf32>):
    %0 = "tensor.empty"() : () -> tensor<16x16x8x8xf32>
    %1 = "linalg.pack"(%arg0, %0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<128x128xf32>, tensor<16x16x8x8xf32>) -> tensor<16x16x8x8xf32>
    %2 = "tensor.empty"() : () -> tensor<128x128xf32>
    %3 = "linalg.unpack"(%1, %2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<16x16x8x8xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%3) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>) -> tensor<128x128xf32>, sym_name = "unpack_pack"}> ({
  ^bb0(%arg0: tensor<128x128xf32>):
    %0 = "tensor.empty"() : () -> tensor<16x16x8x8xf32>
    %1 = "linalg.pack"(%arg0, %0) <{inner_dims_pos = array<i64: 1, 0>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<128x128xf32>, tensor<16x16x8x8xf32>) -> tensor<16x16x8x8xf32>
    %2 = "tensor.empty"() : () -> tensor<128x128xf32>
    %3 = "linalg.unpack"(%1, %2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<16x16x8x8xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%3) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>) -> tensor<128x128xf32>, sym_name = "unpack_pack"}> ({
  ^bb0(%arg0: tensor<128x128xf32>):
    %0 = "tensor.empty"() : () -> tensor<16x16x8x8xf32>
    %1 = "linalg.pack"(%arg0, %0) <{inner_dims_pos = array<i64: 1, 0>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, outer_dims_perm = array<i64: 1, 0>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<128x128xf32>, tensor<16x16x8x8xf32>) -> tensor<16x16x8x8xf32>
    %2 = "tensor.empty"() : () -> tensor<128x128xf32>
    %3 = "linalg.unpack"(%1, %2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<16x16x8x8xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    "func.return"(%3) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>, index, index) -> tensor<128x128xf32>, sym_name = "unpack_pack"}> ({
  ^bb0(%arg0: tensor<128x128xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<16x16x?x?xf32>
    %1 = "linalg.pack"(%arg0, %0, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x128xf32>, tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>
    %2 = "tensor.empty"() : () -> tensor<128x128xf32>
    %3 = "linalg.unpack"(%1, %2, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<16x16x?x?xf32>, tensor<128x128xf32>, index, index) -> tensor<128x128xf32>
    "func.return"(%3) : (tensor<128x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<256x512xbf16>) -> tensor<224x512xbf16>, sym_name = "unpack_pack_with_padding_no_canonicalization"}> ({
  ^bb0(%arg0: tensor<256x512xbf16>):
    %0 = "tensor.empty"() : () -> tensor<4x16x64x32xbf16>
    %1 = "tensor.empty"() : () -> tensor<224x512xbf16>
    %2 = "linalg.pack"(%arg0, %0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, outer_dims_perm = array<i64: 0, 1>, static_inner_tiles = array<i64: 64, 32>}> : (tensor<256x512xbf16>, tensor<4x16x64x32xbf16>) -> tensor<4x16x64x32xbf16>
    %3 = "linalg.unpack"(%2, %1) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 64, 32>}> : (tensor<4x16x64x32xbf16>, tensor<224x512xbf16>) -> tensor<224x512xbf16>
    "func.return"(%3) : (tensor<224x512xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>, sym_name = "pack_unpack"}> ({
  ^bb0(%arg0: tensor<16x16x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.empty"() : () -> tensor<128x128xf32>
    %1 = "linalg.unpack"(%arg0, %0, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<16x16x?x?xf32>, tensor<128x128xf32>, index, index) -> tensor<128x128xf32>
    %2 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<16x16x?x?xf32>
    %3 = "linalg.pack"(%1, %2, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x128xf32>, tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>
    "func.return"(%3) : (tensor<16x16x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16x8x8xf32>) -> tensor<16x16x8x8xf32>, sym_name = "pack_unpack"}> ({
  ^bb0(%arg0: tensor<16x16x8x8xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<128x128xf32>
    %2 = "linalg.unpack"(%arg0, %1) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<16x16x8x8xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
    %3 = "tensor.empty"() : () -> tensor<16x16x8x8xf32>
    %4 = "linalg.pack"(%2, %3, %0) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_inner_tiles = array<i64: 8, 8>}> : (tensor<128x128xf32>, tensor<16x16x8x8xf32>, f32) -> tensor<16x16x8x8xf32>
    "func.return"(%4) : (tensor<16x16x8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, index, index, index, index, index, index, index, index) -> tensor<?x?x?x?xf32>, sym_name = "pack_unpack_same_tiles"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index):
    %0 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<?x?xf32>
    %1 = "linalg.unpack"(%arg0, %0, %arg7, %arg8) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "tensor.empty"(%arg3, %arg4, %arg5, %arg6) : (index, index, index, index) -> tensor<?x?x?x?xf32>
    %3 = "linalg.pack"(%1, %2, %arg7, %arg8) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?x?xf32>, index, index) -> tensor<?x?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, index, index, index, index, index, index, index, index) -> tensor<?x?x?x?xf32>, sym_name = "pack_unpack_different_tiles"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index):
    %0 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<?x?xf32>
    %1 = "linalg.unpack"(%arg0, %0, %arg7, %arg8) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "tensor.empty"(%arg3, %arg4, %arg5, %arg6) : (index, index, index, index) -> tensor<?x?x?x?xf32>
    %3 = "linalg.pack"(%1, %2, %arg8, %arg7) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?x?xf32>, index, index) -> tensor<?x?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, index, index, index, index, index, index, index, index, f32) -> tensor<?x?x?x?xf32>, sym_name = "pack_unpack_dynamic_with_padding"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: f32):
    %0 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<?x?xf32>
    %1 = "linalg.unpack"(%arg0, %0, %arg7, %arg8) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "tensor.empty"(%arg3, %arg4, %arg5, %arg6) : (index, index, index, index) -> tensor<?x?x?x?xf32>
    %3 = "linalg.pack"(%1, %2, %arg9, %arg7, %arg8) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?x?xf32>, f32, index, index) -> tensor<?x?x?x?xf32>
    "func.return"(%3) : (tensor<?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>, sym_name = "pack_outer_dims_unpack_no_outer_dims"}> ({
  ^bb0(%arg0: tensor<16x16x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.empty"() : () -> tensor<128x128xf32>
    %1 = "linalg.unpack"(%arg0, %0, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<16x16x?x?xf32>, tensor<128x128xf32>, index, index) -> tensor<128x128xf32>
    %2 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<16x16x?x?xf32>
    %3 = "linalg.pack"(%1, %2, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, outer_dims_perm = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x128xf32>, tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>
    "func.return"(%3) : (tensor<16x16x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>, sym_name = "pack_no_outer_dims_unpack_outer_dims"}> ({
  ^bb0(%arg0: tensor<16x16x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.empty"() : () -> tensor<128x128xf32>
    %1 = "linalg.unpack"(%arg0, %0, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, outer_dims_perm = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<16x16x?x?xf32>, tensor<128x128xf32>, index, index) -> tensor<128x128xf32>
    %2 = "tensor.empty"(%arg1, %arg2) : (index, index) -> tensor<16x16x?x?xf32>
    %3 = "linalg.pack"(%1, %2, %arg1, %arg2) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<128x128xf32>, tensor<16x16x?x?xf32>, index, index) -> tensor<16x16x?x?xf32>
    "func.return"(%3) : (tensor<16x16x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x8x1xi32>, tensor<7x?xi32>, i32) -> tensor<1x1x8x1xi32>, sym_name = "fold_cast_pack_dynamic_tile_size"}> ({
  ^bb0(%arg0: tensor<1x1x8x1xi32>, %arg1: tensor<7x?xi32>, %arg2: i32):
    %0 = "tensor.cast"(%arg0) : (tensor<1x1x8x1xi32>) -> tensor<1x1x?x1xi32>
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "linalg.pack"(%arg1, %0, %arg2, %1) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 1>, static_inner_tiles = array<i64: -9223372036854775808, 1>}> {test_attr} : (tensor<7x?xi32>, tensor<1x1x?x1xi32>, i32, index) -> tensor<1x1x?x1xi32>
    %3 = "tensor.cast"(%2) : (tensor<1x1x?x1xi32>) -> tensor<1x1x8x1xi32>
    "func.return"(%3) : (tensor<1x1x8x1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10x20x4x4xf32>) -> tensor<10x20x4x4xf32>, sym_name = "infer_and_fold_pack_unpack_same_tiles"}> ({
  ^bb0(%arg0: tensor<10x20x4x4xf32>):
    %0 = "arith.constant"() <{value = 40 : index}> : () -> index
    %1 = "arith.constant"() <{value = 80 : index}> : () -> index
    %2 = "tensor.empty"(%0, %1) : (index, index) -> tensor<?x?xf32>
    %3 = "linalg.unpack"(%arg0, %2) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 4, 4>}> : (tensor<10x20x4x4xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %4 = "tensor.cast"(%3) : (tensor<?x?xf32>) -> tensor<40x80xf32>
    %5 = "tensor.empty"() : () -> tensor<10x20x4x4xf32>
    %6 = "linalg.pack"(%4, %5) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_inner_tiles = array<i64: 4, 4>}> : (tensor<40x80xf32>, tensor<10x20x4x4xf32>) -> tensor<10x20x4x4xf32>
    "func.return"(%6) : (tensor<10x20x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf16>, tensor<128x?x100x16x1xf16>) -> tensor<128x?x100x16x1xf16>, sym_name = "pack_dont_drop_attributes"}> ({
  ^bb0(%arg0: tensor<?x?x?xf16>, %arg1: tensor<128x?x100x16x1xf16>):
    %0 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "linalg.pack"(%arg0, %arg1, %1) <{inner_dims_pos = array<i64: 1, 2>, operandSegmentSizes = array<i32: 1, 1, 1, 0>, outer_dims_perm = array<i64: 0, 1, 2>, static_inner_tiles = array<i64: 16, 1>}> {test_attr} : (tensor<?x?x?xf16>, tensor<128x?x100x16x1xf16>, f16) -> tensor<128x?x100x16x1xf16>
    "func.return"(%2) : (tensor<128x?x100x16x1xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x16x64xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "fold_dst_style_ops_into_unpack"}> ({
  ^bb0(%arg0: tensor<?x?x16x64xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "linalg.unpack"(%arg0, %1) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 16, 64>}> : (tensor<?x?x16x64xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x8x1xi32>, tensor<7x?xi32>) -> tensor<7x?xi32>, sym_name = "fold_cast_unpack_dynamic_tile_size"}> ({
  ^bb0(%arg0: tensor<1x1x8x1xi32>, %arg1: tensor<7x?xi32>):
    %0 = "tensor.cast"(%arg0) : (tensor<1x1x8x1xi32>) -> tensor<1x1x?x1xi32>
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "linalg.unpack"(%0, %arg1, %1) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, 1>}> {test_attr} : (tensor<1x1x?x1xi32>, tensor<7x?xi32>, index) -> tensor<7x?xi32>
    "func.return"(%2) : (tensor<7x?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x2x1x16x16xf32>, tensor<28x28x15xf32>) -> tensor<28x28x10xf32>, sym_name = "fold_extract_slice_into_unpack_slicing_trailing_dim"}> ({
  ^bb0(%arg0: tensor<28x2x1x16x16xf32>, %arg1: tensor<28x28x15xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 1, 2>, outer_dims_perm = array<i64: 0, 1, 2>, static_inner_tiles = array<i64: 16, 16>}> : (tensor<28x2x1x16x16xf32>, tensor<28x28x15xf32>) -> tensor<28x28x15xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 28, 28, 10>, static_strides = array<i64: 1, 1, 1>}> : (tensor<28x28x15xf32>) -> tensor<28x28x10xf32>
    "func.return"(%1) : (tensor<28x28x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x2x1x16x16xf32>, tensor<28x28x15xf32>) -> tensor<28x17x15xf32>, sym_name = "fold_extract_slice_into_unpack_slicing_dim_1"}> ({
  ^bb0(%arg0: tensor<28x2x1x16x16xf32>, %arg1: tensor<28x28x15xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 1, 2>, static_inner_tiles = array<i64: 16, 16>}> : (tensor<28x2x1x16x16xf32>, tensor<28x28x15xf32>) -> tensor<28x28x15xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 28, 17, 15>, static_strides = array<i64: 1, 1, 1>}> : (tensor<28x28x15xf32>) -> tensor<28x17x15xf32>
    "func.return"(%1) : (tensor<28x17x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x2x1x16x16xf32>, tensor<28x28x15xf32>) -> tensor<28x16x15xf32>, sym_name = "no_fold_extract_slice_into_unpack_artificial_padding"}> ({
  ^bb0(%arg0: tensor<28x2x1x16x16xf32>, %arg1: tensor<28x28x15xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 1, 2>, static_inner_tiles = array<i64: 16, 16>}> : (tensor<28x2x1x16x16xf32>, tensor<28x28x15xf32>) -> tensor<28x28x15xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 28, 16, 15>, static_strides = array<i64: 1, 1, 1>}> : (tensor<28x28x15xf32>) -> tensor<28x16x15xf32>
    "func.return"(%1) : (tensor<28x16x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x2x?x16x16xf32>, tensor<28x32x?xf32>, index) -> tensor<28x28x?xf32>, sym_name = "no_fold_extract_slice_into_unpack_dynamic"}> ({
  ^bb0(%arg0: tensor<28x2x?x16x16xf32>, %arg1: tensor<28x32x?xf32>, %arg2: index):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 1, 2>, outer_dims_perm = array<i64: 0, 1, 2>, static_inner_tiles = array<i64: 16, 16>}> : (tensor<28x2x?x16x16xf32>, tensor<28x32x?xf32>) -> tensor<28x32x?xf32>
    %1 = "tensor.extract_slice"(%0, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 28, 28, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<28x32x?xf32>, index) -> tensor<28x28x?xf32>
    "func.return"(%1) : (tensor<28x28x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x2x16xf32>, tensor<28x32xf32>) -> tensor<28xf32>, sym_name = "no_fold_extract_slice_into_unpack_rank_reducing"}> ({
  ^bb0(%arg0: tensor<28x2x16xf32>, %arg1: tensor<28x32xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 1>, outer_dims_perm = array<i64: 0, 1>, static_inner_tiles = array<i64: 16>}> : (tensor<28x2x16xf32>, tensor<28x32xf32>) -> tensor<28x32xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 28>, static_strides = array<i64: 1, 1>}> : (tensor<28x32xf32>) -> tensor<28xf32>
    "func.return"(%1) : (tensor<28xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<28x2x16xf32>, tensor<28x32xf32>) -> tensor<28x28xf32>, sym_name = "no_fold_extract_slice_into_unpack_non_zero_offset"}> ({
  ^bb0(%arg0: tensor<28x2x16xf32>, %arg1: tensor<28x32xf32>):
    %0 = "linalg.unpack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 1>, outer_dims_perm = array<i64: 0, 1>, static_inner_tiles = array<i64: 16>}> : (tensor<28x2x16xf32>, tensor<28x32xf32>) -> tensor<28x32xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 1>, static_sizes = array<i64: 28, 28>, static_strides = array<i64: 1, 1>}> : (tensor<28x32xf32>) -> tensor<28x28xf32>
    "func.return"(%1) : (tensor<28x28xf32>) -> ()
  }) : () -> ()
}) : () -> ()

