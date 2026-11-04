#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<8x16x32xf32>, index, index, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<8x16x32xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %0) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_zero_pad_out_of_bounds", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_transposed", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x?x?xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %arg3, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x8x16xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %arg3, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x8x16xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source2", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d1, d2, d3, d4)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<16x32x64xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x64xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_unsupported_map", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index) -> vector<8xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %1 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %2 = "vector.transfer_read"(%1, %arg2, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<256x256xf16, strided<[4096, 1], offset: ?>>, index, index, f16) -> vector<8xf16>
      "gpu.return"(%2) : (vector<8xf16>) -> ()
    }) {sym_name = "load_from_subview_1D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index) -> vector<8x16xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %1 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %2 = "vector.transfer_read"(%1, %arg2, %arg2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<256x256xf16, strided<[4096, 1], offset: ?>>, index, index, f16) -> vector<8x16xf16>
      "gpu.return"(%2) : (vector<8x16xf16>) -> ()
    }) {sym_name = "load_from_subview_2D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

