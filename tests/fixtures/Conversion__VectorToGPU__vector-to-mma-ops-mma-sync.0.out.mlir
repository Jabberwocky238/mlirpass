#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
#map2 = affine_map<()[s0] -> (s0 floordiv 4 + 40)>
#map3 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 39)>
#map4 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 40)>
#map5 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 41)>
#map6 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 42)>
#map7 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 55)>
#map8 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 56)>
#map9 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 57)>
#map10 = affine_map<()[s0] -> (s0 * 4 - (s0 floordiv 4) * 16 + 58)>
#map11 = affine_map<(d0, d1) -> (d1, d0)>
#map12 = affine_map<()[s0] -> (s0 floordiv 4 + 49)>
#map13 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 40)>
#map14 = affine_map<()[s0] -> (s0 floordiv 4 + 57)>
#map15 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map16 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map17 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @m16n8k32_int8_row_row_row(%arg0: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>) {
    %c0 = arith.constant 0 : index
    %c39 = arith.constant 39 : index
    %c40 = arith.constant 40 : index
    %c49 = arith.constant 49 : index
    %c0_i8 = arith.constant 0 : i8
    %c0_i32 = arith.constant 0 : i32
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<128x128xi8, #gpu.address_space<workgroup>> -> vector<4x4xi8>
    %4 = vector.transfer_read %arg0[%c0, %c0], %c0_i8 {in_bounds = [true, true]} : memref<128x128xi8, #gpu.address_space<workgroup>>, vector<16x32xi8>
    %5 = gpu.lane_id
    %c0_i8_0 = arith.constant 0 : i8
    %6 = vector.broadcast %c0_i8_0 : i8 to vector<2x4xi8>
    %c0_1 = arith.constant 0 : index
    %7 = affine.apply #map2()[%5]
    %8 = affine.apply #map3()[%5]
    %9 = memref.load %arg1[%8, %7] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %10 = vector.insert %9, %6 [0, 0] : i8 into vector<2x4xi8>
    %c1 = arith.constant 1 : index
    %11 = affine.apply #map2()[%5]
    %12 = affine.apply #map4()[%5]
    %13 = memref.load %arg1[%12, %11] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %14 = vector.insert %13, %10 [0, 1] : i8 into vector<2x4xi8>
    %c2 = arith.constant 2 : index
    %15 = affine.apply #map2()[%5]
    %16 = affine.apply #map5()[%5]
    %17 = memref.load %arg1[%16, %15] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %18 = vector.insert %17, %14 [0, 2] : i8 into vector<2x4xi8>
    %c3 = arith.constant 3 : index
    %19 = affine.apply #map2()[%5]
    %20 = affine.apply #map6()[%5]
    %21 = memref.load %arg1[%20, %19] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %22 = vector.insert %21, %18 [0, 3] : i8 into vector<2x4xi8>
    %c4 = arith.constant 4 : index
    %23 = affine.apply #map2()[%5]
    %24 = affine.apply #map7()[%5]
    %25 = memref.load %arg1[%24, %23] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %26 = vector.insert %25, %22 [1, 0] : i8 into vector<2x4xi8>
    %c5 = arith.constant 5 : index
    %27 = affine.apply #map2()[%5]
    %28 = affine.apply #map8()[%5]
    %29 = memref.load %arg1[%28, %27] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %30 = vector.insert %29, %26 [1, 1] : i8 into vector<2x4xi8>
    %c6 = arith.constant 6 : index
    %31 = affine.apply #map2()[%5]
    %32 = affine.apply #map9()[%5]
    %33 = memref.load %arg1[%32, %31] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %34 = vector.insert %33, %30 [1, 2] : i8 into vector<2x4xi8>
    %c7 = arith.constant 7 : index
    %35 = affine.apply #map2()[%5]
    %36 = affine.apply #map10()[%5]
    %37 = memref.load %arg1[%36, %35] : memref<128x128xi8, #gpu.address_space<workgroup>>
    %38 = vector.insert %37, %34 [1, 3] : i8 into vector<2x4xi8>
    %39 = vector.transfer_read %arg1[%c39, %c40], %c0_i8 {in_bounds = [true, true], permutation_map = #map11} : memref<128x128xi8, #gpu.address_space<workgroup>>, vector<8x32xi8>
    %40 = gpu.lane_id
    %c0_i32_2 = arith.constant 0 : i32
    %41 = vector.broadcast %c0_i32_2 : i32 to vector<2x2xi32>
    %c0_3 = arith.constant 0 : index
    %42 = affine.apply #map12()[%40]
    %43 = affine.apply #map13()[%40]
    %44 = vector.load %arg2[%42, %43] : memref<128x128xi32>, vector<2xi32>
    %45 = vector.insert %44, %41 [0] : vector<2xi32> into vector<2x2xi32>
    %c2_4 = arith.constant 2 : index
    %46 = affine.apply #map14()[%40]
    %47 = affine.apply #map13()[%40]
    %48 = vector.load %arg2[%46, %47] : memref<128x128xi32>, vector<2xi32>
    %49 = vector.insert %48, %45 [1] : vector<2xi32> into vector<2x2xi32>
    %50 = vector.transfer_read %arg2[%c49, %c40], %c0_i32 {in_bounds = [true, true]} : memref<128x128xi32>, vector<16x8xi32>
    %51 = nvgpu.mma.sync(%3, %38, %49) {mmaShape = [16, 8, 32]} : (vector<4x4xi8>, vector<2x4xi8>, vector<2x2xi32>) -> vector<2x2xi32>
    %52 = vector.contract {indexing_maps = [#map15, #map16, #map17], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %39, %50 : vector<16x32xi8>, vector<8x32xi8> into vector<16x8xi32>
    %53 = gpu.lane_id
    %c0_5 = arith.constant 0 : index
    %54 = vector.extract %51[0] : vector<2xi32> from vector<2x2xi32>
    %55 = affine.apply #map12()[%53]
    %56 = affine.apply #map13()[%53]
    vector.store %54, %arg2[%55, %56] : memref<128x128xi32>, vector<2xi32>
    %c2_6 = arith.constant 2 : index
    %57 = vector.extract %51[1] : vector<2xi32> from vector<2x2xi32>
    %58 = affine.apply #map14()[%53]
    %59 = affine.apply #map13()[%53]
    vector.store %57, %arg2[%58, %59] : memref<128x128xi32>, vector<2xi32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 floordiv 4 + 1)>
#map1 = affine_map<()[s0] -> (s0 mod 4 + 1)>
#map2 = affine_map<()[s0] -> (s0 floordiv 4 + 40)>
#map3 = affine_map<()[s0] -> (s0 mod 4 + 39)>
#map4 = affine_map<(d0, d1) -> (d1, d0)>
#map5 = affine_map<()[s0] -> (s0 floordiv 4 + 49)>
#map6 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 40)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @m8n8k4_f64_row_row_row(%arg0: memref<128x128xf64>, %arg1: memref<128x128xf64>, %arg2: memref<128x128xf64>) {
    %c1 = arith.constant 1 : index
    %c39 = arith.constant 39 : index
    %c40 = arith.constant 40 : index
    %c49 = arith.constant 49 : index
    %cst = arith.constant 0.000000e+00 : f64
    %0 = gpu.lane_id
    %cst_0 = arith.constant 0.000000e+00 : f64
    %1 = vector.broadcast %cst_0 : f64 to vector<1x1xf64>
    %c0 = arith.constant 0 : index
    %2 = affine.apply #map()[%0]
    %3 = affine.apply #map1()[%0]
    %4 = vector.load %arg0[%2, %3] : memref<128x128xf64>, vector<1xf64>
    %5 = vector.insert %4, %1 [0] : vector<1xf64> into vector<1x1xf64>
    %6 = vector.transfer_read %arg0[%c1, %c1], %cst {in_bounds = [true, true]} : memref<128x128xf64>, vector<8x4xf64>
    %7 = gpu.lane_id
    %cst_1 = arith.constant 0.000000e+00 : f64
    %8 = vector.broadcast %cst_1 : f64 to vector<1x1xf64>
    %c0_2 = arith.constant 0 : index
    %9 = affine.apply #map2()[%7]
    %10 = affine.apply #map3()[%7]
    %11 = memref.load %arg1[%10, %9] : memref<128x128xf64>
    %12 = vector.insert %11, %8 [0, 0] : f64 into vector<1x1xf64>
    %13 = vector.transfer_read %arg1[%c39, %c40], %cst {in_bounds = [true, true], permutation_map = #map4} : memref<128x128xf64>, vector<8x4xf64>
    %14 = gpu.lane_id
    %cst_3 = arith.constant 0.000000e+00 : f64
    %15 = vector.broadcast %cst_3 : f64 to vector<1x2xf64>
    %c0_4 = arith.constant 0 : index
    %16 = affine.apply #map5()[%14]
    %17 = affine.apply #map6()[%14]
    %18 = vector.load %arg2[%16, %17] : memref<128x128xf64>, vector<2xf64>
    %19 = vector.insert %18, %15 [0] : vector<2xf64> into vector<1x2xf64>
    %20 = vector.transfer_read %arg2[%c49, %c40], %cst {in_bounds = [true, true]} : memref<128x128xf64>, vector<8x8xf64>
    %21 = nvgpu.mma.sync(%5, %12, %19) {mmaShape = [8, 8, 4]} : (vector<1x1xf64>, vector<1x1xf64>, vector<1x2xf64>) -> vector<1x2xf64>
    %22 = vector.contract {indexing_maps = [#map7, #map8, #map9], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %6, %13, %20 : vector<8x4xf64>, vector<8x4xf64> into vector<8x8xf64>
    %23 = gpu.lane_id
    %c0_5 = arith.constant 0 : index
    %24 = vector.extract %21[0] : vector<2xf64> from vector<1x2xf64>
    %25 = affine.apply #map5()[%23]
    %26 = affine.apply #map6()[%23]
    vector.store %24, %arg2[%25, %26] : memref<128x128xf64>, vector<2xf64>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d1, d0)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @m16n8k16_fp16_row_row_row(%arg0: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<20x20xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = gpu.lane_id
    %6 = affine.apply #map1()[%5]
    %7 = affine.apply #map()[%5]
    %8 = nvgpu.ldmatrix %arg1[%7, %6] {numTiles = 2 : i32, transpose = true} : memref<20x20xf16, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %9 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map2} : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<8x16xf16>
    %10 = gpu.lane_id
    %11 = affine.apply #map()[%10]
    %12 = affine.apply #map1()[%10]
    %13 = nvgpu.ldmatrix %arg2[%11, %12] {numTiles = 2 : i32, transpose = false} : memref<20x20xf16, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %14 = vector.transfer_read %arg2[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<16x8xf16>
    %15 = nvgpu.mma.sync(%3, %8, %13) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %16 = vector.contract {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %9, %14 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %17 = gpu.lane_id
    %c0_0 = arith.constant 0 : index
    %18 = vector.extract %15[0] : vector<2xf16> from vector<2x2xf16>
    %19 = affine.apply #map6()[%17]
    %20 = affine.apply #map7()[%17]
    vector.store %18, %arg2[%19, %20] : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2 = arith.constant 2 : index
    %21 = vector.extract %15[1] : vector<2xf16> from vector<2x2xf16>
    %22 = affine.apply #map8()[%17]
    %23 = affine.apply #map7()[%17]
    vector.store %21, %arg2[%22, %23] : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d1, d0)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @m16n16k16_mmasync16816_fp16_f16_row_row_row(%arg0: memref<42x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<32x64xf16, #gpu.address_space<workgroup>>, %arg2: memref<42x64xf16, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<42x32xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<42x32xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = gpu.lane_id
    %6 = affine.apply #map1()[%5]
    %7 = affine.apply #map()[%5]
    %8 = nvgpu.ldmatrix %arg1[%7, %6] {numTiles = 4 : i32, transpose = true} : memref<32x64xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %9 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map2} : memref<32x64xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %10 = gpu.lane_id
    %11 = affine.apply #map()[%10]
    %12 = affine.apply #map1()[%10]
    %13 = nvgpu.ldmatrix %arg2[%11, %12] {numTiles = 4 : i32, transpose = false} : memref<42x64xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %14 = vector.transfer_read %arg2[%c0, %c0], %cst {in_bounds = [true, true]} : memref<42x64xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %15 = vector.extract_strided_slice %8 {offsets = [0, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %16 = vector.extract_strided_slice %9 {offsets = [0, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf16> to vector<8x16xf16>
    %17 = vector.extract_strided_slice %13 {offsets = [0, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %18 = vector.extract_strided_slice %14 {offsets = [0, 0], sizes = [16, 8], strides = [1, 1]} : vector<16x16xf16> to vector<16x8xf16>
    %19 = nvgpu.mma.sync(%3, %15, %17) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %20 = vector.contract {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %16, %18 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %21 = gpu.lane_id
    %c0_0 = arith.constant 0 : index
    %22 = vector.extract %19[0] : vector<2xf16> from vector<2x2xf16>
    %23 = affine.apply #map6()[%21]
    %24 = affine.apply #map7()[%21]
    vector.store %22, %arg2[%23, %24] : memref<42x64xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2 = arith.constant 2 : index
    %25 = vector.extract %19[1] : vector<2xf16> from vector<2x2xf16>
    %26 = affine.apply #map8()[%21]
    %27 = affine.apply #map7()[%21]
    vector.store %25, %arg2[%26, %27] : memref<42x64xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %28 = vector.extract_strided_slice %8 {offsets = [2, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %29 = vector.extract_strided_slice %9 {offsets = [8, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf16> to vector<8x16xf16>
    %30 = vector.extract_strided_slice %13 {offsets = [2, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %31 = vector.extract_strided_slice %14 {offsets = [0, 8], sizes = [16, 8], strides = [1, 1]} : vector<16x16xf16> to vector<16x8xf16>
    %32 = nvgpu.mma.sync(%3, %28, %30) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %33 = vector.contract {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %29, %31 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %34 = gpu.lane_id
    %c0_1 = arith.constant 0 : index
    %35 = vector.extract %32[0] : vector<2xf16> from vector<2x2xf16>
    %36 = affine.apply #map6()[%34]
    %37 = affine.apply #map7()[%34]
    vector.store %35, %arg2[%36, %37] : memref<42x64xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2_2 = arith.constant 2 : index
    %38 = vector.extract %32[1] : vector<2xf16> from vector<2x2xf16>
    %39 = affine.apply #map8()[%34]
    %40 = affine.apply #map7()[%34]
    vector.store %38, %arg2[%39, %40] : memref<42x64xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d3, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4)>
#map8 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @multi_dim_m16n8k16_fp16_row_row_row(%arg0: memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, %arg2: memref<1x32x40xf16, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%c0, %1, %c0, %2] {numTiles = 4 : i32, transpose = false} : memref<4x32x1x32xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map2} : memref<4x32x1x32xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = gpu.lane_id
    %6 = affine.apply #map1()[%5]
    %7 = affine.apply #map()[%5]
    %8 = nvgpu.ldmatrix %arg1[%c0, %c0, %7, %6] {numTiles = 4 : i32, transpose = true} : memref<4x1x32x32xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %9 = vector.transfer_read %arg1[%c0, %c0, %c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map3} : memref<4x1x32x32xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %10 = gpu.lane_id
    %11 = affine.apply #map()[%10]
    %12 = affine.apply #map1()[%10]
    %13 = nvgpu.ldmatrix %arg2[%c0, %11, %12] {numTiles = 4 : i32, transpose = false} : memref<1x32x40xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %14 = vector.transfer_read %arg2[%c0, %c0, %c0], %cst {in_bounds = [true, true]} : memref<1x32x40xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %15 = vector.extract_strided_slice %8 {offsets = [0, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %16 = vector.extract_strided_slice %9 {offsets = [0, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf16> to vector<8x16xf16>
    %17 = vector.extract_strided_slice %13 {offsets = [0, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %18 = vector.extract_strided_slice %14 {offsets = [0, 0], sizes = [16, 8], strides = [1, 1]} : vector<16x16xf16> to vector<16x8xf16>
    %19 = nvgpu.mma.sync(%3, %15, %17) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %20 = vector.contract {indexing_maps = [#map4, #map5, #map6], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %16, %18 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %21 = gpu.lane_id
    %c0_0 = arith.constant 0 : index
    %22 = vector.extract %19[0] : vector<2xf16> from vector<2x2xf16>
    %23 = affine.apply #map7()[%21]
    %24 = affine.apply #map8()[%21]
    vector.store %22, %arg2[%c0, %23, %24] : memref<1x32x40xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2 = arith.constant 2 : index
    %25 = vector.extract %19[1] : vector<2xf16> from vector<2x2xf16>
    %26 = affine.apply #map9()[%21]
    %27 = affine.apply #map8()[%21]
    vector.store %25, %arg2[%c0, %26, %27] : memref<1x32x40xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @batch_m16n8k16_fp16_row_row_row(%arg0: memref<2x20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<2x20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<2x20x20xf16, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%c0, %1, %2] {numTiles = 4 : i32, transpose = false} : memref<2x20x20xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0, %c0], %cst {in_bounds = [true, true]} : memref<2x20x20xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = gpu.lane_id
    %6 = affine.apply #map1()[%5]
    %7 = affine.apply #map()[%5]
    %8 = nvgpu.ldmatrix %arg1[%c0, %7, %6] {numTiles = 2 : i32, transpose = true} : memref<2x20x20xf16, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %9 = vector.transfer_read %arg1[%c0, %c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map2} : memref<2x20x20xf16, #gpu.address_space<workgroup>>, vector<8x16xf16>
    %10 = gpu.lane_id
    %11 = affine.apply #map()[%10]
    %12 = affine.apply #map1()[%10]
    %13 = nvgpu.ldmatrix %arg2[%c0, %11, %12] {numTiles = 2 : i32, transpose = false} : memref<2x20x20xf16, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %14 = vector.transfer_read %arg2[%c0, %c0, %c0], %cst {in_bounds = [true, true]} : memref<2x20x20xf16, #gpu.address_space<workgroup>>, vector<16x8xf16>
    %15 = nvgpu.mma.sync(%3, %8, %13) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %16 = vector.contract {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %9, %14 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %17 = gpu.lane_id
    %c0_0 = arith.constant 0 : index
    %18 = vector.extract %15[0] : vector<2xf16> from vector<2x2xf16>
    %19 = affine.apply #map6()[%17]
    %20 = affine.apply #map7()[%17]
    vector.store %18, %arg2[%c0, %19, %20] : memref<2x20x20xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2 = arith.constant 2 : index
    %21 = vector.extract %15[1] : vector<2xf16> from vector<2x2xf16>
    %22 = affine.apply #map8()[%17]
    %23 = affine.apply #map7()[%17]
    vector.store %21, %arg2[%c0, %22, %23] : memref<2x20x20xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<()[s0] -> (s0 mod 8)>
#map3 = affine_map<()[s0] -> ((s0 floordiv 8) * 8)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map7 = affine_map<()[s0] -> (s0 floordiv 4)>
#map8 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @m16n8k16_fp16_row_col_row(%arg0: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<20x20xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = gpu.lane_id
    %6 = affine.apply #map2()[%5]
    %7 = affine.apply #map3()[%5]
    %8 = nvgpu.ldmatrix %arg1[%6, %7] {numTiles = 2 : i32, transpose = false} : memref<20x20xf16, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %9 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<8x16xf16>
    %10 = gpu.lane_id
    %11 = affine.apply #map()[%10]
    %12 = affine.apply #map1()[%10]
    %13 = nvgpu.ldmatrix %arg2[%11, %12] {numTiles = 2 : i32, transpose = false} : memref<20x20xf16, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %14 = vector.transfer_read %arg2[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<16x8xf16>
    %15 = nvgpu.mma.sync(%3, %8, %13) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %16 = vector.contract {indexing_maps = [#map4, #map5, #map6], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %9, %14 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %17 = gpu.lane_id
    %c0_0 = arith.constant 0 : index
    %18 = vector.extract %15[0] : vector<2xf16> from vector<2x2xf16>
    %19 = affine.apply #map7()[%17]
    %20 = affine.apply #map8()[%17]
    vector.store %18, %arg2[%19, %20] : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2 = arith.constant 2 : index
    %21 = vector.extract %15[1] : vector<2xf16> from vector<2x2xf16>
    %22 = affine.apply #map9()[%17]
    %23 = affine.apply #map8()[%17]
    vector.store %21, %arg2[%22, %23] : memref<20x20xf16, #gpu.address_space<workgroup>>, vector<2xf16>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16 + 1)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 4 + 3)>
#map2 = affine_map<()[s0] -> (s0 floordiv 4 + 3)>
#map3 = affine_map<()[s0] -> (s0 mod 4 + 3)>
#map4 = affine_map<(d0, d1) -> (d1, d0)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map6 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4)>
#map9 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map10 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @m16n8k4_tf32_f32_row_row_row(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<16x8xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %cst_1 = arith.constant 0.000000e+00 : f32
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 2 : i32, transpose = false} : memref<20x20xf32, #gpu.address_space<workgroup>> -> vector<2x1xf32>
    %4 = vector.transfer_read %arg0[%c1, %c3], %cst_1 {in_bounds = [true, true]} : memref<20x20xf32, #gpu.address_space<workgroup>>, vector<16x4xf32>
    %5 = gpu.lane_id
    %cst_2 = arith.constant 0.000000e+00 : f32
    %6 = vector.broadcast %cst_2 : f32 to vector<1x1xf32>
    %c0_3 = arith.constant 0 : index
    %7 = affine.apply #map2()[%5]
    %8 = affine.apply #map3()[%5]
    %9 = memref.load %arg1[%8, %7] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %10 = vector.insert %9, %6 [0, 0] : f32 into vector<1x1xf32>
    %11 = vector.transfer_read %arg1[%c3, %c3], %cst_1 {in_bounds = [true, true], permutation_map = #map4} : memref<20x20xf32, #gpu.address_space<workgroup>>, vector<8x4xf32>
    %12 = nvgpu.mma.sync(%3, %10, %cst) {mmaShape = [16, 8, 4]} : (vector<2x1xf32>, vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %13 = vector.contract {indexing_maps = [#map5, #map6, #map7], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %11, %cst_0 : vector<16x4xf32>, vector<8x4xf32> into vector<16x8xf32>
    %14 = gpu.lane_id
    %c0_4 = arith.constant 0 : index
    %15 = vector.extract %12[0] : vector<2xf32> from vector<2x2xf32>
    %16 = affine.apply #map8()[%14]
    %17 = affine.apply #map9()[%14]
    vector.store %15, %arg2[%16, %17] : memref<20x20xf32>, vector<2xf32>
    %c2 = arith.constant 2 : index
    %18 = vector.extract %12[1] : vector<2xf32> from vector<2x2xf32>
    %19 = affine.apply #map10()[%14]
    %20 = affine.apply #map9()[%14]
    vector.store %18, %arg2[%19, %20] : memref<20x20xf32>, vector<2xf32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16 + 1)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 4 + 3)>
#map2 = affine_map<()[s0] -> (s0 floordiv 4 + 3)>
#map3 = affine_map<()[s0] -> (s0 mod 4 + 3)>
#map4 = affine_map<()[s0] -> (s0 mod 4 + 7)>
#map5 = affine_map<(d0, d1) -> (d1, d0)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map7 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map9 = affine_map<()[s0] -> (s0 floordiv 4)>
#map10 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map11 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @m16n8k8_tf32_f32_row_row_row(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<16x8xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    %cst_1 = arith.constant 0.000000e+00 : f32
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<20x20xf32, #gpu.address_space<workgroup>> -> vector<4x1xf32>
    %4 = vector.transfer_read %arg0[%c1, %c3], %cst_1 {in_bounds = [true, true]} : memref<20x20xf32, #gpu.address_space<workgroup>>, vector<16x8xf32>
    %5 = gpu.lane_id
    %cst_2 = arith.constant 0.000000e+00 : f32
    %6 = vector.broadcast %cst_2 : f32 to vector<2x1xf32>
    %c0_3 = arith.constant 0 : index
    %7 = affine.apply #map2()[%5]
    %8 = affine.apply #map3()[%5]
    %9 = memref.load %arg1[%8, %7] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %10 = vector.insert %9, %6 [0, 0] : f32 into vector<2x1xf32>
    %c1_4 = arith.constant 1 : index
    %11 = affine.apply #map2()[%5]
    %12 = affine.apply #map4()[%5]
    %13 = memref.load %arg1[%12, %11] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %14 = vector.insert %13, %10 [1, 0] : f32 into vector<2x1xf32>
    %15 = vector.transfer_read %arg1[%c3, %c3], %cst_1 {in_bounds = [true, true], permutation_map = #map5} : memref<20x20xf32, #gpu.address_space<workgroup>>, vector<8x8xf32>
    %16 = nvgpu.mma.sync(%3, %14, %cst) {mmaShape = [16, 8, 8]} : (vector<4x1xf32>, vector<2x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %17 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %15, %cst_0 : vector<16x8xf32>, vector<8x8xf32> into vector<16x8xf32>
    %18 = gpu.lane_id
    %c0_5 = arith.constant 0 : index
    %19 = vector.extract %16[0] : vector<2xf32> from vector<2x2xf32>
    %20 = affine.apply #map9()[%18]
    %21 = affine.apply #map10()[%18]
    vector.store %19, %arg2[%20, %21] : memref<20x20xf32>, vector<2xf32>
    %c2 = arith.constant 2 : index
    %22 = vector.extract %16[1] : vector<2xf32> from vector<2x2xf32>
    %23 = affine.apply #map11()[%18]
    %24 = affine.apply #map10()[%18]
    vector.store %22, %arg2[%23, %24] : memref<20x20xf32>, vector<2xf32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 floordiv 4)>
#map1 = affine_map<()[s0] -> (s0 mod 4)>
#map2 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map3 = affine_map<()[s0] -> (s0 mod 4 + 4)>
#map4 = affine_map<(d0, d1) -> (d1, d0)>
#map5 = affine_map<()[s0] -> (s0 mod 8)>
#map6 = affine_map<()[s0] -> ((s0 floordiv 8) * 4)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map10 = affine_map<()[s0] -> (s0 floordiv 4 + 16)>
#map11 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 8)>
#map12 = affine_map<()[s0] -> (s0 floordiv 4 + 24)>
module {
  func.func @m16n8k8_tf32_f32_col_col_row(%arg0: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf32, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<16x8xf32>
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c8 = arith.constant 8 : index
    %cst_1 = arith.constant 0.000000e+00 : f32
    %0 = gpu.lane_id
    %cst_2 = arith.constant 0.000000e+00 : f32
    %1 = vector.broadcast %cst_2 : f32 to vector<4x1xf32>
    %c0_3 = arith.constant 0 : index
    %2 = affine.apply #map()[%0]
    %3 = affine.apply #map1()[%0]
    %4 = memref.load %arg0[%3, %2] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %5 = vector.insert %4, %1 [0, 0] : f32 into vector<4x1xf32>
    %c1 = arith.constant 1 : index
    %6 = affine.apply #map2()[%0]
    %7 = affine.apply #map1()[%0]
    %8 = memref.load %arg0[%7, %6] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %9 = vector.insert %8, %5 [1, 0] : f32 into vector<4x1xf32>
    %c2 = arith.constant 2 : index
    %10 = affine.apply #map()[%0]
    %11 = affine.apply #map3()[%0]
    %12 = memref.load %arg0[%11, %10] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %13 = vector.insert %12, %9 [2, 0] : f32 into vector<4x1xf32>
    %c3 = arith.constant 3 : index
    %14 = affine.apply #map2()[%0]
    %15 = affine.apply #map3()[%0]
    %16 = memref.load %arg0[%15, %14] : memref<20x20xf32, #gpu.address_space<workgroup>>
    %17 = vector.insert %16, %13 [3, 0] : f32 into vector<4x1xf32>
    %18 = vector.transfer_read %arg0[%c0, %c0], %cst_1 {in_bounds = [true, true], permutation_map = #map4} : memref<20x20xf32, #gpu.address_space<workgroup>>, vector<16x8xf32>
    %19 = gpu.lane_id
    %20 = affine.apply #map5()[%19]
    %21 = affine.apply #map6()[%19]
    %22 = nvgpu.ldmatrix %arg1[%20, %21] {numTiles = 2 : i32, transpose = false} : memref<20x20xf32, #gpu.address_space<workgroup>> -> vector<2x1xf32>
    %23 = vector.transfer_read %arg1[%c0, %c0], %cst_1 {in_bounds = [true, true]} : memref<20x20xf32, #gpu.address_space<workgroup>>, vector<8x8xf32>
    %24 = nvgpu.mma.sync(%17, %22, %cst) {mmaShape = [16, 8, 8]} : (vector<4x1xf32>, vector<2x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %25 = vector.contract {indexing_maps = [#map7, #map8, #map9], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %18, %23, %cst_0 : vector<16x8xf32>, vector<8x8xf32> into vector<16x8xf32>
    %26 = gpu.lane_id
    %c0_4 = arith.constant 0 : index
    %27 = vector.extract %24[0] : vector<2xf32> from vector<2x2xf32>
    %28 = affine.apply #map10()[%26]
    %29 = affine.apply #map11()[%26]
    vector.store %27, %arg2[%28, %29] : memref<20x20xf32>, vector<2xf32>
    %c2_5 = arith.constant 2 : index
    %30 = vector.extract %24[1] : vector<2xf32> from vector<2x2xf32>
    %31 = affine.apply #map12()[%26]
    %32 = affine.apply #map11()[%26]
    vector.store %30, %arg2[%31, %32] : memref<20x20xf32>, vector<2xf32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 32)>
#map2 = affine_map<()[s0] -> (s0 mod 8)>
#map3 = affine_map<()[s0] -> ((s0 floordiv 8) * 32)>
#map4 = affine_map<()[s0] -> (s0 floordiv 4)>
#map5 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @m16n8k64_int4_row_col_row(%arg0: memref<128x128xi4, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi4, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>) {
    %c0_i4 = arith.constant 0 : i4
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<128x128xi4, #gpu.address_space<workgroup>> -> vector<4x8xi4>
    %4 = vector.transfer_read %arg0[%c0, %c0], %c0_i4 {in_bounds = [true, true]} : memref<128x128xi4, #gpu.address_space<workgroup>>, vector<16x64xi4>
    %5 = gpu.lane_id
    %6 = affine.apply #map2()[%5]
    %7 = affine.apply #map3()[%5]
    %8 = nvgpu.ldmatrix %arg1[%6, %7] {numTiles = 2 : i32, transpose = false} : memref<128x128xi4, #gpu.address_space<workgroup>> -> vector<2x8xi4>
    %9 = vector.transfer_read %arg1[%c0, %c0], %c0_i4 {in_bounds = [true, true]} : memref<128x128xi4, #gpu.address_space<workgroup>>, vector<8x64xi4>
    %10 = gpu.lane_id
    %c0_i32_0 = arith.constant 0 : i32
    %11 = vector.broadcast %c0_i32_0 : i32 to vector<2x2xi32>
    %c0_1 = arith.constant 0 : index
    %12 = affine.apply #map4()[%10]
    %13 = affine.apply #map5()[%10]
    %14 = vector.load %arg2[%12, %13] : memref<128x128xi32>, vector<2xi32>
    %15 = vector.insert %14, %11 [0] : vector<2xi32> into vector<2x2xi32>
    %c2 = arith.constant 2 : index
    %16 = affine.apply #map6()[%10]
    %17 = affine.apply #map5()[%10]
    %18 = vector.load %arg2[%16, %17] : memref<128x128xi32>, vector<2xi32>
    %19 = vector.insert %18, %15 [1] : vector<2xi32> into vector<2x2xi32>
    %20 = vector.transfer_read %arg2[%c0, %c0], %c0_i32 {in_bounds = [true, true]} : memref<128x128xi32>, vector<16x8xi32>
    %21 = nvgpu.mma.sync(%3, %8, %19) {mmaShape = [16, 8, 64]} : (vector<4x8xi4>, vector<2x8xi4>, vector<2x2xi32>) -> vector<2x2xi32>
    %22 = vector.contract {indexing_maps = [#map7, #map8, #map9], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %9, %20 : vector<16x64xi4>, vector<8x64xi4> into vector<16x8xi32>
    %23 = gpu.lane_id
    %c0_2 = arith.constant 0 : index
    %24 = vector.extract %21[0] : vector<2xi32> from vector<2x2xi32>
    %25 = affine.apply #map4()[%23]
    %26 = affine.apply #map5()[%23]
    vector.store %24, %arg2[%25, %26] : memref<128x128xi32>, vector<2xi32>
    %c2_3 = arith.constant 2 : index
    %27 = vector.extract %21[1] : vector<2xi32> from vector<2x2xi32>
    %28 = affine.apply #map6()[%23]
    %29 = affine.apply #map5()[%23]
    vector.store %27, %arg2[%28, %29] : memref<128x128xi32>, vector<2xi32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
#map2 = affine_map<()[s0] -> (s0 mod 8)>
#map3 = affine_map<()[s0] -> ((s0 floordiv 8) * 16)>
#map4 = affine_map<()[s0] -> (s0 floordiv 4)>
#map5 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map8 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @m16n8k32_int8_row_col_row(%arg0: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg1: memref<128x128xi8, #gpu.address_space<workgroup>>, %arg2: memref<128x128xi32>) {
    %c0 = arith.constant 0 : index
    %c0_i8 = arith.constant 0 : i8
    %c0_i32 = arith.constant 0 : i32
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<128x128xi8, #gpu.address_space<workgroup>> -> vector<4x4xi8>
    %4 = vector.transfer_read %arg0[%c0, %c0], %c0_i8 {in_bounds = [true, true]} : memref<128x128xi8, #gpu.address_space<workgroup>>, vector<16x32xi8>
    %5 = gpu.lane_id
    %6 = affine.apply #map2()[%5]
    %7 = affine.apply #map3()[%5]
    %8 = nvgpu.ldmatrix %arg1[%6, %7] {numTiles = 2 : i32, transpose = false} : memref<128x128xi8, #gpu.address_space<workgroup>> -> vector<2x4xi8>
    %9 = vector.transfer_read %arg1[%c0, %c0], %c0_i8 {in_bounds = [true, true]} : memref<128x128xi8, #gpu.address_space<workgroup>>, vector<8x32xi8>
    %10 = gpu.lane_id
    %c0_i32_0 = arith.constant 0 : i32
    %11 = vector.broadcast %c0_i32_0 : i32 to vector<2x2xi32>
    %c0_1 = arith.constant 0 : index
    %12 = affine.apply #map4()[%10]
    %13 = affine.apply #map5()[%10]
    %14 = vector.load %arg2[%12, %13] : memref<128x128xi32>, vector<2xi32>
    %15 = vector.insert %14, %11 [0] : vector<2xi32> into vector<2x2xi32>
    %c2 = arith.constant 2 : index
    %16 = affine.apply #map6()[%10]
    %17 = affine.apply #map5()[%10]
    %18 = vector.load %arg2[%16, %17] : memref<128x128xi32>, vector<2xi32>
    %19 = vector.insert %18, %15 [1] : vector<2xi32> into vector<2x2xi32>
    %20 = vector.transfer_read %arg2[%c0, %c0], %c0_i32 {in_bounds = [true, true]} : memref<128x128xi32>, vector<16x8xi32>
    %21 = nvgpu.mma.sync(%3, %8, %19) {mmaShape = [16, 8, 32]} : (vector<4x4xi8>, vector<2x4xi8>, vector<2x2xi32>) -> vector<2x2xi32>
    %22 = vector.contract {indexing_maps = [#map7, #map8, #map9], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %9, %20 : vector<16x32xi8>, vector<8x32xi8> into vector<16x8xi32>
    %23 = gpu.lane_id
    %c0_2 = arith.constant 0 : index
    %24 = vector.extract %21[0] : vector<2xi32> from vector<2x2xi32>
    %25 = affine.apply #map4()[%23]
    %26 = affine.apply #map5()[%23]
    vector.store %24, %arg2[%25, %26] : memref<128x128xi32>, vector<2xi32>
    %c2_3 = arith.constant 2 : index
    %27 = vector.extract %21[1] : vector<2xi32> from vector<2x2xi32>
    %28 = affine.apply #map6()[%23]
    %29 = affine.apply #map5()[%23]
    vector.store %27, %arg2[%28, %29] : memref<128x128xi32>, vector<2xi32>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d1, d0)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<()[s0] -> (s0 floordiv 4)>
#map7 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map8 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
module {
  func.func @strided_memref_read_write(%arg0: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = gpu.lane_id
    %6 = affine.apply #map1()[%5]
    %7 = affine.apply #map()[%5]
    %8 = nvgpu.ldmatrix %arg1[%7, %6] {numTiles = 2 : i32, transpose = true} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %9 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map2} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<8x16xf16>
    %10 = gpu.lane_id
    %11 = affine.apply #map()[%10]
    %12 = affine.apply #map1()[%10]
    %13 = nvgpu.ldmatrix %arg2[%11, %12] {numTiles = 2 : i32, transpose = false} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>> -> vector<2x2xf16>
    %14 = vector.transfer_read %arg2[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<16x8xf16>
    %15 = nvgpu.mma.sync(%3, %8, %13) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %16 = vector.contract {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %9, %14 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    %17 = gpu.lane_id
    %c0_0 = arith.constant 0 : index
    %18 = vector.extract %15[0] : vector<2xf16> from vector<2x2xf16>
    %19 = affine.apply #map6()[%17]
    %20 = affine.apply #map7()[%17]
    vector.store %18, %arg2[%19, %20] : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<2xf16>
    %c2 = arith.constant 2 : index
    %21 = vector.extract %15[1] : vector<2xf16> from vector<2x2xf16>
    %22 = affine.apply #map8()[%17]
    %23 = affine.apply #map7()[%17]
    vector.store %21, %arg2[%22, %23] : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<2xf16>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d0, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
module {
  func.func @unsupported_non_2d_load_store(%arg0: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = vector.transfer_read %arg0[%c0, %c0, %c0], %cst {in_bounds = [true, true, true]} : memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<1x16x16xf16>
    %1 = vector.transfer_read %arg1[%c0, %c0, %c0], %cst {in_bounds = [true, true, true]} : memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<8x1x16xf16>
    %2 = vector.transfer_read %arg2[%c0, %c0, %c0], %cst {in_bounds = [true, true, true]} : memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<1x16x8xf16>
    %3 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %2 : vector<1x16x16xf16>, vector<8x1x16xf16> into vector<1x16x8xf16>
    vector.transfer_write %3, %arg2[%c0, %c0, %c0] {in_bounds = [true, true, true]} : vector<1x16x8xf16>, memref<20x20x20xf16, strided<[?, ?, 1], offset: ?>, #gpu.address_space<workgroup>>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @unsupported_fully_dynamic_strides(%arg0: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %1 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map} : memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, vector<8x16xf16>
    %2 = vector.transfer_read %arg2[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>, vector<16x8xf16>
    %3 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %2 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    vector.transfer_write %3, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x8xf16>, memref<20x20xf16, strided<[?, ?], offset: ?>, #gpu.address_space<workgroup>>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @unsupported_transposed_store(%arg0: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg1: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, %arg2: memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %1 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<8x16xf16>
    %2 = vector.transfer_read %arg2[%c0, %c0], %cst {in_bounds = [true, true]} : memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>, vector<16x8xf16>
    %3 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %2 : vector<16x16xf16>, vector<8x16xf16> into vector<16x8xf16>
    vector.transfer_write %3, %arg2[%c0, %c0] {in_bounds = [true, true], permutation_map = #map} : vector<16x8xf16>, memref<20x20xf16, strided<[?, 1], offset: ?>, #gpu.address_space<workgroup>>
    return
  }
}

