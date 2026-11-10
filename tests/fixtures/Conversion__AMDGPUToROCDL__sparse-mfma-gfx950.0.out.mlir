module {
  func.func @sparse_mfma_to_rocdl(%arg0: vector<8xf16>, %arg1: vector<16xf16>, %arg2: vector<4xf32>, %arg3: vector<16xf32>, %arg4: vector<8xbf16>, %arg5: vector<16xbf16>, %arg6: vector<16xi8>, %arg7: vector<32xi8>, %arg8: vector<4xi32>, %arg9: vector<16xi32>, %arg10: vector<16xf8E4M3FN>, %arg11: vector<16xf8E5M2>, %arg12: vector<32xf8E4M3FN>, %arg13: vector<32xf8E5M2>, %arg14: vector<2xi16>, %arg15: i32, %arg16: vector<4xbf16>, %arg17: vector<4xi8>) {
    %0 = builtin.unrealized_conversion_cast %arg13 : vector<32xf8E5M2> to vector<32xi8>
    %1 = builtin.unrealized_conversion_cast %arg11 : vector<16xf8E5M2> to vector<16xi8>
    %2 = builtin.unrealized_conversion_cast %arg12 : vector<32xf8E4M3FN> to vector<32xi8>
    %3 = builtin.unrealized_conversion_cast %arg10 : vector<16xf8E4M3FN> to vector<16xi8>
    %4 = llvm.bitcast %arg14 : vector<2xi16> to i32
    %5 = rocdl.smfmac.f32.16x16x64.f16 %arg0, %arg1, %arg2, %4, 0, 0 : (vector<8xf16>, vector<16xf16>, vector<4xf32>, i32) -> vector<4xf32>
    %6 = rocdl.smfmac.f32.16x16x64.bf16 %arg4, %arg5, %arg2, %4, 0, 0 : (vector<8xbf16>, vector<16xbf16>, vector<4xf32>, i32) -> vector<4xf32>
    %7 = llvm.bitcast %arg16 : vector<4xbf16> to vector<4xi16>
    %8 = llvm.bitcast %arg4 : vector<8xbf16> to vector<8xi16>
    %9 = llvm.bitcast %arg17 : vector<4xi8> to i32
    %10 = rocdl.smfmac.f32.16x16x32.bf16 %7, %8, %arg2, %9, 0, 0 : (vector<4xi16>, vector<8xi16>, vector<4xf32>, i32) -> vector<4xf32>
    %11 = llvm.bitcast %arg6 : vector<16xi8> to vector<4xi32>
    %12 = llvm.bitcast %arg7 : vector<32xi8> to vector<8xi32>
    %13 = rocdl.smfmac.i32.16x16x128.i8 %11, %12, %arg8, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<4xi32>, i32) -> vector<4xi32>
    %14 = llvm.bitcast %3 : vector<16xi8> to vector<4xi32>
    %15 = llvm.bitcast %2 : vector<32xi8> to vector<8xi32>
    %16 = rocdl.smfmac.f32.16x16x128.fp8.fp8 %14, %15, %arg2, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32) -> vector<4xf32>
    %17 = llvm.bitcast %1 : vector<16xi8> to vector<4xi32>
    %18 = llvm.bitcast %0 : vector<32xi8> to vector<8xi32>
    %19 = rocdl.smfmac.f32.16x16x128.bf8.bf8 %17, %18, %arg2, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32) -> vector<4xf32>
    %20 = rocdl.smfmac.f32.16x16x128.fp8.bf8 %14, %18, %arg2, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32) -> vector<4xf32>
    %21 = rocdl.smfmac.f32.16x16x128.bf8.fp8 %17, %15, %arg2, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32) -> vector<4xf32>
    %22 = rocdl.smfmac.f32.32x32x32.f16 %arg0, %arg1, %arg3, %4, 0, 0 : (vector<8xf16>, vector<16xf16>, vector<16xf32>, i32) -> vector<16xf32>
    %23 = rocdl.smfmac.f32.32x32x32.bf16 %arg4, %arg5, %arg3, %4, 0, 0 : (vector<8xbf16>, vector<16xbf16>, vector<16xf32>, i32) -> vector<16xf32>
    %24 = rocdl.smfmac.f32.32x32x16.bf16 %7, %8, %arg3, %9, 0, 0 : (vector<4xi16>, vector<8xi16>, vector<16xf32>, i32) -> vector<16xf32>
    %25 = rocdl.smfmac.i32.32x32x64.i8 %11, %12, %arg9, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<16xi32>, i32) -> vector<16xi32>
    %26 = rocdl.smfmac.f32.32x32x64.fp8.fp8 %14, %15, %arg3, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32) -> vector<16xf32>
    %27 = rocdl.smfmac.f32.32x32x64.bf8.bf8 %17, %18, %arg3, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32) -> vector<16xf32>
    %28 = rocdl.smfmac.f32.32x32x64.fp8.bf8 %14, %18, %arg3, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32) -> vector<16xf32>
    %29 = rocdl.smfmac.f32.32x32x64.bf8.fp8 %17, %15, %arg3, %arg15, 0, 0 : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32) -> vector<16xf32>
    return
  }
}

