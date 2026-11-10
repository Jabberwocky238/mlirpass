module {
  func.func @mfma_to_rocdl(%arg0: vector<8xf16>, %arg1: vector<16xf32>, %arg2: vector<4xf32>, %arg3: vector<8xbf16>, %arg4: vector<16xi8>, %arg5: vector<16xi32>, %arg6: vector<4xi32>, %arg7: vector<32xf8E4M3FN>, %arg8: vector<32xf8E5M2>, %arg9: vector<32xf6E2M3FN>, %arg10: vector<32xf6E3M2FN>, %arg11: vector<32xf4E2M1FN>) {
    %0 = builtin.unrealized_conversion_cast %arg11 : vector<32xf4E2M1FN> to vector<32xi4>
    %1 = builtin.unrealized_conversion_cast %arg10 : vector<32xf6E3M2FN> to vector<32xi6>
    %2 = builtin.unrealized_conversion_cast %arg9 : vector<32xf6E2M3FN> to vector<32xi6>
    %3 = builtin.unrealized_conversion_cast %arg8 : vector<32xf8E5M2> to vector<32xi8>
    %4 = builtin.unrealized_conversion_cast %arg7 : vector<32xf8E4M3FN> to vector<32xi8>
    %5 = rocdl.mfma.f32.32x32x16.f16 %arg0, %arg0, %arg1, 0, 0, none : (vector<8xf16>, vector<8xf16>, vector<16xf32>) -> vector<16xf32>
    %6 = rocdl.mfma.f32.16x16x32.f16 %arg0, %arg0, %arg2, 0, 0, none : (vector<8xf16>, vector<8xf16>, vector<4xf32>) -> vector<4xf32>
    %7 = rocdl.mfma.f32.32x32x16.bf16 %arg3, %arg3, %arg1, 0, 0, none : (vector<8xbf16>, vector<8xbf16>, vector<16xf32>) -> vector<16xf32>
    %8 = rocdl.mfma.f32.16x16x32.bf16 %arg3, %arg3, %arg2, 0, 0, none : (vector<8xbf16>, vector<8xbf16>, vector<4xf32>) -> vector<4xf32>
    %9 = llvm.bitcast %arg4 : vector<16xi8> to vector<4xi32>
    %10 = rocdl.mfma.i32.32x32x32.i8 %9, %9, %arg5, 0, 0, none : (vector<4xi32>, vector<4xi32>, vector<16xi32>) -> vector<16xi32>
    %11 = rocdl.mfma.i32.16x16x64.i8 %9, %9, %arg6, 0, 0, none : (vector<4xi32>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %12 = llvm.bitcast %4 : vector<32xi8> to vector<8xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %12, %12, %arg1, fp8_e4m3, fp8_e4m3, 0, %13, 0, %13 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %15 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %12, %12, %arg2, fp8_e4m3, fp8_e4m3, 0, %13, 0, %13 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %16 = llvm.bitcast %3 : vector<32xi8> to vector<8xi32>
    %17 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %16, %16, %arg1, fp8_e5m2, fp8_e5m2, 0, %13, 0, %13 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %18 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %16, %16, %arg2, fp8_e5m2, fp8_e5m2, 0, %13, 0, %13 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %19 = llvm.bitcast %2 : vector<32xi6> to vector<6xi32>
    %20 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %19, %19, %arg1, fp6_e2m3, fp6_e2m3, 0, %13, 0, %13 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %21 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %19, %19, %arg2, fp6_e2m3, fp6_e2m3, 0, %13, 0, %13 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %22 = llvm.bitcast %1 : vector<32xi6> to vector<6xi32>
    %23 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %22, %22, %arg1, fp6_e3m2, fp6_e3m2, 0, %13, 0, %13 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %24 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %22, %22, %arg2, fp6_e3m2, fp6_e3m2, 0, %13, 0, %13 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %25 = llvm.bitcast %0 : vector<32xi4> to vector<4xi32>
    %26 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %25, %25, %arg1, fp4_e2m1, fp4_e2m1, 0, %13, 0, %13 : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %27 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %25, %25, %arg2, fp4_e2m1, fp4_e2m1, 0, %13, 0, %13 : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %28 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %19, %25, %arg1, fp6_e2m3, fp4_e2m1, 0, %13, 0, %13 : (vector<6xi32>, vector<4xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %29 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %19, %25, %arg2, fp6_e2m3, fp4_e2m1, 0, %13, 0, %13 : (vector<6xi32>, vector<4xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    return
  }
  func.func @scaled_mfma_to_rocdl(%arg0: vector<16xf32>, %arg1: vector<4xf32>, %arg2: vector<32xf8E4M3FN>, %arg3: vector<32xf8E5M2>, %arg4: vector<32xf6E2M3FN>, %arg5: vector<32xf6E3M2FN>, %arg6: vector<32xf4E2M1FN>, %arg7: vector<4xf8E8M0FNU>, %arg8: f8E8M0FNU) {
    %0 = builtin.unrealized_conversion_cast %arg6 : vector<32xf4E2M1FN> to vector<32xi4>
    %1 = builtin.unrealized_conversion_cast %arg5 : vector<32xf6E3M2FN> to vector<32xi6>
    %2 = builtin.unrealized_conversion_cast %arg4 : vector<32xf6E2M3FN> to vector<32xi6>
    %3 = builtin.unrealized_conversion_cast %arg3 : vector<32xf8E5M2> to vector<32xi8>
    %4 = builtin.unrealized_conversion_cast %arg8 : f8E8M0FNU to i8
    %5 = builtin.unrealized_conversion_cast %arg7 : vector<4xf8E8M0FNU> to vector<4xi8>
    %6 = builtin.unrealized_conversion_cast %arg2 : vector<32xf8E4M3FN> to vector<32xi8>
    %7 = llvm.bitcast %6 : vector<32xi8> to vector<8xi32>
    %8 = llvm.bitcast %5 : vector<4xi8> to i32
    %9 = llvm.zext %4 : i8 to i32
    %10 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %7, %7, %arg0, fp8_e4m3, fp8_e4m3, 0, %8, 1, %9 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %11 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %7, %7, %arg1, fp8_e4m3, fp8_e4m3, 0, %8, 1, %9 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %12 = llvm.bitcast %3 : vector<32xi8> to vector<8xi32>
    %13 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %12, %12, %arg0, fp8_e5m2, fp8_e5m2, 0, %8, 1, %9 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %14 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %12, %12, %arg1, fp8_e5m2, fp8_e5m2, 0, %8, 1, %9 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %15 = llvm.bitcast %2 : vector<32xi6> to vector<6xi32>
    %16 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %15, %15, %arg0, fp6_e2m3, fp6_e2m3, 0, %8, 1, %9 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %17 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %15, %15, %arg1, fp6_e2m3, fp6_e2m3, 0, %8, 1, %9 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %18 = llvm.bitcast %1 : vector<32xi6> to vector<6xi32>
    %19 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %18, %18, %arg0, fp6_e3m2, fp6_e3m2, 0, %8, 1, %9 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %20 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %18, %18, %arg1, fp6_e3m2, fp6_e3m2, 0, %8, 1, %9 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %21 = llvm.bitcast %0 : vector<32xi4> to vector<4xi32>
    %22 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %21, %21, %arg0, fp4_e2m1, fp4_e2m1, 0, %8, 1, %9 : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %23 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %21, %21, %arg1, fp4_e2m1, fp4_e2m1, 0, %8, 1, %9 : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    return
  }
}

