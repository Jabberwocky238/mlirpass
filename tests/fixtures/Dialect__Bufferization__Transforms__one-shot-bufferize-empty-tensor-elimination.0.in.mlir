#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "buffer_forwarding_conflict"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %4 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%3, %4) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "buffer_forwarding_no_conflict"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "insertion_point_inside_loop"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "tensor.empty"() : () -> tensor<5xf32>
    %4 = "scf.for"(%0, %arg1, %2, %arg0) ({
    ^bb0(%arg2: index, %arg3: tensor<?xf32>):
      %5 = "arith.index_cast"(%arg2) : (index) -> i32
      %6 = "arith.sitofp"(%5) : (i32) -> f32
      %7 = "linalg.fill"(%6, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %8 = "tensor.insert_slice"(%7, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%8) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> tensor<?xf32>, sym_name = "insertion_point_outside_loop"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "tensor.empty"() : () -> tensor<5xf32>
    %4 = "scf.for"(%0, %arg1, %2, %arg0) ({
    ^bb0(%arg3: index, %arg4: tensor<?xf32>):
      %5 = "arith.index_cast"(%arg3) : (index) -> i32
      %6 = "arith.sitofp"(%5) : (i32) -> f32
      %7 = "linalg.fill"(%6, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %8 = "tensor.insert_slice"(%7, %arg4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "scf.yield"(%8) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x6x128xf32>) -> tensor<5x6x128xf32>, sym_name = "shape_mismatch"}> ({
  ^bb0(%arg0: tensor<5x6x128xf32>):
    %0 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<128xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<128xf32>) -> tensor<128xf32>
    %3 = "tensor.expand_shape"(%2) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 1, 1, 128>}> : (tensor<128xf32>) -> tensor<1x1x128xf32>
    %4 = "tensor.insert_slice"(%3, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2, 3, 0>, static_sizes = array<i64: 1, 1, 128>, static_strides = array<i64: 1, 1, 1>}> : (tensor<1x1x128xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%4) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<256xf32>) -> tensor<256xf32>, sym_name = "cast"}> ({
  ^bb0(%arg0: tensor<256xf32>):
    %0 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %4 = "tensor.cast"(%3) : (tensor<?xf32>) -> tensor<128xf32>
    %5 = "tensor.insert_slice"(%4, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (tensor<128xf32>, tensor<256xf32>) -> tensor<256xf32>
    "func.return"(%5) : (tensor<256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "parallel_insert_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 512 : index}> : () -> index
    %2 = "scf.forall"(%1, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<?xf32>):
      %3 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
      %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg3, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map}, {}, {}], function_type = (tensor<?xf32>, index, i1) -> tensor<?xf32>, sym_name = "eleminate_multiple_ops"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "scf.if"(%arg2) ({
      %6 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
      %7 = "linalg.fill"(%0, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%7) : (tensor<?xf32>) -> ()
    }, {
      %4 = "tensor.empty"(%arg1) : (index) -> tensor<?xf32>
      %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg3: f32, %arg4: f32):
        "linalg.yield"(%arg3) : (f32) -> ()
      }) : (f32, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%5) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %3 = "tensor.insert_slice"(%2, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 42>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "regression_do_not_eliminate_non_empty"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: tensor<10xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<10xf32>) -> tensor<5xf32>
    %1 = "tensor.insert_slice"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%1) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>, sym_name = "regression_insert_of_bbarg"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<10xf32>):
    %0 = "tensor.insert_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 2>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>) -> tensor<10xf32>
    "func.return"(%0) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<?x16xi8>) -> tensor<?x16xi8>, sym_name = "regression_eliminate_equivalent_only"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<?x16xi8>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "tensor.empty"(%arg0) : (index) -> tensor<?x8xi32>
    %4 = "tensor.extract_slice"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi32>, index) -> tensor<?x8xi32>
    %5 = "scf.for"(%0, %2, %1, %arg2) ({
    ^bb0(%arg3: index, %arg4: tensor<?x16xi8>):
      %6 = "tensor.insert_slice"(%4, %3, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi32>, tensor<?x8xi32>, index) -> tensor<?x8xi32>
      %7 = "tensor.extract_slice"(%arg4, %arg1, %arg1, %arg0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x16xi8>, index, index, index) -> tensor<?x8xi8>
      %8 = "linalg.generic"(%6, %7) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: i32, %arg6: i8):
        %10 = "arith.trunci"(%arg5) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
        "linalg.yield"(%10) : (i8) -> ()
      }) : (tensor<?x8xi32>, tensor<?x8xi8>) -> tensor<?x8xi8>
      %9 = "tensor.insert_slice"(%8, %arg4, %arg1, %arg3, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 2, 1, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 8>, static_strides = array<i64: 1, 1>}> : (tensor<?x8xi8>, tensor<?x16xi8>, index, index, index) -> tensor<?x16xi8>
      "scf.yield"(%9) : (tensor<?x16xi8>) -> ()
    }) : (index, index, index, tensor<?x16xi8>) -> tensor<?x16xi8>
    "func.return"(%5) : (tensor<?x16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "regression_multiple_insertion_points"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "tensor.empty"() : () -> tensor<2x5xf32>
    %1 = "arith.constant"() <{value = 5.500000e+00 : f32}> : () -> f32
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> index
    %4 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<2x5xf32>) -> tensor<2x5xf32>
    %5 = "tensor.insert_slice"(%4, %arg0, %2, %3) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 5>, static_strides = array<i64: 1, 1>}> : (tensor<2x5xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%5) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, f32) -> tensor<5xf32>, sym_name = "materialize_in_destination"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "bufferization.materialize_in_destination"(%1, %arg0) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%2) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, f32) -> (), sym_name = "materialize_in_destination_buffer"}> ({
  ^bb0(%arg0: memref<5xf32>, %arg1: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    "bufferization.materialize_in_destination"(%1, %arg0) <{restrict, writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, f32) -> tensor<5xf32>, sym_name = "linalg_copy"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "linalg.copy"(%1, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%2) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<26xi32>, sym_name = "linalg_copy_empty"}> ({
    %0 = "tensor.empty"() : () -> tensor<26xi32>
    %1 = "linalg.copy"(%0, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      "linalg.yield"(%arg0) : (i32) -> ()
    }) : (tensor<26xi32>, tensor<26xi32>) -> tensor<26xi32>
    "func.return"(%1) : (tensor<26xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, f32, f32, i1) -> (), sym_name = "multiple_materialize_in_destination_buffer"}> ({
  ^bb0(%arg0: memref<5xf32>, %arg1: f32, %arg2: f32, %arg3: i1):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "tensor.empty"() : () -> tensor<5xf32>
    %3 = "linalg.fill"(%arg2, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %4 = "scf.if"(%arg3) ({
      "scf.yield"(%1) : (tensor<5xf32>) -> ()
    }, {
      "scf.yield"(%3) : (tensor<5xf32>) -> ()
    }) : (i1) -> tensor<5xf32>
    "bufferization.materialize_in_destination"(%4, %arg0) <{restrict, writable}> : (tensor<5xf32>, memref<5xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "eliminate_all_empty_tensors"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %4 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %6 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %7 = "tensor.insert_slice"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %8 = "tensor.insert_slice"(%5, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%8) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "eliminate_concatenated_empty_tensors"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %3 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %5 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %7 = "tensor.insert_slice"(%4, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %8 = "tensor.insert_slice"(%6, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%8) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5x6x128xf32>, sym_name = "multi_use_of_the_same_tensor_empty"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<5x6x128xf32>
    %3 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %5 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: f32):
      "linalg.yield"(%arg0) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %6 = "tensor.insert_slice"(%4, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    %7 = "tensor.insert_slice"(%5, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 64>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%7) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x6x128xf32>, tensor<5x6x64xf32>) -> (tensor<5x6x128xf32>, tensor<5x6x64xf32>), sym_name = "multi_use_of_the_same_tensor_empty_creates_non_existent_read"}> ({
  ^bb0(%arg0: tensor<5x6x128xf32>, %arg1: tensor<5x6x64xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %2 = "linalg.fill"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %3 = "linalg.generic"(%1, %arg1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %5 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<5x6x64xf32>, tensor<5x6x64xf32>) -> tensor<5x6x64xf32>
    %4 = "tensor.insert_slice"(%2, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%4, %3) : (tensor<5x6x128xf32>, tensor<5x6x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x6x128xf32>) -> tensor<5x6x128xf32>, sym_name = "direct_use_of_tensor_empty"}> ({
  ^bb0(%arg0: tensor<5x6x128xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x6x64xf32>
    %1 = "tensor.insert_slice"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 5, 6, 64>, static_strides = array<i64: 1, 1, 1>}> : (tensor<5x6x64xf32>, tensor<5x6x128xf32>) -> tensor<5x6x128xf32>
    "func.return"(%1) : (tensor<5x6x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}, {}], function_type = (tensor<10xf32>, index, f32) -> tensor<10xf32>, sym_name = "move_dependent_arith_op"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: index, %arg2: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "arith.addi"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %4 = "tensor.insert_slice"(%1, %arg0, %3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%4) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = true}, {}, {}], function_type = (tensor<10xf32>, memref<index>, f32) -> tensor<10xf32>, sym_name = "side_effecting_op_blocks_movement"}> ({
  ^bb0(%arg0: tensor<10xf32>, %arg1: memref<index>, %arg2: f32):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.fill"(%arg2, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %2 = "memref.load"(%arg1) : (memref<index>) -> index
    %3 = "tensor.insert_slice"(%1, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 5>, static_strides = array<i64: 1>}> : (tensor<5xf32>, tensor<10xf32>, index) -> tensor<10xf32>
    "func.return"(%3) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

