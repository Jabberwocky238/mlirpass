"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = 4 : index}> : () -> index
      %1 = "memref.subview"(%arg1, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<8x16x32xf32>, index, index) -> memref<32xf32, strided<[1], offset: ?>>
      %2:4 = "memref.extract_strided_metadata"(%1) : (memref<32xf32, strided<[1], offset: ?>>) -> (memref<f32>, index, index, index)
      %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f32>) -> index
      %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 32>, const_strides = array<i64: 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      "xegpu.store_nd"(%arg0, %7, %arg2) <{const_offsets = array<i64: -9223372036854775808>}> : (vector<8xf32>, !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = 4 : index}> : () -> index
      %1 = "memref.subview"(%arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, 16, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<8x16x32xf32>, index) -> memref<16x32xf32, strided<[32, 1], offset: ?>>
      %2:6 = "memref.extract_strided_metadata"(%1) : (memref<16x32xf32, strided<[32, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
      %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f32>) -> index
      %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 16, 32>, const_strides = array<i64: 32, 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      "xegpu.store_nd"(%arg0, %7, %arg2, %arg2) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<8x16xf32>, !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
      %0 = "arith.constant"() <{value = 4 : index}> : () -> index
      %1:8 = "memref.extract_strided_metadata"(%arg1) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %2 = "memref.subview"(%arg1, %arg2, %1#3, %1#4) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32>, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
      %3:6 = "memref.extract_strided_metadata"(%2) : (memref<?x?xf32, strided<[?, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
      %4 = "memref.extract_aligned_pointer_as_index"(%3#0) : (memref<f32>) -> index
      %5 = "arith.muli"(%3#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.index_cast"(%6) : (index) -> i64
      %8 = "xegpu.create_nd_tdesc"(%7, %3#2, %3#3, %3#4) <{const_offsets = array<i64>, const_shape = array<i64: -9223372036854775808, -9223372036854775808>, const_strides = array<i64: -9223372036854775808, 1>, operandSegmentSizes = array<i32: 1, 0, 2, 1>}> : (i64, index, index, index) -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      "xegpu.store_nd"(%arg0, %8, %arg3, %arg4) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<8x16xf32>, !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<7x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<7x64xf32>, %arg2: index):
      %0 = "xegpu.create_nd_tdesc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<7x64xf32>) -> !xegpu.tensor_desc<8x16xf32>
      "xegpu.store_nd"(%arg0, %0, %arg2, %arg2) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<8x16xf32>, !xegpu.tensor_desc<8x16xf32>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_out_of_bounds", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<32x64xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<32x64xf32>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_transposed", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16x32xf32>, memref<16x32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16x32xf32>, %arg1: memref<16x32x64xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8x16x32xf32>, memref<16x32x64xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_high_dim_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<4xf32>, memref<4xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<4xf32>, %arg1: memref<4xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<[false, true, false, true]> : vector<4xi1>}> : () -> vector<4xi1>
      "vector.transfer_write"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<4xf32>, memref<4xf32>, index, vector<4xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_masked", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, tensor<32x64xf32>, index) -> tensor<32x64xf32>}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: tensor<32x64xf32>, %arg2: index):
      %0 = "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x16xf32>, tensor<32x64xf32>, index, index) -> tensor<32x64xf32>
      "gpu.return"(%0) : (tensor<32x64xf32>) -> ()
    }) {sym_name = "no_store_tensor", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_non_unit_inner_stride", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<16x32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<16x32x64xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<16x32x64xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_unsupported_map", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8xf32>, memref<8x16x32xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_out_of_bounds_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (vector<8xf16>, memref<4096x4096xf16>, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = 2 : index}> : () -> index
      %1 = "memref.subview"(%arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %2 = "memref.subview"(%1, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 256>, static_strides = array<i64: 1, 1>}> : (memref<256x256xf16, strided<[4096, 1], offset: ?>>, index) -> memref<256xf16, strided<[1], offset: ?>>
      %3:4 = "memref.extract_strided_metadata"(%2) : (memref<256xf16, strided<[1], offset: ?>>) -> (memref<f16>, index, index, index)
      %4 = "memref.extract_aligned_pointer_as_index"(%3#0) : (memref<f16>) -> index
      %5 = "arith.muli"(%3#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.index_cast"(%6) : (index) -> i64
      %8 = "xegpu.create_nd_tdesc"(%7) <{const_offsets = array<i64>, const_shape = array<i64: 256>, const_strides = array<i64: 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      "xegpu.store_nd"(%arg0, %8, %arg3) <{const_offsets = array<i64: -9223372036854775808>}> : (vector<8xf16>, !xegpu.tensor_desc<8xf16, #xegpu.block_tdesc_attr<boundary_check = false>>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_to_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

