"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}], function_type = (tensor<?xf32>, tensor<?xf32>) -> (tensor<4xf32>, tensor<8xf32>), sym_name = "extract_slice_fun"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %1 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 8>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<8xf32>
    "func.return"(%0, %1) : (tensor<4xf32>, tensor<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "insert_slice_fun"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<4xf32>):
    %0 = "tensor.insert_slice"(%arg2, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %1 = "tensor.insert_slice"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0, %1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<4x4xf32>, tensor<4x4xf32>) -> (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>), sym_name = "conflict_on_B"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: tensor<4x4xf32>):
    %0 = "linalg.matmul"(%arg0, %arg1, %arg1) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):
      %7 = "arith.mulf"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %8 = "arith.addf"(%arg10, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%8) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    %1 = "linalg.matmul"(%arg1, %arg0, %arg1) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
      %5 = "arith.mulf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg7, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    %2 = "linalg.matmul"(%arg0, %arg0, %arg1) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %3 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.addf"(%arg4, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    "func.return"(%0, %1, %2) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<?xf32>) -> (tensor<2xf32>, tensor<2xf32>), sym_name = "extract_slice_extract_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %1 = "tensor.extract_slice"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<4xf32>) -> tensor<2xf32>
    %2 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %3 = "tensor.extract_slice"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<4xf32>) -> tensor<2xf32>
    "func.return"(%1, %3) : (tensor<2xf32>, tensor<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {bufferization.writable = true}, {bufferization.writable = false}, {bufferization.writable = false}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<4xf32>, tensor<2xf32>, tensor<?xf32>, tensor<4xf32>, tensor<2xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "insert_slice_insert_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<4xf32>, %arg2: tensor<2xf32>, %arg3: tensor<?xf32>, %arg4: tensor<4xf32>, %arg5: tensor<2xf32>):
    %0 = "tensor.insert_slice"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<2xf32>, tensor<4xf32>) -> tensor<4xf32>
    %1 = "tensor.insert_slice"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %2 = "tensor.insert_slice"(%arg5, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 2>, static_strides = array<i64: 1>}> : (tensor<2xf32>, tensor<4xf32>) -> tensor<4xf32>
    %3 = "tensor.insert_slice"(%2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = false}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, index) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "extract_slice_nonmatching_insert_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %1 = "tensor.insert_slice"(%0, %arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %3 = "tensor.insert_slice"(%2, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%1, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = false}], function_type = (tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "extract_slice_matching_insert_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %1 = "tensor.insert_slice"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    %2 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<?xf32>) -> tensor<4xf32>
    %3 = "tensor.insert_slice"(%2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}], function_type = (tensor<?xf32>, index, index) -> (tensor<?xf32>, vector<5xf32>), sym_name = "read_of_matching_insert_slice_source"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %4 = "tensor.insert_slice"(%3, %arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    %5 = "vector.transfer_read"(%3, %arg2, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%4, %5) : (tensor<?xf32>, vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index) -> (tensor<?xf32>, vector<5xf32>), sym_name = "read_of_matching_insert_slice_source_interleaved"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %4 = "tensor.insert_slice"(%3, %arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    %5 = "tensor.extract_slice"(%4, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
    %6 = "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %7 = "vector.transfer_read"(%3, %arg2, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<5xf32>
    %8 = "tensor.insert_slice"(%6, %4, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
    "func.return"(%8, %7) : (tensor<?xf32>, vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = false}, {bufferization.writable = true}], function_type = (tensor<?x?xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> (tensor<4x4xf32>, tensor<4x4xf32>), sym_name = "extract_slice_linalg_readonly_use"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<4x4xf32>, %arg2: tensor<4x4xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %1 = "linalg.matmul"(%0, %arg1, %arg1) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %5 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg8, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    %2 = "linalg.matmul"(%0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %3 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.addf"(%arg5, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    "func.return"(%1, %2) : (tensor<4x4xf32>, tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = false}, {bufferization.writable = true}], function_type = (tensor<4x4xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<4x4xf32>, tensor<4x4xf32>), sym_name = "extract_slice_to_linalg_write_use"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %1 = "linalg.matmul"(%arg1, %arg2, %0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %6 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg8, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    %2 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %3 = "linalg.matmul"(%arg0, %0, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %4 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg5, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    "func.return"(%1, %3) : (tensor<4x4xf32>, tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {}, {}, {bufferization.writable = false}, {bufferization.writable = false}, {bufferization.writable = true}], function_type = (index, index, index, index, tensor<8x6xf32>, tensor<6x6xf32>, tensor<30x20xf32>) -> tensor<30x20xf32>, sym_name = "insert_slice_double_extract_slice"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: tensor<8x6xf32>, %arg5: tensor<6x6xf32>, %arg6: tensor<30x20xf32>):
    %0 = "tensor.extract_slice"(%arg6, %arg2, %arg3, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<30x20xf32>, index, index, index, index) -> tensor<?x?xf32>
    %1 = "linalg.matmul"(%arg4, %arg5, %0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
      %4 = "arith.mulf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg9, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<8x6xf32>, tensor<6x6xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.extract_slice"(%1, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %3 = "tensor.insert_slice"(%2, %arg6, %arg2, %arg3, %arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<30x20xf32>, index, index, index, index) -> tensor<30x20xf32>
    "func.return"(%3) : (tensor<30x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = false}, {bufferization.writable = true}], function_type = (tensor<4x4xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<4x4xf32>, tensor<4x4xf32>), sym_name = "extract_slice_to_linalg_write_use"}> ({
  ^bb0(%arg0: tensor<4x4xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %1 = "linalg.matmul"(%arg1, %arg2, %0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %6 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg8, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    %2 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %3 = "linalg.matmul"(%arg0, %arg0, %2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %4 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg5, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<4x4xf32>, tensor<4x4xf32>, tensor<4x4xf32>) -> tensor<4x4xf32>
    "func.return"(%1, %3) : (tensor<4x4xf32>, tensor<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = true}, {bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>, index, index, index) -> (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "nested_extract_slice_and_insert"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "tensor.extract_slice"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<4x4xf32>) -> tensor<4x4xf32>
    %4 = "tensor.insert_slice"(%3, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<4x4xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %5 = "tensor.insert_slice"(%4, %arg0, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %6 = "tensor.extract_slice"(%arg1, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %7 = "tensor.extract_slice"(%6, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index) -> tensor<4x?xf32>
    %8 = "tensor.extract_slice"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<4x?xf32>) -> tensor<4x4xf32>
    %9 = "linalg.fill"(%0, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<4x4xf32>) -> tensor<4x4xf32>
    %10 = "tensor.insert_slice"(%9, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<4x4xf32>, tensor<4x?xf32>) -> tensor<4x?xf32>
    %11 = "tensor.insert_slice"(%10, %6, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<4x?xf32>, tensor<?x?xf32>, index) -> tensor<?x?xf32>
    %12 = "tensor.insert_slice"(%11, %arg1, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %13 = "tensor.extract_slice"(%arg2, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %14 = "tensor.extract_slice"(%13, %arg4) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index) -> tensor<?x4xf32>
    %15 = "linalg.fill"(%0, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?x4xf32>) -> tensor<?x4xf32>
    %16 = "tensor.insert_slice"(%15, %13, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x4xf32>, tensor<?x?xf32>, index) -> tensor<?x?xf32>
    %17 = "tensor.insert_slice"(%16, %arg2, %arg3, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%5, %12, %17) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64xf32>) -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<64xf32>) -> (), sym_name = "dependence_through_call"}> ({
  ^bb0(%arg0: tensor<64xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %3 = "linalg.fill"(%1, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    "func.call"(%2) <{callee = @foo}> : (tensor<64xf32>) -> ()
    "func.call"(%3) <{callee = @foo}> : (tensor<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64xf32>) -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<64xf32>) -> (), sym_name = "bar", sym_visibility = "private"}> ({
  ^bb0(%arg13: tensor<64xf32>):
    "func.call"(%arg13) <{callee = @foo}> : (tensor<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<64xf32>, tensor<64xf32>) -> (), sym_name = "read_dependence_through_scf_and_call"}> ({
  ^bb0(%arg0: tensor<64xf32>, %arg1: tensor<64xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %5 = "linalg.fill"(%3, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %6 = "linalg.fill"(%4, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      "linalg.yield"(%arg9) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %7:2 = "scf.for"(%0, %2, %1, %5, %6) ({
    ^bb0(%arg6: index, %arg7: tensor<64xf32>, %arg8: tensor<64xf32>):
      "scf.yield"(%arg7, %arg8) : (tensor<64xf32>, tensor<64xf32>) -> ()
    }) : (index, index, index, tensor<64xf32>, tensor<64xf32>) -> (tensor<64xf32>, tensor<64xf32>)
    "func.call"(%7#0) <{callee = @foo}> : (tensor<64xf32>) -> ()
    "func.call"(%7#1) <{callee = @foo}> : (tensor<64xf32>) -> ()
    %8 = "linalg.fill"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    %9 = "linalg.fill"(%4, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<64xf32>) -> tensor<64xf32>
    "func.call"(%8) <{callee = @bar}> : (tensor<64xf32>) -> ()
    "func.call"(%9) <{callee = @bar}> : (tensor<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xi32>, index, index, index) -> tensor<?xi32>, sym_name = "write_into_constant_via_alias"}> ({
  ^bb0(%arg0: vector<5xi32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = dense<[1, 2, 3, 4]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tensor.extract_slice"(%0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<4xi32>, index, index) -> tensor<?xi32>
    %2 = "vector.transfer_write"(%arg0, %1, %arg3) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xi32>, tensor<?xi32>, index) -> tensor<?xi32>
    "func.return"(%2) : (tensor<?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "matmul_on_tensors"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map, bufferization.writable = false}, {bufferization.buffer_layout = #map, bufferization.writable = false}, {bufferization.buffer_layout = #map, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "matmul_on_tensors"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<518x518xf32>, index, index, f32) -> vector<256x256xf32>
    %6 = "vector.transfer_write"(%5, %4, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<256x256xf32>, tensor<256x256xf32>, index, index) -> tensor<256x256xf32>
    %7 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %8 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<518x518xf32>, index, index, f32) -> vector<256x256xf32>
    %9 = "vector.transfer_write"(%8, %7, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<256x256xf32>, tensor<256x256xf32>, index, index) -> tensor<256x256xf32>
    %10 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %11 = "tensor.extract_slice"(%9) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %12 = "linalg.matmul"(%10, %11, %arg2) <{indexing_maps = [#map1, #map2, #map3], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %13 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %14 = "arith.addf"(%arg5, %13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%14) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%12) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {bufferization.buffer_layout = #map, bufferization.writable = false}, {bufferization.buffer_layout = #map, bufferization.writable = false}, {bufferization.buffer_layout = #map, bufferization.writable = true}], function_type = (vector<32x90xf32>, vector<30x90xf32>, tensor<62x126xf32>, tensor<126x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>, sym_name = "insert_slice_chain"}> ({
  ^bb0(%arg0: vector<32x90xf32>, %arg1: vector<30x90xf32>, %arg2: tensor<62x126xf32>, %arg3: tensor<126x90xf32>, %arg4: tensor<62x90xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %arg4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<62x90xf32>) -> tensor<62x90xf32>
    %3 = "tensor.extract_slice"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<32x90xf32>
    %4 = "vector.transfer_write"(%arg0, %3, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<32x90xf32>, tensor<32x90xf32>, index, index) -> tensor<32x90xf32>
    %5 = "tensor.insert_slice"(%4, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<32x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    %6 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<30x90xf32>
    %7 = "vector.transfer_write"(%arg1, %6, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<30x90xf32>, tensor<30x90xf32>, index, index) -> tensor<30x90xf32>
    %8 = "tensor.insert_slice"(%7, %5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<30x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    "func.return"(%8) : (tensor<62x90xf32>) -> ()
  }) {passthrough = [["prefer-vector-width", "512"]], target_cpu = "skylake-avx512"} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}], function_type = (tensor<10x20xf32>, index, index, vector<5x6xf32>) -> tensor<10x20xf32>, sym_name = "ip"}> ({
  ^bb0(%arg0: tensor<10x20xf32>, %arg1: index, %arg2: index, %arg3: vector<5x6xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = 257 : index}> : () -> index
    %3 = "scf.for"(%0, %2, %1, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<10x20xf32>):
      %4 = "tensor.extract_slice"(%arg5, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 5, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<10x20xf32>, index, index) -> tensor<5x?xf32>
      %5 = "tensor.extract_slice"(%4, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 5, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<5x?xf32>, index) -> tensor<5x?xf32>
      %6 = "vector.transfer_write"(%arg3, %5, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<5x6xf32>, tensor<5x?xf32>, index, index) -> tensor<5x?xf32>
      %7 = "tensor.insert_slice"(%6, %arg5, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 5, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<5x?xf32>, tensor<10x20xf32>, index, index) -> tensor<10x20xf32>
      "scf.yield"(%7) : (tensor<10x20xf32>) -> ()
    }) : (index, index, index, tensor<10x20xf32>) -> tensor<10x20xf32>
    "func.return"(%3) : (tensor<10x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "linalg_op_same_out_tensors"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0:2 = "linalg.generic"(%arg0, %arg1, %arg1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      "linalg.yield"(%arg2, %arg2) : (f32, f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%0#0, %0#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}], function_type = (tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>), sym_name = "linalg_op_same_out_tensors_2"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0:3 = "linalg.generic"(%arg0, %arg1, %arg1, %arg1) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 3>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32, %arg5: f32):
      "linalg.yield"(%arg2, %arg2, %arg2) : (f32, f32, f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>)
    "func.return"(%0#0, %0#1, %0#2) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {}, {bufferization.writable = true}, {}, {}, {}, {}], function_type = (vector<32x90xf32>, vector<30x90xf32>, tensor<62x90xf32>, index, index, index, index) -> (tensor<62x90xf32>, tensor<?x?xf32>), sym_name = "double_insert_slice_into_alias"}> ({
  ^bb0(%arg0: vector<32x90xf32>, %arg1: vector<30x90xf32>, %arg2: tensor<62x90xf32>, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg2, %arg3, %arg4, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>, index, index, index, index) -> tensor<?x?xf32>
    %2 = "tensor.extract_slice"(%arg2) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<32x90xf32>
    %3 = "vector.transfer_write"(%arg0, %2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<32x90xf32>, tensor<32x90xf32>, index, index) -> tensor<32x90xf32>
    %4 = "tensor.insert_slice"(%3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<32x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    %5 = "tensor.extract_slice"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<30x90xf32>
    %6 = "vector.transfer_write"(%arg1, %5, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<30x90xf32>, tensor<30x90xf32>, index, index) -> tensor<30x90xf32>
    %7 = "tensor.insert_slice"(%6, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<30x90xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%4, %7) : (tensor<62x90xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<62x90xf32>) -> tensor<62x90xf32>, sym_name = "interleaved_extract_insert_slice_chain_1"}> ({
  ^bb0(%arg0: tensor<62x90xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<32x90xf32>
    %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<30x90xf32>
    %2 = "tensor.insert_slice"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<32x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    %3 = "tensor.insert_slice"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 32, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<30x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    "func.return"(%3) : (tensor<62x90xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<62x90xf32>) -> tensor<62x90xf32>, sym_name = "interleaved_extract_insert_slice_chain_2"}> ({
  ^bb0(%arg0: tensor<62x90xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<32x90xf32>
    %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 31, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<30x90xf32>
    %2 = "tensor.insert_slice"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<32x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    %3 = "tensor.insert_slice"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 31, 0>, static_sizes = array<i64: 30, 90>, static_strides = array<i64: 1, 1>}> : (tensor<30x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    "func.return"(%3) : (tensor<62x90xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<62x90xf32>) -> tensor<62x90xf32>, sym_name = "extract_once_insert_twice"}> ({
  ^bb0(%arg0: tensor<62x90xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<62x90xf32>) -> tensor<32x90xf32>
    %1 = "tensor.insert_slice"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<32x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    %2 = "tensor.insert_slice"(%0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 15, 0>, static_sizes = array<i64: 32, 90>, static_strides = array<i64: 1, 1>}> : (tensor<32x90xf32>, tensor<62x90xf32>) -> tensor<62x90xf32>
    "func.return"(%2) : (tensor<62x90xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}], function_type = (tensor<?xf32>, vector<5xf32>) -> tensor<?xf32>, sym_name = "some_use"}> ({
  ^bb0(%arg2: tensor<?xf32>, %arg3: vector<5xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.transfer_write"(%arg3, %arg2, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}], function_type = (tensor<?xf32>, vector<5xf32>) -> tensor<?xf32>, sym_name = "main_func"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<5xf32>):
    %0 = "func.call"(%arg0, %arg1) <{callee = @some_use}> : (tensor<?xf32>, vector<5xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<5xf32>, index, index) -> vector<10xf32>, sym_name = "to_tensor_op_not_writable"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<5xf32>, %arg2: index, %arg3: index):
    %0 = "bufferization.to_tensor"(%arg0) <{restrict}> : (memref<?xf32>) -> tensor<?xf32>
    %1 = "vector.transfer_write"(%arg1, %0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<5xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "vector.transfer_read"(%1, %arg3, %2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<?xf32>, index, f32) -> vector<10xf32>
    "func.return"(%3) : (vector<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "inner_func"}> ({
  ^bb0(%arg6: tensor<?xf32>):
    "func.return"(%arg6) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, tensor<?xf32>) -> tensor<?xf32>, sym_name = "equivalent_func_arg"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: tensor<?xf32>):
    %0 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %1 = "func.call"(%arg5) <{callee = @inner_func}> : (tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "inner_func_2"}> ({
  ^bb0(%arg6: tensor<?xf32>):
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "tensor.insert"(%2, %arg6, %3) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, tensor<?xf32>) -> tensor<?xf32>, sym_name = "equivalent_func_arg_2"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: tensor<?xf32>):
    %0 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>):
      %1 = "func.call"(%arg5) <{callee = @inner_func_2}> : (tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, i1) -> (f32, tensor<?xf32>), sym_name = "write_after_select_read_one"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.select"(%arg2, %arg0, %arg1) : (i1, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert"(%0, %2, %1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %4 = "tensor.extract"(%arg0, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%4, %3) : (f32, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, i1) -> (f32, f32, tensor<?xf32>), sym_name = "write_after_select_read_both"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.select"(%arg2, %arg0, %arg1) : (i1, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert"(%0, %2, %1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %4 = "tensor.extract"(%arg0, %1) : (tensor<?xf32>, index) -> f32
    %5 = "tensor.extract"(%arg1, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%4, %5, %3) : (f32, f32, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, i1) -> (f32, tensor<?xf32>), sym_name = "write_after_select_no_conflict"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.select"(%arg2, %arg0, %arg1) : (i1, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.insert"(%0, %2, %1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %4 = "tensor.extract"(%3, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%4, %3) : (f32, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, index, index, index, index) -> tensor<?xf32>, sym_name = "write_to_same_tensor_in_loop_out_of_place"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "scf.for"(%arg2, %arg3, %arg4, %arg0) ({
    ^bb0(%arg6: index, %arg7: tensor<?xf32>):
      %1 = "arith.index_cast"(%arg6) : (index) -> i32
      %2 = "arith.sitofp"(%1) : (i32) -> f32
      %3 = "tensor.insert"(%2, %arg1, %arg6) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      %4 = "tensor.insert_slice"(%3, %arg7, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%4) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index, index, index) -> tensor<?xf32>, sym_name = "write_to_same_alloc_tensor_in_place"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "bufferization.alloc_tensor"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %1 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg6: index, %arg7: tensor<?xf32>):
      %2 = "arith.index_cast"(%arg6) : (index) -> i32
      %3 = "arith.sitofp"(%2) : (i32) -> f32
      %4 = "tensor.insert"(%3, %0, %arg6) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      %5 = "tensor.insert_slice"(%4, %arg7, %arg6, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%5) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}, {}, {}, {}, {}, {}], function_type = (tensor<?xf32>, index, index, index, index, index, f32) -> tensor<?xf32>, sym_name = "write_to_same_alloc_tensor_out_of_place"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: f32):
    %0 = "bufferization.alloc_tensor"(%arg5) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %1 = "tensor.insert"(%arg6, %0, %arg1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %2 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg7: index, %arg8: tensor<?xf32>):
      %3 = "arith.index_cast"(%arg7) : (index) -> i32
      %4 = "arith.sitofp"(%3) : (i32) -> f32
      %5 = "tensor.insert"(%4, %1, %arg7) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
      %6 = "tensor.insert_slice"(%5, %arg8, %arg7, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> tensor<?xf32>
      "scf.yield"(%6) : (tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "ext_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>) -> f32, sym_name = "private_func_read_write"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.cast"(%arg0) : (tensor<5xf32>) -> tensor<?xf32>
    "func.call"(%1) <{callee = @ext_func}> : (tensor<?xf32>) -> ()
    %2 = "tensor.extract"(%arg0, %0) : (tensor<5xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.access = "read"}], function_type = (tensor<*xf32>) -> (), sym_name = "print_buffer", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<5xf32>) -> f32, sym_name = "private_func_read"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.cast"(%arg0) : (tensor<5xf32>) -> tensor<*xf32>
    "func.call"(%1) <{callee = @print_buffer}> : (tensor<*xf32>) -> ()
    %2 = "tensor.extract"(%arg0, %0) : (tensor<5xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> (), sym_name = "ext_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "private_func_two_params_writing"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    "func.call"(%arg0, %arg0) <{callee = @ext_func}> : (tensor<?xf32>, tensor<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (tensor<5xf32>, tensor<6xf32>), sym_name = "ext_func", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>) -> f32, sym_name = "private_func_aliasing"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:2 = "func.call"(%arg0) <{callee = @ext_func}> : (tensor<?xf32>) -> (tensor<5xf32>, tensor<6xf32>)
    %2 = "tensor.extract"(%1#1, %0) : (tensor<6xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "recursive_function"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0:2 = "func.call"(%arg0, %arg1) <{callee = @recursive_function}> : (tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%0#0, %0#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>, sym_name = "multiple_returns"}> ({
  ^bb0(%arg4: i1, %arg5: tensor<5xf32>, %arg6: tensor<5xf32>, %arg7: tensor<5xf32>):
    "cf.cond_br"(%arg4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%arg5) : (tensor<5xf32>) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg6) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> (), sym_name = "caller"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<5xf32>, %arg2: tensor<5xf32>, %arg3: tensor<5xf32>):
    %0 = "func.call"(%arg0, %arg1, %arg2, %arg3) <{callee = @multiple_returns}> : (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>, sym_name = "multiple_equivalent_returns"}> ({
  ^bb0(%arg4: i1, %arg5: tensor<5xf32>, %arg6: tensor<5xf32>, %arg7: tensor<5xf32>):
    "cf.cond_br"(%arg4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%arg5) : (tensor<5xf32>) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg5) : (tensor<5xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>, sym_name = "caller"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<5xf32>, %arg2: tensor<5xf32>, %arg3: tensor<5xf32>):
    %0 = "func.call"(%arg0, %arg1, %arg2, %arg3) <{callee = @multiple_equivalent_returns}> : (i1, tensor<5xf32>, tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "foo"}> ({
  ^bb0(%arg1: tensor<?xf32>):
    "func.return"(%arg1) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "bar"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "func.call"(%arg0) <{callee = @foo}> : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

