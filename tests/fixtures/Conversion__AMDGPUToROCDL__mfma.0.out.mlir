module {
  func.func @mfma_to_rocdl(%arg0: f32, %arg1: vector<32xf32>, %arg2: vector<16xf32>, %arg3: vector<4xf32>, %arg4: vector<4xf16>, %arg5: vector<4xi8>, %arg6: vector<32xi32>, %arg7: vector<16xi32>, %arg8: vector<4xi32>, %arg9: vector<2xbf16>, %arg10: vector<4xbf16>, %arg11: f64, %arg12: vector<4xf64>, %arg13: vector<8xi8>, %arg14: vector<2xf32>, %arg15: vector<8xf8E5M2FNUZ>, %arg16: vector<8xf8E4M3FNUZ>) {
    %0 = builtin.unrealized_conversion_cast %arg16 : vector<8xf8E4M3FNUZ> to vector<8xi8>
    %1 = builtin.unrealized_conversion_cast %arg15 : vector<8xf8E5M2FNUZ> to vector<8xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = rocdl.mfma.f32.32x32x1f32 %arg0, %arg0, %arg1, %2, %2, %2 : (f32, f32, vector<32xf32>, i32, i32, i32) -> vector<32xf32>
    %4 = rocdl.mfma.f32.16x16x1f32 %arg0, %arg0, %arg2, %2, %2, %2 : (f32, f32, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %5 = rocdl.mfma.f32.4x4x1f32 %arg0, %arg0, %arg3, %2, %2, %2 : (f32, f32, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %6 = rocdl.mfma.f32.32x32x2f32 %arg0, %arg0, %arg2, %2, %2, %2 : (f32, f32, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %7 = rocdl.mfma.f32.16x16x4f32 %arg0, %arg0, %arg3, %2, %2, %2 : (f32, f32, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %8 = rocdl.mfma.f32.32x32x4f16 %arg4, %arg4, %arg1, %2, %2, %2 : (vector<4xf16>, vector<4xf16>, vector<32xf32>, i32, i32, i32) -> vector<32xf32>
    %9 = rocdl.mfma.f32.16x16x4f16 %arg4, %arg4, %arg2, %2, %2, %2 : (vector<4xf16>, vector<4xf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %10 = rocdl.mfma.f32.4x4x4f16 %arg4, %arg4, %arg3, %2, %2, %2 : (vector<4xf16>, vector<4xf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %11 = rocdl.mfma.f32.32x32x8f16 %arg4, %arg4, %arg2, %2, %2, %2 : (vector<4xf16>, vector<4xf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %12 = rocdl.mfma.f32.16x16x16f16 %arg4, %arg4, %arg3, %2, %2, %2 : (vector<4xf16>, vector<4xf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %13 = llvm.bitcast %arg5 : vector<4xi8> to i32
    %14 = rocdl.mfma.i32.32x32x4i8 %13, %13, %arg6, %2, %2, %2 : (i32, i32, vector<32xi32>, i32, i32, i32) -> vector<32xi32>
    %15 = rocdl.mfma.i32.16x16x4i8 %13, %13, %arg7, %2, %2, %2 : (i32, i32, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %16 = rocdl.mfma.i32.4x4x4i8 %13, %13, %arg8, %2, %2, %2 : (i32, i32, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %17 = rocdl.mfma.i32.32x32x8i8 %13, %13, %arg7, %2, %2, %2 : (i32, i32, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %18 = rocdl.mfma.i32.16x16x16i8 %13, %13, %arg8, %2, %2, %2 : (i32, i32, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %19 = llvm.bitcast %arg9 : vector<2xbf16> to vector<2xi16>
    %20 = rocdl.mfma.f32.32x32x2bf16 %19, %19, %arg1, %2, %2, %2 : (vector<2xi16>, vector<2xi16>, vector<32xf32>, i32, i32, i32) -> vector<32xf32>
    %21 = rocdl.mfma.f32.16x16x2bf16 %19, %19, %arg2, %2, %2, %2 : (vector<2xi16>, vector<2xi16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %22 = rocdl.mfma.f32.4x4x2bf16 %19, %19, %arg3, %2, %2, %2 : (vector<2xi16>, vector<2xi16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %23 = rocdl.mfma.f32.32x32x4bf16 %19, %19, %arg2, %2, %2, %2 : (vector<2xi16>, vector<2xi16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %24 = rocdl.mfma.f32.16x16x8bf16 %19, %19, %arg3, %2, %2, %2 : (vector<2xi16>, vector<2xi16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %25 = llvm.bitcast %arg10 : vector<4xbf16> to vector<4xi16>
    %26 = rocdl.mfma.f32.32x32x4bf16.1k %25, %25, %arg1, %2, %2, %2 : (vector<4xi16>, vector<4xi16>, vector<32xf32>, i32, i32, i32) -> vector<32xf32>
    %27 = rocdl.mfma.f32.16x16x4bf16.1k %25, %25, %arg2, %2, %2, %2 : (vector<4xi16>, vector<4xi16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %28 = rocdl.mfma.f32.4x4x4bf16.1k %25, %25, %arg3, %2, %2, %2 : (vector<4xi16>, vector<4xi16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %29 = rocdl.mfma.f32.32x32x8bf16.1k %25, %25, %arg2, %2, %2, %2 : (vector<4xi16>, vector<4xi16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %30 = rocdl.mfma.f32.16x16x16bf16.1k %25, %25, %arg3, %2, %2, %2 : (vector<4xi16>, vector<4xi16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %31 = rocdl.mfma.f64.16x16x4f64 %arg11, %arg11, %arg12, %2, %2, %2 : (f64, f64, vector<4xf64>, i32, i32, i32) -> vector<4xf64>
    %32 = rocdl.mfma.f64.4x4x4f64 %arg11, %arg11, %arg11, %2, %2, %2 : (f64, f64, f64, i32, i32, i32) -> f64
    %33 = llvm.bitcast %arg13 : vector<8xi8> to i64
    %34 = rocdl.mfma.i32.16x16x32.i8 %33, %33, %arg8, %2, %2, %2 : (i64, i64, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %35 = rocdl.mfma.i32.32x32x16.i8 %33, %33, %arg7, %2, %2, %2 : (i64, i64, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %36 = rocdl.mfma.f32.16x16x8.xf32 %arg14, %arg14, %arg3, %2, %2, %2 : (vector<2xf32>, vector<2xf32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %37 = rocdl.mfma.f32.32x32x4.xf32 %arg14, %arg14, %arg2, %2, %2, %2 : (vector<2xf32>, vector<2xf32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %38 = llvm.bitcast %1 : vector<8xi8> to i64
    %39 = rocdl.mfma.f32.16x16x32.bf8.bf8 %38, %38, %arg3, %2, %2, %2 : (i64, i64, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %40 = llvm.bitcast %0 : vector<8xi8> to i64
    %41 = rocdl.mfma.f32.16x16x32.bf8.fp8 %38, %40, %arg3, %2, %2, %2 : (i64, i64, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %42 = rocdl.mfma.f32.16x16x32.fp8.bf8 %40, %38, %arg3, %2, %2, %2 : (i64, i64, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %43 = rocdl.mfma.f32.16x16x32.fp8.fp8 %40, %40, %arg3, %2, %2, %2 : (i64, i64, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %44 = rocdl.mfma.f32.32x32x16.bf8.bf8 %38, %38, %arg2, %2, %2, %2 : (i64, i64, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %45 = rocdl.mfma.f32.32x32x16.bf8.fp8 %38, %40, %arg2, %2, %2, %2 : (i64, i64, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %46 = rocdl.mfma.f32.32x32x16.fp8.bf8 %40, %38, %arg2, %2, %2, %2 : (i64, i64, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %47 = rocdl.mfma.f32.32x32x16.fp8.fp8 %40, %40, %arg2, %2, %2, %2 : (i64, i64, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    return
  }
}

