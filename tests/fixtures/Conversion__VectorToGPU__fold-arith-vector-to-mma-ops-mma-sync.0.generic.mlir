#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d1, d0)>
#map4 = affine_map<()[s0] -> (s0 floordiv 4)>
#map5 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32xf16, #gpu.address_space<workgroup>>, memref<32x64xf16, #gpu.address_space<workgroup>>, memref<42x64xf32, #gpu.address_space<workgroup>>) -> (), sym_name = "m16n8k16_mmasync16816_f16_f16_f32_row_row_row"}> ({
  ^bb0(%arg0: memref<42x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<32x64xf16, #gpu.address_space<workgroup>>, %arg2: memref<42x64xf32, #gpu.address_space<workgroup>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "gpu.lane_id"() : () -> index
    %4 = "affine.apply"(%3) <{map = #map}> : (index) -> index
    %5 = "affine.apply"(%3) <{map = #map1}> : (index) -> index
    %6 = "nvgpu.ldmatrix"(%arg0, %4, %5) <{numTiles = 4 : i32, transpose = false}> : (memref<42x32xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %7 = "vector.transfer_read"(%arg0, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<42x32xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %8 = "nvgpu.ldmatrix"(%arg1, %4, %5) <{numTiles = 4 : i32, transpose = true}> : (memref<32x64xf16, #gpu.address_space<workgroup>>, index, index) -> vector<4x2xf16>
    %9 = "vector.transfer_read"(%arg1, %0, %0, %1) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map3}> : (memref<32x64xf16, #gpu.address_space<workgroup>>, index, index, f16) -> vector<16x16xf16>
    %10 = "vector.broadcast"(%2) : (f32) -> vector<4x2xf32>
    %11 = "affine.apply"(%3) <{map = #map4}> : (index) -> index
    %12 = "affine.apply"(%3) <{map = #map5}> : (index) -> index
    %13 = "vector.load"(%arg2, %11, %12) <{nontemporal = false}> : (memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> vector<2xf32>
    %14 = "vector.insert"(%13, %10) <{static_position = array<i64: 0>}> : (vector<2xf32>, vector<4x2xf32>) -> vector<4x2xf32>
    %15 = "affine.apply"(%3) <{map = #map6}> : (index) -> index
    %16 = "vector.load"(%arg2, %15, %12) <{nontemporal = false}> : (memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> vector<2xf32>
    %17 = "vector.insert"(%16, %14) <{static_position = array<i64: 1>}> : (vector<2xf32>, vector<4x2xf32>) -> vector<4x2xf32>
    %18 = "affine.apply"(%3) <{map = #map7}> : (index) -> index
    %19 = "vector.load"(%arg2, %11, %18) <{nontemporal = false}> : (memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> vector<2xf32>
    %20 = "vector.insert"(%19, %17) <{static_position = array<i64: 2>}> : (vector<2xf32>, vector<4x2xf32>) -> vector<4x2xf32>
    %21 = "vector.load"(%arg2, %15, %18) <{nontemporal = false}> : (memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> vector<2xf32>
    %22 = "vector.insert"(%21, %20) <{static_position = array<i64: 3>}> : (vector<2xf32>, vector<4x2xf32>) -> vector<4x2xf32>
    %23 = "vector.transfer_read"(%arg2, %0, %0, %2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map2}> : (memref<42x64xf32, #gpu.address_space<workgroup>>, index, index, f32) -> vector<16x16xf32>
    %24 = "vector.extract_strided_slice"(%8) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %25 = "vector.extract_strided_slice"(%9) <{offsets = [0, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %26 = "vector.extract_strided_slice"(%22) <{offsets = [0, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf32>) -> vector<2x2xf32>
    %27 = "vector.extract_strided_slice"(%23) <{offsets = [0, 0], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<16x8xf32>
    %28 = "nvgpu.mma.sync"(%6, %24, %26) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf32>) -> vector<2x2xf32>
    %29 = "vector.extract"(%28) <{static_position = array<i64: 0>}> : (vector<2x2xf32>) -> vector<2xf32>
    "vector.store"(%29, %arg2, %11, %12) <{nontemporal = false}> : (vector<2xf32>, memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    %30 = "vector.extract"(%28) <{static_position = array<i64: 1>}> : (vector<2x2xf32>) -> vector<2xf32>
    "vector.store"(%30, %arg2, %15, %12) <{nontemporal = false}> : (vector<2xf32>, memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    %31 = "vector.extract_strided_slice"(%8) <{offsets = [2, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf16>) -> vector<2x2xf16>
    %32 = "vector.extract_strided_slice"(%9) <{offsets = [8, 0], sizes = [8, 16], strides = [1, 1]}> : (vector<16x16xf16>) -> vector<8x16xf16>
    %33 = "vector.extract_strided_slice"(%22) <{offsets = [2, 0], sizes = [2, 2], strides = [1, 1]}> : (vector<4x2xf32>) -> vector<2x2xf32>
    %34 = "vector.extract_strided_slice"(%23) <{offsets = [0, 8], sizes = [16, 8], strides = [1, 1]}> : (vector<16x16xf32>) -> vector<16x8xf32>
    %35 = "nvgpu.mma.sync"(%6, %31, %33) <{mmaShape = [16, 8, 16]}> : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf32>) -> vector<2x2xf32>
    %36 = "vector.extract"(%35) <{static_position = array<i64: 0>}> : (vector<2x2xf32>) -> vector<2xf32>
    "vector.store"(%36, %arg2, %11, %12) <{nontemporal = false}> : (vector<2xf32>, memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    %37 = "vector.extract"(%35) <{static_position = array<i64: 1>}> : (vector<2x2xf32>) -> vector<2xf32>
    "vector.store"(%37, %arg2, %15, %12) <{nontemporal = false}> : (vector<2xf32>, memref<42x64xf32, #gpu.address_space<workgroup>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

