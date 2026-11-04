module {
  func.func @sparse_mfma_to_rocdl(%arg0: vector<4xf16>, %arg1: vector<8xf16>, %arg2: vector<4xf32>, %arg3: vector<16xf32>, %arg4: vector<4xbf16>, %arg5: vector<8xbf16>, %arg6: vector<8xi8>, %arg7: vector<16xi8>, %arg8: vector<4xi32>, %arg9: vector<16xi32>, %arg10: vector<8xf8E4M3FNUZ>, %arg11: vector<8xf8E5M2FNUZ>, %arg12: vector<16xf8E4M3FNUZ>, %arg13: vector<16xf8E5M2FNUZ>, %arg14: vector<4xi8>, %arg15: vector<2xi16>) {
    %0 = builtin.unrealized_conversion_cast %arg13 : vector<16xf8E5M2FNUZ> to vector<16xi8>
    %1 = builtin.unrealized_conversion_cast %arg11 : vector<8xf8E5M2FNUZ> to vector<8xi8>
    %2 = builtin.unrealized_conversion_cast %arg12 : vector<16xf8E4M3FNUZ> to vector<16xi8>
    %3 = builtin.unrealized_conversion_cast %arg10 : vector<8xf8E4M3FNUZ> to vector<8xi8>
    %4 = llvm.bitcast %arg14 : vector<4xi8> to i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = rocdl.smfmac.f32.16x16x32.f16 %arg0, %arg1, %arg2, %4, %5, %5 : (vector<4xf16>, vector<8xf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %7 = llvm.bitcast %arg4 : vector<4xbf16> to vector<4xi16>
    %8 = llvm.bitcast %arg5 : vector<8xbf16> to vector<8xi16>
    %9 = rocdl.smfmac.f32.16x16x32.bf16 %7, %8, %arg2, %4, %5, %5 : (vector<4xi16>, vector<8xi16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %10 = rocdl.smfmac.f32.32x32x16.f16 %arg0, %arg1, %arg3, %4, %5, %5 : (vector<4xf16>, vector<8xf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %11 = rocdl.smfmac.f32.32x32x16.bf16 %7, %8, %arg3, %4, %5, %5 : (vector<4xi16>, vector<8xi16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %12 = llvm.bitcast %arg6 : vector<8xi8> to vector<2xi32>
    %13 = llvm.bitcast %arg7 : vector<16xi8> to vector<4xi32>
    %14 = llvm.bitcast %arg15 : vector<2xi16> to i32
    %15 = rocdl.smfmac.i32.16x16x64.i8 %12, %13, %arg8, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %16 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %17 = llvm.bitcast %2 : vector<16xi8> to vector<4xi32>
    %18 = rocdl.smfmac.f32.16x16x64.fp8.fp8 %16, %17, %arg2, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %19 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %20 = llvm.bitcast %0 : vector<16xi8> to vector<4xi32>
    %21 = rocdl.smfmac.f32.16x16x64.bf8.bf8 %19, %20, %arg2, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %22 = rocdl.smfmac.f32.16x16x64.fp8.bf8 %16, %20, %arg2, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %23 = rocdl.smfmac.f32.16x16x64.bf8.fp8 %19, %17, %arg2, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %24 = rocdl.smfmac.i32.32x32x32.i8 %12, %13, %arg9, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %25 = rocdl.smfmac.f32.32x32x32.fp8.fp8 %16, %17, %arg3, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %26 = rocdl.smfmac.f32.32x32x32.bf8.bf8 %19, %20, %arg3, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %27 = rocdl.smfmac.f32.32x32x32.fp8.bf8 %16, %20, %arg3, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %28 = rocdl.smfmac.f32.32x32x32.bf8.fp8 %19, %17, %arg3, %14, %5, %5 : (vector<2xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    return
  }
}

