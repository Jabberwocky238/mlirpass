#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32xf16, #gpu.address_space<workgroup>>, memref<32x64xf16, #gpu.address_space<workgroup>>, memref<42x64xf32, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n8k16_mmasync16816_f16_f16_f32_row_row_row"}> ({
  ^bb0(%arg0: memref<42x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<32x64xf16, #gpu.address_space<workgroup>>, %arg2: memref<42x64xf32, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "vector.transfer_read"(%arg0, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<42x32xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %5 = "arith.extf"(%4) : (vector<16x16xf16>) -> vector<16x16xf32>
    %6 = "vector.transfer_read"(%arg1, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map1}> : (memref<32x64xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %7 = "vector.transfer_read"(%arg2, %0, %0, %3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<42x64xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x16xf32>
    %8 = "vector.extract_strided_slice"(%6) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %9 = "arith.extf"(%8) : (vector<8x16xf16>) -> vector<8x16xf32>
    %10 = "vector.extract_strided_slice"(%7) <{offsets = [0, 0], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<16x8xf32>
    %11 = "vector.contract"(%5, %9, %10) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf32>, vector<8x16xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    "vector.transfer_write"(%11, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf32>, memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    %12 = "vector.extract_strided_slice"(%6) <{offsets = [8, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %13 = "arith.extf"(%12) : (vector<8x16xf16>) -> vector<8x16xf32>
    %14 = "vector.extract_strided_slice"(%7) <{offsets = [0, 8], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<16x8xf32>
    %15 = "vector.contract"(%5, %13, %14) <{indexing_maps = [#map2, #map3, #map4], iterator_types = [#vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> : (vector<16x16xf32>, vector<8x16xf32>, vector<16x8xf32>) -> vector<16x8xf32>
    "vector.transfer_write"(%15, %arg2, %0, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<16x8xf32>, memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

