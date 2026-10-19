#map = affine_map<()[s0] -> (s0 mod 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 16) * 8)>
#map2 = affine_map<(d0, d1) -> (d1, d0)>
#map3 = affine_map<()[s0] -> (s0 floordiv 4)>
#map4 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8)>
#map5 = affine_map<()[s0] -> (s0 floordiv 4 + 8)>
#map6 = affine_map<()[s0] -> (s0 * 2 - (s0 floordiv 4) * 8 + 8)>
module {
  func.func @m16n8k16_mmasync16816_f16_f16_f32_row_row_row(%arg0: memref<42x32xf16, #gpu.address_space<workgroup>>, %arg1: memref<32x64xf16, #gpu.address_space<workgroup>>, %arg2: memref<42x64xf32, #gpu.address_space<workgroup>>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %cst_0 = arith.constant 0.000000e+00 : f32
    %0 = gpu.lane_id
    %1 = affine.apply #map()[%0]
    %2 = affine.apply #map1()[%0]
    %3 = nvgpu.ldmatrix %arg0[%1, %2] {numTiles = 4 : i32, transpose = false} : memref<42x32xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %4 = vector.transfer_read %arg0[%c0, %c0], %cst {in_bounds = [true, true]} : memref<42x32xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %5 = nvgpu.ldmatrix %arg1[%1, %2] {numTiles = 4 : i32, transpose = true} : memref<32x64xf16, #gpu.address_space<workgroup>> -> vector<4x2xf16>
    %6 = vector.transfer_read %arg1[%c0, %c0], %cst {in_bounds = [true, true], permutation_map = #map2} : memref<32x64xf16, #gpu.address_space<workgroup>>, vector<16x16xf16>
    %7 = vector.broadcast %cst_0 : f32 to vector<4x2xf32>
    %8 = affine.apply #map3()[%0]
    %9 = affine.apply #map4()[%0]
    %10 = vector.load %arg2[%8, %9] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %11 = vector.insert %10, %7 [0] : vector<2xf32> into vector<4x2xf32>
    %12 = affine.apply #map5()[%0]
    %13 = vector.load %arg2[%12, %9] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %14 = vector.insert %13, %11 [1] : vector<2xf32> into vector<4x2xf32>
    %15 = affine.apply #map6()[%0]
    %16 = vector.load %arg2[%8, %15] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %17 = vector.insert %16, %14 [2] : vector<2xf32> into vector<4x2xf32>
    %18 = vector.load %arg2[%12, %15] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %19 = vector.insert %18, %17 [3] : vector<2xf32> into vector<4x2xf32>
    %20 = vector.transfer_read %arg2[%c0, %c0], %cst_0 {in_bounds = [true, true]} : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<16x16xf32>
    %21 = vector.extract_strided_slice %5 {offsets = [0, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %22 = vector.extract_strided_slice %6 {offsets = [0, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf16> to vector<8x16xf16>
    %23 = vector.extract_strided_slice %19 {offsets = [0, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf32> to vector<2x2xf32>
    %24 = vector.extract_strided_slice %20 {offsets = [0, 0], sizes = [16, 8], strides = [1, 1]} : vector<16x16xf32> to vector<16x8xf32>
    %25 = nvgpu.mma.sync(%3, %21, %23) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf32>) -> vector<2x2xf32>
    %26 = vector.extract %25[0] : vector<2xf32> from vector<2x2xf32>
    vector.store %26, %arg2[%8, %9] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %27 = vector.extract %25[1] : vector<2xf32> from vector<2x2xf32>
    vector.store %27, %arg2[%12, %9] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %28 = vector.extract_strided_slice %5 {offsets = [2, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf16> to vector<2x2xf16>
    %29 = vector.extract_strided_slice %6 {offsets = [8, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf16> to vector<8x16xf16>
    %30 = vector.extract_strided_slice %19 {offsets = [2, 0], sizes = [2, 2], strides = [1, 1]} : vector<4x2xf32> to vector<2x2xf32>
    %31 = vector.extract_strided_slice %20 {offsets = [0, 8], sizes = [16, 8], strides = [1, 1]} : vector<16x16xf32> to vector<16x8xf32>
    %32 = nvgpu.mma.sync(%3, %28, %30) {mmaShape = [16, 8, 16]} : (vector<4x2xf16>, vector<2x2xf16>, vector<2x2xf32>) -> vector<2x2xf32>
    %33 = vector.extract %32[0] : vector<2xf32> from vector<2x2xf32>
    vector.store %33, %arg2[%8, %9] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    %34 = vector.extract %32[1] : vector<2xf32> from vector<2x2xf32>
    vector.store %34, %arg2[%12, %9] : memref<42x64xf32, #gpu.address_space<workgroup>>, vector<2xf32>
    return
  }
}

