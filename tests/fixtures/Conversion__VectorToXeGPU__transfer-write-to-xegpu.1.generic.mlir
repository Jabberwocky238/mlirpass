"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 512 : index}> : () -> index
      %2 = "arith.constant"() <{value = 32 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x16x32xf32>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      "xegpu.store"(%arg0, %11, %9, %0) : (vector<8xf32>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<32> : vector<8xindex>}> : () -> vector<8xindex>
      %2 = "arith.constant"() <{value = 512 : index}> : () -> index
      %3 = "arith.constant"() <{value = 32 : index}> : () -> index
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "vector.step"() : () -> vector<16xindex>
      %6 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %7 = "vector.shape_cast"(%6) : (vector<8xindex>) -> vector<8x1xindex>
      %8 = "vector.broadcast"(%7) : (vector<8x1xindex>) -> vector<8x16xindex>
      %9 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<8x16xindex>
      %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %11 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "vector.broadcast"(%14) : (index) -> vector<8x16xindex>
      %16 = "arith.addi"(%15, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %17 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x16x32xf32>) -> index
      %18 = "arith.index_cast"(%17) : (index) -> i64
      "xegpu.store"(%arg0, %18, %16, %0) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1:8 = "memref.extract_strided_metadata"(%arg1) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %2 = "vector.step"() : () -> vector<8xindex>
      %3 = "vector.step"() : () -> vector<16xindex>
      %4 = "vector.broadcast"(%1#6) : (index) -> vector<8xindex>
      %5 = "arith.muli"(%2, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %6 = "vector.shape_cast"(%5) : (vector<8xindex>) -> vector<8x1xindex>
      %7 = "vector.broadcast"(%6) : (vector<8x1xindex>) -> vector<8x16xindex>
      %8 = "vector.broadcast"(%3) : (vector<16xindex>) -> vector<8x16xindex>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %10 = "arith.muli"(%arg2, %1#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.muli"(%arg3, %1#6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%12, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "vector.broadcast"(%13) : (index) -> vector<8x16xindex>
      %15 = "arith.addi"(%14, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %16 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<?x?x?xf32>) -> index
      %17 = "arith.index_cast"(%16) : (index) -> i64
      "xegpu.store"(%arg0, %17, %15, %0) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
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
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<32x64xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<64> : vector<16xindex>}> : () -> vector<16xindex>
      %2 = "arith.constant"() <{value = 64 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "vector.step"() : () -> vector<16xindex>
      %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %6 = "vector.shape_cast"(%3) : (vector<8xindex>) -> vector<8x1xindex>
      %7 = "vector.broadcast"(%6) : (vector<8x1xindex>) -> vector<8x16xindex>
      %8 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<8x16xindex>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %10 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%arg2, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "vector.broadcast"(%11) : (index) -> vector<8x16xindex>
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %14 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<32x64xf32>) -> index
      %15 = "arith.index_cast"(%14) : (index) -> i64
      "xegpu.store"(%arg0, %15, %13, %0) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_transposed", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16x32xf32>, memref<16x32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16x32xf32>, %arg1: memref<16x32x64xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16x32xi1>}> : () -> vector<8x16x32xi1>
      %1 = "arith.constant"() <{value = dense<64> : vector<16xindex>}> : () -> vector<16xindex>
      %2 = "arith.constant"() <{value = dense<2048> : vector<8xindex>}> : () -> vector<8xindex>
      %3 = "arith.constant"() <{value = 2048 : index}> : () -> index
      %4 = "arith.constant"() <{value = 64 : index}> : () -> index
      %5 = "vector.step"() : () -> vector<8xindex>
      %6 = "vector.step"() : () -> vector<16xindex>
      %7 = "vector.step"() : () -> vector<32xindex>
      %8 = "arith.muli"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %9 = "arith.muli"(%6, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %10 = "vector.shape_cast"(%8) : (vector<8xindex>) -> vector<8x1x1xindex>
      %11 = "vector.shape_cast"(%9) : (vector<16xindex>) -> vector<1x16x1xindex>
      %12 = "vector.broadcast"(%10) : (vector<8x1x1xindex>) -> vector<8x16x32xindex>
      %13 = "vector.broadcast"(%11) : (vector<1x16x1xindex>) -> vector<8x16x32xindex>
      %14 = "vector.broadcast"(%7) : (vector<32xindex>) -> vector<8x16x32xindex>
      %15 = "arith.addi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %16 = "arith.addi"(%15, %14) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %17 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.muli"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.addi"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.addi"(%19, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "vector.broadcast"(%20) : (index) -> vector<8x16x32xindex>
      %22 = "arith.addi"(%21, %16) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %23 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<16x32x64xf32>) -> index
      %24 = "arith.index_cast"(%23) : (index) -> i64
      "xegpu.store"(%arg0, %24, %22, %0) : (vector<8x16x32xf32>, i64, vector<8x16x32xindex>, vector<8x16x32xi1>) -> ()
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
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf16>, memref<4096x4096xf16>, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %2 = "memref.subview"(%arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %3:6 = "memref.extract_strided_metadata"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "arith.muli"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%3#1, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      "xegpu.store"(%arg0, %11, %9, %0) : (vector<8xf16>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_to_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

