"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 512 : index}> : () -> index
      %2 = "arith.constant"() <{value = 32 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "arith.muli"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<8x16x32xf32>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      %12 = "xegpu.load"(%11, %9, %0) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf32>
      "gpu.return"(%12) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 4 : index}> : () -> index
      %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, 16, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<8x16x32xf32>, index) -> memref<16x32xf32, strided<[32, 1], offset: ?>>
      %2:6 = "memref.extract_strided_metadata"(%1) : (memref<16x32xf32, strided<[32, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
      %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f32>) -> index
      %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 16, 32>, const_strides = array<i64: 32, 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %8 = "xegpu.load_nd"(%7, %arg1, %arg1) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> vector<8x16xf32>
      "gpu.return"(%8) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index):
      %0 = "xegpu.create_nd_tdesc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<32x64xf32>) -> !xegpu.tensor_desc<8x16xf32>
      %1 = "xegpu.load_nd"(%0, %arg1, %arg1) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32>, index, index) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_zero_pad_out_of_bounds", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index):
      %0 = "xegpu.create_nd_tdesc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<32x64xf32>) -> !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %1 = "xegpu.load_nd"(%0, %arg1, %arg2) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>, transpose = array<i64: 1, 0>}> : (!xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_transposed", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<?x?x?xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = 4 : index}> : () -> index
      %1:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %2 = "memref.subview"(%arg0, %arg1, %1#3, %1#4) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32>, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
      %3:6 = "memref.extract_strided_metadata"(%2) : (memref<?x?xf32, strided<[?, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
      %4 = "memref.extract_aligned_pointer_as_index"(%3#0) : (memref<f32>) -> index
      %5 = "arith.muli"(%3#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.index_cast"(%6) : (index) -> i64
      %8 = "xegpu.create_nd_tdesc"(%7, %3#2, %3#3, %3#4) <{const_offsets = array<i64>, const_shape = array<i64: -9223372036854775808, -9223372036854775808>, const_strides = array<i64: -9223372036854775808, 1>, operandSegmentSizes = array<i32: 1, 0, 2, 1>}> : (i64, index, index, index) -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %9 = "xegpu.load_nd"(%8, %arg2, %arg3) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> vector<8x16xf32>
      "gpu.return"(%9) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<?x8x16xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = 4 : index}> : () -> index
      %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, 8, 16>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x8x16xf32>, index) -> memref<8x16xf32, strided<[16, 1], offset: ?>>
      %2:6 = "memref.extract_strided_metadata"(%1) : (memref<8x16xf32, strided<[16, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
      %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f32>) -> index
      %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 8, 16>, const_strides = array<i64: 16, 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %8 = "xegpu.load_nd"(%7, %arg2, %arg3) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> vector<8x16xf32>
      "gpu.return"(%8) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source2", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d1, d2, d3, d4)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<?x?x?x?x?xf32>, index, index, index, index, index) -> vector<2x4x8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %0) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map}> : (memref<?x?x?x?x?xf32>, index, index, index, index, index, f32) -> vector<2x4x8x16xf32>
      "gpu.return"(%1) : (vector<2x4x8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source3", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<16x32x64xf32>, index, index) -> vector<8x16x32xf32>}> ({
    ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %arg1, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x64xf32>, index, index, index, f32) -> vector<8x16x32xf32>
      "gpu.return"(%1) : (vector<8x16x32xf32>) -> ()
    }) {sym_name = "load_high_dim_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<32x64xf16>, index) -> vector<8x16xf16>}> ({
    ^bb0(%arg0: memref<32x64xf16>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf16>, index, index, f16) -> vector<8x16xf16>
      "gpu.return"(%1) : (vector<8x16xf16>) -> ()
    }) {sym_name = "load_transpose_f16", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index, index, f32) -> (vector<8x16xf32>, vector<8x16xf32>)}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index, %arg3: f32):
      %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      %2 = "vector.transfer_read"(%arg0, %arg2, %arg1, %arg3) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1, %2) : (vector<8x16xf32>, vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_out_of_bounds_non_zero_pad", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<8x16x32xf32>, index, index, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "no_load_out_of_bounds_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4xf32>, index) -> vector<4xf32>}> ({
    ^bb0(%arg0: memref<4xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "arith.constant"() <{value = dense<[false, true, false, true]> : vector<4xi1>}> : () -> vector<4xi1>
      %2 = "vector.transfer_read"(%arg0, %arg1, %0, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (memref<4xf32>, index, f32, vector<4xi1>) -> vector<4xf32>
      "gpu.return"(%2) : (vector<4xf32>) -> ()
    }) {sym_name = "no_load_masked", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (tensor<32x64xf32>, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_tensor", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<32xf32, strided<[?], offset: ?>>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<32xf32, strided<[?], offset: ?>>, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "no_load_non_unit_inner_stride", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<16x32x64xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x64xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_unsupported_map", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index) -> vector<8xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %2 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %3:6 = "memref.extract_strided_metadata"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%3#1, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      %12 = "xegpu.load"(%11, %9, %0) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf16>
      "gpu.return"(%12) : (vector<8xf16>) -> ()
    }) {sym_name = "load_from_subview_1D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module", targets = [#xevm.target<O = 3, chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index) -> vector<8x16xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 2 : index}> : () -> index
      %1 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %2:6 = "memref.extract_strided_metadata"(%1) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f16>) -> index
      %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 256, 256>, const_strides = array<i64: 4096, 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8x16xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      %8 = "xegpu.load_nd"(%7, %arg2, %arg2) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf16, #xegpu.block_tdesc_attr<boundary_check = false>>, index, index) -> vector<8x16xf16>
      "gpu.return"(%8) : (vector<8x16xf16>) -> ()
    }) {sym_name = "load_from_subview_2D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

