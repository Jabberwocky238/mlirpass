module {
  func.func @wmma_to_rocdl(%arg0: vector<8xf16>, %arg1: vector<4xf16>, %arg2: vector<8xf32>, %arg3: vector<4xf32>, %arg4: vector<8xbf16>, %arg5: vector<4xbf16>, %arg6: vector<8xf8E4M3FN>, %arg7: vector<4xf8E4M3FN>, %arg8: vector<8xf8E5M2>, %arg9: vector<4xf8E5M2>, %arg10: vector<8xi8>, %arg11: vector<4xi8>, %arg12: vector<8xi32>, %arg13: vector<4xi32>, %arg14: vector<16xi4>, %arg15: vector<8xi4>, %arg16: vector<4xi4>) {
    %0 = builtin.unrealized_conversion_cast %arg9 : vector<4xf8E5M2> to vector<4xi8>
    %1 = builtin.unrealized_conversion_cast %arg8 : vector<8xf8E5M2> to vector<8xi8>
    %2 = builtin.unrealized_conversion_cast %arg7 : vector<4xf8E4M3FN> to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %arg6 : vector<8xf8E4M3FN> to vector<8xi8>
    %4 = rocdl.wmma.f32.16x16x16.f16 %arg0, %arg0, %arg2 : (vector<8xf16>, vector<8xf16>, vector<8xf32>) -> vector<8xf32>
    %5 = rocdl.wmma.f32.16x16x16.f16 %arg1, %arg1, %arg3 : (vector<4xf16>, vector<4xf16>, vector<4xf32>) -> vector<4xf32>
    %6 = llvm.bitcast %arg4 : vector<8xbf16> to vector<8xi16>
    %7 = llvm.bitcast %arg4 : vector<8xbf16> to vector<8xi16>
    %8 = rocdl.wmma.f32.16x16x16.bf16 %6, %7, %arg2 : (vector<8xi16>, vector<8xi16>, vector<8xf32>) -> vector<8xf32>
    %9 = llvm.bitcast %arg5 : vector<4xbf16> to vector<4xi16>
    %10 = llvm.bitcast %arg5 : vector<4xbf16> to vector<4xi16>
    %11 = rocdl.wmma.f32.16x16x16.bf16 %9, %10, %arg3 : (vector<4xi16>, vector<4xi16>, vector<4xf32>) -> vector<4xf32>
    %12 = rocdl.wmma.f16.16x16x16.f16 %arg0, %arg0, %arg0 : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    %13 = rocdl.wmma.f16.16x16x16.f16 %arg1, %arg1, %arg1 : (vector<4xf16>, vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    %14 = llvm.bitcast %arg4 : vector<8xbf16> to vector<8xi16>
    %15 = llvm.bitcast %arg4 : vector<8xbf16> to vector<8xi16>
    %16 = llvm.bitcast %arg4 : vector<8xbf16> to vector<8xi16>
    %17 = rocdl.wmma.bf16.16x16x16.bf16 %14, %15, %16 : (vector<8xi16>, vector<8xi16>, vector<8xi16>) -> vector<8xi16>
    %18 = llvm.bitcast %17 : vector<8xi16> to vector<8xbf16>
    %19 = llvm.bitcast %arg5 : vector<4xbf16> to vector<4xi16>
    %20 = llvm.bitcast %arg5 : vector<4xbf16> to vector<4xi16>
    %21 = llvm.bitcast %arg5 : vector<4xbf16> to vector<4xi16>
    %22 = rocdl.wmma.bf16.16x16x16.bf16 %19, %20, %21 : (vector<4xi16>, vector<4xi16>, vector<4xi16>) -> vector<4xi16>
    %23 = llvm.bitcast %22 : vector<4xi16> to vector<4xbf16>
    %24 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %25 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %26 = rocdl.wmma.f32.16x16x16.fp8_fp8 %24, %25, %arg2 : (vector<2xi32>, vector<2xi32>, vector<8xf32>) -> vector<8xf32>
    %27 = llvm.bitcast %2 : vector<4xi8> to i32
    %28 = llvm.bitcast %2 : vector<4xi8> to i32
    %29 = rocdl.wmma.f32.16x16x16.fp8_fp8 %27, %28, %arg3 : (i32, i32, vector<4xf32>) -> vector<4xf32>
    %30 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %31 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %32 = rocdl.wmma.f32.16x16x16.fp8_bf8 %30, %31, %arg2 : (vector<2xi32>, vector<2xi32>, vector<8xf32>) -> vector<8xf32>
    %33 = llvm.bitcast %2 : vector<4xi8> to i32
    %34 = llvm.bitcast %0 : vector<4xi8> to i32
    %35 = rocdl.wmma.f32.16x16x16.fp8_bf8 %33, %34, %arg3 : (i32, i32, vector<4xf32>) -> vector<4xf32>
    %36 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %37 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %38 = rocdl.wmma.f32.16x16x16.bf8_bf8 %36, %37, %arg2 : (vector<2xi32>, vector<2xi32>, vector<8xf32>) -> vector<8xf32>
    %39 = llvm.bitcast %0 : vector<4xi8> to i32
    %40 = llvm.bitcast %0 : vector<4xi8> to i32
    %41 = rocdl.wmma.f32.16x16x16.bf8_bf8 %39, %40, %arg3 : (i32, i32, vector<4xf32>) -> vector<4xf32>
    %42 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %43 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %44 = rocdl.wmma.f32.16x16x16.bf8_fp8 %42, %43, %arg2 : (vector<2xi32>, vector<2xi32>, vector<8xf32>) -> vector<8xf32>
    %45 = llvm.bitcast %0 : vector<4xi8> to i32
    %46 = llvm.bitcast %2 : vector<4xi8> to i32
    %47 = rocdl.wmma.f32.16x16x16.bf8_fp8 %45, %46, %arg3 : (i32, i32, vector<4xf32>) -> vector<4xf32>
    %48 = llvm.bitcast %arg10 : vector<8xi8> to vector<2xi32>
    %49 = llvm.bitcast %arg10 : vector<8xi8> to vector<2xi32>
    %50 = rocdl.wmma.i32.16x16x16.iu8 %48, %49, %arg12 {clamp = true, signA = true, signB = true} : (vector<2xi32>, vector<2xi32>, vector<8xi32>) -> vector<8xi32>
    %51 = llvm.bitcast %arg11 : vector<4xi8> to i32
    %52 = llvm.bitcast %arg11 : vector<4xi8> to i32
    %53 = rocdl.wmma.i32.16x16x16.iu8 %51, %52, %arg13 {clamp = true} : (i32, i32, vector<4xi32>) -> vector<4xi32>
    %54 = llvm.bitcast %arg14 : vector<16xi4> to vector<2xi32>
    %55 = llvm.bitcast %arg14 : vector<16xi4> to vector<2xi32>
    %56 = rocdl.wmma.i32.16x16x32.iu4 %54, %55, %arg12 {clamp = true, signA = true, signB = true} : (vector<2xi32>, vector<2xi32>, vector<8xi32>) -> vector<8xi32>
    %57 = llvm.bitcast %arg15 : vector<8xi4> to i32
    %58 = llvm.bitcast %arg15 : vector<8xi4> to i32
    %59 = rocdl.wmma.i32.16x16x32.iu4 %57, %58, %arg13 {clamp = true, signA = true, signB = true} : (i32, i32, vector<4xi32>) -> vector<4xi32>
    %60 = llvm.bitcast %arg15 : vector<8xi4> to i32
    %61 = llvm.bitcast %arg15 : vector<8xi4> to i32
    %62 = rocdl.wmma.i32.16x16x16.iu4 %60, %61, %arg12 {clamp = true, signA = true, signB = true} : (i32, i32, vector<8xi32>) -> vector<8xi32>
    %63 = llvm.bitcast %arg16 : vector<4xi4> to i16
    %64 = llvm.zext %63 : i16 to i32
    %65 = llvm.bitcast %arg16 : vector<4xi4> to i16
    %66 = llvm.zext %65 : i16 to i32
    %67 = rocdl.wmma.i32.16x16x16.iu4 %64, %66, %arg13 {clamp = true, signA = true, signB = true} : (i32, i32, vector<4xi32>) -> vector<4xi32>
    return
  }
}

// -----
