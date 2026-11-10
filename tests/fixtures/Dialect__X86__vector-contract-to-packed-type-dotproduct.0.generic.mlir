"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "brgemm_to_bf16dp"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x16x2xbf16>, %arg3: vector<1x16xf32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x16xf32>) -> vector<16xf32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x1x16x2xbf16>) -> vector<32xbf16>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x1x2xbf16>) -> vector<2xbf16>
    %4 = "vector.bitcast"(%3) : (vector<2xbf16>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<16xi32>
    %6 = "vector.bitcast"(%5) : (vector<16xi32>) -> vector<32xbf16>
    %7 = "x86.avx512.dot"(%1, %6, %2) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %8 = "vector.shape_cast"(%7) : (vector<16xf32>) -> vector<1x16xf32>
    "func.return"(%8) : (vector<1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16x1x2xbf16>, vector<1x1x1x2xbf16>, vector<16x1xf32>) -> vector<16x1xf32>, sym_name = "brgemm_to_bf16dp_bcst_B"}> ({
  ^bb0(%arg1: vector<1x16x1x2xbf16>, %arg2: vector<1x1x1x2xbf16>, %arg3: vector<16x1xf32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<16x1xf32>) -> vector<16xf32>
    %2 = "vector.shape_cast"(%arg1) : (vector<1x16x1x2xbf16>) -> vector<32xbf16>
    %3 = "vector.shape_cast"(%arg2) : (vector<1x1x1x2xbf16>) -> vector<2xbf16>
    %4 = "vector.bitcast"(%3) : (vector<2xbf16>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<16xi32>
    %6 = "vector.bitcast"(%5) : (vector<16xi32>) -> vector<32xbf16>
    %7 = "x86.avx512.dot"(%1, %6, %2) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %8 = "vector.shape_cast"(%7) : (vector<16xf32>) -> vector<16x1xf32>
    "func.return"(%8) : (vector<16x1xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x16x4xi8>, vector<1x16xi32>) -> vector<1x16xi32>, sym_name = "brgemm_to_avx10int8dp"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x16x4xi8>, %arg3: vector<1x16xi32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x16xi32>) -> vector<16xi32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x1x16x4xi8>) -> vector<64xi8>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x1x4xi8>) -> vector<4xi8>
    %4 = "vector.bitcast"(%3) : (vector<4xi8>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<16xi32>
    %6 = "vector.bitcast"(%5) : (vector<16xi32>) -> vector<64xi8>
    %7 = "x86.avx10.dot.i8"(%1, %6, %2) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
    %8 = "vector.shape_cast"(%7) : (vector<16xi32>) -> vector<1x16xi32>
    "func.return"(%8) : (vector<1x16xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x16x1x4xi8>, vector<1x1x1x4xi8>, vector<1x16x1xi32>) -> vector<1x16x1xi32>, sym_name = "batch_matmul_avx10int8dp_bcst_B"}> ({
  ^bb0(%arg1: vector<1x16x1x4xi8>, %arg2: vector<1x1x1x4xi8>, %arg3: vector<1x16x1xi32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x16x1xi32>) -> vector<16xi32>
    %2 = "vector.shape_cast"(%arg1) : (vector<1x16x1x4xi8>) -> vector<64xi8>
    %3 = "vector.shape_cast"(%arg2) : (vector<1x1x1x4xi8>) -> vector<4xi8>
    %4 = "vector.bitcast"(%3) : (vector<4xi8>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<16xi32>
    %6 = "vector.bitcast"(%5) : (vector<16xi32>) -> vector<64xi8>
    %7 = "x86.avx10.dot.i8"(%1, %6, %2) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
    %8 = "vector.shape_cast"(%7) : (vector<16xi32>) -> vector<1x16x1xi32>
    "func.return"(%8) : (vector<1x16x1xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>, sym_name = "brgemm_to_int8dp"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x8x4xi8>, %arg3: vector<1x8xi32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x8xi32>) -> vector<8xi32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x1x8x4xi8>) -> vector<32xi8>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x1x4xi8>) -> vector<4xi8>
    %4 = "vector.bitcast"(%3) : (vector<4xi8>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<8xi32>
    %6 = "vector.bitcast"(%5) : (vector<8xi32>) -> vector<32xi8>
    %7 = "x86.avx.dot.i8"(%1, %6, %2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    %8 = "vector.shape_cast"(%7) : (vector<8xi32>) -> vector<1x8xi32>
    "func.return"(%8) : (vector<1x8xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xf32>) -> vector<1x1x16xf32>, sym_name = "batch_matmul_bf16dp"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x16x2xbf16>, %arg3: vector<1x1x16xf32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x1x16xf32>) -> vector<16xf32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x1x16x2xbf16>) -> vector<32xbf16>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x1x2xbf16>) -> vector<2xbf16>
    %4 = "vector.bitcast"(%3) : (vector<2xbf16>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<16xi32>
    %6 = "vector.bitcast"(%5) : (vector<16xi32>) -> vector<32xbf16>
    %7 = "x86.avx512.dot"(%1, %6, %2) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %8 = "vector.shape_cast"(%7) : (vector<16xf32>) -> vector<1x1x16xf32>
    "func.return"(%8) : (vector<1x1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x1x8xi32>) -> vector<1x1x8xi32>, sym_name = "batch_matmul_int8dp"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x8x4xi8>, %arg3: vector<1x1x8xi32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x1x8xi32>) -> vector<8xi32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x1x8x4xi8>) -> vector<32xi8>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x1x4xi8>) -> vector<4xi8>
    %4 = "vector.bitcast"(%3) : (vector<4xi8>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<8xi32>
    %6 = "vector.bitcast"(%5) : (vector<8xi32>) -> vector<32xi8>
    %7 = "x86.avx.dot.i8"(%1, %6, %2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    %8 = "vector.shape_cast"(%7) : (vector<8xi32>) -> vector<1x1x8xi32>
    "func.return"(%8) : (vector<1x1x8xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x8x1x4xi8>, vector<1x1x1x4xi8>, vector<1x8x1xi32>) -> vector<1x8x1xi32>, sym_name = "batch_matmul_int8dp_bcst_B"}> ({
  ^bb0(%arg1: vector<1x8x1x4xi8>, %arg2: vector<1x1x1x4xi8>, %arg3: vector<1x8x1xi32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x8x1xi32>) -> vector<8xi32>
    %2 = "vector.shape_cast"(%arg1) : (vector<1x8x1x4xi8>) -> vector<32xi8>
    %3 = "vector.shape_cast"(%arg2) : (vector<1x1x1x4xi8>) -> vector<4xi8>
    %4 = "vector.bitcast"(%3) : (vector<4xi8>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<8xi32>
    %6 = "vector.bitcast"(%5) : (vector<8xi32>) -> vector<32xi8>
    %7 = "x86.avx.dot.i8"(%1, %6, %2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    %8 = "vector.shape_cast"(%7) : (vector<8xi32>) -> vector<1x8x1xi32>
    "func.return"(%8) : (vector<1x8x1xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x2xbf16>, vector<1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "matmul_outer_product_to_bf16dp"}> ({
  ^bb0(%arg1: vector<1x1x2xbf16>, %arg2: vector<1x16x2xbf16>, %arg3: vector<1x16xf32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x16xf32>) -> vector<16xf32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x16x2xbf16>) -> vector<32xbf16>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x2xbf16>) -> vector<2xbf16>
    %4 = "vector.bitcast"(%3) : (vector<2xbf16>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<16xi32>
    %6 = "vector.bitcast"(%5) : (vector<16xi32>) -> vector<32xbf16>
    %7 = "x86.avx512.dot"(%1, %6, %2) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %8 = "vector.shape_cast"(%7) : (vector<16xf32>) -> vector<1x16xf32>
    "func.return"(%8) : (vector<1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x4xi8>, vector<1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>, sym_name = "matmul_outer_product_to_int8dp"}> ({
  ^bb0(%arg1: vector<1x1x4xi8>, %arg2: vector<1x8x4xi8>, %arg3: vector<1x8xi32>):
    %1 = "vector.shape_cast"(%arg3) : (vector<1x8xi32>) -> vector<8xi32>
    %2 = "vector.shape_cast"(%arg2) : (vector<1x8x4xi8>) -> vector<32xi8>
    %3 = "vector.shape_cast"(%arg1) : (vector<1x1x4xi8>) -> vector<4xi8>
    %4 = "vector.bitcast"(%3) : (vector<4xi8>) -> vector<1xi32>
    %5 = "vector.broadcast"(%4) : (vector<1xi32>) -> vector<8xi32>
    %6 = "vector.bitcast"(%5) : (vector<8xi32>) -> vector<32xi8>
    %7 = "x86.avx.dot.i8"(%1, %6, %2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    %8 = "vector.shape_cast"(%7) : (vector<8xi32>) -> vector<1x8xi32>
    "func.return"(%8) : (vector<1x8xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "matmul_bf16dp_flat_layout"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %6 = "vector.transfer_read"(%arg1, %2, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %7 = "vector.transfer_read"(%arg3, %2, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %8 = "vector.transfer_read"(%arg3, %2, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %9 = "vector.shape_cast"(%7) : (vector<1x16xf32>) -> vector<16xf32>
    %10 = "vector.shape_cast"(%8) : (vector<1x16xf32>) -> vector<16xf32>
    %11 = "vector.shuffle"(%9, %10) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %12 = "vector.shuffle"(%9, %10) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %13 = "vector.transfer_read"(%arg2, %2, %2, %4) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<2x32xbf16>, index, index, bf16) -> vector<32xbf16>
    %14 = "vector.transfer_read"(%arg2, %1, %2, %4) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<2x32xbf16>, index, index, bf16) -> vector<32xbf16>
    %15 = "vector.shuffle"(%13, %14) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %16 = "vector.shuffle"(%13, %14) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %17 = "vector.shape_cast"(%6) : (vector<1x2xbf16>) -> vector<2xbf16>
    %18 = "vector.bitcast"(%17) : (vector<2xbf16>) -> vector<1xi32>
    %19 = "vector.broadcast"(%18) : (vector<1xi32>) -> vector<16xi32>
    %20 = "vector.bitcast"(%19) : (vector<16xi32>) -> vector<32xbf16>
    %21 = "x86.avx512.dot"(%11, %20, %15) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %22 = "x86.avx512.dot"(%12, %20, %16) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %23 = "vector.shuffle"(%21, %22) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %24 = "vector.shuffle"(%21, %22) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %25 = "vector.shape_cast"(%23) : (vector<16xf32>) -> vector<1x16xf32>
    %26 = "vector.shape_cast"(%24) : (vector<16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%25, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%26, %arg3, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xi8>, memref<4x64xi8>, memref<4x64xi32>) -> memref<4x64xi32>, sym_name = "matmul_i8_avx10dp_flat_layout"}> ({
  ^bb0(%arg1: memref<4x4xi8>, %arg2: memref<4x64xi8>, %arg3: memref<4x64xi32>):
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %6 = "vector.transfer_read"(%arg1, %2, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xi8>, index, index, i8) -> vector<1x4xi8>
    %7 = "vector.transfer_read"(%arg3, %2, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x16xi32>
    %8 = "vector.transfer_read"(%arg3, %2, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x16xi32>
    %9 = "vector.shape_cast"(%7) : (vector<1x16xi32>) -> vector<16xi32>
    %10 = "vector.shape_cast"(%8) : (vector<1x16xi32>) -> vector<16xi32>
    %11 = "vector.shuffle"(%9, %10) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
    %12 = "vector.shuffle"(%9, %10) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
    %13 = "vector.transfer_read"(%arg2, %2, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<2x32xi8>
    %14 = "vector.shape_cast"(%13) : (vector<2x32xi8>) -> vector<64xi8>
    %15 = "vector.transfer_read"(%arg2, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<2x32xi8>
    %16 = "vector.shape_cast"(%15) : (vector<2x32xi8>) -> vector<64xi8>
    %17 = "vector.shuffle"(%14, %16) <{mask = array<i64: 0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
    %18 = "vector.shuffle"(%14, %16) <{mask = array<i64: 4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
    %19 = "vector.shape_cast"(%6) : (vector<1x4xi8>) -> vector<4xi8>
    %20 = "vector.bitcast"(%19) : (vector<4xi8>) -> vector<1xi32>
    %21 = "vector.broadcast"(%20) : (vector<1xi32>) -> vector<16xi32>
    %22 = "vector.bitcast"(%21) : (vector<16xi32>) -> vector<64xi8>
    %23 = "x86.avx10.dot.i8"(%11, %22, %17) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
    %24 = "x86.avx10.dot.i8"(%12, %22, %18) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
    %25 = "vector.shuffle"(%23, %24) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
    %26 = "vector.shuffle"(%23, %24) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
    %27 = "vector.shape_cast"(%25) : (vector<16xi32>) -> vector<1x16xi32>
    %28 = "vector.shape_cast"(%26) : (vector<16xi32>) -> vector<1x16xi32>
    "vector.transfer_write"(%27, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<4x64xi32>, index, index) -> ()
    "vector.transfer_write"(%28, %arg3, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<4x64xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<4x64xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xi8>, memref<4x64xi8>, memref<4x64xi32>) -> memref<4x64xi32>, sym_name = "matmul_i8_avx2dp_flat_layout"}> ({
  ^bb0(%arg1: memref<4x4xi8>, %arg2: memref<4x64xi8>, %arg3: memref<4x64xi32>):
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %6 = "vector.transfer_read"(%arg1, %2, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xi8>, index, index, i8) -> vector<1x4xi8>
    %7 = "vector.transfer_read"(%arg3, %2, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x8xi32>
    %8 = "vector.transfer_read"(%arg3, %2, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x8xi32>
    %9 = "vector.shape_cast"(%7) : (vector<1x8xi32>) -> vector<8xi32>
    %10 = "vector.shape_cast"(%8) : (vector<1x8xi32>) -> vector<8xi32>
    %11 = "vector.shuffle"(%9, %10) <{mask = array<i64: 0, 1, 2, 3, 8, 9, 10, 11>}> : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %12 = "vector.shuffle"(%9, %10) <{mask = array<i64: 4, 5, 6, 7, 12, 13, 14, 15>}> : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %13 = "vector.transfer_read"(%arg2, %2, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<2x16xi8>
    %14 = "vector.shape_cast"(%13) : (vector<2x16xi8>) -> vector<32xi8>
    %15 = "vector.transfer_read"(%arg2, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<2x16xi8>
    %16 = "vector.shape_cast"(%15) : (vector<2x16xi8>) -> vector<32xi8>
    %17 = "vector.shuffle"(%14, %16) <{mask = array<i64: 0, 16, 32, 48, 1, 17, 33, 49, 2, 18, 34, 50, 3, 19, 35, 51, 8, 24, 40, 56, 9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59>}> : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
    %18 = "vector.shuffle"(%14, %16) <{mask = array<i64: 4, 20, 36, 52, 5, 21, 37, 53, 6, 22, 38, 54, 7, 23, 39, 55, 12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63>}> : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
    %19 = "vector.shape_cast"(%6) : (vector<1x4xi8>) -> vector<4xi8>
    %20 = "vector.bitcast"(%19) : (vector<4xi8>) -> vector<1xi32>
    %21 = "vector.broadcast"(%20) : (vector<1xi32>) -> vector<8xi32>
    %22 = "vector.bitcast"(%21) : (vector<8xi32>) -> vector<32xi8>
    %23 = "x86.avx.dot.i8"(%11, %22, %17) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    %24 = "x86.avx.dot.i8"(%12, %22, %18) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    %25 = "vector.shuffle"(%23, %24) <{mask = array<i64: 0, 1, 2, 3, 8, 9, 10, 11>}> : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %26 = "vector.shuffle"(%23, %24) <{mask = array<i64: 4, 5, 6, 7, 12, 13, 14, 15>}> : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %27 = "vector.shape_cast"(%25) : (vector<8xi32>) -> vector<1x8xi32>
    %28 = "vector.shape_cast"(%26) : (vector<8xi32>) -> vector<1x8xi32>
    "vector.transfer_write"(%27, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xi32>, memref<4x64xi32>, index, index) -> ()
    "vector.transfer_write"(%28, %arg3, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xi32>, memref<4x64xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<4x64xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x32xbf16>, memref<2x32xf32>, index) -> memref<2x32xf32>, sym_name = "matmul_bf16dp_flat_layout_offset_args_and_read_after_vc"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x32xbf16>, %arg3: memref<2x32xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %6 = "vector.transfer_read"(%arg1, %2, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %7 = "vector.transfer_read"(%arg3, %2, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %8 = "vector.transfer_read"(%arg3, %2, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %9 = "vector.shape_cast"(%7) : (vector<1x16xf32>) -> vector<16xf32>
    %10 = "vector.shape_cast"(%8) : (vector<1x16xf32>) -> vector<16xf32>
    %11 = "vector.shuffle"(%9, %10) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %12 = "vector.shuffle"(%9, %10) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %13 = "vector.transfer_read"(%arg2, %arg4, %2, %4) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<2x32xbf16>, index, index, bf16) -> vector<32xbf16>
    %14 = "arith.addi"(%arg4, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "vector.transfer_read"(%arg2, %14, %2, %4) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<2x32xbf16>, index, index, bf16) -> vector<32xbf16>
    %16 = "vector.shuffle"(%13, %15) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %17 = "vector.shuffle"(%13, %15) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %18 = "vector.shape_cast"(%6) : (vector<1x2xbf16>) -> vector<2xbf16>
    %19 = "vector.bitcast"(%18) : (vector<2xbf16>) -> vector<1xi32>
    %20 = "vector.broadcast"(%19) : (vector<1xi32>) -> vector<16xi32>
    %21 = "vector.bitcast"(%20) : (vector<16xi32>) -> vector<32xbf16>
    %22 = "x86.avx512.dot"(%11, %21, %16) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %23 = "x86.avx512.dot"(%12, %21, %17) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %24 = "vector.shuffle"(%22, %23) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %25 = "vector.shuffle"(%22, %23) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %26 = "vector.shape_cast"(%24) : (vector<16xf32>) -> vector<1x16xf32>
    %27 = "vector.shape_cast"(%25) : (vector<16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%26, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%27, %arg3, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x32xbf16>, memref<16x32x64xbf16>, memref<64x64xf32>) -> memref<64x64xf32>, sym_name = "brmatmul_bf16dp_flat_layout_loop"}> ({
  ^bb0(%arg1: memref<16x64x32xbf16>, %arg2: memref<16x32x64xbf16>, %arg3: memref<64x64xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %4, %6) ({
      ^bb0(%arg5: index):
        %9 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x64xf32>, index, index) -> memref<1x32xf32, strided<[64, 1], offset: ?>>
        %10 = "vector.transfer_read"(%9, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x32xf32, strided<[64, 1], offset: ?>>, index, index, f32) -> vector<1x16xf32>
        %11 = "vector.transfer_read"(%9, %3, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<1x32xf32, strided<[64, 1], offset: ?>>, index, index, f32) -> vector<1x16xf32>
        %12 = "vector.shape_cast"(%10) : (vector<1x16xf32>) -> vector<16xf32>
        %13 = "vector.shape_cast"(%11) : (vector<1x16xf32>) -> vector<16xf32>
        %14 = "vector.shuffle"(%12, %13) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %15 = "vector.shuffle"(%12, %13) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %16 = "vector.shape_cast"(%14) : (vector<16xf32>) -> vector<1x16xf32>
        %17 = "vector.shape_cast"(%15) : (vector<16xf32>) -> vector<1x16xf32>
        %18:2 = "scf.for"(%3, %5, %7, %16, %17) ({
        ^bb0(%arg6: index, %arg7: vector<1x16xf32>, %arg8: vector<1x16xf32>):
          %25:2 = "scf.for"(%3, %6, %8, %arg7, %arg8) ({
          ^bb0(%arg9: index, %arg10: vector<1x16xf32>, %arg11: vector<1x16xf32>):
            %26 = "memref.subview"(%arg1, %arg6, %arg4, %arg9) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x32xbf16>, index, index, index) -> memref<1x1x2xbf16, strided<[2048, 32, 1], offset: ?>>
            %27 = "memref.subview"(%arg2, %arg6, %arg9, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x32x64xbf16>, index, index, index) -> memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>
            %28 = "vector.transfer_read"(%26, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x1x2xbf16, strided<[2048, 32, 1], offset: ?>>, index, index, index, bf16) -> vector<1x1x2xbf16>
            %29 = "vector.transfer_read"(%27, %3, %3, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
            %30 = "vector.transfer_read"(%27, %3, %7, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
            %31 = "vector.shuffle"(%29, %30) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
            %32 = "vector.shuffle"(%29, %30) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
            %33 = "vector.shape_cast"(%arg10) : (vector<1x16xf32>) -> vector<16xf32>
            %34 = "vector.shape_cast"(%28) : (vector<1x1x2xbf16>) -> vector<2xbf16>
            %35 = "vector.bitcast"(%34) : (vector<2xbf16>) -> vector<1xi32>
            %36 = "vector.broadcast"(%35) : (vector<1xi32>) -> vector<16xi32>
            %37 = "vector.bitcast"(%36) : (vector<16xi32>) -> vector<32xbf16>
            %38 = "x86.avx512.dot"(%33, %37, %31) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
            %39 = "vector.shape_cast"(%38) : (vector<16xf32>) -> vector<1x16xf32>
            %40 = "vector.shape_cast"(%arg11) : (vector<1x16xf32>) -> vector<16xf32>
            %41 = "x86.avx512.dot"(%40, %37, %32) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
            %42 = "vector.shape_cast"(%41) : (vector<16xf32>) -> vector<1x16xf32>
            "scf.yield"(%39, %42) : (vector<1x16xf32>, vector<1x16xf32>) -> ()
          }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>)
          "scf.yield"(%25#0, %25#1) : (vector<1x16xf32>, vector<1x16xf32>) -> ()
        }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>)
        %19 = "vector.shape_cast"(%18#0) : (vector<1x16xf32>) -> vector<16xf32>
        %20 = "vector.shape_cast"(%18#1) : (vector<1x16xf32>) -> vector<16xf32>
        %21 = "vector.shuffle"(%19, %20) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %22 = "vector.shuffle"(%19, %20) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %23 = "vector.shape_cast"(%21) : (vector<16xf32>) -> vector<1x16xf32>
        %24 = "vector.shape_cast"(%22) : (vector<16xf32>) -> vector<1x16xf32>
        "vector.transfer_write"(%24, %9, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<1x32xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%23, %9, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<1x32xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
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
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "matmul_bf16dp_flat_layout_B_shuffled"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1) : (memref<2x32xbf16>, index, index) -> vector<2x16xbf16>
    %5 = "vector.load"(%arg2, %1, %2) : (memref<2x32xbf16>, index, index) -> vector<2x16xbf16>
    %6 = "vector.load"(%arg3, %1, %1) : (memref<2x32xf32>, index, index) -> vector<1x16xf32>
    %7 = "vector.load"(%arg3, %1, %2) : (memref<2x32xf32>, index, index) -> vector<1x16xf32>
    %8 = "vector.shape_cast"(%6) : (vector<1x16xf32>) -> vector<16xf32>
    %9 = "vector.shape_cast"(%7) : (vector<1x16xf32>) -> vector<16xf32>
    %10 = "vector.shuffle"(%8, %9) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %11 = "vector.shuffle"(%8, %9) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %12 = "vector.shape_cast"(%4) : (vector<2x16xbf16>) -> vector<32xbf16>
    %13 = "vector.shape_cast"(%5) : (vector<2x16xbf16>) -> vector<32xbf16>
    %14 = "vector.shuffle"(%12, %13) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %15 = "vector.shuffle"(%12, %13) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %16 = "vector.shape_cast"(%3) : (vector<1x2xbf16>) -> vector<2xbf16>
    %17 = "vector.bitcast"(%16) : (vector<2xbf16>) -> vector<1xi32>
    %18 = "vector.broadcast"(%17) : (vector<1xi32>) -> vector<16xi32>
    %19 = "vector.bitcast"(%18) : (vector<16xi32>) -> vector<32xbf16>
    %20 = "x86.avx512.dot"(%10, %19, %14) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %21 = "x86.avx512.dot"(%11, %19, %15) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    %22 = "vector.shuffle"(%20, %21) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %23 = "vector.shuffle"(%20, %21) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
    %24 = "vector.shape_cast"(%22) : (vector<16xf32>) -> vector<1x16xf32>
    %25 = "vector.shape_cast"(%23) : (vector<16xf32>) -> vector<1x16xf32>
    "vector.store"(%24, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.store"(%25, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x256xi8>, memref<16x256x128xi8>, memref<64x128xi32>) -> memref<64x128xi32>, sym_name = "brgemm_int8_flat_avx10"}> ({
  ^bb0(%arg1: memref<16x64x256xi8>, %arg2: memref<16x256x128xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 256 : index}> : () -> index
    %8 = "arith.constant"() <{value = 2 : index}> : () -> index
    %9 = "arith.constant"() <{value = 32 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.for"(%3, %4, %8) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %9) ({
      ^bb0(%arg5: index):
        %13 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<2x32xi32, strided<[128, 1], offset: ?>>
        %14 = "vector.transfer_read"(%13, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<1x16xi32>
        %15 = "vector.transfer_read"(%13, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<1x16xi32>
        %16 = "vector.shape_cast"(%14) : (vector<1x16xi32>) -> vector<16xi32>
        %17 = "vector.shape_cast"(%15) : (vector<1x16xi32>) -> vector<16xi32>
        %18 = "vector.shuffle"(%16, %17) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %19 = "vector.shuffle"(%16, %17) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %20 = "vector.shape_cast"(%18) : (vector<16xi32>) -> vector<1x16xi32>
        %21 = "vector.shape_cast"(%19) : (vector<16xi32>) -> vector<1x16xi32>
        %22 = "vector.transfer_read"(%13, %10, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<1x16xi32>
        %23 = "vector.transfer_read"(%13, %10, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<1x16xi32>
        %24 = "vector.shape_cast"(%22) : (vector<1x16xi32>) -> vector<16xi32>
        %25 = "vector.shape_cast"(%23) : (vector<1x16xi32>) -> vector<16xi32>
        %26 = "vector.shuffle"(%24, %25) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %27 = "vector.shuffle"(%24, %25) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %28 = "vector.shape_cast"(%26) : (vector<16xi32>) -> vector<1x16xi32>
        %29 = "vector.shape_cast"(%27) : (vector<16xi32>) -> vector<1x16xi32>
        %30:4 = "scf.for"(%3, %6, %10, %20, %21, %28, %29) ({
        ^bb0(%arg6: index, %arg7: vector<1x16xi32>, %arg8: vector<1x16xi32>, %arg9: vector<1x16xi32>, %arg10: vector<1x16xi32>):
          %43:4 = "scf.for"(%3, %7, %11, %arg7, %arg8, %arg9, %arg10) ({
          ^bb0(%arg11: index, %arg12: vector<1x16xi32>, %arg13: vector<1x16xi32>, %arg14: vector<1x16xi32>, %arg15: vector<1x16xi32>):
            %44 = "memref.subview"(%arg1, %arg6, %arg4, %arg11) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x256xi8>, index, index, index) -> memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>
            %45 = "memref.subview"(%arg2, %arg6, %arg11, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 4, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x256x128xi8>, index, index, index) -> memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>
            %46 = "vector.transfer_read"(%44, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>, index, index, index, i8) -> vector<1x1x4xi8>
            %47 = "vector.transfer_read"(%44, %3, %10, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>, index, index, index, i8) -> vector<1x1x4xi8>
            %48 = "vector.transfer_read"(%45, %3, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>, index, index, index, i8) -> vector<2x32xi8>
            %49 = "vector.shape_cast"(%48) : (vector<2x32xi8>) -> vector<64xi8>
            %50 = "vector.transfer_read"(%45, %3, %8, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>, index, index, index, i8) -> vector<2x32xi8>
            %51 = "vector.shape_cast"(%50) : (vector<2x32xi8>) -> vector<64xi8>
            %52 = "vector.shuffle"(%49, %51) <{mask = array<i64: 0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
            %53 = "vector.shuffle"(%49, %51) <{mask = array<i64: 4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
            %54 = "vector.shape_cast"(%arg12) : (vector<1x16xi32>) -> vector<16xi32>
            %55 = "vector.shape_cast"(%46) : (vector<1x1x4xi8>) -> vector<4xi8>
            %56 = "vector.bitcast"(%55) : (vector<4xi8>) -> vector<1xi32>
            %57 = "vector.broadcast"(%56) : (vector<1xi32>) -> vector<16xi32>
            %58 = "vector.bitcast"(%57) : (vector<16xi32>) -> vector<64xi8>
            %59 = "x86.avx10.dot.i8"(%54, %58, %52) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
            %60 = "vector.shape_cast"(%59) : (vector<16xi32>) -> vector<1x16xi32>
            %61 = "vector.shape_cast"(%arg13) : (vector<1x16xi32>) -> vector<16xi32>
            %62 = "x86.avx10.dot.i8"(%61, %58, %53) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
            %63 = "vector.shape_cast"(%62) : (vector<16xi32>) -> vector<1x16xi32>
            %64 = "vector.shape_cast"(%arg14) : (vector<1x16xi32>) -> vector<16xi32>
            %65 = "vector.shape_cast"(%47) : (vector<1x1x4xi8>) -> vector<4xi8>
            %66 = "vector.bitcast"(%65) : (vector<4xi8>) -> vector<1xi32>
            %67 = "vector.broadcast"(%66) : (vector<1xi32>) -> vector<16xi32>
            %68 = "vector.bitcast"(%67) : (vector<16xi32>) -> vector<64xi8>
            %69 = "x86.avx10.dot.i8"(%64, %68, %52) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
            %70 = "vector.shape_cast"(%69) : (vector<16xi32>) -> vector<1x16xi32>
            %71 = "vector.shape_cast"(%arg15) : (vector<1x16xi32>) -> vector<16xi32>
            %72 = "x86.avx10.dot.i8"(%71, %68, %53) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
            %73 = "vector.shape_cast"(%72) : (vector<16xi32>) -> vector<1x16xi32>
            "scf.yield"(%60, %63, %70, %73) : (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> ()
          }) : (index, index, index, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>)
          "scf.yield"(%43#0, %43#1, %43#2, %43#3) : (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> ()
        }) : (index, index, index, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>)
        %31 = "vector.shape_cast"(%30#2) : (vector<1x16xi32>) -> vector<16xi32>
        %32 = "vector.shape_cast"(%30#3) : (vector<1x16xi32>) -> vector<16xi32>
        %33 = "vector.shuffle"(%31, %32) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %34 = "vector.shuffle"(%31, %32) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %35 = "vector.shape_cast"(%33) : (vector<16xi32>) -> vector<1x16xi32>
        %36 = "vector.shape_cast"(%34) : (vector<16xi32>) -> vector<1x16xi32>
        "vector.transfer_write"(%36, %13, %10, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%35, %13, %10, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        %37 = "vector.shape_cast"(%30#0) : (vector<1x16xi32>) -> vector<16xi32>
        %38 = "vector.shape_cast"(%30#1) : (vector<1x16xi32>) -> vector<16xi32>
        %39 = "vector.shuffle"(%37, %38) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %40 = "vector.shuffle"(%37, %38) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        %41 = "vector.shape_cast"(%39) : (vector<16xi32>) -> vector<1x16xi32>
        %42 = "vector.shape_cast"(%40) : (vector<16xi32>) -> vector<1x16xi32>
        "vector.transfer_write"(%42, %13, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%41, %13, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi32>
    "memref.copy"(%arg3, %12) : (memref<64x128xi32>, memref<64x128xi32>) -> ()
    "func.return"(%12) : (memref<64x128xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x64x32xbf16>, tensor<16x32x64xbf16>, tensor<64x64xf32>) -> tensor<64x64xf32>, sym_name = "brmatmul_bf16dp_flat_layout_loop_tensor_type"}> ({
  ^bb0(%arg1: tensor<16x64x32xbf16>, %arg2: tensor<16x32x64xbf16>, %arg3: tensor<64x64xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 2 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "scf.for"(%3, %4, %7, %arg3) ({
    ^bb0(%arg4: index, %arg5: tensor<64x64xf32>):
      %10 = "scf.for"(%3, %4, %6, %arg5) ({
      ^bb0(%arg6: index, %arg7: tensor<64x64xf32>):
        %11 = "tensor.extract_slice"(%arg7, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 32>, static_strides = array<i64: 1, 1>}> : (tensor<64x64xf32>, index, index) -> tensor<2x32xf32>
        %12 = "vector.transfer_read"(%11, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<2x32xf32>, index, index, f32) -> vector<1x16xf32>
        %13 = "vector.transfer_read"(%11, %3, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<2x32xf32>, index, index, f32) -> vector<1x16xf32>
        %14 = "vector.shape_cast"(%12) : (vector<1x16xf32>) -> vector<16xf32>
        %15 = "vector.shape_cast"(%13) : (vector<1x16xf32>) -> vector<16xf32>
        %16 = "vector.shuffle"(%14, %15) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %17 = "vector.shuffle"(%14, %15) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %18 = "vector.shape_cast"(%16) : (vector<16xf32>) -> vector<1x16xf32>
        %19 = "vector.shape_cast"(%17) : (vector<16xf32>) -> vector<1x16xf32>
        %20 = "vector.transfer_read"(%11, %8, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<2x32xf32>, index, index, f32) -> vector<1x16xf32>
        %21 = "vector.transfer_read"(%11, %8, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<2x32xf32>, index, index, f32) -> vector<1x16xf32>
        %22 = "vector.shape_cast"(%20) : (vector<1x16xf32>) -> vector<16xf32>
        %23 = "vector.shape_cast"(%21) : (vector<1x16xf32>) -> vector<16xf32>
        %24 = "vector.shuffle"(%22, %23) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %25 = "vector.shuffle"(%22, %23) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %26 = "vector.shape_cast"(%24) : (vector<16xf32>) -> vector<1x16xf32>
        %27 = "vector.shape_cast"(%25) : (vector<16xf32>) -> vector<1x16xf32>
        %28:4 = "scf.for"(%3, %5, %8, %18, %19, %26, %27) ({
        ^bb0(%arg8: index, %arg9: vector<1x16xf32>, %arg10: vector<1x16xf32>, %arg11: vector<1x16xf32>, %arg12: vector<1x16xf32>):
          %46:4 = "scf.for"(%3, %6, %7, %arg9, %arg10, %arg11, %arg12) ({
          ^bb0(%arg13: index, %arg14: vector<1x16xf32>, %arg15: vector<1x16xf32>, %arg16: vector<1x16xf32>, %arg17: vector<1x16xf32>):
            %47 = "tensor.extract_slice"(%arg1, %arg8, %arg4, %arg13) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 2>, static_strides = array<i64: 1, 1, 1>}> : (tensor<16x64x32xbf16>, index, index, index) -> tensor<1x2x2xbf16>
            %48 = "tensor.extract_slice"(%arg2, %arg8, %arg13, %arg6) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 32>, static_strides = array<i64: 1, 1, 1>}> : (tensor<16x32x64xbf16>, index, index, index) -> tensor<1x2x32xbf16>
            %49 = "vector.transfer_read"(%47, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<1x2x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
            %50 = "vector.transfer_read"(%47, %3, %8, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<1x2x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
            %51 = "vector.transfer_read"(%48, %3, %3, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (tensor<1x2x32xbf16>, index, index, index, bf16) -> vector<32xbf16>
            %52 = "vector.transfer_read"(%48, %3, %8, %3, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (tensor<1x2x32xbf16>, index, index, index, bf16) -> vector<32xbf16>
            %53 = "vector.shuffle"(%51, %52) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
            %54 = "vector.shuffle"(%51, %52) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
            %55 = "vector.shape_cast"(%arg14) : (vector<1x16xf32>) -> vector<16xf32>
            %56 = "vector.shape_cast"(%49) : (vector<1x1x2xbf16>) -> vector<2xbf16>
            %57 = "vector.bitcast"(%56) : (vector<2xbf16>) -> vector<1xi32>
            %58 = "vector.broadcast"(%57) : (vector<1xi32>) -> vector<16xi32>
            %59 = "vector.bitcast"(%58) : (vector<16xi32>) -> vector<32xbf16>
            %60 = "x86.avx512.dot"(%55, %59, %53) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
            %61 = "vector.shape_cast"(%60) : (vector<16xf32>) -> vector<1x16xf32>
            %62 = "vector.shape_cast"(%arg15) : (vector<1x16xf32>) -> vector<16xf32>
            %63 = "x86.avx512.dot"(%62, %59, %54) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
            %64 = "vector.shape_cast"(%63) : (vector<16xf32>) -> vector<1x16xf32>
            %65 = "vector.shape_cast"(%arg16) : (vector<1x16xf32>) -> vector<16xf32>
            %66 = "vector.shape_cast"(%50) : (vector<1x1x2xbf16>) -> vector<2xbf16>
            %67 = "vector.bitcast"(%66) : (vector<2xbf16>) -> vector<1xi32>
            %68 = "vector.broadcast"(%67) : (vector<1xi32>) -> vector<16xi32>
            %69 = "vector.bitcast"(%68) : (vector<16xi32>) -> vector<32xbf16>
            %70 = "x86.avx512.dot"(%65, %69, %53) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
            %71 = "vector.shape_cast"(%70) : (vector<16xf32>) -> vector<1x16xf32>
            %72 = "vector.shape_cast"(%arg17) : (vector<1x16xf32>) -> vector<16xf32>
            %73 = "x86.avx512.dot"(%72, %69, %54) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
            %74 = "vector.shape_cast"(%73) : (vector<16xf32>) -> vector<1x16xf32>
            "scf.yield"(%61, %64, %71, %74) : (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> ()
          }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>)
          "scf.yield"(%46#0, %46#1, %46#2, %46#3) : (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> ()
        }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>)
        %29 = "vector.shape_cast"(%28#2) : (vector<1x16xf32>) -> vector<16xf32>
        %30 = "vector.shape_cast"(%28#3) : (vector<1x16xf32>) -> vector<16xf32>
        %31 = "vector.shuffle"(%29, %30) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %32 = "vector.shuffle"(%29, %30) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %33 = "vector.shape_cast"(%31) : (vector<16xf32>) -> vector<1x16xf32>
        %34 = "vector.shape_cast"(%32) : (vector<16xf32>) -> vector<1x16xf32>
        %35 = "vector.transfer_write"(%34, %11, %8, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %36 = "vector.transfer_write"(%33, %35, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %37 = "vector.shape_cast"(%28#0) : (vector<1x16xf32>) -> vector<16xf32>
        %38 = "vector.shape_cast"(%28#1) : (vector<1x16xf32>) -> vector<16xf32>
        %39 = "vector.shuffle"(%37, %38) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %40 = "vector.shuffle"(%37, %38) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
        %41 = "vector.shape_cast"(%39) : (vector<16xf32>) -> vector<1x16xf32>
        %42 = "vector.shape_cast"(%40) : (vector<16xf32>) -> vector<1x16xf32>
        %43 = "vector.transfer_write"(%42, %36, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %44 = "vector.transfer_write"(%41, %43, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %45 = "tensor.insert_slice"(%44, %arg7, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 32>, static_strides = array<i64: 1, 1>}> : (tensor<2x32xf32>, tensor<64x64xf32>, index, index) -> tensor<64x64xf32>
        "scf.yield"(%45) : (tensor<64x64xf32>) -> ()
      }) : (index, index, index, tensor<64x64xf32>) -> tensor<64x64xf32>
      "scf.yield"(%10) : (tensor<64x64xf32>) -> ()
    }) : (index, index, index, tensor<64x64xf32>) -> tensor<64x64xf32>
    "func.return"(%9) : (tensor<64x64xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<1x1x2xbf16>, vector<1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "negative_invalid_vc_kind"}> ({
  ^bb0(%arg1: vector<1x1x2xbf16>, %arg2: vector<1x16x2xbf16>, %arg3: vector<1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<mul>}> : (vector<1x1x2xbf16>, vector<1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "func.return"(%1) : (vector<1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "negative_false_vnni_bf16"}> ({
  ^bb0(%arg1: vector<1x1x1x4xbf16>, %arg2: vector<1x1x16x4xbf16>, %arg3: vector<1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "func.return"(%1) : (vector<1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x2xi8>, vector<1x1x8x2xi8>, vector<1x8xi32>) -> vector<1x8xi32>, sym_name = "negative_false_vnni_int8"}> ({
  ^bb0(%arg1: vector<1x1x1x2xi8>, %arg2: vector<1x1x8x2xi8>, %arg3: vector<1x8xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xi8>, vector<1x1x8x2xi8>, vector<1x8xi32>) -> vector<1x8xi32>
    "func.return"(%1) : (vector<1x8xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<3x1x1x2xbf16>, vector<3x1x16x2xbf16>, vector<3x1x16xf32>) -> vector<3x1x16xf32>, sym_name = "negative_batch_dimension"}> ({
  ^bb0(%arg1: vector<3x1x1x2xbf16>, %arg2: vector<3x1x16x2xbf16>, %arg3: vector<3x1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<3x1x1x2xbf16>, vector<3x1x16x2xbf16>, vector<3x1x16xf32>) -> vector<3x1x16xf32>
    "func.return"(%1) : (vector<3x1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x1x1x4xi8>, vector<2x1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>, sym_name = "negative_brgemm_dimension"}> ({
  ^bb0(%arg1: vector<2x1x1x4xi8>, %arg2: vector<2x1x8x4xi8>, %arg3: vector<1x8xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<2x1x1x4xi8>, vector<2x1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>
    "func.return"(%1) : (vector<1x8xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xbf16>) -> vector<1x1x16xbf16>, sym_name = "negative_float_acc_type"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x16x2xbf16>, %arg3: vector<1x1x16xbf16>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xbf16>) -> vector<1x1x16xbf16>
    "func.return"(%1) : (vector<1x1x16xbf16>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x1x8xi8>) -> vector<1x1x8xi8>, sym_name = "negative_int_acc_type"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x8x4xi8>, %arg3: vector<1x1x8xi8>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x1x8xi8>) -> vector<1x1x8xi8>
    "func.return"(%1) : (vector<1x1x8xi8>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16>, vector<1x1x16xbf16>) -> vector<1x1x16xbf16>, sym_name = "negative_wrong_vnni_blocking_factor_bf16"}> ({
  ^bb0(%arg1: vector<1x1x1x4xbf16>, %arg2: vector<1x1x16x4xbf16>, %arg3: vector<1x1x16xbf16>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16>, vector<1x1x16xbf16>) -> vector<1x1x16xbf16>
    "func.return"(%1) : (vector<1x1x16xbf16>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1xbf16>, vector<1x1x32xbf16>, vector<1x32xf32>) -> vector<1x32xf32>, sym_name = "negative_brgemm_not_vnni"}> ({
  ^bb0(%arg1: vector<1x1x1xbf16>, %arg2: vector<1x1x32xbf16>, %arg3: vector<1x32xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1xbf16>, vector<1x1x32xbf16>, vector<1x32xf32>) -> vector<1x32xf32>
    "func.return"(%1) : (vector<1x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x32x4xi8>, vector<1x1x32xi32>) -> vector<1x1x32xi32>, sym_name = "negative_wrong_vector_shape_int8"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x32x4xi8>, %arg3: vector<1x1x32xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xi8>, vector<1x1x32x4xi8>, vector<1x1x32xi32>) -> vector<1x1x32xi32>
    "func.return"(%1) : (vector<1x1x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x32x2xbf16>, vector<1x1x32xf32>) -> vector<1x1x32xf32>, sym_name = "negative_wrong_vector_shape_bf16"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x32x2xbf16>, %arg3: vector<1x1x32xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x32x2xbf16>, vector<1x1x32xf32>) -> vector<1x1x32xf32>
    "func.return"(%1) : (vector<1x1x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x4xbf16>, memref<4x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "negative_flat_other_dim_is_not_2"}> ({
  ^bb0(%arg1: memref<4x4xbf16>, %arg2: memref<4x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xbf16>, index, index, bf16) -> vector<1x4xbf16>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x32xbf16>, index, index, bf16) -> vector<4x16xbf16>
    %7 = "vector.transfer_read"(%arg2, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x32xbf16>, index, index, bf16) -> vector<4x16xbf16>
    %8 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %9 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %10 = "vector.contract"(%5, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x4xbf16>, vector<4x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %11 = "vector.contract"(%5, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x4xbf16>, vector<4x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%10, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "negative_flat_offset_diff_is_not16"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %6 = "vector.transfer_read"(%arg1, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %7 = "vector.transfer_read"(%arg2, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x64xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %8 = "vector.transfer_read"(%arg2, %1, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x64xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %9 = "vector.transfer_read"(%arg3, %1, %1, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %10 = "vector.transfer_read"(%arg3, %1, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %11 = "vector.contract"(%6, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %12 = "vector.contract"(%6, %8, %10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%11, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%12, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x32xf32>, index) -> memref<2x32xf32>, sym_name = "negative_flat_dynamic_offset"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x32xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x64xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %7 = "vector.transfer_read"(%arg2, %1, %arg4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x64xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %8 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %9 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %10 = "vector.contract"(%5, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %11 = "vector.contract"(%5, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%10, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "negative_flat_read_after_contract"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x64xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %7 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %8 = "vector.contract"(%5, %6, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %9 = "vector.transfer_read"(%arg2, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x64xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %10 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %11 = "vector.contract"(%5, %9, %10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%8, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x64xf32>) -> memref<2x64xf32>, sym_name = "negative_contracts_not_in_order"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x64xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %5 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %6 = "vector.load"(%arg2, %1, %3) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %7 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %8 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %9 = "vector.contract"(%4, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %10 = "vector.contract"(%4, %5, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%10, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%9, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x64xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x64xf32>) -> memref<2x64xf32>, sym_name = "negative_dim_is_32"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x64xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %4 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x32xbf16>
    %5 = "vector.load"(%arg2, %1, %2) : (memref<2x64xbf16>, index, index) -> vector<1x32xbf16>
    %6 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x32xf32>
    %7 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x32xf32>
    %8 = "vector.contract"(%3, %4, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x32xbf16>, vector<1x32xf32>) -> vector<1x32xf32>
    %9 = "vector.contract"(%3, %5, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x32xbf16>, vector<1x32xf32>) -> vector<1x32xf32>
    "vector.store"(%8, %arg3, %1, %1) : (vector<1x32xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%9, %arg3, %1, %2) : (vector<1x32xf32>, memref<2x64xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x64xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x64xf32>) -> memref<2x64xf32>, sym_name = "negative_offset_diff_is_32"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x64xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %5 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %6 = "vector.load"(%arg2, %1, %3) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %7 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %8 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %9 = "vector.contract"(%4, %5, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %10 = "vector.contract"(%4, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%9, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%10, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x64xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x64xbf16>, memref<2x64xf32>, index) -> memref<2x64xf32>, sym_name = "negative_dynamic_offset"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x64xbf16>, %arg3: memref<2x64xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %4 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %5 = "vector.load"(%arg2, %1, %arg4) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %6 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %7 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %8 = "vector.contract"(%3, %4, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %9 = "vector.contract"(%3, %5, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%8, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%9, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<2x64xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x4xi8>, memref<4x64xi8>, memref<4x64xi32>) -> memref<4x64xi32>, sym_name = "negative_i8_avx2dp_flat_layout_offset_diff_16"}> ({
  ^bb0(%arg1: memref<4x4xi8>, %arg2: memref<4x64xi8>, %arg3: memref<4x64xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xi8>, index, index, i8) -> vector<1x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x8xi32>
    %7 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x8xi32>
    %8 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<4x8xi8>
    %9 = "vector.transfer_read"(%arg2, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<4x8xi8>
    %10 = "vector.contract"(%5, %8, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x4xi8>, vector<4x8xi8>, vector<1x8xi32>) -> vector<1x8xi32>
    %11 = "vector.contract"(%5, %9, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x4xi8>, vector<4x8xi8>, vector<1x8xi32>) -> vector<1x8xi32>
    "vector.transfer_write"(%10, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xi32>, memref<4x64xi32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x8xi32>, memref<4x64xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<4x64xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

