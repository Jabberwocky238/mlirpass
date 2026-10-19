#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_cst"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.contract"(%3, %4, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%5, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, f16) -> (), sym_name = "matmul_broadcast"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: f16):
    %0 = "vector.broadcast"(%arg3) : (f16) -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.contract"(%3, %4, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%5, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf16>, memref<128x128xf16>, memref<128x128xf16>) -> (), sym_name = "matmul_loop"}> ({
  ^bb0(%arg0: memref<128x128xf16>, %arg1: memref<128x128xf16>, %arg2: memref<128x128xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %4 = "vector.transfer_read"(%arg2, %0, %0, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "scf.for"(%0, %1, %2, %4) ({
    ^bb0(%arg3: index, %arg4: vector<16x16xf16>):
      %6 = "vector.transfer_read"(%arg0, %0, %arg3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xf16>, index, index, f16) -> vector<16x16xf16>
      %7 = "vector.transfer_read"(%arg1, %arg3, %0, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<128x128xf16>, index, index, f16) -> vector<16x16xf16>
      %8 = "vector.contract"(%6, %7, %arg4) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
      "scf.yield"(%8) : (vector<16x16xf16>) -> ()
    }) : (index, index, index, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%5, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<128x128xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_fused_elementwise"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = dense<1.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %4 = "vector.transfer_read"(%arg0, %2, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg1, %2, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%4, %5, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    %7 = "arith.addf"(%6, %1) <{fastmath = #arith.fastmath<none>}> : (vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%7, %arg2, %2, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map5 = affine_map<(d0, d1, d2, d3) -> (0, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, memref<16x16x16x16xf16>) -> (), sym_name = "matmul_fused_broadcast"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16x16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.contract"(%3, %4, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    %6 = "vector.transfer_read"(%arg3, %1, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map5}> : (memref<16x16x16x16xf16>, index, index, index, index, f16) -> vector<16x16xf16>
    %7 = "arith.divf"(%5, %6) <{fastmath = #arith.fastmath<none>}> : (vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%7, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
#map1 = affine_map<(d0) -> (d0, 0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x16x16xf16>, memref<16xf16>, memref<2x16x16xf16>) -> (), sym_name = "matmul_3Dmemref"}> ({
  ^bb0(%arg0: memref<2x16x16xf16>, %arg1: memref<16xf16>, %arg2: memref<2x16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<2x16x16xf16>, index, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map1}> : (memref<16xf16>, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<2x16x16xf16>, index, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<2x16x16xf16>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0 * 512 + d1 * 32 + d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0) -> (d0, 0)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x16x16xf16, #map>, memref<16xf16>, memref<2x16x16xf16>) -> (), sym_name = "matmul_memref_strided"}> ({
  ^bb0(%arg0: memref<2x16x16xf16, #map>, %arg1: memref<16xf16>, %arg2: memref<2x16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<2x16x16xf16, #map>, index, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map2}> : (memref<16xf16>, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<2x16x16xf16>, index, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map3, #map1, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map1}> : (vector<16x16xf16>, memref<2x16x16xf16>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_transposed"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf16>, memref<16xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_transposed_broadcasted_1d"}> ({
  ^bb0(%arg0: memref<16xf16>, %arg1: memref<16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<16xf16>, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<16xf16>, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32x32xf16>, memref<32x32xf16>, memref<16x16xf16>) -> (), sym_name = "matmul_transposed_broadcasted_2d"}> ({
  ^bb0(%arg0: memref<32x32xf16>, %arg1: memref<32x32xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x16xf16>}> : () -> vector<16x16xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x32xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xi8>, memref<16x16xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_no_extend_int8"}> ({
  ^bb0(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<16x16xi8>}> : () -> vector<16x16xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %5 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "vector.contract"(%4, %5, %6) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xi8>, vector<16x16xi8>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%7, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xi8>, memref<16x16xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_int8"}> ({
  ^bb0(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<16x16xi8>}> : () -> vector<16x16xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %5 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "arith.extsi"(%4) : (vector<16x16xi8>) -> vector<16x16xi32>
    %8 = "arith.extsi"(%5) : (vector<16x16xi8>) -> vector<16x16xi32>
    %9 = "vector.contract"(%7, %8, %6) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%9, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xi8>, memref<16x16xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_mixed_signedness_int8"}> ({
  ^bb0(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<16x16xi8>}> : () -> vector<16x16xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %5 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xi8>, index, index, i8) -> vector<16x16xi8>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "arith.extui"(%4) : (vector<16x16xi8>) -> vector<16x16xi32>
    %8 = "arith.extsi"(%5) : (vector<16x16xi8>) -> vector<16x16xi32>
    %9 = "vector.contract"(%7, %8, %6) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xi32>, vector<16x16xi32>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%9, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32xi8>, memref<16x32xi8>, memref<16x16xi32>) -> (), sym_name = "matmul_mixed_signedness_int8"}> ({
  ^bb0(%arg0: memref<16x32xi8>, %arg1: memref<16x32xi8>, %arg2: memref<16x16xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<16x16xi8>}> : () -> vector<16x16xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x32xi8>, index, index, i8) -> vector<16x32xi8>
    %5 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x32xi8>, index, index, i8) -> vector<16x32xi8>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xi32>, index, index, i32) -> vector<16x16xi32>
    %7 = "arith.extui"(%4) : (vector<16x32xi8>) -> vector<16x32xi32>
    %8 = "arith.extsi"(%5) : (vector<16x32xi8>) -> vector<16x32xi32>
    %9 = "vector.contract"(%7, %8, %6) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x32xi32>, vector<16x32xi32>, vector<16x16xi32>) -> vector<16x16xi32>
    "vector.transfer_write"(%9, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xi32>, memref<16x16xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf32>) -> (), sym_name = "cast_f16_to_f32_write"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.contract"(%2, %3, %4) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    %6 = "arith.extf"(%5) : (vector<16x16xf16>) -> vector<16x16xf32>
    "vector.transfer_write"(%6, %arg3, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<16x16xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x128xf16>, vector<32x128xf16>, memref<32x64xf32>) -> (), sym_name = "fold_transpose_into_transfer_read"}> ({
  ^bb0(%arg0: memref<64x128xf16>, %arg1: vector<32x128xf16>, %arg2: memref<32x64xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32x64xf32>}> : () -> vector<32x64xf32>
    %3 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<64x128xf16>, index, index, f16) -> vector<64x128xf16>
    %4 = "arith.extf"(%3) : (vector<64x128xf16>) -> vector<64x128xf32>
    %5 = "arith.extf"(%arg1) : (vector<32x128xf16>) -> vector<32x128xf32>
    %6 = "vector.transpose"(%4) <{permutation = array<i64: 1, 0>}> : (vector<64x128xf32>) -> vector<128x64xf32>
    %7 = "vector.contract"(%5, %6, %2) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<32x128xf32>, vector<128x64xf32>, vector<32x64xf32>) -> vector<32x64xf32>
    "vector.transfer_write"(%7, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<32x64xf32>, memref<32x64xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf32>) -> (), sym_name = "cast_f16_to_f32_read"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %5 = "arith.extf"(%2) : (vector<16x16xf16>) -> vector<16x16xf32>
    %6 = "arith.extf"(%3) : (vector<16x16xf16>) -> vector<16x16xf32>
    %7 = "arith.extf"(%4) : (vector<16x16xf16>) -> vector<16x16xf32>
    %8 = "vector.contract"(%5, %6, %7) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) -> vector<16x16xf32>
    "vector.transfer_write"(%8, %arg3, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf32>, memref<16x16xf32>, index, index) -> ()
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
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf16>, memref<16x16xf16>, memref<16x16xf16>) -> (), sym_name = "addf"}> ({
  ^bb0(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<16x16xf16>, index, index, f16) -> vector<16x16xf16>
    %4 = "arith.addf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (vector<16x16xf16>, vector<16x16xf16>) -> vector<16x16xf16>
    "vector.transfer_write"(%4, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x16xf16>, memref<16x16xf16>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

