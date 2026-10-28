module {
  func.func @avx512_mask_rndscale(%arg0: vector<16xf32>, %arg1: vector<8xf64>, %arg2: i32, %arg3: i16, %arg4: i8) -> (vector<16xf32>, vector<8xf64>) {
    %0 = x86vector.avx512.mask.rndscale %arg0, %arg2, %arg0, %arg3, %arg2 : vector<16xf32>
    %1 = x86vector.avx512.mask.rndscale %arg1, %arg2, %arg1, %arg4, %arg2 : vector<8xf64>
    return %0, %1 : vector<16xf32>, vector<8xf64>
  }
  func.func @avx512_scalef(%arg0: vector<16xf32>, %arg1: vector<8xf64>, %arg2: i32, %arg3: i16, %arg4: i8) -> (vector<16xf32>, vector<8xf64>) {
    %0 = x86vector.avx512.mask.scalef %arg0, %arg0, %arg0, %arg3, %arg2 : vector<16xf32>
    %1 = x86vector.avx512.mask.scalef %arg1, %arg1, %arg1, %arg4, %arg2 : vector<8xf64>
    return %0, %1 : vector<16xf32>, vector<8xf64>
  }
  func.func @avx512_vp2intersect(%arg0: vector<16xi32>, %arg1: vector<8xi64>) -> (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>) {
    %k1, %k2 = x86vector.avx512.vp2intersect %arg0, %arg0 : vector<16xi32>
    %k1_0, %k2_1 = x86vector.avx512.vp2intersect %arg1, %arg1 : vector<8xi64>
    return %k1, %k2, %k1_0, %k2_1 : vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>
  }
  func.func @avx512_mask_compress(%arg0: vector<16xi1>, %arg1: vector<16xf32>, %arg2: vector<8xi1>, %arg3: vector<8xi64>) -> (vector<16xf32>, vector<16xf32>, vector<8xi64>) {
    %0 = x86vector.avx512.mask.compress %arg0, %arg1 : vector<16xf32>
    %1 = x86vector.avx512.mask.compress %arg0, %arg1 {constant_src = dense<5.000000e+00> : vector<16xf32>} : vector<16xf32>
    %2 = x86vector.avx512.mask.compress %arg2, %arg3, %arg3 : vector<8xi64>, vector<8xi64>
    return %0, %1, %2 : vector<16xf32>, vector<16xf32>, vector<8xi64>
  }
  func.func @avx512bf16_dot_128(%arg0: vector<4xf32>, %arg1: vector<8xbf16>, %arg2: vector<8xbf16>) -> vector<4xf32> {
    %0 = x86vector.avx512.dot %arg0, %arg1, %arg2 : vector<8xbf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avx512bf16_dot_256(%arg0: vector<8xf32>, %arg1: vector<16xbf16>, %arg2: vector<16xbf16>) -> vector<8xf32> {
    %0 = x86vector.avx512.dot %arg0, %arg1, %arg2 : vector<16xbf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avx512bf16_dot_512(%arg0: vector<16xf32>, %arg1: vector<32xbf16>, %arg2: vector<32xbf16>) -> vector<16xf32> {
    %0 = x86vector.avx512.dot %arg0, %arg1, %arg2 : vector<32xbf16> -> vector<16xf32>
    return %0 : vector<16xf32>
  }
  func.func @avx512bf16_cvt_packed_f32_to_bf16_256(%arg0: vector<8xf32>) -> vector<8xbf16> {
    %0 = x86vector.avx512.cvt.packed.f32_to_bf16 %arg0 : vector<8xf32> -> vector<8xbf16>
    return %0 : vector<8xbf16>
  }
  func.func @avx512bf16_cvt_packed_f32_to_bf16_512(%arg0: vector<16xf32>) -> vector<16xbf16> {
    %0 = x86vector.avx512.cvt.packed.f32_to_bf16 %arg0 : vector<16xf32> -> vector<16xbf16>
    return %0 : vector<16xbf16>
  }
  func.func @avxbf16_cvt_packed_even_indexed_bf16_to_f32_128(%arg0: memref<8xbf16>) -> vector<4xf32> {
    %0 = x86vector.avx.cvt.packed.even.indexed_to_f32 %arg0 : memref<8xbf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avxbf16_cvt_packed_even_indexed_bf16_to_f32_256(%arg0: memref<16xbf16>) -> vector<8xf32> {
    %0 = x86vector.avx.cvt.packed.even.indexed_to_f32 %arg0 : memref<16xbf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avxbf16_cvt_packed_odd_indexed_bf16_to_f32_128(%arg0: memref<8xbf16>) -> vector<4xf32> {
    %0 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %arg0 : memref<8xbf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avxbf16_cvt_packed_odd_indexed_bf16_to_f32_256(%arg0: memref<16xbf16>) -> vector<8xf32> {
    %0 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %arg0 : memref<16xbf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avxbf16_bcst_bf16_to_f32_128(%arg0: memref<1xbf16>) -> vector<4xf32> {
    %0 = x86vector.avx.bcst_to_f32.packed %arg0 : memref<1xbf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avxbf16_bcst_bf16_to_f32_256(%arg0: memref<1xbf16>) -> vector<8xf32> {
    %0 = x86vector.avx.bcst_to_f32.packed %arg0 : memref<1xbf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avxf16_cvt_packed_even_indexed_f16_to_f32_128(%arg0: memref<8xf16>) -> vector<4xf32> {
    %0 = x86vector.avx.cvt.packed.even.indexed_to_f32 %arg0 : memref<8xf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avxf16_cvt_packed_even_indexed_f16_to_f32_256(%arg0: memref<16xf16>) -> vector<8xf32> {
    %0 = x86vector.avx.cvt.packed.even.indexed_to_f32 %arg0 : memref<16xf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avxf16_cvt_packed_odd_indexed_f16_to_f32_128(%arg0: memref<8xf16>) -> vector<4xf32> {
    %0 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %arg0 : memref<8xf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avxf16_cvt_packed_odd_indexed_f16_to_f32_256(%arg0: memref<16xf16>) -> vector<8xf32> {
    %0 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %arg0 : memref<16xf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avxf16_bcst_f16_to_f32_128(%arg0: memref<1xf16>) -> vector<4xf32> {
    %0 = x86vector.avx.bcst_to_f32.packed %arg0 : memref<1xf16> -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avxf16_bcst_f16_to_f32_256(%arg0: memref<1xf16>) -> vector<8xf32> {
    %0 = x86vector.avx.bcst_to_f32.packed %arg0 : memref<1xf16> -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avx_rsqrt(%arg0: vector<8xf32>) -> vector<8xf32> {
    %0 = x86vector.avx.rsqrt %arg0 : vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avx_dot(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = x86vector.avx.intr.dot %arg0, %arg1 : vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avx_dot_i8_128(%arg0: vector<4xi32>, %arg1: vector<16xi8>, %arg2: vector<16xi8>) -> vector<4xi32> {
    %0 = x86vector.avx.dot.i8 %arg0, %arg1, %arg2 : vector<16xi8> -> vector<4xi32>
    return %0 : vector<4xi32>
  }
  func.func @avx_dot_i8_256(%arg0: vector<8xi32>, %arg1: vector<32xi8>, %arg2: vector<32xi8>) -> vector<8xi32> {
    %0 = x86vector.avx.dot.i8 %arg0, %arg1, %arg2 : vector<32xi8> -> vector<8xi32>
    return %0 : vector<8xi32>
  }
}

