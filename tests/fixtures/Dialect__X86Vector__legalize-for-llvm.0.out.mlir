module {
  func.func @avx512_mask_rndscale(%arg0: vector<16xf32>, %arg1: vector<16xf32>, %arg2: vector<8xf64>, %arg3: i16, %arg4: i8, %arg5: i16, %arg6: i8) -> (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>) {
    %c15_i32 = arith.constant 15 : i32
    %c42_i32 = arith.constant 42 : i32
    %0 = llvm.call_intrinsic "llvm.x86.avx512.mask.rndscale.ps.512"(%arg0, %c15_i32, %arg1, %arg3, %c42_i32) : (vector<16xf32>, i32, vector<16xf32>, i16, i32) -> vector<16xf32>
    %1 = llvm.call_intrinsic "llvm.x86.avx512.mask.rndscale.pd.512"(%arg2, %c15_i32, %arg2, %arg4, %c42_i32) : (vector<8xf64>, i32, vector<8xf64>, i8, i32) -> vector<8xf64>
    %2 = llvm.call_intrinsic "llvm.x86.avx512.mask.scalef.ps.512"(%arg1, %arg1, %arg1, %arg5, %c42_i32) : (vector<16xf32>, vector<16xf32>, vector<16xf32>, i16, i32) -> vector<16xf32>
    %3 = llvm.call_intrinsic "llvm.x86.avx512.mask.scalef.pd.512"(%arg2, %arg2, %arg2, %arg6, %c42_i32) : (vector<8xf64>, vector<8xf64>, vector<8xf64>, i8, i32) -> vector<8xf64>
    return %0, %1, %2, %3 : vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>
  }
  func.func @avx512_mask_compress(%arg0: vector<16xi1>, %arg1: vector<16xf32>, %arg2: vector<8xi1>, %arg3: vector<8xi64>) -> (vector<16xf32>, vector<16xf32>, vector<8xi64>) {
    %0 = llvm.mlir.constant(dense<0.000000e+00> : vector<16xf32>) : vector<16xf32>
    %1 = llvm.call_intrinsic "llvm.x86.avx512.mask.compress"(%arg1, %0, %arg0) : (vector<16xf32>, vector<16xf32>, vector<16xi1>) -> vector<16xf32>
    %2 = llvm.mlir.constant(dense<5.000000e+00> : vector<16xf32>) : vector<16xf32>
    %3 = llvm.call_intrinsic "llvm.x86.avx512.mask.compress"(%arg1, %2, %arg0) {constant_src = dense<5.000000e+00> : vector<16xf32>} : (vector<16xf32>, vector<16xf32>, vector<16xi1>) -> vector<16xf32>
    %4 = llvm.call_intrinsic "llvm.x86.avx512.mask.compress"(%arg3, %arg3, %arg2) : (vector<8xi64>, vector<8xi64>, vector<8xi1>) -> vector<8xi64>
    return %1, %3, %4 : vector<16xf32>, vector<16xf32>, vector<8xi64>
  }
  func.func @avx512_vp2intersect(%arg0: vector<16xi32>, %arg1: vector<8xi64>) -> (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>) {
    %0 = llvm.call_intrinsic "llvm.x86.avx512.vp2intersect.d.512"(%arg0, %arg0) : (vector<16xi32>, vector<16xi32>) -> !llvm.struct<(vector<16xi1>, vector<16xi1>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(vector<16xi1>, vector<16xi1>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(vector<16xi1>, vector<16xi1>)> 
    %3 = llvm.call_intrinsic "llvm.x86.avx512.vp2intersect.q.512"(%arg1, %arg1) : (vector<8xi64>, vector<8xi64>) -> !llvm.struct<(vector<8xi1>, vector<8xi1>)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(vector<8xi1>, vector<8xi1>)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(vector<8xi1>, vector<8xi1>)> 
    return %1, %2, %4, %5 : vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>
  }
  func.func @avx512bf16_dot_128(%arg0: vector<4xf32>, %arg1: vector<8xbf16>, %arg2: vector<8xbf16>) -> vector<4xf32> {
    %0 = llvm.call_intrinsic "llvm.x86.avx512bf16.dpbf16ps.128"(%arg0, %arg1, %arg2) : (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @avx512bf16_dot_256(%arg0: vector<8xf32>, %arg1: vector<16xbf16>, %arg2: vector<16xbf16>) -> vector<8xf32> {
    %0 = llvm.call_intrinsic "llvm.x86.avx512bf16.dpbf16ps.256"(%arg0, %arg1, %arg2) : (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avx512bf16_dot_512(%arg0: vector<16xf32>, %arg1: vector<32xbf16>, %arg2: vector<32xbf16>) -> vector<16xf32> {
    %0 = llvm.call_intrinsic "llvm.x86.avx512bf16.dpbf16ps.512"(%arg0, %arg1, %arg2) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    return %0 : vector<16xf32>
  }
  func.func @avx512bf16_cvt_packed_f32_to_bf16_256(%arg0: vector<8xf32>) -> vector<8xbf16> {
    %0 = llvm.call_intrinsic "llvm.x86.avx512bf16.cvtneps2bf16.256"(%arg0) : (vector<8xf32>) -> vector<8xbf16>
    return %0 : vector<8xbf16>
  }
  func.func @avx512bf16_cvt_packed_f32_to_bf16_512(%arg0: vector<16xf32>) -> vector<16xbf16> {
    %0 = llvm.call_intrinsic "llvm.x86.avx512bf16.cvtneps2bf16.512"(%arg0) : (vector<16xf32>) -> vector<16xbf16>
    return %0 : vector<16xbf16>
  }
  func.func @avxbf16_cvt_packed_even_indexed_bf16_to_f32_128(%arg0: memref<8xbf16>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneebf162ps128"(%1) : (!llvm.ptr) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @avxbf16_cvt_packed_even_indexed_bf16_to_f32_256(%arg0: memref<16xbf16>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<16xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneebf162ps256"(%1) : (!llvm.ptr) -> vector<8xf32>
    return %2 : vector<8xf32>
  }
  func.func @avxbf16_cvt_packed_odd_indexed_bf16_to_f32_128(%arg0: memref<8xbf16>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneobf162ps128"(%1) : (!llvm.ptr) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @avxbf16_cvt_packed_odd_indexed_bf16_to_f32_256(%arg0: memref<16xbf16>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<16xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneobf162ps256"(%1) : (!llvm.ptr) -> vector<8xf32>
    return %2 : vector<8xf32>
  }
  func.func @avxbf16_bsct_bf16_to_f32_packed_128(%arg0: memref<1xbf16>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vbcstnebf162ps128"(%1) : (!llvm.ptr) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @avxbf16_bsct_bf16_to_f32_packed_256(%arg0: memref<1xbf16>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1xbf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vbcstnebf162ps256"(%1) : (!llvm.ptr) -> vector<8xf32>
    return %2 : vector<8xf32>
  }
  func.func @avxf16_cvt_packed_even_indexed_f16_to_f32_128(%arg0: memref<8xf16>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneeph2ps128"(%1) : (!llvm.ptr) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @avxf16_cvt_packed_even_indexed_f16_to_f32_256(%arg0: memref<16xf16>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<16xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneeph2ps256"(%1) : (!llvm.ptr) -> vector<8xf32>
    return %2 : vector<8xf32>
  }
  func.func @avxf16_cvt_packed_odd_indexed_f16_to_f32_128(%arg0: memref<8xf16>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<8xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneoph2ps128"(%1) : (!llvm.ptr) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @avxf16_cvt_packed_odd_indexed_f16_to_f32_256(%arg0: memref<16xf16>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<16xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vcvtneoph2ps256"(%1) : (!llvm.ptr) -> vector<8xf32>
    return %2 : vector<8xf32>
  }
  func.func @avxf16_bsct_f16_to_f32_packed_128(%arg0: memref<1xf16>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vbcstnesh2ps128"(%1) : (!llvm.ptr) -> vector<4xf32>
    return %2 : vector<4xf32>
  }
  func.func @avxf16_bsct_f16_to_f32_packed_256(%arg0: memref<1xf16>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1xf16> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.call_intrinsic "llvm.x86.vbcstnesh2ps256"(%1) : (!llvm.ptr) -> vector<8xf32>
    return %2 : vector<8xf32>
  }
  func.func @avx_rsqrt(%arg0: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.call_intrinsic "llvm.x86.avx.rsqrt.ps.256"(%arg0) : (vector<8xf32>) -> vector<8xf32>
    return %0 : vector<8xf32>
  }
  func.func @avx_dot(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call_intrinsic "llvm.x86.avx.dp.ps.256"(%arg0, %arg1, %0) : (vector<8xf32>, vector<8xf32>, i8) -> vector<8xf32>
    return %1 : vector<8xf32>
  }
  func.func @avx_dot_i8_128(%arg0: vector<4xi32>, %arg1: vector<16xi8>, %arg2: vector<16xi8>) -> vector<4xi32> {
    %0 = llvm.call_intrinsic "llvm.x86.avx2.vpdpbssd.128"(%arg0, %arg1, %arg2) : (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>
    return %0 : vector<4xi32>
  }
  func.func @avx_dot_i8_256(%arg0: vector<8xi32>, %arg1: vector<32xi8>, %arg2: vector<32xi8>) -> vector<8xi32> {
    %0 = llvm.call_intrinsic "llvm.x86.avx2.vpdpbssd.256"(%arg0, %arg1, %arg2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    return %0 : vector<8xi32>
  }
}

