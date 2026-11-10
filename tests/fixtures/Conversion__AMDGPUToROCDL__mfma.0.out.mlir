module {
  func.func @mfma_to_rocdl(%arg0: f32, %arg1: vector<32xf32>, %arg2: vector<16xf32>, %arg3: vector<4xf32>, %arg4: vector<4xf16>, %arg5: vector<4xi8>, %arg6: vector<32xi32>, %arg7: vector<16xi32>, %arg8: vector<4xi32>, %arg9: vector<2xbf16>, %arg10: vector<4xbf16>, %arg11: f64, %arg12: vector<4xf64>, %arg13: vector<8xi8>, %arg14: vector<2xf32>, %arg15: vector<8xf8E5M2FNUZ>, %arg16: vector<8xf8E4M3FNUZ>) {
    %0 = builtin.unrealized_conversion_cast %arg16 : vector<8xf8E4M3FNUZ> to vector<8xi8>
    %1 = builtin.unrealized_conversion_cast %arg15 : vector<8xf8E5M2FNUZ> to vector<8xi8>
    %2 = rocdl.mfma.f32.32x32x1f32 %arg0, %arg0, %arg1, 0, 0, none : (f32, f32, vector<32xf32>) -> vector<32xf32>
    %3 = rocdl.mfma.f32.16x16x1f32 %arg0, %arg0, %arg2, 0, 0, none : (f32, f32, vector<16xf32>) -> vector<16xf32>
    %4 = rocdl.mfma.f32.4x4x1f32 %arg0, %arg0, %arg3, 0, 0, none : (f32, f32, vector<4xf32>) -> vector<4xf32>
    %5 = rocdl.mfma.f32.32x32x2f32 %arg0, %arg0, %arg2, 0, 0, none : (f32, f32, vector<16xf32>) -> vector<16xf32>
    %6 = rocdl.mfma.f32.16x16x4f32 %arg0, %arg0, %arg3, 0, 0, none : (f32, f32, vector<4xf32>) -> vector<4xf32>
    %7 = rocdl.mfma.f32.32x32x4f16 %arg4, %arg4, %arg1, 0, 0, none : (vector<4xf16>, vector<4xf16>, vector<32xf32>) -> vector<32xf32>
    %8 = rocdl.mfma.f32.16x16x4f16 %arg4, %arg4, %arg2, 0, 0, none : (vector<4xf16>, vector<4xf16>, vector<16xf32>) -> vector<16xf32>
    %9 = rocdl.mfma.f32.4x4x4f16 %arg4, %arg4, %arg3, 0, 0, none : (vector<4xf16>, vector<4xf16>, vector<4xf32>) -> vector<4xf32>
    %10 = rocdl.mfma.f32.32x32x8f16 %arg4, %arg4, %arg2, 0, 0, none : (vector<4xf16>, vector<4xf16>, vector<16xf32>) -> vector<16xf32>
    %11 = rocdl.mfma.f32.16x16x16f16 %arg4, %arg4, %arg3, 0, 0, none : (vector<4xf16>, vector<4xf16>, vector<4xf32>) -> vector<4xf32>
    %12 = llvm.bitcast %arg5 : vector<4xi8> to i32
    %13 = rocdl.mfma.i32.32x32x4i8 %12, %12, %arg6, 0, 0, none : (i32, i32, vector<32xi32>) -> vector<32xi32>
    %14 = rocdl.mfma.i32.16x16x4i8 %12, %12, %arg7, 0, 0, none : (i32, i32, vector<16xi32>) -> vector<16xi32>
    %15 = rocdl.mfma.i32.4x4x4i8 %12, %12, %arg8, 0, 0, none : (i32, i32, vector<4xi32>) -> vector<4xi32>
    %16 = rocdl.mfma.i32.32x32x8i8 %12, %12, %arg7, 0, 0, none : (i32, i32, vector<16xi32>) -> vector<16xi32>
    %17 = rocdl.mfma.i32.16x16x16i8 %12, %12, %arg8, 0, 0, none : (i32, i32, vector<4xi32>) -> vector<4xi32>
    %18 = llvm.bitcast %arg9 : vector<2xbf16> to vector<2xi16>
    %19 = rocdl.mfma.f32.32x32x2bf16 %18, %18, %arg1, 0, 0, none : (vector<2xi16>, vector<2xi16>, vector<32xf32>) -> vector<32xf32>
    %20 = rocdl.mfma.f32.16x16x2bf16 %18, %18, %arg2, 0, 0, none : (vector<2xi16>, vector<2xi16>, vector<16xf32>) -> vector<16xf32>
    %21 = rocdl.mfma.f32.4x4x2bf16 %18, %18, %arg3, 0, 0, none : (vector<2xi16>, vector<2xi16>, vector<4xf32>) -> vector<4xf32>
    %22 = rocdl.mfma.f32.32x32x4bf16 %18, %18, %arg2, 0, 0, none : (vector<2xi16>, vector<2xi16>, vector<16xf32>) -> vector<16xf32>
    %23 = rocdl.mfma.f32.16x16x8bf16 %18, %18, %arg3, 0, 0, none : (vector<2xi16>, vector<2xi16>, vector<4xf32>) -> vector<4xf32>
    %24 = llvm.bitcast %arg10 : vector<4xbf16> to vector<4xi16>
    %25 = rocdl.mfma.f32.32x32x4bf16.1k %24, %24, %arg1, 0, 0, none : (vector<4xi16>, vector<4xi16>, vector<32xf32>) -> vector<32xf32>
    %26 = rocdl.mfma.f32.16x16x4bf16.1k %24, %24, %arg2, 0, 0, none : (vector<4xi16>, vector<4xi16>, vector<16xf32>) -> vector<16xf32>
    %27 = rocdl.mfma.f32.4x4x4bf16.1k %24, %24, %arg3, 0, 0, none : (vector<4xi16>, vector<4xi16>, vector<4xf32>) -> vector<4xf32>
    %28 = rocdl.mfma.f32.32x32x8bf16.1k %24, %24, %arg2, 0, 0, none : (vector<4xi16>, vector<4xi16>, vector<16xf32>) -> vector<16xf32>
    %29 = rocdl.mfma.f32.16x16x16bf16.1k %24, %24, %arg3, 0, 0, none : (vector<4xi16>, vector<4xi16>, vector<4xf32>) -> vector<4xf32>
    %30 = rocdl.mfma.f64.16x16x4f64 %arg11, %arg11, %arg12, 0, 0, neg_a|neg_b : (f64, f64, vector<4xf64>) -> vector<4xf64>
    %31 = rocdl.mfma.f64.4x4x4f64 %arg11, %arg11, %arg11, 0, 0, none : (f64, f64, f64) -> f64
    %32 = llvm.bitcast %arg13 : vector<8xi8> to i64
    %33 = rocdl.mfma.i32.16x16x32.i8 %32, %32, %arg8, 0, 0, none : (i64, i64, vector<4xi32>) -> vector<4xi32>
    %34 = rocdl.mfma.i32.32x32x16.i8 %32, %32, %arg7, 0, 0, none : (i64, i64, vector<16xi32>) -> vector<16xi32>
    %35 = rocdl.mfma.f32.16x16x8.xf32 %arg14, %arg14, %arg3, 0, 0, none : (vector<2xf32>, vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %36 = rocdl.mfma.f32.32x32x4.xf32 %arg14, %arg14, %arg2, 0, 0, none : (vector<2xf32>, vector<2xf32>, vector<16xf32>) -> vector<16xf32>
    %37 = llvm.bitcast %1 : vector<8xi8> to i64
    %38 = rocdl.mfma.f32.16x16x32.bf8.bf8 %37, %37, %arg3, 0, 0, none : (i64, i64, vector<4xf32>) -> vector<4xf32>
    %39 = llvm.bitcast %0 : vector<8xi8> to i64
    %40 = rocdl.mfma.f32.16x16x32.bf8.fp8 %37, %39, %arg3, 0, 0, none : (i64, i64, vector<4xf32>) -> vector<4xf32>
    %41 = rocdl.mfma.f32.16x16x32.fp8.bf8 %39, %37, %arg3, 0, 0, none : (i64, i64, vector<4xf32>) -> vector<4xf32>
    %42 = rocdl.mfma.f32.16x16x32.fp8.fp8 %39, %39, %arg3, 0, 0, none : (i64, i64, vector<4xf32>) -> vector<4xf32>
    %43 = rocdl.mfma.f32.32x32x16.bf8.bf8 %37, %37, %arg2, 0, 0, none : (i64, i64, vector<16xf32>) -> vector<16xf32>
    %44 = rocdl.mfma.f32.32x32x16.bf8.fp8 %37, %39, %arg2, 0, 0, none : (i64, i64, vector<16xf32>) -> vector<16xf32>
    %45 = rocdl.mfma.f32.32x32x16.fp8.bf8 %39, %37, %arg2, 0, 0, none : (i64, i64, vector<16xf32>) -> vector<16xf32>
    %46 = rocdl.mfma.f32.32x32x16.fp8.fp8 %39, %39, %arg2, 0, 0, none : (i64, i64, vector<16xf32>) -> vector<16xf32>
    return
  }
}

