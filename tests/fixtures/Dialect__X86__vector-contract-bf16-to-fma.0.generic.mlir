"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x4x1x2xbf16>, memref<1x1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "brgemm_to_fma"}> ({
  ^bb0(%arg1: memref<1x4x1x2xbf16>, %arg2: memref<1x1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x4x1x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x4x1x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg2, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 8, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x1x32x2xbf16>, index, index, index, index) -> memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%12) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x4x1x2xbf16>, memref<1x1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "brgemm_to_fma_load"}> ({
  ^bb0(%arg1: memref<1x4x1x2xbf16>, %arg2: memref<1x1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x4x1x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x4x1x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg2, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 8, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x1x32x2xbf16>, index, index, index, index) -> memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%12) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x1x2xbf16>, memref<1x1x4x2xbf16>, vector<8x1xf32>) -> vector<8x1xf32>, sym_name = "brgemm_to_fma_load_bcst_B"}> ({
  ^bb0(%arg1: memref<1x32x1x2xbf16>, %arg2: memref<1x1x4x2xbf16>, %arg3: vector<8x1xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x1x4x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x1x4x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg1, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 8, 1, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x32x1x2xbf16>, index, index, index, index) -> memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<8x1xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<8x1xf32>
    "func.return"(%12) : (vector<8x1xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x4x1x2xbf16>, memref<1x1x32x2xbf16>, vector<1x1x8xf32>) -> vector<1x1x8xf32>, sym_name = "batch_matmul_fma_load"}> ({
  ^bb0(%arg1: memref<1x4x1x2xbf16>, %arg2: memref<1x1x32x2xbf16>, %arg3: vector<1x1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x4x1x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x4x1x2xbf16>, index, index, index) -> memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg2, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 8, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<1x1x32x2xbf16>, index, index, index, index) -> memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<1x1x8xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<1x1x8xf32>
    "func.return"(%12) : (vector<1x1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "matmul_outer_product_to_fma_load"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg1, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x1x2xbf16>, index, index) -> memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg1, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x1x2xbf16>, index, index) -> memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 8, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x32x2xbf16>, index, index, index) -> memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%12) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1xbf16>, memref<1x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "matmul_to_fma_flat_layout"}> ({
  ^bb0(%arg1: memref<4x1xbf16>, %arg2: memref<1x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x8xf32>
    %5 = "vector.transfer_read"(%arg3, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x8xf32>
    %6 = "vector.shape_cast"(%4) : (vector<1x8xf32>) -> vector<8xf32>
    %7 = "vector.shape_cast"(%5) : (vector<1x8xf32>) -> vector<8xf32>
    %8 = "vector.shuffle"(%6, %7) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "vector.shuffle"(%6, %7) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %10 = "memref.subview"(%arg1, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<4x1xbf16>, index, index) -> memref<1x1xbf16, strided<[1, 1], offset: ?>>
    %11 = "memref.subview"(%arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<1x32xbf16>, index, index) -> memref<1x16xbf16, strided<[32, 1], offset: ?>>
    %12 = "x86.avx.bcst_to_f32.packed"(%10) : (memref<1x1xbf16, strided<[1, 1], offset: ?>>) -> vector<8xf32>
    %13 = "x86.avx.cvt.packed.even.indexed_to_f32"(%11) : (memref<1x16xbf16, strided<[32, 1], offset: ?>>) -> vector<8xf32>
    %14 = "vector.fma"(%12, %13, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %15 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%11) : (memref<1x16xbf16, strided<[32, 1], offset: ?>>) -> vector<8xf32>
    %16 = "vector.fma"(%12, %15, %9) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %17 = "vector.shuffle"(%14, %16) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %18 = "vector.shuffle"(%14, %16) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %19 = "vector.shape_cast"(%17) : (vector<8xf32>) -> vector<1x8xf32>
    %20 = "vector.shape_cast"(%18) : (vector<8xf32>) -> vector<1x8xf32>
    "vector.transfer_write"(%19, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%20, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1xbf16>, memref<1x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "matmul_to_fma_flat_layout_load"}> ({
  ^bb0(%arg1: memref<4x1xbf16>, %arg2: memref<1x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "vector.load"(%arg3, %1, %1) : (memref<2x32xf32>, index, index) -> vector<1x8xf32>
    %4 = "vector.load"(%arg3, %1, %2) : (memref<2x32xf32>, index, index) -> vector<1x8xf32>
    %5 = "vector.shape_cast"(%3) : (vector<1x8xf32>) -> vector<8xf32>
    %6 = "vector.shape_cast"(%4) : (vector<1x8xf32>) -> vector<8xf32>
    %7 = "vector.shuffle"(%5, %6) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %8 = "vector.shuffle"(%5, %6) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "memref.subview"(%arg1, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<4x1xbf16>, index, index) -> memref<1x1xbf16, strided<[1, 1], offset: ?>>
    %10 = "memref.subview"(%arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<1x32xbf16>, index, index) -> memref<1x16xbf16, strided<[32, 1], offset: ?>>
    %11 = "x86.avx.bcst_to_f32.packed"(%9) : (memref<1x1xbf16, strided<[1, 1], offset: ?>>) -> vector<8xf32>
    %12 = "x86.avx.cvt.packed.even.indexed_to_f32"(%10) : (memref<1x16xbf16, strided<[32, 1], offset: ?>>) -> vector<8xf32>
    %13 = "vector.fma"(%11, %12, %7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %14 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%10) : (memref<1x16xbf16, strided<[32, 1], offset: ?>>) -> vector<8xf32>
    %15 = "vector.fma"(%11, %14, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %16 = "vector.shuffle"(%13, %15) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %17 = "vector.shuffle"(%13, %15) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %18 = "vector.shape_cast"(%16) : (vector<8xf32>) -> vector<1x8xf32>
    %19 = "vector.shape_cast"(%17) : (vector<8xf32>) -> vector<1x8xf32>
    "vector.store"(%18, %arg3, %1, %1) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.store"(%19, %arg3, %1, %2) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x32xbf16>, memref<16x32x64xbf16>, memref<64x64xf32>) -> memref<64x64xf32>, sym_name = "matmul_to_fma_flat_layout_loop"}> ({
  ^bb0(%arg1: memref<16x64x32xbf16>, %arg2: memref<16x32x64xbf16>, %arg3: memref<64x64xf32>):
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %4, %5) ({
      ^bb0(%arg5: index):
        %8 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16>, static_strides = array<i64: 1, 1>}> : (memref<64x64xf32>, index, index) -> memref<1x16xf32, strided<[64, 1], offset: ?>>
        %9 = "vector.transfer_read"(%8, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x16xf32, strided<[64, 1], offset: ?>>, index, index, f32) -> vector<1x8xf32>
        %10 = "vector.transfer_read"(%8, %3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x16xf32, strided<[64, 1], offset: ?>>, index, index, f32) -> vector<1x8xf32>
        %11 = "vector.shape_cast"(%9) : (vector<1x8xf32>) -> vector<8xf32>
        %12 = "vector.shape_cast"(%10) : (vector<1x8xf32>) -> vector<8xf32>
        %13 = "vector.shuffle"(%11, %12) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
        %14 = "vector.shuffle"(%11, %12) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
        %15 = "vector.shape_cast"(%13) : (vector<8xf32>) -> vector<1x8xf32>
        %16 = "vector.shape_cast"(%14) : (vector<8xf32>) -> vector<1x8xf32>
        %17:2 = "scf.for"(%3, %5, %7, %15, %16) ({
        ^bb0(%arg6: index, %arg7: vector<1x8xf32>, %arg8: vector<1x8xf32>):
          %24:2 = "scf.for"(%3, %6, %7, %arg7, %arg8) ({
          ^bb0(%arg9: index, %arg10: vector<1x8xf32>, %arg11: vector<1x8xf32>):
            %25 = "memref.subview"(%arg1, %arg6, %arg4, %arg9) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x32xbf16>, index, index, index) -> memref<1x1x1xbf16, strided<[2048, 32, 1], offset: ?>>
            %26 = "memref.subview"(%arg2, %arg6, %arg9, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 16>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x32x64xbf16>, index, index, index) -> memref<1x1x16xbf16, strided<[2048, 64, 1], offset: ?>>
            %27 = "vector.shape_cast"(%arg10) : (vector<1x8xf32>) -> vector<8xf32>
            %28 = "x86.avx.bcst_to_f32.packed"(%25) : (memref<1x1x1xbf16, strided<[2048, 32, 1], offset: ?>>) -> vector<8xf32>
            %29 = "x86.avx.cvt.packed.even.indexed_to_f32"(%26) : (memref<1x1x16xbf16, strided<[2048, 64, 1], offset: ?>>) -> vector<8xf32>
            %30 = "vector.fma"(%28, %29, %27) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
            %31 = "vector.shape_cast"(%30) : (vector<8xf32>) -> vector<1x8xf32>
            %32 = "vector.shape_cast"(%arg11) : (vector<1x8xf32>) -> vector<8xf32>
            %33 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%26) : (memref<1x1x16xbf16, strided<[2048, 64, 1], offset: ?>>) -> vector<8xf32>
            %34 = "vector.fma"(%28, %33, %32) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
            %35 = "vector.shape_cast"(%34) : (vector<8xf32>) -> vector<1x8xf32>
            "scf.yield"(%31, %35) : (vector<1x8xf32>, vector<1x8xf32>) -> ()
          }) : (index, index, index, vector<1x8xf32>, vector<1x8xf32>) -> (vector<1x8xf32>, vector<1x8xf32>)
          "scf.yield"(%24#0, %24#1) : (vector<1x8xf32>, vector<1x8xf32>) -> ()
        }) : (index, index, index, vector<1x8xf32>, vector<1x8xf32>) -> (vector<1x8xf32>, vector<1x8xf32>)
        %18 = "vector.shape_cast"(%17#0) : (vector<1x8xf32>) -> vector<8xf32>
        %19 = "vector.shape_cast"(%17#1) : (vector<1x8xf32>) -> vector<8xf32>
        %20 = "vector.shuffle"(%18, %19) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
        %21 = "vector.shuffle"(%18, %19) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
        %22 = "vector.shape_cast"(%20) : (vector<8xf32>) -> vector<1x8xf32>
        %23 = "vector.shape_cast"(%21) : (vector<8xf32>) -> vector<1x8xf32>
        "vector.transfer_write"(%23, %8, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xf32>, memref<1x16xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%22, %8, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xf32>, memref<1x16xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg3) : (memref<64x64xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x1xbf16>, memref<1x4xbf16>, memref<32x4xf32>) -> memref<32x4xf32>, sym_name = "matmul_to_fma_flat_layout_bcstB"}> ({
  ^bb0(%arg1: memref<32x1xbf16>, %arg2: memref<1x4xbf16>, %arg3: memref<32x4xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x4xf32>, index, index, f32) -> vector<8x1xf32>
    %5 = "vector.transfer_read"(%arg3, %2, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x4xf32>, index, index, f32) -> vector<8x1xf32>
    %6 = "vector.shape_cast"(%4) : (vector<8x1xf32>) -> vector<8xf32>
    %7 = "vector.shape_cast"(%5) : (vector<8x1xf32>) -> vector<8xf32>
    %8 = "vector.shuffle"(%6, %7) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "vector.shuffle"(%6, %7) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %10 = "memref.subview"(%arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (memref<1x4xbf16>, index, index) -> memref<1x1xbf16, strided<[4, 1], offset: ?>>
    %11 = "memref.subview"(%arg1, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 1>, static_strides = array<i64: 1, 1>}> : (memref<32x1xbf16>, index, index) -> memref<16x1xbf16, strided<[1, 1], offset: ?>>
    %12 = "x86.avx.bcst_to_f32.packed"(%10) : (memref<1x1xbf16, strided<[4, 1], offset: ?>>) -> vector<8xf32>
    %13 = "x86.avx.cvt.packed.even.indexed_to_f32"(%11) : (memref<16x1xbf16, strided<[1, 1], offset: ?>>) -> vector<8xf32>
    %14 = "vector.fma"(%12, %13, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %15 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%11) : (memref<16x1xbf16, strided<[1, 1], offset: ?>>) -> vector<8xf32>
    %16 = "vector.fma"(%12, %15, %9) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %17 = "vector.shuffle"(%14, %16) <{mask = array<i64: 0, 8, 1, 9, 2, 10, 3, 11>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %18 = "vector.shuffle"(%14, %16) <{mask = array<i64: 4, 12, 5, 13, 6, 14, 7, 15>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %19 = "vector.shape_cast"(%17) : (vector<8xf32>) -> vector<8x1xf32>
    %20 = "vector.shape_cast"(%18) : (vector<8xf32>) -> vector<8x1xf32>
    "vector.transfer_write"(%19, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x1xf32>, memref<32x4xf32>, index, index) -> ()
    "vector.transfer_write"(%20, %arg3, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x1xf32>, memref<32x4xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x4xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>, index) -> vector<1x8xf32>, sym_name = "matmul_dynamic_offset"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg1, %arg4, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x1x2xbf16>, index, index) -> memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg1, %arg4, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<4x1x2xbf16>, index, index) -> memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 8, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x32x2xbf16>, index, index, index) -> memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%12) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x1x2xbf16>, memref<1x4x2xbf16>, vector<8x1xf32>) -> vector<8x1xf32>, sym_name = "matmul_to_fma_load_bcst_B"}> ({
  ^bb0(%arg1: memref<32x1x2xbf16>, %arg2: memref<1x4x2xbf16>, %arg3: vector<8x1xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x4x2xbf16>, index, index) -> memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x4x2xbf16>, index, index) -> memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 1, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<32x1x2xbf16>, index, index, index) -> memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<8x1xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<8x1xf32>
    "func.return"(%12) : (vector<8x1xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x4x1x2xbf16>, memref<1x1x1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "many_dimensions"}> ({
  ^bb0(%arg1: memref<1x1x4x1x2xbf16>, %arg2: memref<1x1x1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.subview"(%arg1, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, 1>, static_sizes = array<i64: 1, 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (memref<1x1x4x1x2xbf16>, index, index, index, index) -> memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>>
    %3 = "memref.subview"(%arg1, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (memref<1x1x4x1x2xbf16>, index, index, index, index) -> memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>>
    %4 = "memref.subview"(%arg2, %1, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 5, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 1, 8, 2>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (memref<1x1x1x32x2xbf16>, index, index, index, index, index) -> memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>>
    %5 = "vector.shape_cast"(%arg3) : (vector<1x8xf32>) -> vector<8xf32>
    %6 = "x86.avx.bcst_to_f32.packed"(%2) : (memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%4) : (memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %8 = "vector.fma"(%6, %7, %5) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "x86.avx.bcst_to_f32.packed"(%3) : (memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>>) -> vector<8xf32>
    %10 = "x86.avx.cvt.packed.even.indexed_to_f32"(%4) : (memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>>) -> vector<8xf32>
    %11 = "vector.fma"(%9, %10, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "vector.shape_cast"(%11) : (vector<8xf32>) -> vector<1x8xf32>
    "func.return"(%12) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1xbf16>, memref<1x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "negative_multiple_vc_users_flat"}> ({
  ^bb0(%arg1: memref<4x1xbf16>, %arg2: memref<1x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "vector.load"(%arg1, %1, %1) : (memref<4x1xbf16>, index, index) -> vector<1x1xbf16>
    %5 = "vector.load"(%arg2, %1, %1) : (memref<1x32xbf16>, index, index) -> vector<1x8xbf16>
    %6 = "vector.load"(%arg2, %1, %2) : (memref<1x32xbf16>, index, index) -> vector<1x8xbf16>
    %7 = "vector.load"(%arg3, %1, %1) : (memref<2x32xf32>, index, index) -> vector<1x8xf32>
    %8 = "vector.load"(%arg3, %1, %2) : (memref<2x32xf32>, index, index) -> vector<1x8xf32>
    %9 = "vector.contract"(%4, %5, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x8xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    %10 = "vector.contract"(%4, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x8xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "vector.store"(%9, %arg3, %1, %1) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.store"(%10, %arg3, %1, %2) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    %11 = "arith.addf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (vector<1x8xf32>, vector<1x8xf32>) -> vector<1x8xf32>
    "vector.store"(%11, %arg3, %1, %3) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x1x2xbf16>, tensor<1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "negative_tensor_type"}> ({
  ^bb0(%arg1: tensor<4x1x2xbf16>, %arg2: tensor<1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "vector.transfer_read"(%arg1, %2, %2, %2, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (tensor<4x1x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
    %5 = "vector.transfer_read"(%arg2, %2, %3, %2, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (tensor<1x32x2xbf16>, index, index, index, bf16) -> vector<1x8x2xbf16>
    %6 = "vector.contract"(%4, %5, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%6) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1xbf16>, memref<1x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "negative_offset_diff_is_not_8"}> ({
  ^bb0(%arg1: memref<4x1xbf16>, %arg2: memref<1x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<4x1xbf16>, index, index) -> vector<1x1xbf16>
    %4 = "vector.load"(%arg2, %1, %1) : (memref<1x32xbf16>, index, index) -> vector<1x8xbf16>
    %5 = "vector.load"(%arg2, %1, %2) : (memref<1x32xbf16>, index, index) -> vector<1x8xbf16>
    %6 = "vector.load"(%arg3, %1, %1) : (memref<2x32xf32>, index, index) -> vector<1x8xf32>
    %7 = "vector.load"(%arg3, %1, %2) : (memref<2x32xf32>, index, index) -> vector<1x8xf32>
    %8 = "vector.contract"(%3, %4, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x8xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    %9 = "vector.contract"(%3, %5, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x8xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "vector.store"(%8, %arg3, %1, %1) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.store"(%9, %arg3, %1, %2) : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1xbf16>, memref<1x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "negative_vector_contracts_not_in_order"}> ({
  ^bb0(%arg1: memref<4x1xbf16>, %arg2: memref<1x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x1xbf16>, index, index, bf16) -> vector<1x1xbf16>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x32xbf16>, index, index, bf16) -> vector<1x8xbf16>
    %7 = "vector.transfer_read"(%arg2, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x32xbf16>, index, index, bf16) -> vector<1x8xbf16>
    %8 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x8xf32>
    %9 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x8xf32>
    %10 = "vector.contract"(%5, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x8xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    %11 = "vector.contract"(%5, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x8xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "vector.transfer_write"(%11, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%10, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x1xbf16>, memref<1x4xbf16>, memref<32x4xf32>, index) -> memref<32x4xf32>, sym_name = "negative_flat_layout_dynamic_index"}> ({
  ^bb0(%arg1: memref<32x1xbf16>, %arg2: memref<1x4xbf16>, %arg3: memref<32x4xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x1xbf16>, index, index, bf16) -> vector<8x1xbf16>
    %6 = "vector.transfer_read"(%arg1, %arg4, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x1xbf16>, index, index, bf16) -> vector<8x1xbf16>
    %7 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x4xbf16>, index, index, bf16) -> vector<1x1xbf16>
    %8 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x4xf32>, index, index, f32) -> vector<8x1xf32>
    %9 = "vector.transfer_read"(%arg3, %2, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x4xf32>, index, index, f32) -> vector<8x1xf32>
    %10 = "vector.contract"(%5, %7, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x1xbf16>, vector<1x1xbf16>, vector<8x1xf32>) -> vector<8x1xf32>
    %11 = "vector.contract"(%6, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x1xbf16>, vector<1x1xbf16>, vector<8x1xf32>) -> vector<8x1xf32>
    "vector.transfer_write"(%10, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x1xf32>, memref<32x4xf32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x1xf32>, memref<32x4xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x4xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x2xbf16>, memref<2x4xbf16>, memref<32x4xf32>) -> memref<32x4xf32>, sym_name = "negative_non_unit_K_dim"}> ({
  ^bb0(%arg1: memref<32x2xbf16>, %arg2: memref<2x4xbf16>, %arg3: memref<32x4xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x2xbf16>, index, index, bf16) -> vector<8x2xbf16>
    %6 = "vector.transfer_read"(%arg1, %2, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x2xbf16>, index, index, bf16) -> vector<8x2xbf16>
    %7 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x4xbf16>, index, index, bf16) -> vector<2x1xbf16>
    %8 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x4xf32>, index, index, f32) -> vector<8x1xf32>
    %9 = "vector.transfer_read"(%arg3, %2, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x4xf32>, index, index, f32) -> vector<8x1xf32>
    %10 = "vector.contract"(%5, %7, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x2xbf16>, vector<2x1xbf16>, vector<8x1xf32>) -> vector<8x1xf32>
    %11 = "vector.contract"(%6, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x2xbf16>, vector<2x1xbf16>, vector<8x1xf32>) -> vector<8x1xf32>
    "vector.transfer_write"(%10, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x1xf32>, memref<32x4xf32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x1xf32>, memref<32x4xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x4xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xf32>) -> vector<1x1x16xf32>, sym_name = "negative_no_memref_src"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x16x2xbf16>, %arg3: vector<1x1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xf32>) -> vector<1x1x16xf32>
    "func.return"(%1) : (vector<1x1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "negative_non_zero_vnni_offset"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1, %1) : (memref<4x1x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %2) : (memref<1x32x2xbf16>, index, index, index) -> vector<1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "negative_perm_map_not_identity"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<4x1x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
    %4 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x2xbf16>, index, index, index, bf16) -> vector<1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "negative_non_unit_stride"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "memref.subview"(%arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16, 2>, static_strides = array<i64: 1, 1, 2>}> : (memref<1x32x2xbf16>, index, index, index) -> memref<1x16x2xbf16, strided<[64, 2, 2], offset: ?>>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<4x1x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
    %5 = "vector.transfer_read"(%3, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x16x2xbf16, strided<[64, 2, 2], offset: ?>>, index, index, index, bf16) -> vector<1x8x2xbf16>
    %6 = "vector.contract"(%4, %5, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%6) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>, index) -> vector<1x8xf32>, sym_name = "negative_out_of_bound"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.transfer_read"(%arg1, %1, %arg4, %1, %2) <{in_bounds = [true, false, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<4x1x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
    %4 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x2xbf16>, index, index, index, bf16) -> vector<1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>, index) -> vector<1x8xf32>, sym_name = "negative_no_dynamic_vnni_offset"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.load"(%arg1, %1, %1, %arg4) : (memref<4x1x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %3 = "vector.load"(%arg2, %1, %1, %1) : (memref<1x32x2xbf16>, index, index, index) -> vector<1x8x2xbf16>
    %4 = "vector.contract"(%2, %3, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%4) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

