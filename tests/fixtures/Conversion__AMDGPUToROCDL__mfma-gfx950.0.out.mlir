module {
  func.func @mfma_to_rocdl(%arg0: vector<8xf16>, %arg1: vector<16xf32>, %arg2: vector<4xf32>, %arg3: vector<8xbf16>, %arg4: vector<16xi8>, %arg5: vector<16xi32>, %arg6: vector<4xi32>, %arg7: vector<32xf8E4M3FN>, %arg8: vector<32xf8E5M2>, %arg9: vector<32xf6E2M3FN>, %arg10: vector<32xf6E3M2FN>, %arg11: vector<32xf4E2M1FN>) {
    %0 = builtin.unrealized_conversion_cast %arg11 : vector<32xf4E2M1FN> to vector<32xi4>
    %1 = builtin.unrealized_conversion_cast %arg10 : vector<32xf6E3M2FN> to vector<32xi6>
    %2 = builtin.unrealized_conversion_cast %arg9 : vector<32xf6E2M3FN> to vector<32xi6>
    %3 = builtin.unrealized_conversion_cast %arg8 : vector<32xf8E5M2> to vector<32xi8>
    %4 = builtin.unrealized_conversion_cast %arg7 : vector<32xf8E4M3FN> to vector<32xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = rocdl.mfma.f32.32x32x16.f16 %arg0, %arg0, %arg1, %5, %5, %5 : (vector<8xf16>, vector<8xf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %7 = rocdl.mfma.f32.16x16x32.f16 %arg0, %arg0, %arg2, %5, %5, %5 : (vector<8xf16>, vector<8xf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %8 = rocdl.mfma.f32.32x32x16.bf16 %arg3, %arg3, %arg1, %5, %5, %5 : (vector<8xbf16>, vector<8xbf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %9 = rocdl.mfma.f32.16x16x32.bf16 %arg3, %arg3, %arg2, %5, %5, %5 : (vector<8xbf16>, vector<8xbf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %10 = llvm.bitcast %arg4 : vector<16xi8> to vector<4xi32>
    %11 = rocdl.mfma.i32.32x32x32.i8 %10, %10, %arg5, %5, %5, %5 : (vector<4xi32>, vector<4xi32>, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %12 = rocdl.mfma.i32.16x16x64.i8 %10, %10, %arg6, %5, %5, %5 : (vector<4xi32>, vector<4xi32>, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %13 = llvm.bitcast %4 : vector<32xi8> to vector<8xi32>
    %14 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %13, %13, %arg1, %5, %5, %5, %5, %5, %5 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %15 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %13, %13, %arg2, %5, %5, %5, %5, %5, %5 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %16 = llvm.bitcast %3 : vector<32xi8> to vector<8xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %16, %16, %arg1, %17, %17, %5, %5, %5, %5 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %19 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %16, %16, %arg2, %17, %17, %5, %5, %5, %5 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %20 = llvm.bitcast %2 : vector<32xi6> to vector<6xi32>
    %21 = llvm.mlir.constant(2 : i32) : i32
    %22 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %20, %20, %arg1, %21, %21, %5, %5, %5, %5 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %23 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %20, %20, %arg2, %21, %21, %5, %5, %5, %5 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %24 = llvm.bitcast %1 : vector<32xi6> to vector<6xi32>
    %25 = llvm.mlir.constant(3 : i32) : i32
    %26 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %24, %24, %arg1, %25, %25, %5, %5, %5, %5 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %27 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %24, %24, %arg2, %25, %25, %5, %5, %5, %5 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %28 = llvm.bitcast %0 : vector<32xi4> to vector<4xi32>
    %29 = llvm.mlir.constant(4 : i32) : i32
    %30 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %28, %28, %arg1, %29, %29, %5, %5, %5, %5 : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %31 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %28, %28, %arg2, %29, %29, %5, %5, %5, %5 : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %32 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %20, %28, %arg1, %21, %29, %5, %5, %5, %5 : (vector<6xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %33 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %20, %28, %arg2, %21, %29, %5, %5, %5, %5 : (vector<6xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
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
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.bitcast %5 : vector<4xi8> to i32
    %11 = llvm.zext %4 : i8 to i32
    %12 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %7, %7, %arg0, %8, %8, %8, %10, %9, %11 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %13 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %7, %7, %arg1, %8, %8, %8, %10, %9, %11 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %14 = llvm.bitcast %3 : vector<32xi8> to vector<8xi32>
    %15 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %14, %14, %arg0, %9, %9, %8, %10, %9, %11 : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %16 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %14, %14, %arg1, %9, %9, %8, %10, %9, %11 : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %17 = llvm.bitcast %2 : vector<32xi6> to vector<6xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %17, %17, %arg0, %18, %18, %8, %10, %9, %11 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %20 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %17, %17, %arg1, %18, %18, %8, %10, %9, %11 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %21 = llvm.bitcast %1 : vector<32xi6> to vector<6xi32>
    %22 = llvm.mlir.constant(3 : i32) : i32
    %23 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %21, %21, %arg0, %22, %22, %8, %10, %9, %11 : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %24 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %21, %21, %arg1, %22, %22, %8, %10, %9, %11 : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %25 = llvm.bitcast %0 : vector<32xi4> to vector<4xi32>
    %26 = llvm.mlir.constant(4 : i32) : i32
    %27 = rocdl.mfma.scale.f32.32x32x64.f8f6f4 %25, %25, %arg0, %26, %26, %8, %10, %9, %11 : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %28 = rocdl.mfma.scale.f32.16x16x128.f8f6f4 %25, %25, %arg1, %26, %26, %8, %10, %9, %11 : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    return
  }
}

