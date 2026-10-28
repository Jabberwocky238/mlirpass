#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x4x1x2xbf16>, memref<1x1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "brgemm_to_fma"}> ({
  ^bb0(%arg1: memref<1x4x1x2xbf16>, %arg2: memref<1x1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x4x1x2xbf16>, index, index, index, index, bf16) -> vector<1x1x1x2xbf16>
    %4 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x1x32x2xbf16>, index, index, index, index, bf16) -> vector<1x1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
  "func.func"() <{function_type = (memref<1x4x1x2xbf16>, memref<1x1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "brgemm_to_fma_load"}> ({
  ^bb0(%arg1: memref<1x4x1x2xbf16>, %arg2: memref<1x1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %1, %1) : (memref<1x4x1x2xbf16>, index, index, index, index) -> vector<1x1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1, %1) : (memref<1x1x32x2xbf16>, index, index, index, index) -> vector<1x1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
  "func.func"() <{function_type = (memref<1x32x1x2xbf16>, memref<1x1x4x2xbf16>, vector<8x1xf32>) -> vector<8x1xf32>, sym_name = "brgemm_to_fma_load_bcst_B"}> ({
  ^bb0(%arg1: memref<1x32x1x2xbf16>, %arg2: memref<1x1x4x2xbf16>, %arg3: vector<8x1xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %1, %1) : (memref<1x32x1x2xbf16>, index, index, index, index) -> vector<1x8x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1, %1) : (memref<1x1x4x2xbf16>, index, index, index, index) -> vector<1x1x1x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x8x1x2xbf16>, vector<1x1x1x2xbf16>, vector<8x1xf32>) -> vector<8x1xf32>
    "func.return"(%5) : (vector<8x1xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
  "func.func"() <{function_type = (memref<1x4x1x2xbf16>, memref<1x1x32x2xbf16>, vector<1x1x8xf32>) -> vector<1x1x8xf32>, sym_name = "batch_matmul_fma_load"}> ({
  ^bb0(%arg1: memref<1x4x1x2xbf16>, %arg2: memref<1x1x32x2xbf16>, %arg3: vector<1x1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %1, %1) : (memref<1x4x1x2xbf16>, index, index, index, index) -> vector<1x1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1, %1) : (memref<1x1x32x2xbf16>, index, index, index, index) -> vector<1x1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x8x2xbf16>, vector<1x1x8xf32>) -> vector<1x1x8xf32>
    "func.return"(%5) : (vector<1x1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "matmul_outer_product_to_fma_load"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %1) : (memref<4x1x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1) : (memref<1x32x2xbf16>, index, index, index) -> vector<1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
  "func.func"() <{function_type = (memref<4x1x2xbf16>, memref<1x32x2xbf16>, vector<1x8xf32>, index) -> vector<1x8xf32>, sym_name = "matmul_dynamic_offset"}> ({
  ^bb0(%arg1: memref<4x1x2xbf16>, %arg2: memref<1x32x2xbf16>, %arg3: vector<1x8xf32>, %arg4: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %arg4, %1, %1) : (memref<4x1x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1) : (memref<1x32x2xbf16>, index, index, index) -> vector<1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
  "func.func"() <{function_type = (memref<32x1x2xbf16>, memref<1x4x2xbf16>, vector<8x1xf32>) -> vector<8x1xf32>, sym_name = "matmul_to_fma_load_bcst_B"}> ({
  ^bb0(%arg1: memref<32x1x2xbf16>, %arg2: memref<1x4x2xbf16>, %arg3: vector<8x1xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %1) : (memref<32x1x2xbf16>, index, index, index) -> vector<8x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1) : (memref<1x4x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x1x2xbf16>, vector<1x1x2xbf16>, vector<8x1xf32>) -> vector<8x1xf32>
    "func.return"(%5) : (vector<8x1xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d3, d5, d2)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d5, d4, d2)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d3, d4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x4x1x2xbf16>, memref<1x1x1x32x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>, sym_name = "many_dimensions"}> ({
  ^bb0(%arg1: memref<1x1x4x1x2xbf16>, %arg2: memref<1x1x1x32x2xbf16>, %arg3: vector<1x8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %1, %1, %1) : (memref<1x1x4x1x2xbf16>, index, index, index, index, index) -> vector<1x1x1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1, %1, %1) : (memref<1x1x1x32x2xbf16>, index, index, index, index, index) -> vector<1x1x1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x1x2xbf16>, vector<1x1x1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %6 = "vector.contract"(%4, %5, %arg3) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%6) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %1 = "vector.contract"(%arg1, %arg2, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x1x16xf32>) -> vector<1x1x16xf32>
    "func.return"(%1) : (vector<1x1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %4 = "vector.load"(%arg1, %1, %1, %1) : (memref<4x1x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %5 = "vector.load"(%arg2, %1, %1, %2) : (memref<1x32x2xbf16>, index, index, index) -> vector<1x8x2xbf16>
    %6 = "vector.contract"(%4, %5, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%6) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %6 = "vector.contract"(%4, %5, %arg3) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%6) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
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
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "vector.load"(%arg1, %1, %1, %arg4) : (memref<4x1x2xbf16>, index, index, index) -> vector<1x1x2xbf16>
    %4 = "vector.load"(%arg2, %1, %1, %1) : (memref<1x32x2xbf16>, index, index, index) -> vector<1x8x2xbf16>
    %5 = "vector.contract"(%3, %4, %arg3) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x1x2xbf16>, vector<1x8x2xbf16>, vector<1x8xf32>) -> vector<1x8xf32>
    "func.return"(%5) : (vector<1x8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.vector_contract_bf16_to_fma"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

