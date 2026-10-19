"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_cst"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.subgroup_mma_constant_matrix"(%1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %4 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %5 = "gpu.subgroup_mma_compute"(%3, %4, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%5, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, f16) -> (), sym_name = "matmul_broadcast"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: f16):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_constant_matrix"(%arg3) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%2, %3, %1) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf16>, memref<128x128xf16>, memref<128x128xf16>) -> (), sym_name = "matmul_loop"}> ({
  ^bb0(%arg0: memref<128x128xf16>, %arg1: memref<128x128xf16>, %arg2: memref<128x128xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 128 : index}> : (memref<128x128xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %4 = "scf.for"(%0, %1, %2, %3) ({
    ^bb0(%arg3: index, %arg4: !gpu.mma_matrix<16x16xf16, "COp">):
      %5 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %arg3) <{leadDimension = 128 : index}> : (memref<128x128xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
      %6 = "gpu.subgroup_mma_load_matrix"(%arg1, %arg3, %0) <{leadDimension = 128 : index}> : (memref<128x128xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
      %7 = "gpu.subgroup_mma_compute"(%5, %6, %arg4) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "scf.yield"(%7) : (!gpu.mma_matrix<16x16xf16, "COp">) -> ()
    }) : (index, index, index, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 128 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<128x128xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_fused_elementwise"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "gpu.subgroup_mma_constant_matrix"(%2) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
    %4 = "gpu.subgroup_mma_constant_matrix"(%1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
    %5 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %6 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %7 = "gpu.subgroup_mma_compute"(%5, %6, %3) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    %8 = "gpu.subgroup_mma_elementwise"(%7, %4) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%8, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, memref<16x16x16x16xf16>) -> (), sym_name = "matmul_fused_broadcast"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16x16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "gpu.subgroup_mma_constant_matrix"(%1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %4 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %5 = "gpu.subgroup_mma_compute"(%3, %4, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    %6 = "gpu.subgroup_mma_load_matrix"(%arg3, %0, %0, %0, %0) <{leadDimension = 0 : index}> : (memref<16x16x16x16xf16>, index, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %7 = "gpu.subgroup_mma_elementwise"(%5, %6) <{opType = #gpu<mma_element_wise divf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%7, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x16x16xf16>, memref<16xf16>, memref<2x16x16xf16>) -> (), sym_name = "matmul_3Dmemref"}> ({
  ^bb0(%arg0: memref<2x16x16xf16>, %arg1: memref<16xf16>, %arg2: memref<2x16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0, %0) <{leadDimension = 16 : index}> : (memref<2x16x16xf16>, index, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0, %0) <{leadDimension = 16 : index}> : (memref<2x16x16xf16>, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0) <{leadDimension = 0 : index}> : (memref<16xf16>, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<2x16x16xf16>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0 * 512 + d1 * 32 + d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x16x16xf16, #map>, memref<16xf16>, memref<2x16x16xf16>) -> (), sym_name = "matmul_memref_strided"}> ({
  ^bb0(%arg0: memref<2x16x16xf16, #map>, %arg1: memref<16xf16>, %arg2: memref<2x16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0, %0) <{leadDimension = 32 : index}> : (memref<2x16x16xf16, #map>, index, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0, %0) <{leadDimension = 16 : index}> : (memref<2x16x16xf16>, index, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0) <{leadDimension = 0 : index}> : (memref<16xf16>, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<2x16x16xf16>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_transposed"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index, transpose}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf16>, memref<16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_transposed_broadcasted_1d"}> ({
  ^bb0(%arg0: memref<16xf16>, %arg1: memref<16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0) <{leadDimension = 0 : index, transpose}> : (memref<16xf16>, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0) <{leadDimension = 0 : index}> : (memref<16xf16>, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf16>, memref<32x32xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_transposed_broadcasted_2d"}> ({
  ^bb0(%arg0: memref<32x32xf16>, %arg1: memref<32x32xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 0 : index, transpose}> : (memref<32x32xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 0 : index}> : (memref<32x32xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xi8>, memref<16x16xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_no_extend_int8"}> ({
  ^bb0(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    %5 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %6 = "vector.contract"(%3, %5, %4) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xi8>, vector<16x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%6, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xi8>, memref<16x16xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_int8"}> ({
  ^bb0(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi8>, index, index) -> !gpu.mma_matrix<16x16xsi8, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi32>, index, index) -> !gpu.mma_matrix<16x16xi32, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi8>, index, index) -> !gpu.mma_matrix<16x16xsi8, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xsi8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">) -> !gpu.mma_matrix<16x16xi32, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xi8>, memref<16x16xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_mixed_signedness_int8"}> ({
  ^bb0(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi8>, index, index) -> !gpu.mma_matrix<16x16xui8, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi32>, index, index) -> !gpu.mma_matrix<16x16xi32, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi8>, index, index) -> !gpu.mma_matrix<16x16xsi8, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xui8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">) -> !gpu.mma_matrix<16x16xi32, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32xi8>, memref<16x32xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_mixed_signedness_int8"}> ({
  ^bb0(%arg0: memref<16x32xi8>, %arg1: memref<16x32xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 32 : index}> : (memref<16x32xi8>, index, index) -> !gpu.mma_matrix<16x32xui8, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xi32>, index, index) -> !gpu.mma_matrix<16x16xi32, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 32 : index}> : (memref<16x32xi8>, index, index) -> !gpu.mma_matrix<32x16xsi8, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x32xui8, "AOp">, !gpu.mma_matrix<32x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">) -> !gpu.mma_matrix<16x16xi32, "COp">
    "gpu.subgroup_mma_store_matrix"(%4, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf32>) -> (), sym_name = "cast_f16_to_f32_write"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index, transpose}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = "gpu.subgroup_mma_compute"(%1, %3, %2) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    %5 = "gpu.subgroup_mma_elementwise"(%4) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
    "gpu.subgroup_mma_store_matrix"(%5, %arg3, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x128xf16>, vector<32x128xf16>, memref<32x64xf32>) -> (), sym_name = "fold_transpose_into_transfer_read"}> ({
  ^bb0(%arg0: memref<64x128xf16>, %arg1: vector<32x128xf16>, %arg2: memref<32x64xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32x64xf32>}> : () -> vector<32x64xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "arith.extf"(%arg1) : (vector<32x128xf16>) -> vector<32x128xf32>
    %4 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x128xf16>, index, index, f16) -> vector<128x64xf16>
    %5 = "arith.extf"(%4) : (vector<128x64xf16>) -> vector<128x64xf32>
    %6 = "vector.contract"(%3, %5, %0) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<32x128xf32>, vector<128x64xf32>, vector<32x64xf32>) -> vector<32x64xf32>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map4}> : (vector<32x64xf32>, memref<32x64xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf32>) -> (), sym_name = "cast_f16_to_f32_read"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg2, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_elementwise"(%1) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "AOp">) -> !gpu.mma_matrix<16x16xf32, "AOp">
    %4 = "gpu.subgroup_mma_elementwise"(%2) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
    %5 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index, transpose}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "BOp">
    %6 = "gpu.subgroup_mma_elementwise"(%5) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "BOp">) -> !gpu.mma_matrix<16x16xf32, "BOp">
    %7 = "gpu.subgroup_mma_compute"(%3, %6, %4) : (!gpu.mma_matrix<16x16xf32, "AOp">, !gpu.mma_matrix<16x16xf32, "BOp">, !gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
    "gpu.subgroup_mma_store_matrix"(%7, %arg3, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x4xi32>, vector<4x4xi32>, vector<4x4xi64>) -> vector<4x4xi64>, sym_name = "test_unsupported"}> ({
  ^bb0(%arg0: vector<4x4xi32>, %arg1: vector<4x4xi32>, %arg2: vector<4x4xi64>):
    %0 = "arith.extui"(%arg0) : (vector<4x4xi32>) -> vector<4x4xi64>
    %1 = "arith.extui"(%arg1) : (vector<4x4xi32>) -> vector<4x4xi64>
    %2 = "vector.contract"(%0, %1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<4x4xi64>, vector<4x4xi64>, vector<4x4xi64>) -> vector<4x4xi64>
    "func.return"(%2) : (vector<4x4xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "addf"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "gpu.subgroup_mma_load_matrix"(%arg0, %0, %0) <{leadDimension = 16 : index}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = "gpu.subgroup_mma_load_matrix"(%arg1, %0, %0) <{leadDimension = 16 : index, transpose}> : (memref<16x16xf16>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
    %3 = "gpu.subgroup_mma_elementwise"(%1, %2) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    "gpu.subgroup_mma_store_matrix"(%3, %arg2, %0, %0) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

