#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index) -> f32, sym_name = "fold_static_stride_subview_with_load"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    %2 = "memref.load"(%arg0, %0, %1) : (memref<12x32xf32>, index, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * s2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, index, index) -> f32, sym_name = "fold_dynamic_stride_subview_with_load"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
    %0 = "affine.apply"(%arg1, %arg3, %arg5) <{map = #map}> : (index, index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4, %arg6) <{map = #map}> : (index, index, index) -> index
    %2 = "memref.load"(%arg0, %0, %1) : (memref<12x32xf32>, index, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, f32) -> (), sym_name = "fold_static_stride_subview_with_store"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    "memref.store"(%arg5, %arg0, %0, %1) : (f32, memref<12x32xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * s2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, index, index, f32) -> (), sym_name = "fold_dynamic_stride_subview_with_store"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: f32):
    %0 = "affine.apply"(%arg1, %arg3, %arg5) <{map = #map}> : (index, index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4, %arg6) <{map = #map}> : (index, index, index) -> index
    "memref.store"(%arg7, %arg0, %0, %1) : (f32, memref<12x32xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index) -> vector<f32>, sym_name = "fold_subview_with_transfer_read_0d"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<12x32xf32>, index, index, f32) -> vector<f32>
    "func.return"(%1) : (vector<f32>) -> ()
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
#map = affine_map<(d0, d1) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, vector<f32>) -> (), sym_name = "fold_static_stride_subview_with_transfer_write_0d"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<f32>):
    "vector.transfer_write"(%arg4, %arg0, %arg1, %arg2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<f32>, memref<12x32xf32>, index, index) -> ()
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
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * s2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?x?x?xf32>, index, index, index, index, index, index, index, index, index, index, index, index, index, index, index, index) -> f32, sym_name = "fold_rank_reducing_subview_with_load"}> ({
  ^bb0(%arg0: memref<?x?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index):
    %0 = "affine.apply"(%arg1, %arg13, %arg7) <{map = #map}> : (index, index, index) -> index
    %1 = "affine.apply"(%arg2, %arg14, %arg8) <{map = #map}> : (index, index, index) -> index
    %2 = "affine.apply"(%arg4, %arg15, %arg10) <{map = #map}> : (index, index, index) -> index
    %3 = "affine.apply"(%arg5, %arg16, %arg11) <{map = #map}> : (index, index, index) -> index
    %4 = "memref.load"(%arg0, %0, %1, %arg3, %2, %3, %arg6) : (memref<?x?x?x?x?x?xf32>, index, index, index, index, index, index) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index) -> f32, sym_name = "fold_rank_reducing_subview_1x8x1x3_to_1x8x3_drop_middle_unit_dim"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.load"(%arg0, %0, %arg1, %0, %arg2) : (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, index, index, index) -> vector<4xf32>, sym_name = "fold_vector_transfer_read_with_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "affine.apply"(%arg1, %arg5) <{map = #map}> : (index, index) -> index
    %3 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %4 = "vector.transfer_read"(%arg0, %1, %2, %3, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index, f32) -> vector<4xf32>
    "func.return"(%4) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, vector<4xf32>, index, index, index, index, index, index) -> (), sym_name = "fold_vector_transfer_write_with_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %2 = "affine.apply"(%arg3, %arg7) <{map = #map}> : (index, index) -> index
    "vector.transfer_write"(%arg1, %arg0, %0, %1, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<4xf32>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, vector<4xf32>, index, index, index, index, index, index) -> (), sym_name = "fold_vector_transfer_write_with_inner_rank_reduced_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %2 = "affine.apply"(%arg3, %arg7) <{map = #map}> : (index, index) -> index
    "vector.transfer_write"(%arg1, %arg0, %1, %2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<4xf32>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, index, index, index, index, vector<4xi1>) -> vector<4xf32>, sym_name = "fold_masked_vector_transfer_read_with_subview"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "affine.apply"(%arg1, %arg5) <{map = #map}> : (index, index) -> index
    %2 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %3 = "vector.transfer_read"(%arg0, %1, %2, %0, %arg7) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map1}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, f32, vector<4xi1>) -> vector<4xf32>
    "func.return"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index, index, index, vector<4x3xi1>) -> vector<3x4xf32>, sym_name = "fold_masked_vector_transfer_read_with_rank_reducing_subview"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: vector<4x3xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "affine.apply"(%arg1, %arg5) <{map = #map}> : (index, index) -> index
    %3 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %4 = "vector.transfer_read"(%arg0, %1, %2, %1, %3, %0, %arg7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 1>, permutation_map = #map1}> : (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index, f32, vector<4x3xi1>) -> vector<3x4xf32>
    "func.return"(%4) : (vector<3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, vector<4xf32>, index, index, index, index, index, index, vector<4xi1>) -> (), sym_name = "fold_masked_vector_transfer_write_with_subview"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: vector<4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: vector<4xi1>):
    %0 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg3, %arg7) <{map = #map}> : (index, index) -> index
    "vector.transfer_write"(%arg1, %arg0, %0, %1, %arg8) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map1}> : (vector<4xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, vector<4xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, vector<3x4xf32>, index, index, index, index, index, index, vector<4x3xi1>) -> (), sym_name = "fold_masked_vector_transfer_write_with_rank_reducing_subview"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg1: vector<3x4xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: vector<4x3xi1>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.apply"(%arg2, %arg6) <{map = #map}> : (index, index) -> index
    %2 = "affine.apply"(%arg3, %arg7) <{map = #map}> : (index, index) -> index
    "vector.transfer_write"(%arg1, %arg0, %0, %1, %0, %2, %arg8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 4, 1>, permutation_map = #map1}> : (vector<3x4xf32>, memref<?x?x?x?xf32, strided<[?, ?, ?, ?], offset: ?>>, index, index, index, index, vector<4x3xi1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x?xf32, strided<[16, 1]>>, index, index, index) -> f32, sym_name = "fold_dynamic_subview_with_memref_load_expand_shape"}> ({
  ^bb0(%arg0: memref<16x?xf32, strided<[16, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%0, %arg1) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 1, 16>}> : (index, index) -> index
    %2 = "affine.linearize_index"(%arg2, %0, %arg3) <{disjoint, operandSegmentSizes = array<i32: 2, 1>, static_basis = array<i64: -9223372036854775808, 1>}> : (index, index, index) -> index
    %3 = "memref.load"(%arg0, %1, %2) <{nontemporal = true}> : (memref<16x?xf32, strided<[16, 1]>>, index, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x?xf32, strided<[16, 1]>>, index, index, index) -> (), sym_name = "fold_dynamic_subview_with_memref_store_expand_shape"}> ({
  ^bb0(%arg0: memref<16x?xf32, strided<[16, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "affine.linearize_index"(%0, %arg1) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 1, 16>}> : (index, index) -> index
    %3 = "affine.linearize_index"(%arg2, %0, %arg3) <{disjoint, operandSegmentSizes = array<i32: 2, 1>, static_basis = array<i64: -9223372036854775808, 1>}> : (index, index, index) -> index
    "memref.store"(%1, %arg0, %2, %3) <{nontemporal = true}> : (f32, memref<16x?xf32, strided<[16, 1]>>, index, index) -> ()
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
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg3: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg4: index):
        "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg5: index):
          "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
          ^bb0(%arg6: index):
            %2 = "affine.linearize_index"(%arg3, %0) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 1, 1024>}> : (index, index) -> index
            %3 = "affine.linearize_index"(%arg5, %arg6) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 1024, 1>}> : (index, index) -> index
            %4 = "memref.load"(%arg0, %2, %3) : (memref<1024x1024xf32>, index, index) -> f32
            "memref.store"(%4, %arg1, %arg2) : (f32, memref<1xf32>, index) -> ()
            "affine.yield"() : () -> ()
          }) : () -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    %1 = "memref.load"(%arg1, %arg2) : (memref<1xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x1024xf32, 3>, index) -> memref<f32, strided<[], offset: ?>, 3>, sym_name = "subview_of_subview"}> ({
  ^bb0(%arg0: memref<8x1024xf32, 3>, %arg1: index):
    %0 = "affine.apply"(%arg1) <{map = #map}> : (index) -> index
    %1 = "memref.subview"(%arg0, %0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 4, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<8x1024xf32, 3>, index) -> memref<f32, strided<[], offset: ?>, 3>
    "func.return"(%1) : (memref<f32, strided<[], offset: ?>, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index) -> memref<f32, strided<[], offset: ?>>, sym_name = "subview_of_subview_rank_reducing"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 3, 7, 8>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32>) -> memref<f32, strided<[], offset: ?>>
    "func.return"(%0) : (memref<f32, strided<[], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8xf32, strided<[8, 1]>>) -> memref<2x2xf32, strided<[32, 4], offset: 27>>, sym_name = "subview_of_subview_no_unit_stride"}> ({
  ^bb0(%arg0: memref<8x8xf32, strided<[8, 1]>>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 3, 3>, static_sizes = array<i64: 2, 2>, static_strides = array<i64: 4, 4>}> : (memref<8x8xf32, strided<[8, 1]>>) -> memref<2x2xf32, strided<[32, 4], offset: 27>>
    "func.return"(%0) : (memref<2x2xf32, strided<[32, 4], offset: 27>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x8xf32, strided<[8, 1]>>) -> memref<2xf32, strided<[4], offset: 27>>, sym_name = "subview_of_subview_rank_reducing_no_unit_stride"}> ({
  ^bb0(%arg0: memref<8x8xf32, strided<[8, 1]>>):
    %0 = "memref.subview"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 3, 3>, static_sizes = array<i64: 1, 2>, static_strides = array<i64: 4, 4>}> : (memref<8x8xf32, strided<[8, 1]>>) -> memref<2xf32, strided<[4], offset: 27>>
    "func.return"(%0) : (memref<2xf32, strided<[4], offset: 27>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index) -> f32, sym_name = "fold_load_keep_nontemporal"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    %2 = "memref.load"(%arg0, %0, %1) <{nontemporal = true}> : (memref<12x32xf32>, index, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 * 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, index, index, f32) -> (), sym_name = "fold_store_keep_nontemporal"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    "memref.store"(%arg5, %arg0, %0, %1) <{nontemporal = true}> : (f32, memref<12x32xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, index) -> (), sym_name = "fold_prefetch_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: index):
    %0 = "affine.linearize_index"(%arg1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    "memref.prefetch"(%arg0, %0) <{isDataCache = true, isWrite = false, localityHint = 2 : i32}> : (memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index):
    %0 = "affine.apply"(%arg1, %arg2) <{map = #map}> : (index, index) -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0) <{leadDimension = 160 : index}> : (memref<?xvector<4xf32>>, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%1) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xvector<4xf32>>, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_store_matrix_1d"}> ({
  ^bb0(%arg0: memref<?xvector<4xf32>>, %arg1: index, %arg2: index, %arg3: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "affine.apply"(%arg1, %arg2) <{map = #map}> : (index, index) -> index
    "gpu.subgroup_mma_store_matrix"(%arg3, %arg0, %0) <{leadDimension = 160 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<?xvector<4xf32>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">, sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    %2 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %1) <{leadDimension = 32 : index}> : (memref<128x128xf32>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    "func.return"(%2) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> (), sym_name = "fold_gpu_subgroup_mma_load_matrix_2d"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: !gpu.mma_matrix<16x16xf16, "COp">):
    %0 = "affine.apply"(%arg1, %arg3) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map1}> : (index, index) -> index
    "gpu.subgroup_mma_store_matrix"(%arg5, %arg0, %0, %1) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<128x128xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<24x64xf32>, index, index, index, index, index) -> vector<12x32xf32>, sym_name = "fold_vector_load_subview"}> ({
  ^bb0(%arg0: memref<24x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "affine.apply"(%arg1, %arg5) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg5) <{map = #map}> : (index, index) -> index
    %2 = "vector.load"(%arg0, %0, %1) : (memref<24x64xf32>, index, index) -> vector<12x32xf32>
    "func.return"(%2) : (vector<12x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf32>, index, index) -> vector<1xf32>, sym_name = "fold_scalar_equivalent_vector_load_subview"}> ({
  ^bb0(%arg0: memref<16xf32>, %arg1: index, %arg2: index):
    %0 = "affine.apply"(%arg1, %arg2) <{map = #map}> : (index, index) -> index
    %1 = "vector.load"(%arg0, %0) : (memref<16xf32>, index) -> vector<1xf32>
    "func.return"(%1) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, vector<32xi1>, vector<32xf32>) -> vector<32xf32>, sym_name = "fold_vector_maskedload_subview"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: vector<32xi1>, %arg4: vector<32xf32>):
    %0 = "vector.maskedload"(%arg0, %arg1, %arg2, %arg3, %arg4) : (memref<12x32xf32>, index, index, vector<32xi1>, vector<32xf32>) -> vector<32xf32>
    "func.return"(%0) : (vector<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xf32>, index, vector<2x2x2xi1>, vector<2x2x2xf32>) -> vector<2x2x2xf32>, sym_name = "no_fold_vector_maskedload_subview_high_rank_vector"}> ({
  ^bb0(%arg0: memref<8xf32>, %arg1: index, %arg2: vector<2x2x2xi1>, %arg3: vector<2x2x2xf32>):
    %0 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<8xf32>, index) -> memref<1xf32, strided<[1], offset: ?>>
    %1 = "vector.maskedload"(%0, %arg1, %arg2, %arg3) : (memref<1xf32, strided<[1], offset: ?>>, index, vector<2x2x2xi1>, vector<2x2x2xf32>) -> vector<2x2x2xf32>
    "func.return"(%1) : (vector<2x2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<24x64xf32>, index, index, vector<2x32xf32>, index, index, index) -> (), sym_name = "fold_vector_store_subview"}> ({
  ^bb0(%arg0: memref<24x64xf32>, %arg1: index, %arg2: index, %arg3: vector<2x32xf32>, %arg4: index, %arg5: index, %arg6: index):
    %0 = "affine.apply"(%arg1, %arg4) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg2, %arg4) <{map = #map}> : (index, index) -> index
    "vector.store"(%arg3, %arg0, %0, %1) : (vector<2x32xf32>, memref<24x64xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x32xf32>, index, index, vector<32xi1>, vector<32xf32>) -> (), sym_name = "fold_vector_maskedstore_subview"}> ({
  ^bb0(%arg0: memref<12x32xf32>, %arg1: index, %arg2: index, %arg3: vector<32xi1>, %arg4: vector<32xf32>):
    "vector.maskedstore"(%arg0, %arg1, %arg2, %arg3, %arg4) : (memref<12x32xf32>, index, index, vector<32xi1>, vector<32xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<8xf32>, sym_name = "fold_vector_load_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.load"(%arg0, %1) <{nontemporal = true}> : (memref<32xf32>, index) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<1x8xf32>, sym_name = "fold_vector_load_expand_shape_leading_unit"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.load"(%arg0, %1) : (memref<32xf32>, index) -> vector<8xf32>
    %3 = "vector.shape_cast"(%2) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%3) : (vector<1x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> vector<1xf32>, sym_name = "fold_vector_load_expand_shape_all_unit"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "vector.load"(%arg0) : (memref<f32>) -> vector<f32>
    %1 = "vector.shape_cast"(%0) : (vector<f32>) -> vector<1xf32>
    "func.return"(%1) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>, sym_name = "fold_vector_maskedload_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.maskedload"(%arg0, %1, %arg2, %arg3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<1x8xi1>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "fold_vector_maskedload_expand_shape_leading_unit"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<1x8xi1>, %arg3: vector<1x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.shape_cast"(%arg2) : (vector<1x8xi1>) -> vector<8xi1>
    %3 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    %4 = "vector.maskedload"(%arg0, %1, %2, %3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    %5 = "vector.shape_cast"(%4) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, vector<1xi1>, vector<1xf32>) -> vector<1xf32>, sym_name = "negative_fold_vector_maskedload_expand_shape_all_unit"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: vector<1xi1>, %arg2: vector<1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (memref<f32>) -> memref<1xf32>
    %2 = "vector.maskedload"(%1, %0, %arg1, %arg2) : (memref<1xf32>, index, vector<1xi1>, vector<1xf32>) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<2x2x2xi1>, vector<2x2x2xf32>) -> vector<2x2x2xf32>, sym_name = "no_fold_vector_maskedload_expand_shape_high_rank_vector"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<2x2x2xi1>, %arg3: vector<2x2x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1]], static_output_shape = array<i64: 4, 8>}> : (memref<32xf32>) -> memref<4x8xf32>
    %2 = "vector.maskedload"(%1, %arg1, %0, %arg2, %arg3) : (memref<4x8xf32>, index, index, vector<2x2x2xi1>, vector<2x2x2xf32>) -> vector<2x2x2xf32>
    "func.return"(%2) : (vector<2x2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xf32>) -> (), sym_name = "fold_vector_store_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    "vector.store"(%arg2, %arg0, %1) <{nontemporal = true}> : (vector<8xf32>, memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<1x8xf32>) -> (), sym_name = "fold_vector_store_expand_shape_leading_unit"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<1x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.shape_cast"(%arg2) : (vector<1x8xf32>) -> vector<8xf32>
    "vector.store"(%2, %arg0, %1) : (vector<8xf32>, memref<32xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, vector<1xf32>) -> (), sym_name = "fold_vector_store_expand_shape_all_unit"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: vector<1xf32>):
    %0 = "vector.shape_cast"(%arg1) : (vector<1xf32>) -> vector<f32>
    "vector.store"(%0, %arg0) : (vector<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> (), sym_name = "fold_vector_maskedstore_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    "vector.maskedstore"(%arg0, %1, %arg2, %arg3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<1x8xi1>, vector<1x8xf32>) -> (), sym_name = "fold_vector_maskedstore_expand_shape_leading_unit"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<1x8xi1>, %arg3: vector<1x8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.shape_cast"(%arg2) : (vector<1x8xi1>) -> vector<8xi1>
    %3 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    "vector.maskedstore"(%arg0, %1, %2, %3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, vector<1xi1>, vector<1xf32>) -> (), sym_name = "no_fold_vector_maskedstore_expand_shape_all_unit"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: vector<1xi1>, %arg2: vector<1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (memref<f32>) -> memref<1xf32>
    "vector.maskedstore"(%1, %0, %arg1, %arg2) : (memref<1xf32>, index, vector<1xi1>, vector<1xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>, sym_name = "fold_vector_expandload_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %2 = "vector.expandload"(%arg0, %1, %arg2, %arg3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, vector<1xi1>, vector<1xf32>) -> vector<1xf32>, sym_name = "no_fold_vector_expandload_expand_shape_all_unit"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: vector<1xi1>, %arg2: vector<1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (memref<f32>) -> memref<1xf32>
    %2 = "vector.expandload"(%1, %0, %arg1, %arg2) : (memref<1xf32>, index, vector<1xi1>, vector<1xf32>) -> vector<1xf32>
    "func.return"(%2) : (vector<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> (), sym_name = "fold_vector_compressstore_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    "vector.compressstore"(%arg0, %1, %arg2, %arg3) : (memref<32xf32>, index, vector<8xi1>, vector<8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, vector<1xi1>, vector<1xf32>) -> (), sym_name = "negative_fold_vector_compressstore_expand_shape_all_unit"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: vector<1xi1>, %arg2: vector<1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.expand_shape"(%arg0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (memref<f32>) -> memref<1xf32>
    "vector.compressstore"(%1, %0, %arg1, %arg2) : (memref<1xf32>, index, vector<1xi1>, vector<1xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, index) -> vector<8xf32>, sym_name = "fold_vector_transfer_read_expand_shape"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "affine.linearize_index"(%arg1, %0) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %3 = "vector.transfer_read"(%arg0, %2, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<32xf32>, index, f32) -> vector<8xf32>
    "func.return"(%3) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, index, index) -> vector<8x8xf32>, sym_name = "fold_vector_transfer_read_expand_shape_non_identity"}> ({
  ^bb0(%arg0: memref<32x32xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "affine.linearize_index"(%arg1, %0) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %3 = "affine.linearize_index"(%arg2, %0) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    %4 = "vector.transfer_read"(%arg0, %2, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<8x8xf32>
    "func.return"(%4) : (vector<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf32>, index, index) -> vector<8x8xf32>, sym_name = "fold_vector_transfer_read_expand_shape_non_identity_non_contiguous"}> ({
  ^bb0(%arg0: memref<32x32xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "memref.expand_shape"(%arg0) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: 4, 8, 4, 8>}> : (memref<32x32xf32>) -> memref<4x8x4x8xf32>
    %3 = "vector.transfer_read"(%2, %arg1, %0, %arg2, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<4x8x4x8xf32>, index, index, index, index, f32) -> vector<8x8xf32>
    "func.return"(%3) : (vector<8x8xf32>) -> ()
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
  "func.func"() <{function_type = (memref<4x8xf32>, index) -> f32, sym_name = "fold_memref_load_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index):
    %0:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index)
    %1 = "memref.load"(%arg0, %0#0, %0#1) <{nontemporal = true}> : (memref<4x8xf32>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index) -> vector<8xf32>, sym_name = "fold_vector_load_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index):
    %0:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 8>}> : (index) -> (index, index)
    %1 = "vector.load"(%arg0, %0#0, %0#1) <{nontemporal = true}> : (memref<4x8xf32>, index, index) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>, sym_name = "fold_vector_maskedload_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 8>}> : (index) -> (index, index)
    %1 = "vector.maskedload"(%arg0, %0#0, %0#1, %arg2, %arg3) : (memref<4x8xf32>, index, index, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%1) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, f32) -> (), sym_name = "fold_memref_store_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: f32):
    %0:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index)
    "memref.store"(%arg2, %arg0, %0#0, %0#1) <{nontemporal = true}> : (f32, memref<4x8xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, vector<8xf32>) -> (), sym_name = "fold_vector_store_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xf32>):
    %0:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 8>}> : (index) -> (index, index)
    "vector.store"(%arg2, %arg0, %0#0, %0#1) <{nontemporal = true}> : (vector<8xf32>, memref<4x8xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, vector<8xi1>, vector<8xf32>) -> (), sym_name = "fold_vector_maskedstore_collapse_shape"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: vector<8xi1>, %arg3: vector<8xf32>):
    %0:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 8>}> : (index) -> (index, index)
    "vector.maskedstore"(%arg0, %0#0, %0#1, %arg2, %arg3) : (memref<4x8xf32>, index, index, vector<8xi1>, vector<8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4x8xf32>, index) -> vector<4x8xf32>, sym_name = "no_fold_collapse_shape_transfer_read"}> ({
  ^bb0(%arg0: memref<4x4x8xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "memref.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2]]}> : (memref<4x4x8xf32>) -> memref<16x8xf32>
    %3 = "vector.transfer_read"(%2, %arg1, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x8xf32>, index, index, f32) -> vector<4x8xf32>
    "func.return"(%3) : (vector<4x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4x8xf32>, index) -> vector<8xf32>, sym_name = "fold_collapse_shape_transfer_read"}> ({
  ^bb0(%arg0: memref<4x4x8xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 4, 4>}> : (index) -> (index, index)
    %3 = "vector.transfer_read"(%arg0, %2#0, %2#1, %0, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<4x4x8xf32>, index, index, index, f32) -> vector<8xf32>
    "func.return"(%3) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x64xf32>, memref<32xf32, 1>, memref<1xi32>, index, index) -> (), sym_name = "fold_dma_start_subview_src"}> ({
  ^bb0(%arg0: memref<128x64xf32>, %arg1: memref<32xf32, 1>, %arg2: memref<1xi32>, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    "memref.dma_start"(%arg0, %arg3, %arg4, %arg1, %0, %1, %arg2, %0) : (memref<128x64xf32>, index, index, memref<32xf32, 1>, index, index, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, memref<128x64xf32, 1>, memref<1xi32>, index, index) -> (), sym_name = "fold_dma_start_subview_dst"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: memref<128x64xf32, 1>, %arg2: memref<1xi32>, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    "memref.dma_start"(%arg0, %0, %arg1, %arg3, %arg4, %1, %arg2, %0) : (memref<32xf32>, index, memref<128x64xf32, 1>, index, index, index, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xf32>, memref<8xf32, 1>, memref<1xi32>, index) -> (), sym_name = "fold_dma_start_expand_shape_src"}> ({
  ^bb0(%arg0: memref<32xf32>, %arg1: memref<8xf32, 1>, %arg2: memref<1xi32>, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "affine.linearize_index"(%arg3, %0) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    "memref.dma_start"(%arg0, %2, %arg1, %0, %1, %arg2, %0) : (memref<32xf32>, index, memref<8xf32, 1>, index, index, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xf32>, memref<32xf32, 1>, memref<1xi32>, index) -> (), sym_name = "fold_dma_start_expand_shape_dst"}> ({
  ^bb0(%arg0: memref<8xf32>, %arg1: memref<32xf32, 1>, %arg2: memref<1xi32>, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "affine.linearize_index"(%arg3, %0) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 4, 8>}> : (index, index) -> index
    "memref.dma_start"(%arg0, %0, %arg1, %2, %1, %arg2, %0) : (memref<8xf32>, index, memref<32xf32, 1>, index, index, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, memref<8xf32, 1>, memref<1xi32>, index) -> (), sym_name = "fold_dma_start_collapse_shape_src"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: memref<8xf32, 1>, %arg2: memref<1xi32>, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2:2 = "affine.delinearize_index"(%arg3) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index)
    "memref.dma_start"(%arg0, %2#0, %2#1, %arg1, %0, %1, %arg2, %0) : (memref<4x8xf32>, index, index, memref<8xf32, 1>, index, index, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xf32>, memref<4x8xf32, 1>, memref<1xi32>, index) -> (), sym_name = "fold_dma_start_collapse_shape_dst"}> ({
  ^bb0(%arg0: memref<8xf32>, %arg1: memref<4x8xf32, 1>, %arg2: memref<1xi32>, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2:2 = "affine.delinearize_index"(%arg3) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index)
    "memref.dma_start"(%arg0, %0, %arg1, %2#0, %2#1, %1, %arg2, %0) : (memref<8xf32>, index, memref<4x8xf32, 1>, index, index, index, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

