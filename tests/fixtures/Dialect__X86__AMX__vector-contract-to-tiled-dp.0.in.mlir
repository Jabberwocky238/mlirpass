#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x4xi8>, memref<1x16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "brgemm_int8"}> ({
  ^bb0(%arg1: memref<1x32x16x4xi8>, %arg2: memref<1x16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x4xi8>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x4xi8>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x4xi8>, vector<1x16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x16x4xi8>, memref<16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "matmul_int8"}> ({
  ^bb0(%arg1: memref<32x16x4xi8>, %arg2: memref<16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<32x16x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xbf16>, memref<1x16x32x2xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "brgemm_bf16"}> ({
  ^bb0(%arg1: memref<1x32x16x2xbf16>, %arg2: memref<1x16x32x2xbf16>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xbf16>, memref<1x16x32x2xbf16>, memref<1x32x32xf32>) -> memref<1x32x32xf32>, sym_name = "batch_matmul_bf16"}> ({
  ^bb0(%arg1: memref<1x32x16x2xbf16>, %arg2: memref<1x16x32x2xbf16>, %arg3: memref<1x32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %1, %3) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x32xf32>, index, index, index, f32) -> vector<1x16x16xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<1x16x16xf32>) -> vector<1x16x16xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<1x16x16xf32>, memref<1x32x32xf32>, index, index, index) -> ()
    "func.return"(%arg3) : (memref<1x32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x4xf8E5M2>, memref<1x16x32x4xf8E5M2>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "brgemm_f8E5M2"}> ({
  ^bb0(%arg1: memref<1x32x16x4xf8E5M2>, %arg2: memref<1x16x32x4xf8E5M2>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f8E5M2
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x4xf8E5M2>, index, index, index, index, f8E5M2) -> vector<1x16x16x4xf8E5M2>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x4xf8E5M2>, index, index, index, index, f8E5M2) -> vector<1x16x16x4xf8E5M2>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x4xf8E5M2>, vector<1x16x16x4xf8E5M2>, vector<16x16xf32>) -> vector<16x16xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<32x64xi8>, memref<64x32xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "online_packing_int8"}> ({
  ^bb0(%arg1: memref<32x64xi8>, %arg2: memref<64x32xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xi8>, index, index, i8) -> vector<16x64xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8>, index, index, i8) -> vector<64x16xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "arith.constant"() <{value = dense<13> : vector<16x16xi32>}> : () -> vector<16x16xi32>
    %8 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    %9 = "arith.addi"(%8, %7) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%9, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x32xbf16>, memref<1x32x32xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "online_packing_bf16"}> ({
  ^bb0(%arg1: memref<1x32x32xbf16>, %arg2: memref<1x32x32xbf16>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16>, index, index, index, bf16) -> vector<1x16x32xbf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16>, index, index, index, bf16) -> vector<1x32x16xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x64x2xbf16>, memref<16x64x128x2xbf16>, memref<64x128xf32>) -> memref<64x128xf32>, sym_name = "brgemm_bf16_loop"}> ({
  ^bb0(%arg1: memref<16x64x64x2xbf16>, %arg2: memref<16x64x128x2xbf16>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg5: index):
        %9 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %10 = "vector.transfer_read"(%9, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %11 = "vector.transfer_read"(%9, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %12 = "vector.transfer_read"(%9, %6, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %13 = "vector.transfer_read"(%9, %6, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %14:4 = "scf.for"(%3, %6, %8, %10, %11, %12, %13) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xf32>, %arg8: vector<16x16xf32>, %arg9: vector<16x16xf32>, %arg10: vector<16x16xf32>):
          %15:4 = "scf.for"(%3, %4, %6, %arg7, %arg8, %arg9, %arg10) ({
          ^bb0(%arg11: index, %arg12: vector<16x16xf32>, %arg13: vector<16x16xf32>, %arg14: vector<16x16xf32>, %arg15: vector<16x16xf32>):
            %16 = "memref.subview"(%arg1, %arg6, %arg4, %arg11) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 32, 16, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x64x2xbf16>, index, index, index) -> memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>>
            %17 = "memref.subview"(%arg2, %arg6, %arg11, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 32, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x128x2xbf16>, index, index, index) -> memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>>
            %18 = "vector.transfer_read"(%16, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
            %19 = "vector.transfer_read"(%17, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
            %20 = "vector.contract"(%18, %19, %arg12) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            %21 = "vector.transfer_read"(%17, %3, %3, %6, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
            %22 = "vector.contract"(%18, %21, %arg13) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            %23 = "vector.transfer_read"(%16, %3, %6, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
            %24 = "vector.contract"(%23, %19, %arg14) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            %25 = "vector.contract"(%23, %21, %arg15) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            "scf.yield"(%20, %22, %24, %25) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
          }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
          "scf.yield"(%15#0, %15#1, %15#2, %15#3) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%14#3, %9, %6, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%14#2, %9, %6, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%14#1, %9, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%14#0, %9, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg3) : (memref<64x128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64x4xi8>, memref<64x128x4xi8>, memref<64x128xi32>) -> (), sym_name = "matmul_int8_loop"}> ({
  ^bb0(%arg1: memref<64x64x4xi8>, %arg2: memref<64x128x4xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%3, %4, %6) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg5: index):
        %8 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<16x32xi32, strided<[128, 1], offset: ?>>
        %9 = "vector.transfer_read"(%8, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %10 = "vector.transfer_read"(%8, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %11:2 = "scf.for"(%3, %4, %6, %9, %10) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xi32>, %arg8: vector<16x16xi32>):
          %12 = "memref.subview"(%arg1, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 16, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x64x4xi8>, index, index) -> memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %13 = "memref.subview"(%arg2, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 32, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x128x4xi8>, index, index) -> memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>
          %14 = "vector.transfer_read"(%12, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %15 = "vector.transfer_read"(%13, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %16 = "vector.transfer_read"(%13, %3, %6, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %17 = "vector.contract"(%14, %15, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 4, 16, 16, 16>} : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %18 = "vector.contract"(%14, %16, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 4, 16, 16, 16>} : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          "scf.yield"(%17, %18) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
        }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
        "vector.transfer_write"(%11#1, %8, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%11#0, %8, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64x4xf8E4M3FN>, memref<64x128x4xf8E4M3FN>, memref<64x128xf32>) -> (), sym_name = "matmul_f8E4M3FN_loop"}> ({
  ^bb0(%arg1: memref<64x64x4xf8E4M3FN>, %arg2: memref<64x128x4xf8E4M3FN>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f8E4M3FN
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%3, %4, %6) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg5: index):
        %8 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<16x32xf32, strided<[128, 1], offset: ?>>
        %9 = "vector.transfer_read"(%8, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %10 = "vector.transfer_read"(%8, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %11:2 = "scf.for"(%3, %4, %6, %9, %10) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xf32>, %arg8: vector<16x16xf32>):
          %12 = "memref.subview"(%arg1, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 16, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x64x4xf8E4M3FN>, index, index) -> memref<16x16x4xf8E4M3FN, strided<[256, 4, 1], offset: ?>>
          %13 = "memref.subview"(%arg2, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 32, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x128x4xf8E4M3FN>, index, index) -> memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>>
          %14 = "vector.transfer_read"(%12, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x16x4xf8E4M3FN, strided<[256, 4, 1], offset: ?>>, index, index, index, f8E4M3FN) -> vector<16x16x4xf8E4M3FN>
          %15 = "vector.transfer_read"(%13, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>>, index, index, index, f8E4M3FN) -> vector<16x16x4xf8E4M3FN>
          %16 = "vector.transfer_read"(%13, %3, %6, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>>, index, index, index, f8E4M3FN) -> vector<16x16x4xf8E4M3FN>
          %17 = "vector.contract"(%14, %15, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 4, 16, 16, 16>} : (vector<16x16x4xf8E4M3FN>, vector<16x16x4xf8E4M3FN>, vector<16x16xf32>) -> vector<16x16xf32>
          %18 = "vector.contract"(%14, %16, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 4, 16, 16, 16>} : (vector<16x16x4xf8E4M3FN>, vector<16x16x4xf8E4M3FN>, vector<16x16xf32>) -> vector<16x16xf32>
          "scf.yield"(%17, %18) : (vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%11#1, %8, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%11#0, %8, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x64x4xi8>, memref<16x64x128x4xi8>, memref<16x64x128xi32>) -> (), sym_name = "batch_matmul_int8_loop"}> ({
  ^bb0(%arg1: memref<16x64x64x4xi8>, %arg2: memref<16x64x128x4xi8>, %arg3: memref<16x64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %6) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg5: index):
        "scf.for"(%3, %6, %8) ({
        ^bb0(%arg6: index):
          %9 = "memref.subview"(%arg3, %arg6, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x128xi32>, index, index, index) -> memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
          %10 = "vector.transfer_read"(%9, %3, %3, %3, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index, i32) -> vector<1x16x16xi32>
          %11 = "vector.transfer_read"(%9, %3, %3, %6, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index, i32) -> vector<1x16x16xi32>
          %12:2 = "scf.for"(%3, %4, %6, %10, %11) ({
          ^bb0(%arg7: index, %arg8: vector<1x16x16xi32>, %arg9: vector<1x16x16xi32>):
            %13 = "memref.subview"(%arg1, %arg6, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 16, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x64x4xi8>, index, index, index) -> memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>
            %14 = "memref.subview"(%arg2, %arg6, %arg7, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 32, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x128x4xi8>, index, index, index) -> memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>
            %15 = "vector.transfer_read"(%13, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
            %16 = "vector.transfer_read"(%14, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
            %17 = "vector.transfer_read"(%14, %3, %3, %6, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
            %18 = "vector.contract"(%15, %16, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 4, 16, 16, 16>} : (vector<1x16x16x4xi8>, vector<1x16x16x4xi8>, vector<1x16x16xi32>) -> vector<1x16x16xi32>
            %19 = "vector.contract"(%15, %17, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 4, 16, 16, 16>} : (vector<1x16x16x4xi8>, vector<1x16x16x4xi8>, vector<1x16x16xi32>) -> vector<1x16x16xi32>
            "scf.yield"(%18, %19) : (vector<1x16x16xi32>, vector<1x16x16xi32>) -> ()
          }) : (index, index, index, vector<1x16x16xi32>, vector<1x16x16xi32>) -> (vector<1x16x16xi32>, vector<1x16x16xi32>)
          "vector.transfer_write"(%12#1, %9, %3, %3, %6) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<1x16x16xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> ()
          "vector.transfer_write"(%12#0, %9, %3, %3, %3) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<1x16x16xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<16x64x96xbf16>, memref<16x96x128xbf16>, memref<64x128xf32>) -> memref<64x128xf32>, sym_name = "online_packing_bf16_loop"}> ({
  ^bb0(%arg1: memref<16x64x96xbf16>, %arg2: memref<16x96x128xbf16>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 96 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %8) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %8) ({
      ^bb0(%arg5: index):
        %11 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %12 = "vector.transfer_read"(%11, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %13 = "vector.transfer_read"(%11, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %14 = "vector.transfer_read"(%11, %6, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %15 = "vector.transfer_read"(%11, %6, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %16:4 = "scf.for"(%3, %6, %9, %12, %13, %14, %15) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xf32>, %arg8: vector<16x16xf32>, %arg9: vector<16x16xf32>, %arg10: vector<16x16xf32>):
          %17:4 = "scf.for"(%3, %7, %8, %arg7, %arg8, %arg9, %arg10) ({
          ^bb0(%arg11: index, %arg12: vector<16x16xf32>, %arg13: vector<16x16xf32>, %arg14: vector<16x16xf32>, %arg15: vector<16x16xf32>):
            %18 = "memref.subview"(%arg1, %arg6, %arg4, %arg11) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x96xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %19 = "memref.subview"(%arg2, %arg6, %arg11, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x96x128xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            %20 = "vector.transfer_read"(%18, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index, bf16) -> vector<1x16x32xbf16>
            %21 = "vector.transfer_read"(%18, %3, %6, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index, bf16) -> vector<1x16x32xbf16>
            %22 = "vector.transfer_read"(%19, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<1x32x16xbf16>
            %23 = "vector.transfer_read"(%19, %3, %3, %6, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<1x32x16xbf16>
            %24 = "vector.contract"(%20, %22, %arg12) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            %25 = "vector.contract"(%20, %23, %arg13) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            %26 = "vector.contract"(%21, %22, %arg14) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            %27 = "vector.contract"(%21, %23, %arg15) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
            "scf.yield"(%24, %25, %26, %27) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
          }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
          "scf.yield"(%17#0, %17#1, %17#2, %17#3) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%16#3, %11, %6, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#2, %11, %6, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#1, %11, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#0, %11, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %10) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%10) : (memref<64x128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<64x96xbf16>, memref<96x128xbf16>, memref<64x128xf32>, index, index) -> memref<64x128xf32>, sym_name = "online_packing_bf16_loop_lb_non_zero"}> ({
  ^bb0(%arg1: memref<64x96xbf16>, %arg2: memref<96x128xbf16>, %arg3: memref<64x128xf32>, %arg4: index, %arg5: index):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 96 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %8) ({
    ^bb0(%arg6: index):
      "scf.for"(%3, %5, %8) ({
      ^bb0(%arg7: index):
        %11 = "memref.subview"(%arg3, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %12 = "vector.transfer_read"(%11, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %13 = "vector.transfer_read"(%11, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %14 = "vector.transfer_read"(%11, %6, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %15 = "vector.transfer_read"(%11, %6, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %16:4 = "scf.for"(%arg4, %arg5, %8, %12, %13, %14, %15) ({
        ^bb0(%arg8: index, %arg9: vector<16x16xf32>, %arg10: vector<16x16xf32>, %arg11: vector<16x16xf32>, %arg12: vector<16x16xf32>):
          %17 = "memref.subview"(%arg1, %arg6, %arg8) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x96xbf16>, index, index) -> memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %18 = "memref.subview"(%arg2, %arg8, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<96x128xbf16>, index, index) -> memref<32x32xbf16, strided<[128, 1], offset: ?>>
          %19 = "vector.transfer_read"(%17, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index, bf16) -> vector<16x32xbf16>
          %20 = "vector.transfer_read"(%17, %6, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index, bf16) -> vector<16x32xbf16>
          %21 = "vector.transfer_read"(%18, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32x16xbf16>
          %22 = "vector.transfer_read"(%18, %3, %6, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32x16xbf16>
          %23 = "vector.contract"(%19, %21, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %24 = "vector.contract"(%19, %22, %arg10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %25 = "vector.contract"(%20, %21, %arg11) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %26 = "vector.contract"(%20, %22, %arg12) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          "scf.yield"(%23, %24, %25, %26) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%16#3, %11, %6, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#2, %11, %6, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#1, %11, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#0, %11, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %10) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%10) : (memref<64x128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<64x256xf8E5M2>, memref<256x128xf8E5M2>, memref<64x128xf32>) -> memref<64x128xf32>, sym_name = "online_packing_f8E5M2_matmul_loop"}> ({
  ^bb0(%arg1: memref<64x256xf8E5M2>, %arg2: memref<256x128xf8E5M2>, %arg3: memref<64x128xf32>):
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f8E5M2
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 64 : index}> : () -> index
    %6 = "arith.constant"() <{value = 128 : index}> : () -> index
    %7 = "arith.constant"() <{value = 256 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%4, %5, %8) ({
    ^bb0(%arg4: index):
      "scf.for"(%4, %6, %8) ({
      ^bb0(%arg5: index):
        %10 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %11 = "vector.transfer_read"(%10, %4, %4, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %12 = "vector.transfer_read"(%10, %4, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %13 = "vector.transfer_read"(%10, %1, %4, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %14 = "vector.transfer_read"(%10, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %15:4 = "scf.for"(%4, %7, %5, %11, %12, %13, %14) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xf32>, %arg8: vector<16x16xf32>, %arg9: vector<16x16xf32>, %arg10: vector<16x16xf32>):
          %16 = "memref.subview"(%arg1, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xf8E5M2>, index, index) -> memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>
          %17 = "memref.subview"(%arg2, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xf8E5M2>, index, index) -> memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>
          %18 = "vector.transfer_read"(%16, %4, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>, index, index, f8E5M2) -> vector<16x64xf8E5M2>
          %19 = "vector.transfer_read"(%16, %1, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>, index, index, f8E5M2) -> vector<16x64xf8E5M2>
          %20 = "vector.transfer_read"(%17, %4, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, index, index, f8E5M2) -> vector<64x16xf8E5M2>
          %21 = "vector.transfer_read"(%17, %4, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, index, index, f8E5M2) -> vector<64x16xf8E5M2>
          %22 = "vector.contract"(%18, %20, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xf8E5M2>, vector<64x16xf8E5M2>, vector<16x16xf32>) -> vector<16x16xf32>
          %23 = "vector.contract"(%18, %21, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xf8E5M2>, vector<64x16xf8E5M2>, vector<16x16xf32>) -> vector<16x16xf32>
          %24 = "vector.contract"(%19, %20, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xf8E5M2>, vector<64x16xf8E5M2>, vector<16x16xf32>) -> vector<16x16xf32>
          %25 = "vector.contract"(%19, %21, %arg10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xf8E5M2>, vector<64x16xf8E5M2>, vector<16x16xf32>) -> vector<16x16xf32>
          "scf.yield"(%22, %23, %24, %25) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%15#3, %10, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%15#2, %10, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%15#1, %10, %4, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%15#0, %10, %4, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %9) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%9) : (memref<64x128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x16x2xbf16>, memref<16x16x32x2xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "brgemm_bf16_with_cano"}> ({
  ^bb0(%arg1: memref<16x32x16x2xbf16>, %arg2: memref<16x16x32x2xbf16>, %arg3: memref<32x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "vector.transfer_read"(%arg3, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %7 = "vector.transfer_read"(%arg3, %3, %4, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %8 = "vector.transfer_read"(%arg3, %4, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %9 = "vector.transfer_read"(%arg3, %4, %4, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %10:4 = "scf.for"(%3, %4, %5, %6, %7, %8, %9) ({
    ^bb0(%arg4: index, %arg5: vector<16x16xf32>, %arg6: vector<16x16xf32>, %arg7: vector<16x16xf32>, %arg8: vector<16x16xf32>):
      %12 = "memref.subview"(%arg1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 32, 16, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x32x16x2xbf16>, index) -> memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>>
      %13 = "memref.subview"(%arg2, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 16, 32, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x16x32x2xbf16>, index) -> memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>>
      %14 = "vector.transfer_read"(%12, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
      %15 = "vector.transfer_read"(%12, %3, %4, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
      %16 = "vector.transfer_read"(%13, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
      %17 = "vector.transfer_read"(%13, %3, %3, %4, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
      %18 = "vector.contract"(%14, %16, %arg5) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
      %19 = "vector.contract"(%14, %17, %arg6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
      %20 = "vector.contract"(%15, %16, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
      %21 = "vector.contract"(%15, %17, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 16, 16, 16>} : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
      "scf.yield"(%18, %19, %20, %21) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
    }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
    "vector.transfer_write"(%10#3, %arg3, %4, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "vector.transfer_write"(%10#2, %arg3, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "vector.transfer_write"(%10#1, %arg3, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "vector.transfer_write"(%10#0, %arg3, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    %11 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    "memref.copy"(%arg3, %11) : (memref<32x32xf32>, memref<32x32xf32>) -> ()
    "func.return"(%11) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<64x256xi8>, memref<256x128xi8>, memref<64x128xi32>) -> memref<64x128xi32>, sym_name = "online_packing_int8_matmul_loop"}> ({
  ^bb0(%arg1: memref<64x256xi8>, %arg2: memref<256x128xi8>, %arg3: memref<64x128xi32>):
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 64 : index}> : () -> index
    %6 = "arith.constant"() <{value = 128 : index}> : () -> index
    %7 = "arith.constant"() <{value = 256 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "arith.constant"() <{value = dense<13> : vector<16x16xi32>}> : () -> vector<16x16xi32>
    "scf.for"(%4, %5, %8) ({
    ^bb0(%arg4: index):
      "scf.for"(%4, %6, %8) ({
      ^bb0(%arg5: index):
        %11 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<32x32xi32, strided<[128, 1], offset: ?>>
        %12 = "vector.transfer_read"(%11, %4, %4, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %13 = "vector.transfer_read"(%11, %4, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %14 = "vector.transfer_read"(%11, %1, %4, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %15 = "vector.transfer_read"(%11, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %16:4 = "scf.for"(%4, %7, %5, %12, %13, %14, %15) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xi32>, %arg8: vector<16x16xi32>, %arg9: vector<16x16xi32>, %arg10: vector<16x16xi32>):
          %21 = "memref.subview"(%arg1, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xi8>, index, index) -> memref<32x64xi8, strided<[256, 1], offset: ?>>
          %22 = "memref.subview"(%arg2, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xi8>, index, index) -> memref<64x32xi8, strided<[128, 1], offset: ?>>
          %23 = "vector.transfer_read"(%21, %4, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index, i8) -> vector<16x64xi8>
          %24 = "vector.transfer_read"(%21, %1, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index, i8) -> vector<16x64xi8>
          %25 = "vector.transfer_read"(%22, %4, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<64x16xi8>
          %26 = "vector.transfer_read"(%22, %4, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<64x16xi8>
          %27 = "vector.contract"(%23, %25, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %28 = "vector.contract"(%23, %26, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %29 = "vector.contract"(%24, %25, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %30 = "vector.contract"(%24, %26, %arg10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          "scf.yield"(%27, %28, %29, %30) : (vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>) -> ()
        }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>)
        %17 = "arith.addi"(%16#3, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        %18 = "arith.addi"(%16#2, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        %19 = "arith.addi"(%16#1, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        %20 = "arith.addi"(%16#0, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        "vector.transfer_write"(%17, %11, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%18, %11, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%19, %11, %4, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%20, %11, %4, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi32>
    "memref.copy"(%arg3, %10) : (memref<64x128xi32>, memref<64x128xi32>) -> ()
    "func.return"(%10) : (memref<64x128xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x4xi8>, memref<1x16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "negative_invalid_vc_kind"}> ({
  ^bb0(%arg1: memref<1x32x16x4xi8>, %arg2: memref<1x16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x4xi8>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x4xi8>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<mul>}> : (vector<1x16x16x4xi8>, vector<1x16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xbf16>, memref<1x16x32x2xbf16>, memref<1x32x32xf32>) -> memref<1x32x32xf32>, sym_name = "negative_wrong_dimensions"}> ({
  ^bb0(%arg1: memref<1x32x16x2xbf16>, %arg2: memref<1x16x32x2xbf16>, %arg3: memref<1x32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x2xbf16>, index, index, index, index, bf16) -> vector<1x32x16x2xbf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x2xbf16>, index, index, index, index, bf16) -> vector<1x16x32x2xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %1, %3) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<1x32x32xf32>, index, index, index, f32) -> vector<1x32x32xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x32x16x2xbf16>, vector<1x16x32x2xbf16>, vector<1x32x32xf32>) -> vector<1x32x32xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<1x32x32xf32>, memref<1x32x32xf32>, index, index, index) -> ()
    "func.return"(%arg3) : (memref<1x32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16x16x4xi8>, memref<16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "negative_no_memref_source_LHS"}> ({
  ^bb0(%arg1: vector<16x16x4xi8>, %arg2: memref<16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %5 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %6 = "vector.contract"(%arg1, %4, %5) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%6, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x32xbf16>, memref<1x32x32xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "negative_wrong_dimensions_online_packing"}> ({
  ^bb0(%arg1: memref<1x32x32xbf16>, %arg2: memref<1x32x32xbf16>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16>, index, index, index, bf16) -> vector<1x16x32xbf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16>, index, index, index, bf16) -> vector<1x32x32xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x32xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x32xbf16>, vector<1x32x32xbf16>, vector<16x32xf32>) -> vector<16x32xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x32xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64x4xi8>, memref<64x128x4xi8>, memref<64x128xi32>, memref<64x64x4xi8>) -> (), sym_name = "negative_VCs_LHS_src_differ"}> ({
  ^bb0(%arg1: memref<64x64x4xi8>, %arg2: memref<64x128x4xi8>, %arg3: memref<64x128xi32>, %arg4: memref<64x64x4xi8>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%3, %4, %6) ({
    ^bb0(%arg5: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg6: index):
        %8 = "memref.subview"(%arg3, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<16x32xi32, strided<[128, 1], offset: ?>>
        %9 = "vector.transfer_read"(%8, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %10 = "vector.transfer_read"(%8, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %11:2 = "scf.for"(%3, %4, %6, %9, %10) ({
        ^bb0(%arg7: index, %arg8: vector<16x16xi32>, %arg9: vector<16x16xi32>):
          %12 = "memref.subview"(%arg1, %arg5, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 16, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x64x4xi8>, index, index) -> memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %13 = "memref.subview"(%arg4, %arg5, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 16, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x64x4xi8>, index, index) -> memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %14 = "memref.subview"(%arg2, %arg7, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 32, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x128x4xi8>, index, index) -> memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>
          %15 = "vector.transfer_read"(%12, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %16 = "vector.transfer_read"(%13, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %17 = "vector.transfer_read"(%14, %3, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %18 = "vector.transfer_read"(%14, %3, %6, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>, index, index, index, i8) -> vector<16x16x4xi8>
          %19 = "vector.contract"(%15, %17, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 4, 16, 16, 16>} : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %20 = "vector.contract"(%16, %18, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 4, 16, 16, 16>} : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          "scf.yield"(%19, %20) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
        }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
        "vector.transfer_write"(%11#1, %8, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%11#0, %8, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x64x4xi8>, memref<16x64x128x4xi8>, memref<16x64x128xi32>) -> (), sym_name = "negative_wrong_N_dim"}> ({
  ^bb0(%arg1: memref<16x64x64x4xi8>, %arg2: memref<16x64x128x4xi8>, %arg3: memref<16x64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %6) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg5: index):
        "scf.for"(%3, %6, %8) ({
        ^bb0(%arg6: index):
          %9 = "memref.subview"(%arg3, %arg6, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x128xi32>, index, index, index) -> memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
          %10 = "vector.transfer_read"(%9, %3, %3, %3, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index, i32) -> vector<1x16x32xi32>
          %11 = "scf.for"(%3, %4, %6, %10) ({
          ^bb0(%arg7: index, %arg8: vector<1x16x32xi32>):
            %12 = "memref.subview"(%arg1, %arg6, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 16, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x64x4xi8>, index, index, index) -> memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>
            %13 = "memref.subview"(%arg2, %arg6, %arg7, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 32, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x128x4xi8>, index, index, index) -> memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>
            %14 = "vector.transfer_read"(%12, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>, index, index, index, index, i8) -> vector<1x16x16x4xi8>
            %15 = "vector.transfer_read"(%13, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>, index, index, index, index, i8) -> vector<1x16x32x4xi8>
            %16 = "vector.contract"(%14, %15, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 4, 16, 32, 16>} : (vector<1x16x16x4xi8>, vector<1x16x32x4xi8>, vector<1x16x32xi32>) -> vector<1x16x32xi32>
            "scf.yield"(%16) : (vector<1x16x32xi32>) -> ()
          }) : (index, index, index, vector<1x16x32xi32>) -> vector<1x16x32xi32>
          "vector.transfer_write"(%11, %9, %3, %3, %3) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<1x16x32xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<64x96xbf16>, memref<96x128xbf16>, memref<64x128xf32>, index) -> memref<64x128xf32>, sym_name = "negative_online_packing_bf16_dynamic_loop_step"}> ({
  ^bb0(%arg1: memref<64x96xbf16>, %arg2: memref<96x128xbf16>, %arg3: memref<64x128xf32>, %arg4: index):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "arith.constant"() <{value = 96 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %8) ({
    ^bb0(%arg5: index):
      "scf.for"(%3, %5, %8) ({
      ^bb0(%arg6: index):
        %11 = "memref.subview"(%arg3, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %12 = "vector.transfer_read"(%11, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %13 = "vector.transfer_read"(%11, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %14 = "vector.transfer_read"(%11, %6, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %15 = "vector.transfer_read"(%11, %6, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %16:4 = "scf.for"(%3, %8, %arg4, %12, %13, %14, %15) ({
        ^bb0(%arg7: index, %arg8: vector<16x16xf32>, %arg9: vector<16x16xf32>, %arg10: vector<16x16xf32>, %arg11: vector<16x16xf32>):
          %17 = "memref.subview"(%arg1, %arg5, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x96xbf16>, index, index) -> memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %18 = "memref.subview"(%arg2, %arg7, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<96x128xbf16>, index, index) -> memref<32x32xbf16, strided<[128, 1], offset: ?>>
          %19 = "vector.transfer_read"(%17, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index, bf16) -> vector<16x32xbf16>
          %20 = "vector.transfer_read"(%17, %6, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index, bf16) -> vector<16x32xbf16>
          %21 = "vector.transfer_read"(%18, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32x16xbf16>
          %22 = "vector.transfer_read"(%18, %3, %6, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32x16xbf16>
          %23 = "vector.contract"(%19, %21, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %24 = "vector.contract"(%19, %22, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %25 = "vector.contract"(%20, %21, %arg10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %26 = "vector.contract"(%20, %22, %arg11) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          "scf.yield"(%23, %24, %25, %26) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%16#3, %11, %6, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#2, %11, %6, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#1, %11, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16#0, %11, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %10) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%10) : (memref<64x128xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d3, d5, d2)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d5, d4, d2)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x16x64x64x4xi8>, memref<2x16x64x128x4xi8>, memref<64x128xi32>) -> (), sym_name = "negative_reduction_loop_depth_3"}> ({
  ^bb0(%arg1: memref<2x16x64x64x4xi8>, %arg2: memref<2x16x64x128x4xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 2 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %8) ({
      ^bb0(%arg5: index):
        %10 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<16x32xi32, strided<[128, 1], offset: ?>>
        %11 = "vector.transfer_read"(%10, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %12 = "vector.transfer_read"(%10, %3, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %13:2 = "scf.for"(%3, %6, %9, %11, %12) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xi32>, %arg8: vector<16x16xi32>):
          %14:2 = "scf.for"(%3, %7, %9, %arg7, %arg8) ({
          ^bb0(%arg9: index, %arg10: vector<16x16xi32>, %arg11: vector<16x16xi32>):
            %15:2 = "scf.for"(%3, %4, %7, %arg10, %arg11) ({
            ^bb0(%arg12: index, %arg13: vector<16x16xi32>, %arg14: vector<16x16xi32>):
              %16 = "memref.subview"(%arg1, %arg6, %arg9, %arg4, %arg12) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 16, 16, 4>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (memref<2x16x64x64x4xi8>, index, index, index, index) -> memref<1x1x16x16x4xi8, strided<[262144, 16384, 256, 4, 1], offset: ?>>
              %17 = "memref.subview"(%arg2, %arg6, %arg9, %arg12, %arg5) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 16, 32, 4>, static_strides = array<i64: 1, 1, 1, 1, 1>}> : (memref<2x16x64x128x4xi8>, index, index, index, index) -> memref<1x1x16x32x4xi8, strided<[524288, 32768, 512, 4, 1], offset: ?>>
              %18 = "vector.transfer_read"(%16, %3, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true, true], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map1}> : (memref<1x1x16x16x4xi8, strided<[262144, 16384, 256, 4, 1], offset: ?>>, index, index, index, index, index, i8) -> vector<1x1x16x16x4xi8>
              %19 = "vector.transfer_read"(%17, %3, %3, %3, %3, %3, %2) <{in_bounds = [true, true, true, true, true], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map1}> : (memref<1x1x16x32x4xi8, strided<[524288, 32768, 512, 4, 1], offset: ?>>, index, index, index, index, index, i8) -> vector<1x1x16x16x4xi8>
              %20 = "vector.transfer_read"(%17, %3, %3, %3, %7, %3, %2) <{in_bounds = [true, true, true, true, true], operandSegmentSizes = array<i32: 1, 5, 1, 0>, permutation_map = #map1}> : (memref<1x1x16x32x4xi8, strided<[524288, 32768, 512, 4, 1], offset: ?>>, index, index, index, index, index, i8) -> vector<1x1x16x16x4xi8>
              %21 = "vector.contract"(%18, %19, %arg13) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 4, 16, 16, 16>} : (vector<1x1x16x16x4xi8>, vector<1x1x16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
              %22 = "vector.contract"(%18, %20, %arg14) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 1, 4, 16, 16, 16>} : (vector<1x1x16x16x4xi8>, vector<1x1x16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
              "scf.yield"(%21, %22) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
            }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
            "scf.yield"(%15#0, %15#1) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
          }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
          "scf.yield"(%14#0, %14#1) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
        }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
        "vector.transfer_write"(%13#1, %10, %3, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%13#0, %10, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {dlti.target_system_spec = #dlti.target_system_spec<"CPU" = #dlti.target_device_spec<"reg_gemm_unroll" = [16, 16, 16]>>} : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xf16>, memref<1x16x32x2xf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "negative_wrong_type_f16"}> ({
  ^bb0(%arg1: memref<1x32x16x2xf16>, %arg2: memref<1x16x32x2xf16>, %arg3: memref<32x32xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x2xf16>, index, index, index, index, f16) -> vector<1x16x16x2xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x2xf16>, index, index, index, index, f16) -> vector<1x16x16x2xf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x2xf16>, vector<1x16x16x2xf16>, vector<16x16xf32>) -> vector<16x16xf32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xbf16>, memref<1x16x32x2xbf16>, memref<32x32xbf16>) -> memref<32x32xbf16>, sym_name = "negative_wrong_acc_type_bf16"}> ({
  ^bb0(%arg1: memref<1x32x16x2xbf16>, %arg2: memref<1x16x32x2xbf16>, %arg3: memref<32x32xbf16>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xbf16>, index, index, bf16) -> vector<16x16xbf16>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xbf16>) -> vector<16x16xbf16>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xbf16>, memref<32x32xbf16>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xbf16>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<64x256xi8>, memref<256x128xi8>, memref<64x128xi32>) -> memref<64x128xi32>, sym_name = "negative_vc_wrong_order_no_pair"}> ({
  ^bb0(%arg1: memref<64x256xi8>, %arg2: memref<256x128xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 256 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %8) ({
      ^bb0(%arg5: index):
        %10 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<16x32xi32, strided<[128, 1], offset: ?>>
        %11 = "vector.transfer_read"(%10, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %12 = "vector.transfer_read"(%10, %3, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %13:2 = "scf.for"(%3, %6, %4, %11, %12) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xi32>, %arg8: vector<16x16xi32>):
          %14 = "memref.subview"(%arg1, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 16, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xi8>, index, index) -> memref<16x64xi8, strided<[256, 1], offset: ?>>
          %15 = "memref.subview"(%arg2, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xi8>, index, index) -> memref<64x32xi8, strided<[128, 1], offset: ?>>
          %16 = "vector.transfer_read"(%14, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x64xi8, strided<[256, 1], offset: ?>>, index, index, i8) -> vector<16x64xi8>
          %17 = "vector.transfer_read"(%15, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<64x16xi8>
          %18 = "vector.transfer_read"(%15, %3, %7, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<64x16xi8>
          %19 = "vector.contract"(%16, %18, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %20 = "vector.contract"(%16, %17, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          "scf.yield"(%20, %19) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
        }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
        "vector.transfer_write"(%13#1, %10, %3, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%13#0, %10, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi32>
    "memref.copy"(%arg3, %9) : (memref<64x128xi32>, memref<64x128xi32>) -> ()
    "func.return"(%9) : (memref<64x128xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<64x256xi8>, memref<256x128xi8>, memref<64x128xi32>) -> memref<64x128xi32>, sym_name = "negative_vc_no_pair"}> ({
  ^bb0(%arg1: memref<64x256xi8>, %arg2: memref<256x128xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 128 : index}> : () -> index
    %6 = "arith.constant"() <{value = 256 : index}> : () -> index
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    %8 = "arith.constant"() <{value = 16 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg4: index):
      "scf.for"(%3, %5, %8) ({
      ^bb0(%arg5: index):
        %10 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 16>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<32x16xi32, strided<[128, 1], offset: ?>>
        %11 = "vector.transfer_read"(%10, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x16xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %12 = "vector.transfer_read"(%10, %8, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x16xi32, strided<[128, 1], offset: ?>>, index, index, i32) -> vector<16x16xi32>
        %13:2 = "scf.for"(%3, %6, %4, %11, %12) ({
        ^bb0(%arg6: index, %arg7: vector<16x16xi32>, %arg8: vector<16x16xi32>):
          %14 = "memref.subview"(%arg1, %arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xi8>, index, index) -> memref<32x64xi8, strided<[256, 1], offset: ?>>
          %15 = "memref.subview"(%arg2, %arg6, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x128xi8>, index, index) -> memref<64x16xi8, strided<[128, 1], offset: ?>>
          %16 = "vector.transfer_read"(%14, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index, i8) -> vector<16x64xi8>
          %17 = "vector.transfer_read"(%14, %8, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index, i8) -> vector<16x64xi8>
          %18 = "vector.transfer_read"(%15, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x16xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<64x16xi8>
          %19 = "vector.contract"(%16, %18, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          %20 = "vector.contract"(%17, %18, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 16, 16, 64>} : (vector<16x64xi8>, vector<64x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
          "scf.yield"(%19, %20) : (vector<16x16xi32>, vector<16x16xi32>) -> ()
        }) : (index, index, index, vector<16x16xi32>, vector<16x16xi32>) -> (vector<16x16xi32>, vector<16x16xi32>)
        "vector.transfer_write"(%13#1, %10, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x16xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%13#0, %10, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x16xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi32>
    "memref.copy"(%arg3, %9) : (memref<64x128xi32>, memref<64x128xi32>) -> ()
    "func.return"(%9) : (memref<64x128xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
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
  "func.func"() <{function_type = (memref<16x64x32xbf16>, memref<16x32x128xbf16>, memref<64x32xf32>) -> (), sym_name = "negative_no_read_op_source"}> ({
  ^bb0(%arg1: memref<16x64x32xbf16>, %arg2: memref<16x32x128xbf16>, %arg3: memref<64x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %4, %6) ({
    ^bb0(%arg4: index):
      %8 = "vector.transfer_read"(%arg3, %arg4, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf32>, index, index, f32) -> vector<16x16xf32>
      %9 = "vector.transfer_read"(%arg3, %arg4, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf32>, index, index, f32) -> vector<16x16xf32>
      %10 = "arith.addi"(%arg4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "vector.transfer_read"(%arg3, %10, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf32>, index, index, f32) -> vector<16x16xf32>
      %12 = "vector.transfer_read"(%arg3, %10, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf32>, index, index, f32) -> vector<16x16xf32>
      %13:4 = "scf.for"(%3, %5, %7, %8, %9, %11, %12) ({
      ^bb0(%arg5: index, %arg6: vector<16x16xf32>, %arg7: vector<16x16xf32>, %arg8: vector<16x16xf32>, %arg9: vector<16x16xf32>):
        %14 = "vector.transfer_read"(%arg1, %arg5, %arg4, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x64x32xbf16>, index, index, index, bf16) -> vector<1x16x32xbf16>
        %15 = "vector.transfer_read"(%arg1, %arg5, %10, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x64x32xbf16>, index, index, index, bf16) -> vector<1x16x32xbf16>
        %16 = "vector.transfer_read"(%arg2, %arg5, %3, %3, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x128xbf16>, index, index, index, bf16) -> vector<1x32x16xbf16>
        %17 = "vector.transfer_read"(%arg2, %arg5, %3, %5, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<16x32x128xbf16>, index, index, index, bf16) -> vector<1x32x16xbf16>
        %18 = "vector.contract"(%14, %16, %arg6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
        %19 = "vector.contract"(%14, %17, %arg7) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
        %20 = "vector.contract"(%15, %16, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
        %21 = "vector.contract"(%15, %17, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x32xbf16>, vector<1x32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
        "scf.yield"(%18, %19, %20, %21) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
      }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
      "vector.transfer_write"(%13#3, %arg3, %10, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<64x32xf32>, index, index) -> ()
      "vector.transfer_write"(%13#2, %arg3, %10, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<64x32xf32>, index, index) -> ()
      "vector.transfer_write"(%13#1, %arg3, %arg4, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<64x32xf32>, index, index) -> ()
      "vector.transfer_write"(%13#0, %arg3, %arg4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<64x32xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<32x16x4xi8>, memref<16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "negative_lhs_tensor"}> ({
  ^bb0(%arg1: tensor<32x16x4xi8>, %arg2: memref<16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (tensor<32x16x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x16x4xi8>, tensor<16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "negative_rhs_tensor"}> ({
  ^bb0(%arg1: memref<32x16x4xi8>, %arg2: tensor<16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<32x16x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (tensor<16x32x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
    "func.return"(%arg3) : (memref<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x16x4xi8>, memref<16x32x4xi8>, tensor<32x32xi32>) -> tensor<32x32xi32>, sym_name = "negative_acc_tensor"}> ({
  ^bb0(%arg1: memref<32x16x4xi8>, %arg2: memref<16x32x4xi8>, %arg3: tensor<32x32xi32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<32x16x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x4xi8>, index, index, index, i8) -> vector<16x16x4xi8>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (tensor<32x32xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16x4xi8>, vector<16x16x4xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    %8 = "vector.transfer_write"(%7, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xi32>, tensor<32x32xi32>, index, index) -> tensor<32x32xi32>
    "func.return"(%8) : (tensor<32x32xi32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86.vector_contract_to_amx_dot_product"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

