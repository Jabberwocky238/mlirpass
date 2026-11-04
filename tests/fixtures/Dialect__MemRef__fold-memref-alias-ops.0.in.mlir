"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index) -> f32, sym_name = "fold_static_stride_subview_with_load"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 2, 3>}> : (memref<12x32xf32>, index, index) -> memref<4x4xf32, strided<[64, 3], offset: ?>>
    %1 = "memref.load"(%0, %arg3, %arg4) : (memref<4x4xf32, strided<[64, 3], offset: ?>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, index, index) -> f32, sym_name = "fold_dynamic_stride_subview_with_load"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<12x32xf32>, index, index, index, index) -> memref<4x4xf32, strided<[?, ?], offset: ?>>
    %1 = "memref.load"(%0, %arg3, %arg4) : (memref<4x4xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, f32) -> (), sym_name = "fold_static_stride_subview_with_store"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 2, 3>}> : (memref<12x32xf32>, index, index) -> memref<4x4xf32, strided<[64, 3], offset: ?>>
    "memref.store"(%arg5, %0, %arg3, %arg4) : (f32, memref<4x4xf32, strided<[64, 3], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, index, index, f32) -> (), sym_name = "fold_dynamic_stride_subview_with_store"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: f32):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<12x32xf32>, index, index, index, index) -> memref<4x4xf32, strided<[?, ?], offset: ?>>
    "memref.store"(%arg7, %0, %arg3, %arg4) : (f32, memref<4x4xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index) -> vector<f32>, sym_name = "fold_subview_with_transfer_read_0d"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<12x32xf32>, index, index) -> memref<f32, strided<[], offset: ?>>
    %2 = "vector.transfer_read"(%1, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (memref<f32, strided<[], offset: ?>>, f32) -> vector<f32>
    "func.return"(%2) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, index, index) -> vector<4xf32>, sym_name = "fold_subview_with_transfer_read"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<12x32xf32>, index, index, index, index) -> memref<4x4xf32, strided<[?, ?], offset: ?>>
    %2 = "vector.transfer_read"(%1, %arg3, %arg4, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xf32, strided<[?, ?], offset: ?>>, index, index, f32) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, vector<f32>) -> (), sym_name = "fold_static_stride_subview_with_transfer_write_0d"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<f32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<12x32xf32>, index, index) -> memref<f32, strided<[], offset: ?>>
    "vector.transfer_write"(%arg4, %1) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 0, 0>, permutation_map = #map}> : (vector<f32>, memref<f32, strided<[], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, index, index, vector<4xf32>) -> (), sym_name = "fold_static_stride_subview_with_transfer_write"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4xf32>):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<12x32xf32>, index, index, index, index) -> memref<4x4xf32, strided<[?, ?], offset: ?>>
    "vector.transfer_write"(%arg7, %0, %arg3, %arg4) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, memref<4x4xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?x?x?xf32>, index, index, index, index, index, index, index, index, index, index, index, index, index, index, index, index) -> f32, sym_name = "fold_rank_reducing_subview_with_load"}> ({
  ^bb0(%arg0: memref<?x?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12) <{operandSegmentSizes = array<i32: 1, 6, 0, 6>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 1, 1, 4, 1, 1>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?x?x?x?xf32>, index, index, index, index, index, index, index, index, index, index, index, index) -> memref<4x1x4x1xf32, strided<[?, ?, ?, ?], offset: ?>>
    %1 = "memref.load"(%0, %arg13, %arg14, %arg15, %arg16) : (memref<4x1x4x1xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, index, index, index) -> vector<4xf32>, sym_name = "fold_vector_transfer_read_with_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %2 = "vector.transfer_read"(%1, %arg5, %arg6, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, f32) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, vector<4xf32>, index, index, index, index, index, index) -> (), sym_name = "fold_vector_transfer_write_with_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg2, %arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "vector.transfer_write"(%arg1, %1, %arg6, %arg7) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, vector<4xf32>, index, index, index, index, index, index) -> (), sym_name = "fold_vector_transfer_write_with_inner_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg2, %arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "vector.transfer_write"(%arg1, %1, %arg6, %arg7) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, index, index, index, index, vector<4xi1>) -> vector<4xf32>, sym_name = "fold_masked_vector_transfer_read_with_subview"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %2 = "vector.transfer_read"(%1, %arg5, %arg6, %0, %arg7) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, f32, vector<4xi1>) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index, index, index, vector<4x3xi1>) -> vector<3x4xf32>, sym_name = "fold_masked_vector_transfer_read_with_rank_reducing_subview"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4x3xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %2 = "vector.transfer_read"(%1, %arg5, %arg6, %0, %arg7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, f32, vector<4x3xi1>) -> vector<3x4xf32>
    "func.return"(%2) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, vector<4xf32>, index, index, index, index, index, index, vector<4xi1>) -> (), sym_name = "fold_masked_vector_transfer_write_with_subview"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: vector<4xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg2, %arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "vector.transfer_write"(%arg1, %1, %arg6, %arg7, %arg8) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<4xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, vector<4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, vector<3x4xf32>, index, index, index, index, index, index, vector<4x3xi1>) -> (), sym_name = "fold_masked_vector_transfer_write_with_rank_reducing_subview"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: vector<3x4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: vector<4x3xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg2, %arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: 0, -9223372036854775808, 0, -9223372036854775808>, static_sizes = array<i64: 1, -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "vector.transfer_write"(%arg1, %1, %arg6, %arg7, %arg8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<3x4xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, vector<4x3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x?xf32, strided<[16, 1]>>, index, index, index) -> f32, sym_name = "fold_dynamic_subview_with_memref_load_expand_shape"}> ({
  ^bb0(%arg0: memref<16x?xf32, strided<[16, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0, %arg3) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: 1, 16, -9223372036854775808, 1>}> : (memref<16x?xf32, strided<[16, 1]>>, index) -> memref<1x16x?x1xf32, strided<[256, 16, 1, 1]>>
    %2 = "memref.load"(%1, %0, %arg1, %arg2, %0) <{nontemporal = true}> : (memref<1x16x?x1xf32, strided<[256, 16, 1, 1]>>, index, index, index, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x?xf32, strided<[16, 1]>>, index, index, index) -> (), sym_name = "fold_dynamic_subview_with_memref_store_expand_shape"}> ({
  ^bb0(%arg0: memref<16x?xf32, strided<[16, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "memref.expand_shape"(%arg0, %arg3) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: 1, 16, -9223372036854775808, 1>}> : (memref<16x?xf32, strided<[16, 1]>>, index) -> memref<1x16x?x1xf32, strided<[256, 16, 1, 1]>>
    "memref.store"(%1, %2, %0, %arg1, %arg2, %0) <{nontemporal = true}> : (f32, memref<1x16x?x1xf32, strided<[256, 16, 1, 1]>>, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (1)>
#map2 = affine_map<() -> (1020)>
#map3 = affine_map<() -> (1024)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1024x1024xf32>, memref<1xf32>, index) -> f32, sym_name = "fold_static_stride_subview_with_memref_expand_shape_with_constant_access_index"}> ({
  ^bb0(%arg0: memref<1024x1024xf32>, %arg1: memref<1xf32>, %arg2: index):
    %0 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: 1, 1024, 1024, 1>}> : (memref<1024x1024xf32>) -> memref<1x1024x1024x1xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg3: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg4: index):
        "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg5: index):
          "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
          ^bb0(%arg6: index):
            %3 = "memref.load"(%0, %arg3, %1, %arg5, %arg6) : (memref<1x1024x1024x1xf32>, index, index, index, index) -> f32
            "memref.store"(%3, %arg1, %arg2) : (f32, memref<1xf32>, index) -> ()
            "affine.yield"() : () -> ()
          }) : () -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    %2 = "memref.load"(%arg1, %arg2) : (memref<1xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x1024xf32, 3>, index) -> memref<f32, strided<[], offset: ?>, 3>, sym_name = "subview_of_subview"}> ({
  ^bb0(%arg0: memref<8x1024xf32, 3>, %arg1: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 3, -9223372036854775808>, static_sizes = array<i64: 5, 7>, static_strides = array<i64: 1, 1>}> : (memref<8x1024xf32, 3>, index) -> memref<5x7xf32, strided<[1024, 1], offset: ?>, 3>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1, 2>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<5x7xf32, strided<[1024, 1], offset: ?>, 3>) -> memref<f32, strided<[], offset: ?>, 3>
    "func.return"(%1) : (memref<f32, strided<[], offset: ?>, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index) -> memref<f32, strided<[], offset: ?>>, sym_name = "subview_of_subview_rank_reducing"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 3, 1, 8>, static_sizes = array<i64: 1, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32>, index) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "memref.subview"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 6>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<?xf32, strided<[?], offset: ?>>) -> memref<f32, strided<[], offset: ?>>
    "func.return"(%1) : (memref<f32, strided<[], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index) -> f32, sym_name = "fold_load_keep_nontemporal"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 2, 3>}> : (memref<12x32xf32>, index, index) -> memref<4x4xf32, strided<[64, 3], offset: ?>>
    %1 = "memref.load"(%0, %arg3, %arg4) <{nontemporal = true}> : (memref<4x4xf32, strided<[64, 3], offset: ?>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, f32) -> (), sym_name = "fold_store_keep_nontemporal"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 2, 3>}> : (memref<12x32xf32>, index, index) -> memref<4x4xf32, strided<[64, 3], offset: ?>>
    "memref.store"(%arg5, %0, %arg3, %arg4) <{nontemporal = true}> : (f32, memref<4x4xf32, strided<[64, 3], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 81920>, static_strides = array<i64: 1>}> : (memref<?xvector<4xf32>>, index) -> memref<81920xvector<4xf32>, strided<[1], offset: ?>>
    %1 = "gpu.subgroup_mma_load_matrix"(%0, %arg2) <{leadDimension = 160 : index}> : (memref<81920xvector<4xf32>, strided<[1], offset: ?>>, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_store_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 81920>, static_strides = array<i64: 1>}> : (memref<?xvector<4xf32>>, index) -> memref<81920xvector<4xf32>, strided<[1], offset: ?>>
    "gpu.subgroup_mma_store_matrix"(%arg3, %0, %arg2) <{leadDimension = 160 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<81920xvector<4xf32>, strided<[1], offset: ?>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 2, 1>}> : (memref<128x128xf32>, index, index) -> memref<64x32xf32, strided<[256, 1], offset: ?>>
    %1 = "gpu.subgroup_mma_load_matrix"(%0, %arg3, %arg4) <{leadDimension = 32 : index}> : (memref<64x32xf32, strided<[256, 1], offset: ?>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 2, 1>}> : (memref<128x128xf32>, index, index) -> memref<64x32xf32, strided<[256, 1], offset: ?>>
    "gpu.subgroup_mma_store_matrix"(%arg5, %0, %arg3, %arg4) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<64x32xf32, strided<[256, 1], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x128x768xf16>, index, index, index) -> (), sym_name = "fold_nvgpu_device_async_copy_zero_sub_idx"}> ({
  ^bb0(%arg0: memref<2x128x768xf16>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    %2 = "memref.subview"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (memref<2x128x768xf16>, index, index, index) -> memref<1x8xf16, strided<[98304, 1], offset: ?>>
    %3 = "nvgpu.device_async_copy"(%1, %0, %0, %0, %0, %2, %0, %0) <{bypassL1, dstElements = 8 : index, operandSegmentSizes = array<i32: 1, 4, 1, 2, 0>}> : (memref<5x1x64x64xf16, #gpu.address_space<workgroup>>, index, index, index, index, memref<1x8xf16, strided<[98304, 1], offset: ?>>, index, index) -> !nvgpu.device.async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x128x768xf16>, index, index, index, index, index) -> (), sym_name = "fold_src_nvgpu_device_async_copy"}> ({
  ^bb0(%arg0: memref<2x128x768xf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    %2 = "memref.subview"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (memref<2x128x768xf16>, index, index, index) -> memref<1x8xf16, strided<[98304, 1], offset: ?>>
    %3 = "nvgpu.device_async_copy"(%1, %0, %0, %0, %0, %2, %arg4, %arg5) <{bypassL1, dstElements = 8 : index, operandSegmentSizes = array<i32: 1, 4, 1, 2, 0>}> : (memref<5x1x64x64xf16, #gpu.address_space<workgroup>>, index, index, index, index, memref<1x8xf16, strided<[98304, 1], offset: ?>>, index, index) -> !nvgpu.device.async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x128x768xf16>, index, index, index, index, index, index, index, index, index, index, index) -> (), sym_name = "fold_src_fold_dest_nvgpu_device_async_copy"}> ({
  ^bb0(%arg0: memref<2x128x768xf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5x1x64x64xf16, #gpu.address_space<workgroup>>
    %2 = "memref.subview"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 8>, static_strides = array<i64: 1, 1, 1>}> : (memref<2x128x768xf16>, index, index, index) -> memref<1x8xf16, strided<[98304, 1], offset: ?>>
    %3 = "memref.subview"(%1, %arg6, %arg7, %arg8, %arg9) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 1, 8>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<5x1x64x64xf16, #gpu.address_space<workgroup>>, index, index, index, index) -> memref<1x8xf16, strided<[4096, 1], offset: ?>, #gpu.address_space<workgroup>>
    %4 = "nvgpu.device_async_copy"(%3, %arg10, %arg11, %2, %arg4, %arg5) <{bypassL1, dstElements = 8 : index, operandSegmentSizes = array<i32: 1, 2, 1, 2, 0>}> : (memref<1x8xf16, strided<[4096, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, memref<1x8xf16, strided<[98304, 1], offset: ?>>, index, index) -> !nvgpu.device.async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (-s0 + 4)>
#map1 = affine_map<()[s0] -> (-s0 + 32)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x32x32xf16, 3>, index, index, index) -> vector<4x2xf16>, sym_name = "test_ldmatrix"}> ({
  ^bb0(%arg0: memref<4x32x32xf16, 3>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.apply"(%arg1) <{map = #map}> : (index) -> index
    %2 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
    %3 = "affine.apply"(%arg3) <{map = #map1}> : (index) -> index
    %4 = "memref.subview"(%arg0, %arg1, %arg2, %arg3, %1, %2, %3) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x32x32xf16, 3>, index, index, index, index, index, index) -> memref<?x?x?xf16, strided<[1024, 32, 1], offset: ?>, 3>
    %5 = "nvgpu.ldmatrix"(%4, %0, %0, %0) <{numTiles = 4 : i32, transpose = false}> : (memref<?x?x?xf16, strided<[1024, 32, 1], offset: ?>, 3>, index, index, index) -> vector<4x2xf16>
    "func.return"(%5) : (vector<4x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<24x64xf32>, index, index, index, index, index) -> vector<12x32xf32>, sym_name = "fold_vector_load_subview"}> ({
  ^bb0(%arg0: memref<24x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<24x64xf32>, index, index, index, index) -> memref<?x?xf32, strided<[64, 1], offset: ?>>
    %1 = "vector.load"(%0, %arg5, %arg5) : (memref<?x?xf32, strided<[64, 1], offset: ?>>, index, index) -> vector<12x32xf32>
    "func.return"(%1) : (vector<12x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, vector<32xi1>, vector<32xf32>) -> vector<32xf32>, sym_name = "fold_vector_maskedload_subview"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: vector<32xi1>, %arg4: vector<32xf32>):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<12x32xf32>, index, index) -> memref<f32, strided<[], offset: ?>>
    %1 = "vector.maskedload"(%0, %arg3, %arg4) : (memref<f32, strided<[], offset: ?>>, vector<32xi1>, vector<32xf32>) -> vector<32xf32>
    "func.return"(%1) : (vector<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<24x64xf32>, index, index, vector<2x32xf32>, index, index, index) -> (), sym_name = "fold_vector_store_subview"}> ({
  ^bb0(%arg0: memref<24x64xf32>, %arg1: index, %arg2: index, %arg3: vector<2x32xf32>, %arg4: index, %arg5: index, %arg6: index):
    %0 = "memref.subview"(%arg0, %arg1, %arg2, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 2, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<24x64xf32>, index, index, index, index) -> memref<?x?xf32, strided<[64, 1], offset: ?>>
    "vector.store"(%arg3, %0, %arg4, %arg4) : (vector<2x32xf32>, memref<?x?xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, vector<32xi1>, vector<32xf32>) -> (), sym_name = "fold_vector_maskedstore_subview"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: vector<32xi1>, %arg4: vector<32xf32>):
    %0 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<12x32xf32>, index, index) -> memref<f32, strided<[], offset: ?>>
    "vector.maskedstore"(%0, %arg3, %arg4) : (memref<f32, strided<[], offset: ?>>, vector<32xi1>, vector<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<8xf32>, sym_name = "fold_vector_load_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    %2 = "vector.load"(%1, %arg1, %0) <{nontemporal = true}> : (memref<4x8xf32>, index, index) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>, sym_name = "fold_vector_maskedload_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    %2 = "vector.maskedload"(%1, %arg1, %0, %arg2, %arg3) : (memref<4x8xf32>, index, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xf32>) -> (), sym_name = "fold_vector_store_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    "vector.store"(%arg2, %1, %arg1, %0) <{nontemporal = true}> : (vector<8xf32>, memref<4x8xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> (), sym_name = "fold_vector_maskedstore_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    "vector.maskedstore"(%1, %arg1, %0, %arg2, %arg3) : (memref<4x8xf32>, index, index, vector<8xi1>, vector<8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<8xf32>, sym_name = "fold_vector_transfer_read_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    %3 = "vector.transfer_read"(%2, %arg1, %0, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x8xf32>, index, index, f32) -> vector<8xf32>
    "func.return"(%3) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<4x4xf32>, sym_name = "fold_vector_transfer_read_with_perm_map"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    %3 = "vector.transfer_read"(%2, %arg1, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x8xf32>, index, index, f32) -> vector<4x4xf32>
    "func.return"(%3) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<4x4xf32>, sym_name = "fold_vector_transfer_read_rank_mismatch"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1, 2]], static_output_shape = array<i64: 2, 4, 4>}> : (memref<32xf32>) -> memref<2x4x4xf32>
    %3 = "vector.transfer_read"(%2, %arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<2x4x4xf32>, index, index, index, f32) -> vector<4x4xf32>
    "func.return"(%3) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index) -> vector<8xf32>, sym_name = "fold_vector_load_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (memref<4x8xf32>) -> memref<32xf32>
    %1 = "vector.load"(%0, %arg1) <{nontemporal = true}> : (memref<32xf32>, index) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>, sym_name = "fold_vector_maskedload_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (memref<4x8xf32>) -> memref<32xf32>
    %1 = "vector.maskedload"(%0, %arg1, %arg2, %arg3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, vector<8xf32>) -> (), sym_name = "fold_vector_store_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (memref<4x8xf32>) -> memref<32xf32>
    "vector.store"(%arg2, %0, %arg1) <{nontemporal = true}> : (vector<8xf32>, memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, vector<8xi1>, vector<8xf32>) -> (), sym_name = "fold_vector_maskedstore_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1]]}> : (memref<4x8xf32>) -> memref<32xf32>
    "vector.maskedstore"(%0, %arg1, %arg2, %arg3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

