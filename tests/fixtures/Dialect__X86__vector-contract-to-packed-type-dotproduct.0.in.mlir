#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "brgemm_to_bf16dp"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x16x2xbf16>, %arg3: vector<1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
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
  "func.func"() <{function_type = (vector<1x16x1x2xbf16>, vector<1x1x1x2xbf16>, vector<16x1xf32>) -> vector<16x1xf32>, sym_name = "brgemm_to_bf16dp_bcst_B"}> ({
  ^bb0(%arg1: vector<1x16x1x2xbf16>, %arg2: vector<1x1x1x2xbf16>, %arg3: vector<16x1xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x1x2xbf16>, vector<1x1x1x2xbf16>, vector<16x1xf32>) -> vector<16x1xf32>
    "func.return"(%1) : (vector<16x1xf32>) -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x16x4xi8>, vector<1x16xi32>) -> vector<1x16xi32>, sym_name = "brgemm_to_avx10int8dp"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x16x4xi8>, %arg3: vector<1x16xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xi8>, vector<1x1x16x4xi8>, vector<1x16xi32>) -> vector<1x16xi32>
    "func.return"(%1) : (vector<1x16xi32>) -> ()
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
  "func.func"() <{function_type = (vector<1x16x1x4xi8>, vector<1x1x1x4xi8>, vector<1x16x1xi32>) -> vector<1x16x1xi32>, sym_name = "batch_matmul_avx10int8dp_bcst_B"}> ({
  ^bb0(%arg1: vector<1x16x1x4xi8>, %arg2: vector<1x1x1x4xi8>, %arg3: vector<1x16x1xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x1x4xi8>, vector<1x1x1x4xi8>, vector<1x16x1xi32>) -> vector<1x16x1xi32>
    "func.return"(%1) : (vector<1x16x1xi32>) -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>, sym_name = "brgemm_to_int8dp"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x8x4xi8>, %arg3: vector<1x8xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>
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
  "func.func"() <{function_type = (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xf32>) -> vector<1x1x16xf32>, sym_name = "batch_matmul_bf16dp"}> ({
  ^bb0(%arg1: vector<1x1x1x2xbf16>, %arg2: vector<1x1x16x2xbf16>, %arg3: vector<1x1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xf32>) -> vector<1x1x16xf32>
    "func.return"(%1) : (vector<1x1x16xf32>) -> ()
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
  "func.func"() <{function_type = (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x1x8xi32>) -> vector<1x1x8xi32>, sym_name = "batch_matmul_int8dp"}> ({
  ^bb0(%arg1: vector<1x1x1x4xi8>, %arg2: vector<1x1x8x4xi8>, %arg3: vector<1x1x8xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x4xi8>, vector<1x1x8x4xi8>, vector<1x1x8xi32>) -> vector<1x1x8xi32>
    "func.return"(%1) : (vector<1x1x8xi32>) -> ()
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
  "func.func"() <{function_type = (vector<1x8x1x4xi8>, vector<1x1x1x4xi8>, vector<1x8x1xi32>) -> vector<1x8x1xi32>, sym_name = "batch_matmul_int8dp_bcst_B"}> ({
  ^bb0(%arg1: vector<1x8x1x4xi8>, %arg2: vector<1x1x1x4xi8>, %arg3: vector<1x8x1xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x8x1x4xi8>, vector<1x1x1x4xi8>, vector<1x8x1xi32>) -> vector<1x8x1xi32>
    "func.return"(%1) : (vector<1x8x1xi32>) -> ()
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
  "func.func"() <{function_type = (vector<1x1x2xbf16>, vector<1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "matmul_outer_product_to_bf16dp"}> ({
  ^bb0(%arg1: vector<1x1x2xbf16>, %arg2: vector<1x16x2xbf16>, %arg3: vector<1x16xf32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
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
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x1x4xi8>, vector<1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>, sym_name = "matmul_outer_product_to_int8dp"}> ({
  ^bb0(%arg1: vector<1x1x4xi8>, %arg2: vector<1x8x4xi8>, %arg3: vector<1x8xi32>):
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x4xi8>, vector<1x8x4xi8>, vector<1x8xi32>) -> vector<1x8xi32>
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
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "matmul_bf16dp_flat_layout"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %7 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %8 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %9 = "vector.transfer_read"(%arg2, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %10 = "vector.contract"(%5, %8, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %11 = "vector.contract"(%5, %9, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
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
  "func.func"() <{function_type = (memref<4x4xi8>, memref<4x64xi8>, memref<4x64xi32>) -> memref<4x64xi32>, sym_name = "matmul_i8_avx10dp_flat_layout"}> ({
  ^bb0(%arg1: memref<4x4xi8>, %arg2: memref<4x64xi8>, %arg3: memref<4x64xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x4xi8>, index, index, i8) -> vector<1x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x16xi32>
    %7 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi32>, index, index, i32) -> vector<1x16xi32>
    %8 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<4x16xi8>
    %9 = "vector.transfer_read"(%arg2, %1, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x64xi8>, index, index, i8) -> vector<4x16xi8>
    %10 = "vector.contract"(%5, %8, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x4xi8>, vector<4x16xi8>, vector<1x16xi32>) -> vector<1x16xi32>
    %11 = "vector.contract"(%5, %9, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x4xi8>, vector<4x16xi8>, vector<1x16xi32>) -> vector<1x16xi32>
    "vector.transfer_write"(%10, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<4x64xi32>, index, index) -> ()
    "vector.transfer_write"(%11, %arg3, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<4x64xi32>, index, index) -> ()
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
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x4xi8>, memref<4x64xi8>, memref<4x64xi32>) -> memref<4x64xi32>, sym_name = "matmul_i8_avx2dp_flat_layout"}> ({
  ^bb0(%arg1: memref<4x4xi8>, %arg2: memref<4x64xi8>, %arg3: memref<4x64xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
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

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x32xbf16>, memref<2x32xf32>, index) -> memref<2x32xf32>, sym_name = "matmul_bf16dp_flat_layout_offset_args_and_read_after_vc"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x32xbf16>, %arg3: memref<2x32xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<4x2xbf16>, index, index, bf16) -> vector<1x2xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %7 = "vector.transfer_read"(%arg3, %1, %2, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xf32>, index, index, f32) -> vector<1x16xf32>
    %8 = "vector.transfer_read"(%arg2, %arg4, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %9 = "vector.contract"(%5, %8, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %10 = "vector.transfer_read"(%arg2, %arg4, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xbf16>, index, index, bf16) -> vector<2x16xbf16>
    %11 = "vector.contract"(%5, %10, %7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.transfer_write"(%9, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
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
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
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
        %12:2 = "scf.for"(%3, %5, %7, %10, %11) ({
        ^bb0(%arg6: index, %arg7: vector<1x16xf32>, %arg8: vector<1x16xf32>):
          %13:2 = "scf.for"(%3, %6, %8, %arg7, %arg8) ({
          ^bb0(%arg9: index, %arg10: vector<1x16xf32>, %arg11: vector<1x16xf32>):
            %14 = "memref.subview"(%arg1, %arg6, %arg4, %arg9) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1, 2>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x32xbf16>, index, index, index) -> memref<1x1x2xbf16, strided<[2048, 32, 1], offset: ?>>
            %15 = "memref.subview"(%arg2, %arg6, %arg9, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x32x64xbf16>, index, index, index) -> memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>
            %16 = "vector.transfer_read"(%14, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x1x2xbf16, strided<[2048, 32, 1], offset: ?>>, index, index, index, bf16) -> vector<1x1x2xbf16>
            %17 = "vector.transfer_read"(%15, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>, index, index, index, bf16) -> vector<1x2x16xbf16>
            %18 = "vector.transfer_read"(%15, %3, %3, %5, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>, index, index, index, bf16) -> vector<1x2x16xbf16>
            %19 = "vector.contract"(%16, %17, %arg10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 2>} : (vector<1x1x2xbf16>, vector<1x2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
            %20 = "vector.contract"(%16, %18, %arg11) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 2>} : (vector<1x1x2xbf16>, vector<1x2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
            "scf.yield"(%19, %20) : (vector<1x16xf32>, vector<1x16xf32>) -> ()
          }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>)
          "scf.yield"(%13#0, %13#1) : (vector<1x16xf32>, vector<1x16xf32>) -> ()
        }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>)
        "vector.transfer_write"(%12#1, %9, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<1x32xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%12#0, %9, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, memref<1x32xf32, strided<[64, 1], offset: ?>>, index, index) -> ()
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
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x2xbf16>, memref<2x32xbf16>, memref<2x32xf32>) -> memref<2x32xf32>, sym_name = "matmul_bf16dp_flat_layout_B_shuffled"}> ({
  ^bb0(%arg1: memref<4x2xbf16>, %arg2: memref<2x32xbf16>, %arg3: memref<2x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x2xbf16>
    %6 = "vector.load"(%arg2, %1, %1) : (memref<2x32xbf16>, index, index) -> vector<2x16xbf16>
    %7 = "vector.load"(%arg2, %1, %2) : (memref<2x32xbf16>, index, index) -> vector<2x16xbf16>
    %8 = "vector.load"(%arg3, %1, %1) : (memref<2x32xf32>, index, index) -> vector<1x16xf32>
    %9 = "vector.load"(%arg3, %1, %2) : (memref<2x32xf32>, index, index) -> vector<1x16xf32>
    %10 = "vector.shape_cast"(%6) : (vector<2x16xbf16>) -> vector<32xbf16>
    %11 = "vector.shape_cast"(%7) : (vector<2x16xbf16>) -> vector<32xbf16>
    %12 = "vector.shuffle"(%10, %11) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %13 = "vector.shuffle"(%10, %11) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
    %14 = "vector.shape_cast"(%12) : (vector<32xbf16>) -> vector<2x16xbf16>
    %15 = "vector.shape_cast"(%13) : (vector<32xbf16>) -> vector<2x16xbf16>
    %16 = "vector.contract"(%5, %14, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %17 = "vector.contract"(%5, %15, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x2xbf16>, vector<2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%16, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
    "vector.store"(%17, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x32xf32>, index, index) -> ()
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
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
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
        %16 = "vector.transfer_read"(%13, %10, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<1x16xi32>
        %17 = "vector.transfer_read"(%13, %10, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<1x16xi32>
        %18:4 = "scf.for"(%3, %6, %10, %14, %15, %16, %17) ({
        ^bb0(%arg6: index, %arg7: vector<1x16xi32>, %arg8: vector<1x16xi32>, %arg9: vector<1x16xi32>, %arg10: vector<1x16xi32>):
          %19:4 = "scf.for"(%3, %7, %11, %arg7, %arg8, %arg9, %arg10) ({
          ^bb0(%arg11: index, %arg12: vector<1x16xi32>, %arg13: vector<1x16xi32>, %arg14: vector<1x16xi32>, %arg15: vector<1x16xi32>):
            %20 = "memref.subview"(%arg1, %arg6, %arg4, %arg11) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x256xi8>, index, index, index) -> memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>
            %21 = "memref.subview"(%arg2, %arg6, %arg11, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 4, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x256x128xi8>, index, index, index) -> memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>
            %22 = "vector.transfer_read"(%20, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>, index, index, index, i8) -> vector<1x1x4xi8>
            %23 = "vector.transfer_read"(%20, %3, %10, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>, index, index, index, i8) -> vector<1x1x4xi8>
            %24 = "vector.transfer_read"(%21, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>, index, index, index, i8) -> vector<1x4x16xi8>
            %25 = "vector.transfer_read"(%21, %3, %3, %6, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>, index, index, index, i8) -> vector<1x4x16xi8>
            %26 = "vector.contract"(%22, %24, %arg12) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 4>} : (vector<1x1x4xi8>, vector<1x4x16xi8>, vector<1x16xi32>) -> vector<1x16xi32>
            %27 = "vector.contract"(%22, %25, %arg13) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 4>} : (vector<1x1x4xi8>, vector<1x4x16xi8>, vector<1x16xi32>) -> vector<1x16xi32>
            %28 = "vector.contract"(%23, %24, %arg14) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 4>} : (vector<1x1x4xi8>, vector<1x4x16xi8>, vector<1x16xi32>) -> vector<1x16xi32>
            %29 = "vector.contract"(%23, %25, %arg15) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 4>} : (vector<1x1x4xi8>, vector<1x4x16xi8>, vector<1x16xi32>) -> vector<1x16xi32>
            "scf.yield"(%26, %27, %28, %29) : (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> ()
          }) : (index, index, index, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>)
          "scf.yield"(%19#0, %19#1, %19#2, %19#3) : (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> ()
        }) : (index, index, index, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) -> (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>)
        "vector.transfer_write"(%18#3, %13, %10, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%18#2, %13, %10, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%18#1, %13, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%18#0, %13, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
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
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
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
        %14 = "vector.transfer_read"(%11, %8, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<2x32xf32>, index, index, f32) -> vector<1x16xf32>
        %15 = "vector.transfer_read"(%11, %8, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<2x32xf32>, index, index, f32) -> vector<1x16xf32>
        %16:4 = "scf.for"(%3, %5, %8, %12, %13, %14, %15) ({
        ^bb0(%arg8: index, %arg9: vector<1x16xf32>, %arg10: vector<1x16xf32>, %arg11: vector<1x16xf32>, %arg12: vector<1x16xf32>):
          %22:4 = "scf.for"(%3, %6, %7, %arg9, %arg10, %arg11, %arg12) ({
          ^bb0(%arg13: index, %arg14: vector<1x16xf32>, %arg15: vector<1x16xf32>, %arg16: vector<1x16xf32>, %arg17: vector<1x16xf32>):
            %23 = "tensor.extract_slice"(%arg1, %arg8, %arg4, %arg13) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 2>, static_strides = array<i64: 1, 1, 1>}> : (tensor<16x64x32xbf16>, index, index, index) -> tensor<1x2x2xbf16>
            %24 = "tensor.extract_slice"(%arg2, %arg8, %arg13, %arg6) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 32>, static_strides = array<i64: 1, 1, 1>}> : (tensor<16x32x64xbf16>, index, index, index) -> tensor<1x2x32xbf16>
            %25 = "vector.transfer_read"(%23, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<1x2x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
            %26 = "vector.transfer_read"(%23, %3, %8, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<1x2x2xbf16>, index, index, index, bf16) -> vector<1x1x2xbf16>
            %27 = "vector.transfer_read"(%24, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<1x2x32xbf16>, index, index, index, bf16) -> vector<1x2x16xbf16>
            %28 = "vector.transfer_read"(%24, %3, %3, %5, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (tensor<1x2x32xbf16>, index, index, index, bf16) -> vector<1x2x16xbf16>
            %29 = "vector.contract"(%25, %27, %arg14) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 2>} : (vector<1x1x2xbf16>, vector<1x2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
            %30 = "vector.contract"(%25, %28, %arg15) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 2>} : (vector<1x1x2xbf16>, vector<1x2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
            %31 = "vector.contract"(%26, %27, %arg16) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 2>} : (vector<1x1x2xbf16>, vector<1x2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
            %32 = "vector.contract"(%26, %28, %arg17) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 16, 2>} : (vector<1x1x2xbf16>, vector<1x2x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
            "scf.yield"(%29, %30, %31, %32) : (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> ()
          }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>)
          "scf.yield"(%22#0, %22#1, %22#2, %22#3) : (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> ()
        }) : (index, index, index, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) -> (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>)
        %17 = "vector.transfer_write"(%16#3, %11, %8, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %18 = "vector.transfer_write"(%16#2, %17, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %19 = "vector.transfer_write"(%16#1, %18, %3, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %20 = "vector.transfer_write"(%16#0, %19, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1x16xf32>, tensor<2x32xf32>, index, index) -> tensor<2x32xf32>
        %21 = "tensor.insert_slice"(%20, %arg7, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 32>, static_strides = array<i64: 1, 1>}> : (tensor<2x32xf32>, tensor<64x64xf32>, index, index) -> tensor<64x64xf32>
        "scf.yield"(%21) : (tensor<64x64xf32>) -> ()
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
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %6 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %7 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %8 = "vector.load"(%arg2, %1, %3) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %9 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %10 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %11 = "vector.contract"(%6, %8, %10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %12 = "vector.contract"(%6, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%12, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%11, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
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
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %6 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x32xbf16>
    %7 = "vector.load"(%arg2, %1, %2) : (memref<2x64xbf16>, index, index) -> vector<1x32xbf16>
    %8 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x32xf32>
    %9 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x32xf32>
    %10 = "vector.contract"(%5, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x32xbf16>, vector<1x32xf32>) -> vector<1x32xf32>
    %11 = "vector.contract"(%5, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x32xbf16>, vector<1x32xf32>) -> vector<1x32xf32>
    "vector.store"(%10, %arg3, %1, %1) : (vector<1x32xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%11, %arg3, %1, %2) : (vector<1x32xf32>, memref<2x64xf32>, index, index) -> ()
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
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %5 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %6 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %7 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %8 = "vector.load"(%arg2, %1, %3) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %9 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %10 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %11 = "vector.contract"(%6, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %12 = "vector.contract"(%6, %8, %10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%11, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%12, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
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
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %5 = "vector.load"(%arg1, %1, %1) : (memref<4x2xbf16>, index, index) -> vector<1x1xbf16>
    %6 = "vector.load"(%arg2, %1, %1) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %7 = "vector.load"(%arg2, %1, %arg4) : (memref<2x64xbf16>, index, index) -> vector<1x16xbf16>
    %8 = "vector.load"(%arg3, %1, %1) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %9 = "vector.load"(%arg3, %1, %2) : (memref<2x64xf32>, index, index) -> vector<1x16xf32>
    %10 = "vector.contract"(%5, %6, %8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %11 = "vector.contract"(%5, %7, %9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1xbf16>, vector<1x16xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "vector.store"(%10, %arg3, %1, %1) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
    "vector.store"(%11, %arg3, %1, %2) : (vector<1x16xf32>, memref<2x64xf32>, index, index) -> ()
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

