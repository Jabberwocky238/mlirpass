#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi32>) -> (), sym_name = "m16n8k32_int8_row_row_row"}> ({
  ^bb0(%arg0: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<32x8xi8>}> : () -> vector<32x8xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 17 : index}> : () -> index
    %4 = "arith.constant"() <{value = 39 : index}> : () -> index
    %5 = "arith.constant"() <{value = 40 : index}> : () -> index
    %6 = "arith.constant"() <{value = 49 : index}> : () -> index
    %7 = "arith.constant"() <{value = 50 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %10 = "vector.transfer_read"(%arg0, %1, %1, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<16x32xi8>
    %11 = "vector.transfer_read"(%arg1, %4, %5, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<8x32xi8>
    %12 = "vector.transfer_read"(%arg2, %6, %5, %9) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi32>, index, index, i32) -> vector<16x8xi32>
    %13 = "vector.contract"(%10, %11, %12) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x32xi8>, vector<8x32xi8>, vector<16x8xi32>) -> vector<16x8xi32>
    "vector.transfer_write"(%13, %arg2, %6, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xi32>, memref<128x128xi32>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<128x128xf64>, memref<128x128xf64>, memref<128x128xf64>) -> (), sym_name = "m8n8k4_f64_row_row_row"}> ({
  ^bb0(%arg0: memref<128x128xf64>, %arg1: memref<128x128xf64>, %arg2: memref<128x128xf64>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x8xf64>}> : () -> vector<4x8xf64>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 17 : index}> : () -> index
    %4 = "arith.constant"() <{value = 39 : index}> : () -> index
    %5 = "arith.constant"() <{value = 40 : index}> : () -> index
    %6 = "arith.constant"() <{value = 49 : index}> : () -> index
    %7 = "arith.constant"() <{value = 50 : index}> : () -> index
    %8 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %9 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %10 = "vector.transfer_read"(%arg0, %2, %2, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xf64>, index, index, f64) -> vector<8x4xf64>
    %11 = "vector.transfer_read"(%arg1, %4, %5, %8) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<128x128xf64>, index, index, f64) -> vector<8x4xf64>
    %12 = "vector.transfer_read"(%arg2, %6, %5, %9) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xf64>, index, index, f64) -> vector<8x8xf64>
    %13 = "vector.contract"(%10, %11, %12) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<8x4xf64>, vector<8x4xf64>, vector<8x8xf64>) -> vector<8x8xf64>
    "vector.transfer_write"(%13, %arg2, %6, %5) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x8xf64>, memref<128x128xf64>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n8k16_fp16_row_row_row"}> ({
  ^bb0(%arg0: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf16>}> : () -> vector<16x8xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<42x32xf16, #gpu.address_space<workgroup>>, memref<32x64xf16, #gpu.address_space<workgroup>>, memref<42x64xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n16k16_mmasync16816_fp16_f16_row_row_row"}> ({
  ^bb0(%arg0: memref<42x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<32x64xf16, #gpu.address_space<workgroup>>, %arg2: memref<42x64xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<42x32xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x64xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.transfer_read"(%arg2, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<42x64xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %6 = "vector.extract_strided_slice"(%4) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %7 = "vector.extract_strided_slice"(%5) <{offsets = [0, 0], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<16x8xf16>
    %8 = "vector.contract"(%3, %6, %7) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%8, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    %9 = "vector.extract_strided_slice"(%4) <{offsets = [8, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %10 = "vector.extract_strided_slice"(%5) <{offsets = [0, 8], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<16x8xf16>
    %11 = "vector.contract"(%3, %9, %10) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%11, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<42x64xf16, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, memref<1x32x40xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "multi_dim_m16n8k16_fp16_row_row_row"}> ({
  ^bb0(%arg0: memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, %arg2: memref<1x32x40xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "vector.transfer_read"(%arg0, %0, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, index, index, index, index, f16) -> vector<16x16xf16>
    %3 = "vector.transfer_read"(%arg1, %0, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map1}> : (memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, index, index, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg2, %0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map2}> : (memref<1x32x40xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<16x16xf16>
    %5 = "vector.extract_strided_slice"(%3) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %6 = "vector.extract_strided_slice"(%4) <{offsets = [0, 0], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<16x8xf16>
    %7 = "vector.contract"(%2, %5, %6) <{indexing_maps = [#map3, #map2, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%7, %arg2, %0, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map2}> : (vector<16x8xf16>, memref<1x32x40xf16, #gpu.address_space<workgroup>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x20x20xf16, #gpu.address_space<workgroup>>, memref<2x20x20xf16, #gpu.address_space<workgroup>>, memref<2x20x20xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "batch_m16n8k16_fp16_row_row_row"}> ({
  ^bb0(%arg0: memref<2x20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<2x20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<2x20x20xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<20x20xf16>}> : () -> vector<20x20xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map1}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<8x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<2x20x20xf16, #gpu.address_space<workgroup>>, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>, memref<20x20xf16, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n8k16_fp16_row_col_row"}> ({
  ^bb0(%arg0: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf16>}> : () -> vector<16x8xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<20x20xf16, #gpu.address_space<workgroup>>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32>) -> (), sym_name = "m16n8k4_tf32_f32_row_row_row"}> ({
  ^bb0(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf32>}> : () -> vector<16x8xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "vector.transfer_read"(%arg0, %2, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x4xf32>
    %6 = "vector.transfer_read"(%arg1, %3, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<8x4xf32>
    %7 = "vector.contract"(%5, %6, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x4xf32>, vector<8x4xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    "vector.transfer_write"(%7, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf32>, memref<20x20xf32>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32>) -> (), sym_name = "m16n8k8_tf32_f32_row_row_row"}> ({
  ^bb0(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf32>}> : () -> vector<16x8xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "vector.transfer_read"(%arg0, %2, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x8xf32>
    %6 = "vector.transfer_read"(%arg1, %3, %3, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<8x8xf32>
    %7 = "vector.contract"(%5, %6, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf32>, vector<8x8xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    "vector.transfer_write"(%7, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf32>, memref<20x20xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32, #gpu.address_space<workgroup>>, memref<20x20xf32>) -> (), sym_name = "m16n8k8_tf32_f32_col_col_row"}> ({
  ^bb0(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf32>}> : () -> vector<16x8xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "vector.transfer_read"(%arg0, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x8xf32>
    %6 = "vector.transfer_read"(%arg1, %1, %1, %4) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<8x8xf32>
    %7 = "vector.contract"(%5, %6, %0) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x8xf32>, vector<8x8xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    "vector.transfer_write"(%7, %arg2, %2, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x8xf32>, memref<20x20xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xi4, #gpu.address_space<workgroup>>, memref<128x128xi4, #gpu.address_space<workgroup>>, memref<128x128xi32>) -> (), sym_name = "m16n8k64_int4_row_col_row"}> ({
  ^bb0(%arg0: memref<128x128xi4, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi4, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>):
    %0 = "arith.constant"() <{value = 0 : i4}> : () -> i4
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = dense<0> : vector<32x8xi4>}> : () -> vector<32x8xi4>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "vector.transfer_read"(%arg0, %3, %3, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi4, #gpu.address_space<workgroup>>, index, index, i4) -> vector<16x64xi4>
    %5 = "vector.transfer_read"(%arg1, %3, %3, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi4, #gpu.address_space<workgroup>>, index, index, i4) -> vector<8x64xi4>
    %6 = "vector.transfer_read"(%arg2, %3, %3, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi32>, index, index, i32) -> vector<16x8xi32>
    %7 = "vector.contract"(%4, %5, %6) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x64xi4>, vector<8x64xi4>, vector<16x8xi32>) -> vector<16x8xi32>
    "vector.transfer_write"(%7, %arg2, %3, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xi32>, memref<128x128xi32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi8, #gpu.address_space<workgroup>>, memref<128x128xi32>) -> (), sym_name = "m16n8k32_int8_row_col_row"}> ({
  ^bb0(%arg0: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<32x8xi8>}> : () -> vector<32x8xi8>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<16x32xi8>
    %5 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi8, #gpu.address_space<workgroup>>, index, index, i8) -> vector<8x32xi8>
    %6 = "vector.transfer_read"(%arg2, %1, %1, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xi32>, index, index, i32) -> vector<16x8xi32>
    %7 = "vector.contract"(%4, %5, %6) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x32xi8>, vector<8x32xi8>, vector<16x8xi32>) -> vector<16x8xi32>
    "vector.transfer_write"(%7, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xi32>, memref<128x128xi32>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "strided_memref_read_write"}> ({
  ^bb0(%arg0: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf16>}> : () -> vector<16x8xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d2, d0, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "unsupported_non_2d_load_store"}> ({
  ^bb0(%arg0: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf16>}> : () -> vector<16x8xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<1x16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<8x1x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %1, %2) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index, f16) -> vector<1x16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<1x16x16xf16>, vector<8x1x16xf16>, vector<1x16x8xf16>) -> vector<1x16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1, %1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<1x16x8xf16>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, index) -> ()
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
  "func.func"() <{function_type = (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "unsupported_fully_dynamic_strides"}> ({
  ^bb0(%arg0: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf16>}> : () -> vector<16x8xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf16>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
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
  "func.func"() <{function_type = (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>) -> (), sym_name = "unsupported_transposed_store"}> ({
  ^bb0(%arg0: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<16x8xf16>}> : () -> vector<16x8xf16>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "vector.transfer_read"(%arg0, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %4 = "vector.transfer_read"(%arg1, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<8x16xf16>
    %5 = "vector.transfer_read"(%arg2, %1, %1, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x8xf16>
    %6 = "vector.contract"(%3, %4, %5) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf16>, vector<8x16xf16>, vector<16x8xf16>) -> vector<16x8xf16>
    "vector.transfer_write"(%6, %arg2, %1, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map1}> : (vector<16x8xf16>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

