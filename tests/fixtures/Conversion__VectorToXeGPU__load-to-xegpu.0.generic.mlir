"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>, sym_name = "load_1D_vector"}> ({
  ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<8x16x32xf32>, index, index) -> memref<32xf32, strided<[1], offset: ?>>
    %2:4 = "memref.extract_strided_metadata"(%1) : (memref<32xf32, strided<[1], offset: ?>>) -> (memref<f32>, index, index, index)
    %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f32>) -> index
    %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.index_cast"(%5) : (index) -> i64
    %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 32>, const_strides = array<i64: 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
    %8 = "xegpu.load_nd"(%7, %arg1) <{const_offsets = array<i64: -9223372036854775808>}> : (!xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>, index) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8x16xf32>, sym_name = "load_2D_vector"}> ({
  ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "memref.subview"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, 16, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<8x16x32xf32>, index) -> memref<16x32xf32, strided<[32, 1], offset: ?>>
    %2:6 = "memref.extract_strided_metadata"(%1) : (memref<16x32xf32, strided<[32, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
    %3 = "memref.extract_aligned_pointer_as_index"(%2#0) : (memref<f32>) -> index
    %4 = "arith.muli"(%2#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.index_cast"(%5) : (index) -> i64
    %7 = "xegpu.create_nd_tdesc"(%6) <{const_offsets = array<i64>, const_shape = array<i64: 16, 32>, const_strides = array<i64: 32, 1>, operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (i64) -> !xegpu.tensor_desc<8x16xf32>
    %8 = "xegpu.load_nd"(%7, %arg1, %arg1) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32>, index, index) -> vector<8x16xf32>
    "func.return"(%8) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, index, index, index) -> vector<8x16xf32>, sym_name = "load_dynamic_source"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
    %2 = "memref.subview"(%arg0, %arg1, %1#3, %1#4) <{operandSegmentSizes = array<i32: 1, 1, 2, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (memref<?x?x?xf32>, index, index, index) -> memref<?x?xf32, strided<[?, 1], offset: ?>>
    %3:6 = "memref.extract_strided_metadata"(%2) : (memref<?x?xf32, strided<[?, 1], offset: ?>>) -> (memref<f32>, index, index, index, index, index)
    %4 = "memref.extract_aligned_pointer_as_index"(%3#0) : (memref<f32>) -> index
    %5 = "arith.muli"(%3#1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.index_cast"(%6) : (index) -> i64
    %8 = "xegpu.create_nd_tdesc"(%7, %3#2, %3#3, %3#4) <{const_offsets = array<i64>, const_shape = array<i64: -9223372036854775808, -9223372036854775808>, const_strides = array<i64: -9223372036854775808, 1>, operandSegmentSizes = array<i32: 1, 0, 2, 1>}> : (i64, index, index, index) -> !xegpu.tensor_desc<8x16xf32>
    %9 = "xegpu.load_nd"(%8, %arg2, %arg3) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32>, index, index) -> vector<8x16xf32>
    "func.return"(%9) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<7x15xf32>, index) -> vector<8x16xf32>, sym_name = "load_out_of_bounds"}> ({
  ^bb0(%arg0: memref<7x15xf32>, %arg1: index):
    %0 = "xegpu.create_nd_tdesc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<7x15xf32>) -> !xegpu.tensor_desc<8x16xf32>
    %1 = "xegpu.load_nd"(%0, %arg1, %arg1) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.tensor_desc<8x16xf32>, index, index) -> vector<8x16xf32>
    "func.return"(%1) : (vector<8x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x64xf32>, index) -> vector<8x16x32xf32>, sym_name = "no_load_high_dim_vector"}> ({
  ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1, %arg1, %arg1) : (memref<16x32x64xf32>, index, index, index) -> vector<8x16x32xf32>
    "func.return"(%0) : (vector<8x16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xf32>, index) -> vector<f32>, sym_name = "no_load_zero_dim_vector"}> ({
  ^bb0(%arg0: memref<64xf32>, %arg1: index):
    %0 = "vector.load"(%arg0, %arg1) : (memref<64xf32>, index) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

