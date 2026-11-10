#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<8x16x32xf32>, index, index, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector"} : () -> ()
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
    }) {sym_name = "load_2D_vector"} : () -> ()
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
    }) {sym_name = "load_zero_pad_out_of_bounds"} : () -> ()
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
    }) {sym_name = "load_transposed"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64x128xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64x128xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %arg3, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<32x64x128xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_transpose_3d_memref"} : () -> ()
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
    }) {sym_name = "load_dynamic_source"} : () -> ()
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
    }) {sym_name = "load_dynamic_source2"} : () -> ()
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
    }) {sym_name = "load_dynamic_source3"} : () -> ()
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
    }) {sym_name = "load_high_dim_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2, d3, d4, d5, d6, d7)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<2x2x2x2x2x2x2x2xf32>, index) -> vector<2x2x2x2x2x2x2x2xf32>}> ({
    ^bb0(%arg0: memref<2x2x2x2x2x2x2x2xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %arg1, %arg1, %arg1, %arg1, %arg1, %0) <{in_bounds = [true, true, true, true, true, true, true, true], operandSegmentSizes = array<i32: 1, 8, 1, 0>, permutation_map = #map}> : (memref<2x2x2x2x2x2x2x2xf32>, index, index, index, index, index, index, index, index, f32) -> vector<2x2x2x2x2x2x2x2xf32>
      "gpu.return"(%1) : (vector<2x2x2x2x2x2x2x2xf32>) -> ()
    }) {sym_name = "load_8D_vector"} : () -> ()
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
    }) {sym_name = "load_transpose_f16"} : () -> ()
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
    }) {sym_name = "no_load_out_of_bounds_non_zero_pad"} : () -> ()
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
    }) {sym_name = "no_load_out_of_bounds_1D_vector"} : () -> ()
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
    }) {sym_name = "no_load_masked"} : () -> ()
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
    }) {sym_name = "no_load_tensor"} : () -> ()
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
    }) {sym_name = "no_load_non_unit_inner_stride"} : () -> ()
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
    }) {sym_name = "no_load_unsupported_map"} : () -> ()
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
    }) {sym_name = "load_from_subview_1D"} : () -> ()
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
    }) {sym_name = "load_from_subview_2D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<16x32xf32, 3>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<16x32xf32, 3>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xf32, 3>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector_addrspace3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32xf32, 3>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<32xf32, 3>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<32xf32, 3>, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector_addrspace3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: index):
      %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
      %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %2 = "vector.transfer_read"(%0, %arg0, %arg0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%2) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector_alloca_promoted_to_slm"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (index) -> vector<8xf32>}> ({
    ^bb0(%arg0: index):
      %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32>
      %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %2 = "vector.transfer_read"(%0, %arg0, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<16xf32>, index, f32) -> vector<8xf32>
      "gpu.return"(%2) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector_alloca_promoted_to_slm"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<f16>) -> vector<f16>}> ({
    ^bb0(%arg0: memref<f16>):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (memref<f16>, f16) -> vector<f16>
      "gpu.return"(%1) : (vector<f16>) -> ()
    }) {sym_name = "load_0D_memref_unsupported"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> ()>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<3xf32>, index) -> vector<f32>}> ({
    ^bb0(%arg0: memref<3xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<3xf32>, index, f32) -> vector<f32>
      "gpu.return"(%1) : (vector<f32>) -> ()
    }) {sym_name = "load_0D_vector_unsupported"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> (s0 * 8)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<1x1024x24x64xf16>, memref<1x24x1024x64xf16>) -> (), kernel, known_block_size = array<i32: 256, 1, 1>}> ({
    ^bb0(%arg0: memref<1x1024x24x64xf16>, %arg1: memref<1x24x1024x64xf16>):
      %0 = "ub.poison"() <{value = #ub.poison}> : () -> f16
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %3 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %4 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %5 = "affine.apply"(%3) <{map = #map}> : (index) -> index
      %6 = "affine.apply"(%4) <{map = #map1}> : (index) -> index
      %7 = "vector.transfer_read"(%arg0, %1, %5, %2, %6, %0) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map2}> : (memref<1x1024x24x64xf16>, index, index, index, index, f16) -> vector<1x16x1x8xf16>
      %8 = "vector.transpose"(%7) <{permutation = array<i64: 0, 2, 1, 3>}> : (vector<1x16x1x8xf16>) -> vector<1x1x16x8xf16>
      "vector.transfer_write"(%8, %arg1, %1, %2, %5, %6) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 1, 4, 0>, permutation_map = #map2}> : (vector<1x1x16x8xf16>, memref<1x24x1024x64xf16>, index, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "transpose_1x1024x24x64"} : () -> ()
  }) : () -> ()
}) : () -> ()

