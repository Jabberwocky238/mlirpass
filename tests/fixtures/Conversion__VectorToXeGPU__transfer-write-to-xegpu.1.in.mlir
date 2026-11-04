#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8xf32>, memref<8x16x32xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<8x16x32xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg3, %arg4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<7x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<7x64xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<7x64xf32>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_out_of_bounds", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
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
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8xf32>, memref<8x16x32xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_out_of_bounds_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf16>, memref<4096x4096xf16>, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index):
      %0 = "memref.subview"(%arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      "vector.transfer_write"(%arg0, %0, %arg3, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8xf16>, memref<256x256xf16, strided<[4096, 1], offset: ?>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_to_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

