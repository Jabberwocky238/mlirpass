#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x4xi8>, memref<1x16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "brgemm_int8"}> ({
  ^bb0(%arg1: memref<1x32x16x4xi8>, %arg2: memref<1x16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.collapse_shape"(%arg1) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x32x16x4xi8>) -> memref<1x32x64xi8>
    %4 = "memref.collapse_shape"(%arg2) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x4xi8>) -> memref<1x16x128xi8>
    %5 = "x86.amx.tile_load"(%3, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x64xi8>, index, index, index) -> !x86.amx.tile<16x64xi8>
    %6 = "x86.amx.tile_load"(%4, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x128xi8>, index, index, index) -> !x86.amx.tile<16x64xi8>
    %7 = "x86.amx.tile_load"(%arg3, %2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xi32>, index, index) -> !x86.amx.tile<16x16xi32>
    %8 = "x86.amx.tile_muli"(%5, %6, %7) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xi32>
    "x86.amx.tile_store"(%9, %2, %2, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %10 = "vector.transfer_read"(%9, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    "vector.transfer_write"(%10, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
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
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x16x4xi8>, memref<16x32x4xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "matmul_int8"}> ({
  ^bb0(%arg1: memref<32x16x4xi8>, %arg2: memref<16x32x4xi8>, %arg3: memref<32x32xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.collapse_shape"(%arg1) <{reassociation = [[0], [1, 2]]}> : (memref<32x16x4xi8>) -> memref<32x64xi8>
    %4 = "memref.collapse_shape"(%arg2) <{reassociation = [[0], [1, 2]]}> : (memref<16x32x4xi8>) -> memref<16x128xi8>
    %5 = "x86.amx.tile_load"(%3, %2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %6 = "x86.amx.tile_load"(%4, %2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x128xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %7 = "x86.amx.tile_load"(%arg3, %2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xi32>, index, index) -> !x86.amx.tile<16x16xi32>
    %8 = "x86.amx.tile_muli"(%5, %6, %7) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xi32>
    "x86.amx.tile_store"(%9, %2, %2, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %10 = "vector.transfer_read"(%9, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    "vector.transfer_write"(%10, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
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
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xbf16>, memref<1x16x32x2xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "brgemm_bf16"}> ({
  ^bb0(%arg1: memref<1x32x16x2xbf16>, %arg2: memref<1x16x32x2xbf16>, %arg3: memref<32x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.collapse_shape"(%arg1) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x32x16x2xbf16>) -> memref<1x32x32xbf16>
    %4 = "memref.collapse_shape"(%arg2) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x2xbf16>) -> memref<1x16x64xbf16>
    %5 = "x86.amx.tile_load"(%3, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %6 = "x86.amx.tile_load"(%4, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %7 = "x86.amx.tile_load"(%arg3, %2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %8 = "x86.amx.tile_mulf"(%5, %6, %7) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xf32>
    "x86.amx.tile_store"(%9, %2, %2, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    %10 = "vector.transfer_read"(%9, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<16x16xf32>
    "vector.transfer_write"(%10, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x2xbf16>, memref<1x16x32x2xbf16>, memref<1x32x32xf32>) -> memref<1x32x32xf32>, sym_name = "batch_matmul_bf16"}> ({
  ^bb0(%arg1: memref<1x32x16x2xbf16>, %arg2: memref<1x16x32x2xbf16>, %arg3: memref<1x32x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.collapse_shape"(%arg1) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x32x16x2xbf16>) -> memref<1x32x32xbf16>
    %4 = "memref.collapse_shape"(%arg2) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x2xbf16>) -> memref<1x16x64xbf16>
    %5 = "x86.amx.tile_load"(%3, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %6 = "x86.amx.tile_load"(%4, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %7 = "x86.amx.tile_load"(%arg3, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xf32>, index, index, index) -> !x86.amx.tile<16x16xf32>
    %8 = "x86.amx.tile_mulf"(%5, %6, %7) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xf32>
    "x86.amx.tile_store"(%9, %2, %2, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    %10 = "vector.transfer_read"(%9, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<16x16xf32>
    %11 = "vector.shape_cast"(%10) : (vector<16x16xf32>) -> vector<1x16x16xf32>
    "vector.transfer_write"(%11, %arg3, %2, %2, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<1x16x16xf32>, memref<1x32x32xf32>, index, index, index) -> ()
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
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x16x4xf8E5M2>, memref<1x16x32x4xf8E5M2>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "brgemm_f8E5M2"}> ({
  ^bb0(%arg1: memref<1x32x16x4xf8E5M2>, %arg2: memref<1x16x32x4xf8E5M2>, %arg3: memref<32x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.collapse_shape"(%arg1) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x32x16x4xf8E5M2>) -> memref<1x32x64xf8E5M2>
    %4 = "memref.collapse_shape"(%arg2) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x4xf8E5M2>) -> memref<1x16x128xf8E5M2>
    %5 = "x86.amx.tile_load"(%3, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x64xf8E5M2>, index, index, index) -> !x86.amx.tile<16x64xf8E5M2>
    %6 = "x86.amx.tile_load"(%4, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x128xf8E5M2>, index, index, index) -> !x86.amx.tile<16x64xf8E5M2>
    %7 = "x86.amx.tile_load"(%arg3, %2, %2) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %8 = "x86.amx.tile_mulf"(%5, %6, %7) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xf32>
    "x86.amx.tile_store"(%9, %2, %2, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    %10 = "vector.transfer_read"(%9, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<16x16xf32>
    "vector.transfer_write"(%10, %arg3, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x64xi8>, memref<64x32xi8>, memref<32x32xi32>) -> memref<32x32xi32>, sym_name = "online_packing_int8"}> ({
  ^bb0(%arg1: memref<32x64xi8>, %arg2: memref<64x32xi8>, %arg3: memref<32x32xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = dense<13> : vector<16x16xi32>}> : () -> vector<16x16xi32>
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "x86.amx.tile_load"(%arg1, %7, %7) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %9 = "memref.subview"(%arg2, %7, %7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 16>, static_strides = array<i64: 1, 1>}> : (memref<64x32xi8>, index, index) -> memref<64x16xi8, strided<[32, 1], offset: ?>>
    %10 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x64xi8>
    "scf.for"(%7, %4, %5) ({
    ^bb0(%arg4: index):
      %17 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "vector.load"(%9, %arg4, %7) <{nontemporal = false}> : (memref<64x16xi8, strided<[32, 1], offset: ?>>, index, index) -> vector<32xi8>
      %19 = "vector.load"(%9, %17, %7) <{nontemporal = false}> : (memref<64x16xi8, strided<[32, 1], offset: ?>>, index, index) -> vector<32xi8>
      %20 = "vector.shuffle"(%18, %19) <{mask = array<i64: 0, 16, 32, 48, 1, 17, 33, 49, 2, 18, 34, 50, 3, 19, 35, 51, 4, 20, 36, 52, 5, 21, 37, 53, 6, 22, 38, 54, 7, 23, 39, 55>}> : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
      %21 = "vector.shuffle"(%18, %19) <{mask = array<i64: 8, 24, 40, 56, 9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59, 12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63>}> : (vector<32xi8>, vector<32xi8>) -> vector<32xi8>
      %22 = "arith.divui"(%arg4, %5) : (index, index) -> index
      "vector.store"(%20, %10, %22, %7) <{nontemporal = false}> : (vector<32xi8>, memref<16x64xi8>, index, index) -> ()
      "vector.store"(%21, %10, %22, %2) <{nontemporal = false}> : (vector<32xi8>, memref<16x64xi8>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %11 = "x86.amx.tile_load"(%10, %7, %7) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x64xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %12 = "x86.amx.tile_load"(%arg3, %7, %7) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xi32>, index, index) -> !x86.amx.tile<16x16xi32>
    %13 = "x86.amx.tile_muli"(%8, %11, %12) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    %14 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xi32>
    "x86.amx.tile_store"(%14, %7, %7, %13) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %15 = "vector.transfer_read"(%14, %7, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    %16 = "arith.addi"(%15, %6) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%16, %arg3, %7, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32>, index, index) -> ()
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
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x32x32xbf16>, memref<1x32x32xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "online_packing_bf16"}> ({
  ^bb0(%arg1: memref<1x32x32xbf16>, %arg2: memref<1x32x32xbf16>, %arg3: memref<32x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 32 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "x86.amx.tile_load"(%arg1, %6, %6, %6) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %8 = "memref.subview"(%arg2, %6, %6, %6) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 16>, static_strides = array<i64: 1, 1, 1>}> : (memref<1x32x32xbf16>, index, index, index) -> memref<1x32x16xbf16, strided<[1024, 32, 1], offset: ?>>
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xbf16>
    "scf.for"(%6, %4, %5) ({
    ^bb0(%arg4: index):
      %15 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16 = "vector.load"(%8, %6, %arg4, %6) <{nontemporal = false}> : (memref<1x32x16xbf16, strided<[1024, 32, 1], offset: ?>>, index, index, index) -> vector<16xbf16>
      %17 = "vector.load"(%8, %6, %15, %6) <{nontemporal = false}> : (memref<1x32x16xbf16, strided<[1024, 32, 1], offset: ?>>, index, index, index) -> vector<16xbf16>
      %18 = "vector.shuffle"(%16, %17) <{mask = array<i64: 0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23>}> : (vector<16xbf16>, vector<16xbf16>) -> vector<16xbf16>
      %19 = "vector.shuffle"(%16, %17) <{mask = array<i64: 8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31>}> : (vector<16xbf16>, vector<16xbf16>) -> vector<16xbf16>
      %20 = "arith.divui"(%arg4, %5) : (index, index) -> index
      "vector.store"(%18, %9, %20, %6) <{nontemporal = false}> : (vector<16xbf16>, memref<16x32xbf16>, index, index) -> ()
      "vector.store"(%19, %9, %20, %2) <{nontemporal = false}> : (vector<16xbf16>, memref<16x32xbf16>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %10 = "x86.amx.tile_load"(%9, %6, %6) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x32xbf16>, index, index) -> !x86.amx.tile<16x32xbf16>
    %11 = "x86.amx.tile_load"(%arg3, %6, %6) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %12 = "x86.amx.tile_mulf"(%7, %10, %11) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    %13 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x16xf32>
    "x86.amx.tile_store"(%13, %6, %6, %12) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x16xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    %14 = "vector.transfer_read"(%13, %6, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<16x16xf32>
    "vector.transfer_write"(%14, %arg3, %6, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x64x2xbf16>, memref<16x64x128x2xbf16>, memref<64x128xf32>) -> memref<64x128xf32>, sym_name = "brgemm_bf16_loop"}> ({
  ^bb0(%arg1: memref<16x64x64x2xbf16>, %arg2: memref<16x64x128x2xbf16>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 128 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%2, %3, %6) ({
    ^bb0(%arg4: index):
      "scf.for"(%2, %4, %6) ({
      ^bb0(%arg5: index):
        %8 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %9 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %10 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %11 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %12 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %13:4 = "scf.for"(%2, %5, %7, %9, %10, %11, %12) ({
        ^bb0(%arg7: index, %arg8: !x86.amx.tile<16x16xf32>, %arg9: !x86.amx.tile<16x16xf32>, %arg10: !x86.amx.tile<16x16xf32>, %arg11: !x86.amx.tile<16x16xf32>):
          %25:4 = "scf.for"(%2, %3, %5, %arg8, %arg9, %arg10, %arg11) ({
          ^bb0(%arg12: index, %arg13: !x86.amx.tile<16x16xf32>, %arg14: !x86.amx.tile<16x16xf32>, %arg15: !x86.amx.tile<16x16xf32>, %arg16: !x86.amx.tile<16x16xf32>):
            %26 = "memref.subview"(%arg1, %arg7, %arg4, %arg12) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 32, 16, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x64x2xbf16>, index, index, index) -> memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>>
            %27 = "memref.subview"(%arg2, %arg7, %arg12, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 32, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x128x2xbf16>, index, index, index) -> memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>>
            %28 = "memref.collapse_shape"(%26) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>>) -> memref<1x32x32xbf16, strided<[8192, 128, 1], offset: ?>>
            %29 = "memref.collapse_shape"(%27) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>>) -> memref<1x16x64xbf16, strided<[16384, 256, 1], offset: ?>>
            %30 = "x86.amx.tile_load"(%28, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %31 = "x86.amx.tile_load"(%29, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xbf16, strided<[16384, 256, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %32 = "x86.amx.tile_mulf"(%30, %31, %arg13) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %33 = "x86.amx.tile_load"(%29, %2, %2, %6) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xbf16, strided<[16384, 256, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %34 = "x86.amx.tile_mulf"(%30, %33, %arg14) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %35 = "x86.amx.tile_load"(%28, %2, %5, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %36 = "x86.amx.tile_mulf"(%35, %31, %arg15) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %37 = "x86.amx.tile_mulf"(%35, %33, %arg16) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            "scf.yield"(%32, %34, %36, %37) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
          }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
          "scf.yield"(%25#0, %25#1, %25#2, %25#3) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %14 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
        "x86.amx.tile_store"(%14, %2, %2, %13#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%14, %2, %5, %13#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%14, %5, %2, %13#2) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%14, %5, %5, %13#3) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "scf.for"(%2, %6, %7) ({
        ^bb0(%arg6: index):
          %19 = "vector.load"(%14, %arg6, %2) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %20 = "vector.load"(%14, %arg6, %5) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %21 = "vector.load"(%8, %arg6, %2) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %22 = "vector.load"(%8, %arg6, %5) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %23 = "arith.addf"(%19, %21) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %24 = "arith.addf"(%20, %22) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          "vector.store"(%23, %14, %arg6, %2) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "vector.store"(%24, %14, %arg6, %5) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %15 = "vector.transfer_read"(%14, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %16 = "vector.transfer_read"(%14, %2, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %17 = "vector.transfer_read"(%14, %5, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %18 = "vector.transfer_read"(%14, %5, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        "vector.transfer_write"(%18, %8, %5, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%17, %8, %5, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%16, %8, %2, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%15, %8, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64x4xi8>, memref<64x128x4xi8>, memref<64x128xi32>) -> (), sym_name = "matmul_int8_loop"}> ({
  ^bb0(%arg1: memref<64x64x4xi8>, %arg2: memref<64x128x4xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
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
        %9 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
        %10 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
        %11:2 = "scf.for"(%3, %4, %6, %9, %10) ({
        ^bb0(%arg7: index, %arg8: !x86.amx.tile<16x16xi32>, %arg9: !x86.amx.tile<16x16xi32>):
          %21 = "memref.subview"(%arg1, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 16, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x64x4xi8>, index, index) -> memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %22 = "memref.subview"(%arg2, %arg7, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 32, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x128x4xi8>, index, index) -> memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>
          %23 = "memref.collapse_shape"(%21) <{reassociation = [[0], [1, 2]]}> : (memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>) -> memref<16x64xi8, strided<[256, 1], offset: ?>>
          %24 = "memref.collapse_shape"(%22) <{reassociation = [[0], [1, 2]]}> : (memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>) -> memref<16x128xi8, strided<[512, 1], offset: ?>>
          %25 = "x86.amx.tile_load"(%23, %3, %3) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x64xi8, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %26 = "x86.amx.tile_load"(%24, %3, %3) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x128xi8, strided<[512, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %27 = "x86.amx.tile_muli"(%25, %26, %arg8) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %28 = "x86.amx.tile_load"(%24, %3, %4) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x128xi8, strided<[512, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %29 = "x86.amx.tile_muli"(%25, %28, %arg9) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          "scf.yield"(%27, %29) : (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>)
        %12 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xi32>
        "x86.amx.tile_store"(%12, %3, %3, %11#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
        "x86.amx.tile_store"(%12, %3, %6, %11#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
        "scf.for"(%3, %7, %2) ({
        ^bb0(%arg6: index):
          %15 = "vector.load"(%12, %arg6, %3) <{nontemporal = false}> : (memref<16x32xi32>, index, index) -> vector<16xi32>
          %16 = "vector.load"(%12, %arg6, %6) <{nontemporal = false}> : (memref<16x32xi32>, index, index) -> vector<16xi32>
          %17 = "vector.load"(%8, %arg6, %3) <{nontemporal = false}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xi32>
          %18 = "vector.load"(%8, %arg6, %6) <{nontemporal = false}> : (memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xi32>
          %19 = "arith.addi"(%15, %17) <{overflowFlags = #arith.overflow<none>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
          %20 = "arith.addi"(%16, %18) <{overflowFlags = #arith.overflow<none>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
          "vector.store"(%19, %12, %arg6, %3) <{nontemporal = false}> : (vector<16xi32>, memref<16x32xi32>, index, index) -> ()
          "vector.store"(%20, %12, %arg6, %6) <{nontemporal = false}> : (vector<16xi32>, memref<16x32xi32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %13 = "vector.transfer_read"(%12, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32>, index, index, i32) -> vector<16x16xi32>
        %14 = "vector.transfer_read"(%12, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32>, index, index, i32) -> vector<16x16xi32>
        "vector.transfer_write"(%14, %8, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%13, %8, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64x4xf8E4M3FN>, memref<64x128x4xf8E4M3FN>, memref<64x128xf32>) -> (), sym_name = "matmul_f8E4M3FN_loop"}> ({
  ^bb0(%arg1: memref<64x64x4xf8E4M3FN>, %arg2: memref<64x128x4xf8E4M3FN>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
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
        %9 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %10 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %11:2 = "scf.for"(%3, %4, %6, %9, %10) ({
        ^bb0(%arg7: index, %arg8: !x86.amx.tile<16x16xf32>, %arg9: !x86.amx.tile<16x16xf32>):
          %21 = "memref.subview"(%arg1, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 16, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x64x4xf8E4M3FN>, index, index) -> memref<16x16x4xf8E4M3FN, strided<[256, 4, 1], offset: ?>>
          %22 = "memref.subview"(%arg2, %arg7, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 16, 32, 4>, static_strides = array<i64: 1, 1, 1>}> : (memref<64x128x4xf8E4M3FN>, index, index) -> memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>>
          %23 = "memref.collapse_shape"(%21) <{reassociation = [[0], [1, 2]]}> : (memref<16x16x4xf8E4M3FN, strided<[256, 4, 1], offset: ?>>) -> memref<16x64xf8E4M3FN, strided<[256, 1], offset: ?>>
          %24 = "memref.collapse_shape"(%22) <{reassociation = [[0], [1, 2]]}> : (memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>>) -> memref<16x128xf8E4M3FN, strided<[512, 1], offset: ?>>
          %25 = "x86.amx.tile_load"(%23, %3, %3) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x64xf8E4M3FN, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E4M3FN>
          %26 = "x86.amx.tile_load"(%24, %3, %3) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x128xf8E4M3FN, strided<[512, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E4M3FN>
          %27 = "x86.amx.tile_mulf"(%25, %26, %arg8) : (!x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %28 = "x86.amx.tile_load"(%24, %3, %4) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x128xf8E4M3FN, strided<[512, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E4M3FN>
          %29 = "x86.amx.tile_mulf"(%25, %28, %arg9) : (!x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          "scf.yield"(%27, %29) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %12 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
        "x86.amx.tile_store"(%12, %3, %3, %11#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%12, %3, %6, %11#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "scf.for"(%3, %7, %2) ({
        ^bb0(%arg6: index):
          %15 = "vector.load"(%12, %arg6, %3) <{nontemporal = false}> : (memref<16x32xf32>, index, index) -> vector<16xf32>
          %16 = "vector.load"(%12, %arg6, %6) <{nontemporal = false}> : (memref<16x32xf32>, index, index) -> vector<16xf32>
          %17 = "vector.load"(%8, %arg6, %3) <{nontemporal = false}> : (memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %18 = "vector.load"(%8, %arg6, %6) <{nontemporal = false}> : (memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %19 = "arith.addf"(%15, %17) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %20 = "arith.addf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          "vector.store"(%19, %12, %arg6, %3) <{nontemporal = false}> : (vector<16xf32>, memref<16x32xf32>, index, index) -> ()
          "vector.store"(%20, %12, %arg6, %6) <{nontemporal = false}> : (vector<16xf32>, memref<16x32xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %13 = "vector.transfer_read"(%12, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xf32>, index, index, f32) -> vector<16x16xf32>
        %14 = "vector.transfer_read"(%12, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xf32>, index, index, f32) -> vector<16x16xf32>
        "vector.transfer_write"(%14, %8, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%13, %8, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<16x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x64x4xi8>, memref<16x64x128x4xi8>, memref<16x64x128xi32>) -> (), sym_name = "batch_matmul_int8_loop"}> ({
  ^bb0(%arg1: memref<16x64x64x4xi8>, %arg2: memref<16x64x128x4xi8>, %arg3: memref<16x64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 128 : index}> : () -> index
    %5 = "arith.constant"() <{value = 16 : index}> : () -> index
    %6 = "arith.constant"() <{value = 32 : index}> : () -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%2, %3, %5) ({
    ^bb0(%arg4: index):
      "scf.for"(%2, %4, %6) ({
      ^bb0(%arg5: index):
        "scf.for"(%2, %5, %7) ({
        ^bb0(%arg6: index):
          %8 = "memref.subview"(%arg3, %arg6, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 16, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x128xi32>, index, index, index) -> memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
          %9 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
          %10 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
          %11:2 = "scf.for"(%2, %3, %5, %9, %10) ({
          ^bb0(%arg8: index, %arg9: !x86.amx.tile<16x16xi32>, %arg10: !x86.amx.tile<16x16xi32>):
            %23 = "memref.subview"(%arg1, %arg6, %arg4, %arg8) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 16, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x64x4xi8>, index, index, index) -> memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>
            %24 = "memref.subview"(%arg2, %arg6, %arg8, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 16, 32, 4>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x64x128x4xi8>, index, index, index) -> memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>
            %25 = "memref.collapse_shape"(%23) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>) -> memref<1x16x64xi8, strided<[16384, 256, 1], offset: ?>>
            %26 = "memref.collapse_shape"(%24) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>) -> memref<1x16x128xi8, strided<[32768, 512, 1], offset: ?>>
            %27 = "x86.amx.tile_load"(%25, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xi8, strided<[16384, 256, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x64xi8>
            %28 = "x86.amx.tile_load"(%26, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x128xi8, strided<[32768, 512, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x64xi8>
            %29 = "x86.amx.tile_muli"(%27, %28, %arg9) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
            %30 = "x86.amx.tile_load"(%26, %2, %2, %3) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x128xi8, strided<[32768, 512, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x64xi8>
            %31 = "x86.amx.tile_muli"(%27, %30, %arg10) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
            "scf.yield"(%29, %31) : (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> ()
          }) : (index, index, index, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>)
          %12 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xi32>
          "x86.amx.tile_store"(%12, %2, %2, %11#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
          "x86.amx.tile_store"(%12, %2, %5, %11#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
          "scf.for"(%2, %6, %7) ({
          ^bb0(%arg7: index):
            %17 = "vector.load"(%12, %arg7, %2) <{nontemporal = false}> : (memref<16x32xi32>, index, index) -> vector<16xi32>
            %18 = "vector.load"(%12, %arg7, %5) <{nontemporal = false}> : (memref<16x32xi32>, index, index) -> vector<16xi32>
            %19 = "vector.load"(%8, %2, %arg7, %2) <{nontemporal = false}> : (memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> vector<16xi32>
            %20 = "vector.load"(%8, %2, %arg7, %5) <{nontemporal = false}> : (memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> vector<16xi32>
            %21 = "arith.addi"(%17, %19) <{overflowFlags = #arith.overflow<none>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
            %22 = "arith.addi"(%18, %20) <{overflowFlags = #arith.overflow<none>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
            "vector.store"(%21, %12, %arg7, %2) <{nontemporal = false}> : (vector<16xi32>, memref<16x32xi32>, index, index) -> ()
            "vector.store"(%22, %12, %arg7, %5) <{nontemporal = false}> : (vector<16xi32>, memref<16x32xi32>, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %13 = "vector.transfer_read"(%12, %2, %2, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32>, index, index, i32) -> vector<16x16xi32>
          %14 = "vector.transfer_read"(%12, %2, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi32>, index, index, i32) -> vector<16x16xi32>
          %15 = "vector.shape_cast"(%13) : (vector<16x16xi32>) -> vector<1x16x16xi32>
          %16 = "vector.shape_cast"(%14) : (vector<16x16xi32>) -> vector<1x16x16xi32>
          "vector.transfer_write"(%16, %8, %2, %2, %5) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<1x16x16xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> ()
          "vector.transfer_write"(%15, %8, %2, %2, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<1x16x16xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, index, index, index) -> ()
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
#map = affine_map<(d0, d1, d2) -> (d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x64x96xbf16>, memref<16x96x128xbf16>, memref<64x128xf32>) -> memref<64x128xf32>, sym_name = "online_packing_bf16_loop"}> ({
  ^bb0(%arg1: memref<16x64x96xbf16>, %arg2: memref<16x96x128xbf16>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 15 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 64 : index}> : () -> index
    %7 = "arith.constant"() <{value = 128 : index}> : () -> index
    %8 = "arith.constant"() <{value = 16 : index}> : () -> index
    %9 = "arith.constant"() <{value = 96 : index}> : () -> index
    %10 = "arith.constant"() <{value = 32 : index}> : () -> index
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%5, %6, %10) ({
    ^bb0(%arg4: index):
      "scf.for"(%5, %7, %10) ({
      ^bb0(%arg5: index):
        %13 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %14 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %15 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %16 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %17 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %18 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x32x32xbf16>
        %19 = "memref.subview"(%arg2, %5, %5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x96x128xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
        "scf.for"(%5, %10, %3) ({
        ^bb0(%arg40: index):
          %122 = "vector.transfer_read"(%19, %5, %arg40, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
          %123 = "arith.addi"(%arg40, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %124 = "vector.transfer_read"(%19, %5, %123, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
          %125 = "vector.shuffle"(%122, %124) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
          %126 = "vector.shuffle"(%122, %124) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
          %127 = "arith.divui"(%arg40, %3) : (index, index) -> index
          %128 = "arith.addi"(%127, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          "vector.store"(%125, %18, %5, %127, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
          "vector.store"(%126, %18, %5, %128, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %20:4 = "scf.for"(%5, %4, %11, %14, %15, %16, %17) ({
        ^bb0(%arg23: index, %arg24: !x86.amx.tile<16x16xf32>, %arg25: !x86.amx.tile<16x16xf32>, %arg26: !x86.amx.tile<16x16xf32>, %arg27: !x86.amx.tile<16x16xf32>):
          %74:4 = "scf.for"(%5, %6, %10, %arg24, %arg25, %arg26, %arg27) ({
          ^bb0(%arg34: index, %arg35: !x86.amx.tile<16x16xf32>, %arg36: !x86.amx.tile<16x16xf32>, %arg37: !x86.amx.tile<16x16xf32>, %arg38: !x86.amx.tile<16x16xf32>):
            %97 = "memref.subview"(%arg1, %arg23, %arg4, %arg34) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x96xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %98 = "arith.addi"(%arg34, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %99 = "arith.divui"(%98, %10) : (index, index) -> index
            %100 = "arith.remui"(%99, %3) : (index, index) -> index
            %101 = "arith.remui"(%arg23, %3) : (index, index) -> index
            %102 = "arith.addi"(%100, %101) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %103 = "arith.remui"(%102, %3) : (index, index) -> index
            %104 = "arith.addi"(%103, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %105 = "arith.remui"(%104, %3) : (index, index) -> index
            %106 = "memref.subview"(%arg2, %arg23, %98, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x96x128xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            "scf.for"(%5, %10, %3) ({
            ^bb0(%arg39: index):
              %115 = "vector.transfer_read"(%106, %5, %arg39, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
              %116 = "arith.addi"(%arg39, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              %117 = "vector.transfer_read"(%106, %5, %116, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
              %118 = "vector.shuffle"(%115, %117) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
              %119 = "vector.shuffle"(%115, %117) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
              %120 = "arith.divui"(%arg39, %3) : (index, index) -> index
              %121 = "arith.addi"(%120, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              "vector.store"(%118, %18, %103, %120, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
              "vector.store"(%119, %18, %103, %121, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            %107 = "x86.amx.tile_load"(%18, %105, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %108 = "x86.amx.tile_load"(%18, %105, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %109 = "x86.amx.tile_load"(%97, %5, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %110 = "x86.amx.tile_mulf"(%109, %107, %arg35) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %111 = "x86.amx.tile_mulf"(%109, %108, %arg36) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %112 = "x86.amx.tile_load"(%97, %5, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %113 = "x86.amx.tile_mulf"(%112, %107, %arg37) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %114 = "x86.amx.tile_mulf"(%112, %108, %arg38) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            "scf.yield"(%110, %111, %113, %114) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
          }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
          %75:4 = "scf.for"(%6, %9, %10, %74#0, %74#1, %74#2, %74#3) ({
          ^bb0(%arg28: index, %arg29: !x86.amx.tile<16x16xf32>, %arg30: !x86.amx.tile<16x16xf32>, %arg31: !x86.amx.tile<16x16xf32>, %arg32: !x86.amx.tile<16x16xf32>):
            %76 = "memref.subview"(%arg1, %arg23, %arg4, %arg28) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x96xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %77 = "arith.addi"(%arg23, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %78 = "arith.remui"(%77, %3) : (index, index) -> index
            %79 = "arith.addi"(%78, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %80 = "arith.remui"(%79, %3) : (index, index) -> index
            %81 = "memref.subview"(%arg2, %77, %5, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x96x128xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            "scf.for"(%5, %10, %3) ({
            ^bb0(%arg33: index):
              %90 = "vector.transfer_read"(%81, %5, %arg33, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
              %91 = "arith.addi"(%arg33, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              %92 = "vector.transfer_read"(%81, %5, %91, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
              %93 = "vector.shuffle"(%90, %92) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
              %94 = "vector.shuffle"(%90, %92) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
              %95 = "arith.divui"(%arg33, %3) : (index, index) -> index
              %96 = "arith.addi"(%95, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              "vector.store"(%93, %18, %78, %95, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
              "vector.store"(%94, %18, %78, %96, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            %82 = "x86.amx.tile_load"(%18, %80, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %83 = "x86.amx.tile_load"(%18, %80, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %84 = "x86.amx.tile_load"(%76, %5, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %85 = "x86.amx.tile_mulf"(%84, %82, %arg29) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %86 = "x86.amx.tile_mulf"(%84, %83, %arg30) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %87 = "x86.amx.tile_load"(%76, %5, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %88 = "x86.amx.tile_mulf"(%87, %82, %arg31) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %89 = "x86.amx.tile_mulf"(%87, %83, %arg32) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            "scf.yield"(%85, %86, %88, %89) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
          }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
          "scf.yield"(%75#0, %75#1, %75#2, %75#3) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %21:4 = "scf.for"(%4, %8, %11, %20#0, %20#1, %20#2, %20#3) ({
        ^bb0(%arg7: index, %arg8: !x86.amx.tile<16x16xf32>, %arg9: !x86.amx.tile<16x16xf32>, %arg10: !x86.amx.tile<16x16xf32>, %arg11: !x86.amx.tile<16x16xf32>):
          %35:4 = "scf.for"(%5, %6, %10, %arg8, %arg9, %arg10, %arg11) ({
          ^bb0(%arg17: index, %arg18: !x86.amx.tile<16x16xf32>, %arg19: !x86.amx.tile<16x16xf32>, %arg20: !x86.amx.tile<16x16xf32>, %arg21: !x86.amx.tile<16x16xf32>):
            %49 = "memref.subview"(%arg1, %arg7, %arg4, %arg17) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x96xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %50 = "arith.addi"(%arg17, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %51 = "arith.divui"(%50, %10) : (index, index) -> index
            %52 = "arith.remui"(%51, %3) : (index, index) -> index
            %53 = "arith.remui"(%arg7, %3) : (index, index) -> index
            %54 = "arith.addi"(%52, %53) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %55 = "arith.remui"(%54, %3) : (index, index) -> index
            %56 = "arith.addi"(%55, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %57 = "arith.remui"(%56, %3) : (index, index) -> index
            %58 = "memref.subview"(%arg2, %arg7, %50, %arg5) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x96x128xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            "scf.for"(%5, %10, %3) ({
            ^bb0(%arg22: index):
              %67 = "vector.transfer_read"(%58, %5, %arg22, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
              %68 = "arith.addi"(%arg22, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              %69 = "vector.transfer_read"(%58, %5, %68, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, index, index, index, bf16) -> vector<32xbf16>
              %70 = "vector.shuffle"(%67, %69) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
              %71 = "vector.shuffle"(%67, %69) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
              %72 = "arith.divui"(%arg22, %3) : (index, index) -> index
              %73 = "arith.addi"(%72, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
              "vector.store"(%70, %18, %55, %72, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
              "vector.store"(%71, %18, %55, %73, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            %59 = "x86.amx.tile_load"(%18, %57, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %60 = "x86.amx.tile_load"(%18, %57, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %61 = "x86.amx.tile_load"(%49, %5, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %62 = "x86.amx.tile_mulf"(%61, %59, %arg18) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %63 = "x86.amx.tile_mulf"(%61, %60, %arg19) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %64 = "x86.amx.tile_load"(%49, %5, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %65 = "x86.amx.tile_mulf"(%64, %59, %arg20) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %66 = "x86.amx.tile_mulf"(%64, %60, %arg21) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            "scf.yield"(%62, %63, %65, %66) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
          }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
          %36:4 = "scf.for"(%6, %9, %10, %35#0, %35#1, %35#2, %35#3) ({
          ^bb0(%arg12: index, %arg13: !x86.amx.tile<16x16xf32>, %arg14: !x86.amx.tile<16x16xf32>, %arg15: !x86.amx.tile<16x16xf32>, %arg16: !x86.amx.tile<16x16xf32>):
            %37 = "memref.subview"(%arg1, %arg7, %arg4, %arg12) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 32, 32>, static_strides = array<i64: 1, 1, 1>}> : (memref<16x64x96xbf16>, index, index, index) -> memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %38 = "arith.remui"(%arg7, %3) : (index, index) -> index
            %39 = "arith.addi"(%38, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %40 = "arith.remui"(%39, %3) : (index, index) -> index
            %41 = "x86.amx.tile_load"(%18, %40, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %42 = "x86.amx.tile_load"(%18, %40, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %43 = "x86.amx.tile_load"(%37, %5, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %44 = "x86.amx.tile_mulf"(%43, %41, %arg13) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %45 = "x86.amx.tile_mulf"(%43, %42, %arg14) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %46 = "x86.amx.tile_load"(%37, %5, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
            %47 = "x86.amx.tile_mulf"(%46, %41, %arg15) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            %48 = "x86.amx.tile_mulf"(%46, %42, %arg16) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
            "scf.yield"(%44, %45, %47, %48) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
          }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
          "scf.yield"(%36#0, %36#1, %36#2, %36#3) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %22 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
        "x86.amx.tile_store"(%22, %5, %5, %21#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%22, %5, %8, %21#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%22, %8, %5, %21#2) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%22, %8, %8, %21#3) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "scf.for"(%5, %10, %11) ({
        ^bb0(%arg6: index):
          %27 = "vector.load"(%22, %arg6, %5) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %28 = "vector.load"(%22, %arg6, %8) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %29 = "vector.shuffle"(%27, %28) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %30 = "vector.shuffle"(%27, %28) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %31 = "vector.load"(%13, %arg6, %5) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %32 = "vector.load"(%13, %arg6, %8) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %33 = "arith.addf"(%29, %31) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %34 = "arith.addf"(%30, %32) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          "vector.store"(%33, %22, %arg6, %5) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "vector.store"(%34, %22, %arg6, %8) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %23 = "vector.transfer_read"(%22, %5, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %24 = "vector.transfer_read"(%22, %5, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %25 = "vector.transfer_read"(%22, %8, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %26 = "vector.transfer_read"(%22, %8, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        "vector.transfer_write"(%26, %13, %8, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%25, %13, %8, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%24, %13, %5, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%23, %13, %5, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %12 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %12) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%12) : (memref<64x128xf32>) -> ()
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
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x96xbf16>, memref<96x128xbf16>, memref<64x128xf32>, index, index) -> memref<64x128xf32>, sym_name = "online_packing_bf16_loop_lb_non_zero"}> ({
  ^bb0(%arg1: memref<64x96xbf16>, %arg2: memref<96x128xbf16>, %arg3: memref<64x128xf32>, %arg4: index, %arg5: index):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "arith.constant"() <{value = 64 : index}> : () -> index
    %7 = "arith.constant"() <{value = 128 : index}> : () -> index
    %8 = "arith.constant"() <{value = 16 : index}> : () -> index
    %9 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%5, %6, %9) ({
    ^bb0(%arg6: index):
      "scf.for"(%5, %7, %9) ({
      ^bb0(%arg7: index):
        %11 = "memref.subview"(%arg3, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %12 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %13 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %14 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %15 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %16 = "arith.subi"(%arg5, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %17 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x32x32xbf16>
        %18 = "memref.subview"(%arg2, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<96x128xbf16>, index, index) -> memref<32x32xbf16, strided<[128, 1], offset: ?>>
        %19 = "arith.divui"(%arg4, %9) : (index, index) -> index
        %20 = "arith.remui"(%19, %4) : (index, index) -> index
        "scf.for"(%5, %9, %4) ({
        ^bb0(%arg20: index):
          %69 = "vector.transfer_read"(%18, %arg20, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32xbf16>
          %70 = "arith.addi"(%arg20, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %71 = "vector.transfer_read"(%18, %70, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32xbf16>
          %72 = "vector.shuffle"(%69, %71) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
          %73 = "vector.shuffle"(%69, %71) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
          %74 = "arith.divui"(%arg20, %4) : (index, index) -> index
          %75 = "arith.addi"(%74, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          "vector.store"(%72, %17, %20, %74, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
          "vector.store"(%73, %17, %20, %75, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %21:4 = "scf.for"(%arg4, %16, %9, %12, %13, %14, %15) ({
        ^bb0(%arg14: index, %arg15: !x86.amx.tile<16x16xf32>, %arg16: !x86.amx.tile<16x16xf32>, %arg17: !x86.amx.tile<16x16xf32>, %arg18: !x86.amx.tile<16x16xf32>):
          %47 = "memref.subview"(%arg1, %arg6, %arg14) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x96xbf16>, index, index) -> memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %48 = "arith.addi"(%arg14, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %49 = "arith.divui"(%48, %9) : (index, index) -> index
          %50 = "arith.remui"(%49, %4) : (index, index) -> index
          %51 = "arith.addi"(%50, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %52 = "arith.remui"(%51, %4) : (index, index) -> index
          %53 = "memref.subview"(%arg2, %48, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<96x128xbf16>, index, index) -> memref<32x32xbf16, strided<[128, 1], offset: ?>>
          "scf.for"(%5, %9, %4) ({
          ^bb0(%arg19: index):
            %62 = "vector.transfer_read"(%53, %arg19, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32xbf16>
            %63 = "arith.addi"(%arg19, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %64 = "vector.transfer_read"(%53, %63, %5, %2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32xbf16>
            %65 = "vector.shuffle"(%62, %64) <{mask = array<i64: 0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
            %66 = "vector.shuffle"(%62, %64) <{mask = array<i64: 4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63>}> : (vector<32xbf16>, vector<32xbf16>) -> vector<32xbf16>
            %67 = "arith.divui"(%arg19, %4) : (index, index) -> index
            %68 = "arith.addi"(%67, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            "vector.store"(%65, %17, %50, %67, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
            "vector.store"(%66, %17, %50, %68, %5) <{nontemporal = false}> : (vector<32xbf16>, memref<2x32x32xbf16>, index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %54 = "x86.amx.tile_load"(%17, %52, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
          %55 = "x86.amx.tile_load"(%17, %52, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
          %56 = "x86.amx.tile_load"(%47, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x32xbf16>
          %57 = "x86.amx.tile_mulf"(%56, %54, %arg15) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %58 = "x86.amx.tile_mulf"(%56, %55, %arg16) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %59 = "x86.amx.tile_load"(%47, %8, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x32xbf16>
          %60 = "x86.amx.tile_mulf"(%59, %54, %arg17) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %61 = "x86.amx.tile_mulf"(%59, %55, %arg18) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          "scf.yield"(%57, %58, %60, %61) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %22:4 = "scf.for"(%16, %arg5, %9, %21#0, %21#1, %21#2, %21#3) ({
        ^bb0(%arg9: index, %arg10: !x86.amx.tile<16x16xf32>, %arg11: !x86.amx.tile<16x16xf32>, %arg12: !x86.amx.tile<16x16xf32>, %arg13: !x86.amx.tile<16x16xf32>):
          %36 = "memref.subview"(%arg1, %arg6, %arg9) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x96xbf16>, index, index) -> memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %37 = "arith.divui"(%arg9, %9) : (index, index) -> index
          %38 = "arith.remui"(%37, %4) : (index, index) -> index
          %39 = "x86.amx.tile_load"(%17, %38, %5, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
          %40 = "x86.amx.tile_load"(%17, %38, %8, %5) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
          %41 = "x86.amx.tile_load"(%36, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x32xbf16>
          %42 = "x86.amx.tile_mulf"(%41, %39, %arg10) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %43 = "x86.amx.tile_mulf"(%41, %40, %arg11) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %44 = "x86.amx.tile_load"(%36, %8, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x32xbf16>
          %45 = "x86.amx.tile_mulf"(%44, %39, %arg12) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %46 = "x86.amx.tile_mulf"(%44, %40, %arg13) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          "scf.yield"(%42, %43, %45, %46) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %23 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
        "x86.amx.tile_store"(%23, %5, %5, %22#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%23, %5, %8, %22#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%23, %8, %5, %22#2) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%23, %8, %8, %22#3) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "scf.for"(%5, %9, %3) ({
        ^bb0(%arg8: index):
          %28 = "vector.load"(%23, %arg8, %5) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %29 = "vector.load"(%23, %arg8, %8) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %30 = "vector.shuffle"(%28, %29) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %31 = "vector.shuffle"(%28, %29) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %32 = "vector.load"(%11, %arg8, %5) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %33 = "vector.load"(%11, %arg8, %8) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %34 = "arith.addf"(%30, %32) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %35 = "arith.addf"(%31, %33) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          "vector.store"(%34, %23, %arg8, %5) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "vector.store"(%35, %23, %arg8, %8) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %24 = "vector.transfer_read"(%23, %5, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %25 = "vector.transfer_read"(%23, %5, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %26 = "vector.transfer_read"(%23, %8, %5, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %27 = "vector.transfer_read"(%23, %8, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        "vector.transfer_write"(%27, %11, %8, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%26, %11, %8, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%25, %11, %5, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%24, %11, %5, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x256xf8E5M2>, memref<256x128xf8E5M2>, memref<64x128xf32>) -> memref<64x128xf32>, sym_name = "online_packing_f8E5M2_matmul_loop"}> ({
  ^bb0(%arg1: memref<64x256xf8E5M2>, %arg2: memref<256x128xf8E5M2>, %arg3: memref<64x128xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f8E5M2
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = 192 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "arith.constant"() <{value = 64 : index}> : () -> index
    %10 = "arith.constant"() <{value = 128 : index}> : () -> index
    %11 = "arith.constant"() <{value = 256 : index}> : () -> index
    %12 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%8, %9, %12) ({
    ^bb0(%arg4: index):
      "scf.for"(%8, %10, %12) ({
      ^bb0(%arg5: index):
        %14 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %15 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %16 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %17 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %18 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
        %19 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x32x64xf8E5M2>
        %20 = "memref.subview"(%arg2, %8, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xf8E5M2>, index, index) -> memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>
        "scf.for"(%8, %9, %5) ({
        ^bb0(%arg18: index):
          %71 = "vector.transfer_read"(%20, %arg18, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, index, index, f8E5M2) -> vector<2x32xf8E5M2>
          %72 = "vector.shape_cast"(%71) : (vector<2x32xf8E5M2>) -> vector<64xf8E5M2>
          %73 = "arith.addi"(%arg18, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %74 = "vector.transfer_read"(%20, %73, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, index, index, f8E5M2) -> vector<2x32xf8E5M2>
          %75 = "vector.shape_cast"(%74) : (vector<2x32xf8E5M2>) -> vector<64xf8E5M2>
          %76 = "vector.shuffle"(%72, %75) <{mask = array<i64: 0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123>}> : (vector<64xf8E5M2>, vector<64xf8E5M2>) -> vector<64xf8E5M2>
          %77 = "vector.shuffle"(%72, %75) <{mask = array<i64: 4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127>}> : (vector<64xf8E5M2>, vector<64xf8E5M2>) -> vector<64xf8E5M2>
          %78 = "arith.divui"(%arg18, %5) : (index, index) -> index
          %79 = "arith.addi"(%78, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          "vector.store"(%76, %19, %8, %78, %8) <{nontemporal = false}> : (vector<64xf8E5M2>, memref<2x32x64xf8E5M2>, index, index, index) -> ()
          "vector.store"(%77, %19, %8, %79, %8) <{nontemporal = false}> : (vector<64xf8E5M2>, memref<2x32x64xf8E5M2>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %21:4 = "scf.for"(%8, %6, %9, %15, %16, %17, %18) ({
        ^bb0(%arg12: index, %arg13: !x86.amx.tile<16x16xf32>, %arg14: !x86.amx.tile<16x16xf32>, %arg15: !x86.amx.tile<16x16xf32>, %arg16: !x86.amx.tile<16x16xf32>):
          %47 = "memref.subview"(%arg1, %arg4, %arg12) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xf8E5M2>, index, index) -> memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>
          %48 = "arith.addi"(%arg12, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %49 = "arith.divui"(%48, %9) : (index, index) -> index
          %50 = "arith.remui"(%49, %4) : (index, index) -> index
          %51 = "arith.addi"(%50, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %52 = "arith.remui"(%51, %4) : (index, index) -> index
          %53 = "memref.subview"(%arg2, %48, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xf8E5M2>, index, index) -> memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>
          "scf.for"(%8, %9, %5) ({
          ^bb0(%arg17: index):
            %62 = "vector.transfer_read"(%53, %arg17, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, index, index, f8E5M2) -> vector<2x32xf8E5M2>
            %63 = "vector.shape_cast"(%62) : (vector<2x32xf8E5M2>) -> vector<64xf8E5M2>
            %64 = "arith.addi"(%arg17, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %65 = "vector.transfer_read"(%53, %64, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, index, index, f8E5M2) -> vector<2x32xf8E5M2>
            %66 = "vector.shape_cast"(%65) : (vector<2x32xf8E5M2>) -> vector<64xf8E5M2>
            %67 = "vector.shuffle"(%63, %66) <{mask = array<i64: 0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123>}> : (vector<64xf8E5M2>, vector<64xf8E5M2>) -> vector<64xf8E5M2>
            %68 = "vector.shuffle"(%63, %66) <{mask = array<i64: 4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127>}> : (vector<64xf8E5M2>, vector<64xf8E5M2>) -> vector<64xf8E5M2>
            %69 = "arith.divui"(%arg17, %5) : (index, index) -> index
            %70 = "arith.addi"(%69, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            "vector.store"(%67, %19, %50, %69, %8) <{nontemporal = false}> : (vector<64xf8E5M2>, memref<2x32x64xf8E5M2>, index, index, index) -> ()
            "vector.store"(%68, %19, %50, %70, %8) <{nontemporal = false}> : (vector<64xf8E5M2>, memref<2x32x64xf8E5M2>, index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %54 = "x86.amx.tile_load"(%19, %52, %8, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xf8E5M2>, index, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %55 = "x86.amx.tile_load"(%19, %52, %7, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xf8E5M2>, index, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %56 = "x86.amx.tile_load"(%47, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %57 = "x86.amx.tile_mulf"(%56, %54, %arg13) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %58 = "x86.amx.tile_mulf"(%56, %55, %arg14) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %59 = "x86.amx.tile_load"(%47, %7, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %60 = "x86.amx.tile_mulf"(%59, %54, %arg15) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %61 = "x86.amx.tile_mulf"(%59, %55, %arg16) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          "scf.yield"(%57, %58, %60, %61) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %22:4 = "scf.for"(%6, %11, %9, %21#0, %21#1, %21#2, %21#3) ({
        ^bb0(%arg7: index, %arg8: !x86.amx.tile<16x16xf32>, %arg9: !x86.amx.tile<16x16xf32>, %arg10: !x86.amx.tile<16x16xf32>, %arg11: !x86.amx.tile<16x16xf32>):
          %36 = "memref.subview"(%arg1, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xf8E5M2>, index, index) -> memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>
          %37 = "arith.divui"(%arg7, %9) : (index, index) -> index
          %38 = "arith.remui"(%37, %4) : (index, index) -> index
          %39 = "x86.amx.tile_load"(%19, %38, %8, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xf8E5M2>, index, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %40 = "x86.amx.tile_load"(%19, %38, %7, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xf8E5M2>, index, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %41 = "x86.amx.tile_load"(%36, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %42 = "x86.amx.tile_mulf"(%41, %39, %arg8) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %43 = "x86.amx.tile_mulf"(%41, %40, %arg9) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %44 = "x86.amx.tile_load"(%36, %7, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xf8E5M2>
          %45 = "x86.amx.tile_mulf"(%44, %39, %arg10) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          %46 = "x86.amx.tile_mulf"(%44, %40, %arg11) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
          "scf.yield"(%42, %43, %45, %46) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
        %23 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
        "x86.amx.tile_store"(%23, %8, %8, %22#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%23, %8, %7, %22#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%23, %7, %8, %22#2) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "x86.amx.tile_store"(%23, %7, %7, %22#3) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
        "scf.for"(%8, %12, %2) ({
        ^bb0(%arg6: index):
          %28 = "vector.load"(%23, %arg6, %8) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %29 = "vector.load"(%23, %arg6, %7) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
          %30 = "vector.shuffle"(%28, %29) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %31 = "vector.shuffle"(%28, %29) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %32 = "vector.load"(%14, %arg6, %8) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %33 = "vector.load"(%14, %arg6, %7) <{nontemporal = false}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xf32>
          %34 = "arith.addf"(%30, %32) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          %35 = "arith.addf"(%31, %33) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
          "vector.store"(%34, %23, %arg6, %8) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "vector.store"(%35, %23, %arg6, %7) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %24 = "vector.transfer_read"(%23, %8, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %25 = "vector.transfer_read"(%23, %8, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %26 = "vector.transfer_read"(%23, %7, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        %27 = "vector.transfer_read"(%23, %7, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
        "vector.transfer_write"(%27, %14, %7, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%26, %14, %7, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%25, %14, %8, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%24, %14, %8, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %13 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %13) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%13) : (memref<64x128xf32>) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x16x2xbf16>, memref<16x16x32x2xbf16>, memref<32x32xf32>) -> memref<32x32xf32>, sym_name = "brgemm_bf16_with_cano"}> ({
  ^bb0(%arg1: memref<16x32x16x2xbf16>, %arg2: memref<16x16x32x2xbf16>, %arg3: memref<32x32xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
    %7 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
    %8 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
    %9 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xf32>
    %10:4 = "scf.for"(%3, %4, %5, %6, %7, %8, %9) ({
    ^bb0(%arg5: index, %arg6: !x86.amx.tile<16x16xf32>, %arg7: !x86.amx.tile<16x16xf32>, %arg8: !x86.amx.tile<16x16xf32>, %arg9: !x86.amx.tile<16x16xf32>):
      %23 = "memref.subview"(%arg1, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 32, 16, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x32x16x2xbf16>, index) -> memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>>
      %24 = "memref.subview"(%arg2, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 16, 32, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<16x16x32x2xbf16>, index) -> memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>>
      %25 = "memref.collapse_shape"(%23) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>>) -> memref<1x32x32xbf16, strided<[1024, 32, 1], offset: ?>>
      %26 = "memref.collapse_shape"(%24) <{reassociation = [[0], [1], [2, 3]]}> : (memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>>) -> memref<1x16x64xbf16, strided<[1024, 64, 1], offset: ?>>
      %27 = "x86.amx.tile_load"(%25, %3, %3, %3) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[1024, 32, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
      %28 = "x86.amx.tile_load"(%26, %3, %3, %3) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xbf16, strided<[1024, 64, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
      %29 = "x86.amx.tile_mulf"(%27, %28, %arg6) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
      %30 = "x86.amx.tile_load"(%26, %3, %3, %2) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x16x64xbf16, strided<[1024, 64, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
      %31 = "x86.amx.tile_mulf"(%27, %30, %arg7) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
      %32 = "x86.amx.tile_load"(%25, %3, %4, %3) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<1x32x32xbf16, strided<[1024, 32, 1], offset: ?>>, index, index, index) -> !x86.amx.tile<16x32xbf16>
      %33 = "x86.amx.tile_mulf"(%32, %28, %arg8) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
      %34 = "x86.amx.tile_mulf"(%32, %30, %arg9) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
      "scf.yield"(%29, %31, %33, %34) : (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> ()
    }) : (index, index, index, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>)
    %11 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    "x86.amx.tile_store"(%11, %3, %3, %10#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "x86.amx.tile_store"(%11, %3, %4, %10#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "x86.amx.tile_store"(%11, %4, %3, %10#2) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "x86.amx.tile_store"(%11, %4, %4, %10#3) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "scf.for"(%3, %2, %5) ({
    ^bb0(%arg4: index):
      %17 = "vector.load"(%11, %arg4, %3) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
      %18 = "vector.load"(%11, %arg4, %4) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
      %19 = "vector.load"(%arg3, %arg4, %3) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
      %20 = "vector.load"(%arg3, %arg4, %4) <{nontemporal = false}> : (memref<32x32xf32>, index, index) -> vector<16xf32>
      %21 = "arith.addf"(%17, %19) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
      %22 = "arith.addf"(%18, %20) <{fastmath = #arith.fastmath<none>}> : (vector<16xf32>, vector<16xf32>) -> vector<16xf32>
      "vector.store"(%21, %11, %arg4, %3) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
      "vector.store"(%22, %11, %arg4, %4) <{nontemporal = false}> : (vector<16xf32>, memref<32x32xf32>, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %12 = "vector.transfer_read"(%11, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %13 = "vector.transfer_read"(%11, %3, %4, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %14 = "vector.transfer_read"(%11, %4, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    %15 = "vector.transfer_read"(%11, %4, %4, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32>, index, index, f32) -> vector<16x16xf32>
    "vector.transfer_write"(%15, %arg3, %4, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "vector.transfer_write"(%14, %arg3, %4, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "vector.transfer_write"(%13, %arg3, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    "vector.transfer_write"(%12, %arg3, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32>, index, index) -> ()
    %16 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xf32>
    "memref.copy"(%arg3, %16) : (memref<32x32xf32>, memref<32x32xf32>) -> ()
    "func.return"(%16) : (memref<32x32xf32>) -> ()
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
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x256xi8>, memref<256x128xi8>, memref<64x128xi32>) -> memref<64x128xi32>, sym_name = "online_packing_int8_matmul_loop"}> ({
  ^bb0(%arg1: memref<64x256xi8>, %arg2: memref<256x128xi8>, %arg3: memref<64x128xi32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> i8
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = 192 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "arith.constant"() <{value = 64 : index}> : () -> index
    %10 = "arith.constant"() <{value = 128 : index}> : () -> index
    %11 = "arith.constant"() <{value = 256 : index}> : () -> index
    %12 = "arith.constant"() <{value = 32 : index}> : () -> index
    %13 = "arith.constant"() <{value = dense<13> : vector<16x16xi32>}> : () -> vector<16x16xi32>
    "scf.for"(%8, %9, %12) ({
    ^bb0(%arg4: index):
      "scf.for"(%8, %10, %12) ({
      ^bb0(%arg5: index):
        %15 = "memref.subview"(%arg3, %arg4, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xi32>, index, index) -> memref<32x32xi32, strided<[128, 1], offset: ?>>
        %16 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
        %17 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
        %18 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
        %19 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xi32>
        %20 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x32x64xi8>
        %21 = "memref.subview"(%arg2, %8, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xi8>, index, index) -> memref<64x32xi8, strided<[128, 1], offset: ?>>
        "scf.for"(%8, %9, %5) ({
        ^bb0(%arg18: index):
          %76 = "vector.transfer_read"(%21, %arg18, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<2x32xi8>
          %77 = "vector.shape_cast"(%76) : (vector<2x32xi8>) -> vector<64xi8>
          %78 = "arith.addi"(%arg18, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %79 = "vector.transfer_read"(%21, %78, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<2x32xi8>
          %80 = "vector.shape_cast"(%79) : (vector<2x32xi8>) -> vector<64xi8>
          %81 = "vector.shuffle"(%77, %80) <{mask = array<i64: 0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
          %82 = "vector.shuffle"(%77, %80) <{mask = array<i64: 4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
          %83 = "arith.divui"(%arg18, %5) : (index, index) -> index
          %84 = "arith.addi"(%83, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          "vector.store"(%81, %20, %8, %83, %8) <{nontemporal = false}> : (vector<64xi8>, memref<2x32x64xi8>, index, index, index) -> ()
          "vector.store"(%82, %20, %8, %84, %8) <{nontemporal = false}> : (vector<64xi8>, memref<2x32x64xi8>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %22:4 = "scf.for"(%8, %6, %9, %16, %17, %18, %19) ({
        ^bb0(%arg12: index, %arg13: !x86.amx.tile<16x16xi32>, %arg14: !x86.amx.tile<16x16xi32>, %arg15: !x86.amx.tile<16x16xi32>, %arg16: !x86.amx.tile<16x16xi32>):
          %52 = "memref.subview"(%arg1, %arg4, %arg12) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xi8>, index, index) -> memref<32x64xi8, strided<[256, 1], offset: ?>>
          %53 = "arith.addi"(%arg12, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %54 = "arith.divui"(%53, %9) : (index, index) -> index
          %55 = "arith.remui"(%54, %4) : (index, index) -> index
          %56 = "arith.addi"(%55, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %57 = "arith.remui"(%56, %4) : (index, index) -> index
          %58 = "memref.subview"(%arg2, %53, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 64, 32>, static_strides = array<i64: 1, 1>}> : (memref<256x128xi8>, index, index) -> memref<64x32xi8, strided<[128, 1], offset: ?>>
          "scf.for"(%8, %9, %5) ({
          ^bb0(%arg17: index):
            %67 = "vector.transfer_read"(%58, %arg17, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<2x32xi8>
            %68 = "vector.shape_cast"(%67) : (vector<2x32xi8>) -> vector<64xi8>
            %69 = "arith.addi"(%arg17, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            %70 = "vector.transfer_read"(%58, %69, %8, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x32xi8, strided<[128, 1], offset: ?>>, index, index, i8) -> vector<2x32xi8>
            %71 = "vector.shape_cast"(%70) : (vector<2x32xi8>) -> vector<64xi8>
            %72 = "vector.shuffle"(%68, %71) <{mask = array<i64: 0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
            %73 = "vector.shuffle"(%68, %71) <{mask = array<i64: 4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127>}> : (vector<64xi8>, vector<64xi8>) -> vector<64xi8>
            %74 = "arith.divui"(%arg17, %5) : (index, index) -> index
            %75 = "arith.addi"(%74, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
            "vector.store"(%72, %20, %55, %74, %8) <{nontemporal = false}> : (vector<64xi8>, memref<2x32x64xi8>, index, index, index) -> ()
            "vector.store"(%73, %20, %55, %75, %8) <{nontemporal = false}> : (vector<64xi8>, memref<2x32x64xi8>, index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          %59 = "x86.amx.tile_load"(%20, %57, %8, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xi8>, index, index, index) -> !x86.amx.tile<16x64xi8>
          %60 = "x86.amx.tile_load"(%20, %57, %7, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xi8>, index, index, index) -> !x86.amx.tile<16x64xi8>
          %61 = "x86.amx.tile_load"(%52, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %62 = "x86.amx.tile_muli"(%61, %59, %arg13) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %63 = "x86.amx.tile_muli"(%61, %60, %arg14) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %64 = "x86.amx.tile_load"(%52, %7, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %65 = "x86.amx.tile_muli"(%64, %59, %arg15) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %66 = "x86.amx.tile_muli"(%64, %60, %arg16) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          "scf.yield"(%62, %63, %65, %66) : (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>)
        %23:4 = "scf.for"(%6, %11, %9, %22#0, %22#1, %22#2, %22#3) ({
        ^bb0(%arg7: index, %arg8: !x86.amx.tile<16x16xi32>, %arg9: !x86.amx.tile<16x16xi32>, %arg10: !x86.amx.tile<16x16xi32>, %arg11: !x86.amx.tile<16x16xi32>):
          %41 = "memref.subview"(%arg1, %arg4, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 64>, static_strides = array<i64: 1, 1>}> : (memref<64x256xi8>, index, index) -> memref<32x64xi8, strided<[256, 1], offset: ?>>
          %42 = "arith.divui"(%arg7, %9) : (index, index) -> index
          %43 = "arith.remui"(%42, %4) : (index, index) -> index
          %44 = "x86.amx.tile_load"(%20, %43, %8, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xi8>, index, index, index) -> !x86.amx.tile<16x64xi8>
          %45 = "x86.amx.tile_load"(%20, %43, %7, %8) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x64xi8>, index, index, index) -> !x86.amx.tile<16x64xi8>
          %46 = "x86.amx.tile_load"(%41, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %47 = "x86.amx.tile_muli"(%46, %44, %arg8) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %48 = "x86.amx.tile_muli"(%46, %45, %arg9) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %49 = "x86.amx.tile_load"(%41, %7, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x64xi8, strided<[256, 1], offset: ?>>, index, index) -> !x86.amx.tile<16x64xi8>
          %50 = "x86.amx.tile_muli"(%49, %44, %arg10) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          %51 = "x86.amx.tile_muli"(%49, %45, %arg11) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
          "scf.yield"(%47, %48, %50, %51) : (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> ()
        }) : (index, index, index, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>)
        %24 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x32xi32>
        "x86.amx.tile_store"(%24, %8, %8, %23#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
        "x86.amx.tile_store"(%24, %8, %7, %23#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
        "x86.amx.tile_store"(%24, %7, %8, %23#2) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
        "x86.amx.tile_store"(%24, %7, %7, %23#3) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
        "scf.for"(%8, %12, %2) ({
        ^bb0(%arg6: index):
          %33 = "vector.load"(%24, %arg6, %8) <{nontemporal = false}> : (memref<32x32xi32>, index, index) -> vector<16xi32>
          %34 = "vector.load"(%24, %arg6, %7) <{nontemporal = false}> : (memref<32x32xi32>, index, index) -> vector<16xi32>
          %35 = "vector.shuffle"(%33, %34) <{mask = array<i64: 0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
          %36 = "vector.shuffle"(%33, %34) <{mask = array<i64: 8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
          %37 = "vector.load"(%15, %arg6, %8) <{nontemporal = false}> : (memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xi32>
          %38 = "vector.load"(%15, %arg6, %7) <{nontemporal = false}> : (memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> vector<16xi32>
          %39 = "arith.addi"(%35, %37) <{overflowFlags = #arith.overflow<none>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
          %40 = "arith.addi"(%36, %38) <{overflowFlags = #arith.overflow<none>}> : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
          "vector.store"(%39, %24, %arg6, %8) <{nontemporal = false}> : (vector<16xi32>, memref<32x32xi32>, index, index) -> ()
          "vector.store"(%40, %24, %arg6, %7) <{nontemporal = false}> : (vector<16xi32>, memref<32x32xi32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %25 = "vector.transfer_read"(%24, %8, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
        %26 = "vector.transfer_read"(%24, %8, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
        %27 = "vector.transfer_read"(%24, %7, %8, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
        %28 = "vector.transfer_read"(%24, %7, %7, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xi32>, index, index, i32) -> vector<16x16xi32>
        %29 = "arith.addi"(%28, %13) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        %30 = "arith.addi"(%27, %13) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        %31 = "arith.addi"(%26, %13) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        %32 = "arith.addi"(%25, %13) <{overflowFlags = #arith.overflow<none>}> : (vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
        "vector.transfer_write"(%29, %15, %7, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%30, %15, %7, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%31, %15, %8, %7) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%32, %15, %8, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %14 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xi32>
    "memref.copy"(%arg3, %14) : (memref<64x128xi32>, memref<64x128xi32>) -> ()
    "func.return"(%14) : (memref<64x128xi32>) -> ()
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
    %7 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.for"(%3, %4, %7) ({
    ^bb0(%arg5: index):
      "scf.for"(%3, %5, %7) ({
      ^bb0(%arg6: index):
        %9 = "memref.subview"(%arg3, %arg5, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x128xf32>, index, index) -> memref<32x32xf32, strided<[128, 1], offset: ?>>
        %10 = "vector.transfer_read"(%9, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %11 = "vector.transfer_read"(%9, %3, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %12 = "vector.transfer_read"(%9, %6, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %13 = "vector.transfer_read"(%9, %6, %6, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index, f32) -> vector<16x16xf32>
        %14:4 = "scf.for"(%3, %7, %arg4, %10, %11, %12, %13) ({
        ^bb0(%arg7: index, %arg8: vector<16x16xf32>, %arg9: vector<16x16xf32>, %arg10: vector<16x16xf32>, %arg11: vector<16x16xf32>):
          %15 = "memref.subview"(%arg1, %arg5, %arg7) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<64x96xbf16>, index, index) -> memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %16 = "memref.subview"(%arg2, %arg7, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 32, 32>, static_strides = array<i64: 1, 1>}> : (memref<96x128xbf16>, index, index) -> memref<32x32xbf16, strided<[128, 1], offset: ?>>
          %17 = "vector.transfer_read"(%15, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index, bf16) -> vector<16x32xbf16>
          %18 = "vector.transfer_read"(%15, %6, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[96, 1], offset: ?>>, index, index, bf16) -> vector<16x32xbf16>
          %19 = "vector.transfer_read"(%16, %3, %3, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32x16xbf16>
          %20 = "vector.transfer_read"(%16, %3, %6, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xbf16, strided<[128, 1], offset: ?>>, index, index, bf16) -> vector<32x16xbf16>
          %21 = "vector.contract"(%17, %19, %arg8) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %22 = "vector.contract"(%17, %20, %arg9) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %23 = "vector.contract"(%18, %19, %arg10) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          %24 = "vector.contract"(%18, %20, %arg11) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 16, 16, 32>} : (vector<16x32xbf16>, vector<32x16xbf16>, vector<16x16xf32>) -> vector<16x16xf32>
          "scf.yield"(%21, %22, %23, %24) : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> ()
        }) : (index, index, index, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>)
        "vector.transfer_write"(%14#3, %9, %6, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%14#2, %9, %6, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%14#1, %9, %3, %6) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "vector.transfer_write"(%14#0, %9, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %8 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64x128xf32>
    "memref.copy"(%arg3, %8) : (memref<64x128xf32>, memref<64x128xf32>) -> ()
    "func.return"(%8) : (memref<64x128xf32>) -> ()
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
    %3 = "vector.transfer_read"(%arg1, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x32x16x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %4 = "vector.transfer_read"(%arg2, %1, %1, %1, %1, %2) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<1x16x32x2xbf16>, index, index, index, index, bf16) -> vector<1x16x16x2xbf16>
    %5 = "vector.transfer_read"(%arg3, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x32xbf16>, index, index, bf16) -> vector<16x16xbf16>
    %6 = "vector.contract"(%3, %4, %5) <{fastmath = #arith.fastmath<none>, indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16>, vector<16x16xbf16>) -> vector<16x16xbf16>
    "vector.transfer_write"(%6, %arg3, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xbf16>, memref<32x32xbf16>, index, index) -> ()
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

