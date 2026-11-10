module {
  func.func @cvt_float_f32_to_f16(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    return
  }
  func.func @cvt_float_f32_to_f16_v8(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<8xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<4xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<4xi32>
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.mlir.constant(4 : i64) : i64
    %24 = llvm.extractelement %0[%23 : i64] : vector<8xi32>
    %25 = llvm.mlir.constant(5 : i64) : i64
    %26 = llvm.extractelement %0[%25 : i64] : vector<8xi32>
    %27 = llvm.bitcast %24 : i32 to f32
    %28 = llvm.bitcast %26 : i32 to f32
    %29 = nvvm.convert.f32x2.to.f16x2 %28, %27 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %30 = llvm.bitcast %29 : vector<2xf16> to i32
    %31 = llvm.insertelement %30, %21[%22 : i64] : vector<4xi32>
    %32 = llvm.mlir.constant(3 : i64) : i64
    %33 = llvm.mlir.constant(6 : i64) : i64
    %34 = llvm.extractelement %0[%33 : i64] : vector<8xi32>
    %35 = llvm.mlir.constant(7 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.bitcast %34 : i32 to f32
    %38 = llvm.bitcast %36 : i32 to f32
    %39 = nvvm.convert.f32x2.to.f16x2 %38, %37 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %40 = llvm.bitcast %39 : vector<2xf16> to i32
    %41 = llvm.insertelement %40, %31[%32 : i64] : vector<4xi32>
    %42 = llvm.bitcast %41 : vector<4xi32> to vector<8xf16>
    return
  }
  func.func @cvt_float_f32_to_bf16(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.bf16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %10 = llvm.bitcast %9 : vector<2xbf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.bf16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %20 = llvm.bitcast %19 : vector<2xbf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xbf16>
    return
  }
  func.func @cvt_float_f32_to_e4m3(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f8x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<2xi16>
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f8x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.insertelement %19, %12[%20 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : vector<2xi16> to i32
    %23 = llvm.insertelement %22, %1[%2 : i64] : vector<2xi32>
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.mlir.undef : vector<2xi16>
    %26 = llvm.mlir.constant(6 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<8xi32>
    %28 = llvm.mlir.constant(7 : i64) : i64
    %29 = llvm.extractelement %0[%28 : i64] : vector<8xi32>
    %30 = llvm.bitcast %27 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f8x2 %31, %30 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %33 = llvm.mlir.constant(1 : i64) : i64
    %34 = llvm.insertelement %32, %25[%33 : i64] : vector<2xi16>
    %35 = llvm.mlir.constant(4 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.mlir.constant(5 : i64) : i64
    %38 = llvm.extractelement %0[%37 : i64] : vector<8xi32>
    %39 = llvm.bitcast %36 : i32 to f32
    %40 = llvm.bitcast %38 : i32 to f32
    %41 = nvvm.convert.f32x2.to.f8x2 %40, %39 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.insertelement %41, %34[%42 : i64] : vector<2xi16>
    %44 = llvm.bitcast %43 : vector<2xi16> to i32
    %45 = llvm.insertelement %44, %23[%24 : i64] : vector<2xi32>
    %46 = llvm.bitcast %45 : vector<2xi32> to vector<8xi8>
    return
  }
  func.func @cvt_float_f16_to_e2m3(%arg0: vector<8xf16>) {
    %0 = llvm.bitcast %arg0 : vector<8xf16> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<4xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xf16>
    %7 = nvvm.convert.f16x2.to.f6x2 %6 : vector<2xf16> -> i16(f6E2M3FN)
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %7, %3[%8 : i64] : vector<2xi16>
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.extractelement %0[%10 : i64] : vector<4xi32>
    %12 = llvm.bitcast %11 : i32 to vector<2xf16>
    %13 = nvvm.convert.f16x2.to.f6x2 %12 : vector<2xf16> -> i16(f6E2M3FN)
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.insertelement %13, %9[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : vector<2xi16> to i32
    %17 = llvm.insertelement %16, %1[%2 : i64] : vector<2xi32>
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.mlir.undef : vector<2xi16>
    %20 = llvm.mlir.constant(3 : i64) : i64
    %21 = llvm.extractelement %0[%20 : i64] : vector<4xi32>
    %22 = llvm.bitcast %21 : i32 to vector<2xf16>
    %23 = nvvm.convert.f16x2.to.f6x2 %22 : vector<2xf16> -> i16(f6E2M3FN)
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.insertelement %23, %19[%24 : i64] : vector<2xi16>
    %26 = llvm.mlir.constant(2 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<4xi32>
    %28 = llvm.bitcast %27 : i32 to vector<2xf16>
    %29 = nvvm.convert.f16x2.to.f6x2 %28 : vector<2xf16> -> i16(f6E2M3FN)
    %30 = llvm.mlir.constant(0 : i64) : i64
    %31 = llvm.insertelement %29, %25[%30 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : vector<2xi16> to i32
    %33 = llvm.insertelement %32, %17[%18 : i64] : vector<2xi32>
    %34 = llvm.bitcast %33 : vector<2xi32> to vector<8xi8>
    %35 = llvm.trunc %34 : vector<8xi8> to vector<8xi6>
    return
  }
  func.func @cvt_float_bf16_to_e3m2(%arg0: vector<8xbf16>) {
    %0 = llvm.bitcast %arg0 : vector<8xbf16> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<4xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xbf16>
    %7 = nvvm.convert.bf16x2.to.f6x2 %6 : vector<2xbf16> -> i16(f6E3M2FN)
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %7, %3[%8 : i64] : vector<2xi16>
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.extractelement %0[%10 : i64] : vector<4xi32>
    %12 = llvm.bitcast %11 : i32 to vector<2xbf16>
    %13 = nvvm.convert.bf16x2.to.f6x2 %12 : vector<2xbf16> -> i16(f6E3M2FN)
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.insertelement %13, %9[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : vector<2xi16> to i32
    %17 = llvm.insertelement %16, %1[%2 : i64] : vector<2xi32>
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.mlir.undef : vector<2xi16>
    %20 = llvm.mlir.constant(3 : i64) : i64
    %21 = llvm.extractelement %0[%20 : i64] : vector<4xi32>
    %22 = llvm.bitcast %21 : i32 to vector<2xbf16>
    %23 = nvvm.convert.bf16x2.to.f6x2 %22 : vector<2xbf16> -> i16(f6E3M2FN)
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.insertelement %23, %19[%24 : i64] : vector<2xi16>
    %26 = llvm.mlir.constant(2 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<4xi32>
    %28 = llvm.bitcast %27 : i32 to vector<2xbf16>
    %29 = nvvm.convert.bf16x2.to.f6x2 %28 : vector<2xbf16> -> i16(f6E3M2FN)
    %30 = llvm.mlir.constant(0 : i64) : i64
    %31 = llvm.insertelement %29, %25[%30 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : vector<2xi16> to i32
    %33 = llvm.insertelement %32, %17[%18 : i64] : vector<2xi32>
    %34 = llvm.bitcast %33 : vector<2xi32> to vector<8xi8>
    %35 = llvm.trunc %34 : vector<8xi8> to vector<8xi6>
    return
  }
  func.func @cvt_float_f32_to_e2m3(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f6x2 %9, %8 : i16(f6E2M3FN)
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<2xi16>
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f6x2 %18, %17 : i16(f6E2M3FN)
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.insertelement %19, %12[%20 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : vector<2xi16> to i32
    %23 = llvm.insertelement %22, %1[%2 : i64] : vector<2xi32>
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.mlir.undef : vector<2xi16>
    %26 = llvm.mlir.constant(6 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<8xi32>
    %28 = llvm.mlir.constant(7 : i64) : i64
    %29 = llvm.extractelement %0[%28 : i64] : vector<8xi32>
    %30 = llvm.bitcast %27 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f6x2 %31, %30 : i16(f6E2M3FN)
    %33 = llvm.mlir.constant(1 : i64) : i64
    %34 = llvm.insertelement %32, %25[%33 : i64] : vector<2xi16>
    %35 = llvm.mlir.constant(4 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.mlir.constant(5 : i64) : i64
    %38 = llvm.extractelement %0[%37 : i64] : vector<8xi32>
    %39 = llvm.bitcast %36 : i32 to f32
    %40 = llvm.bitcast %38 : i32 to f32
    %41 = nvvm.convert.f32x2.to.f6x2 %40, %39 : i16(f6E2M3FN)
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.insertelement %41, %34[%42 : i64] : vector<2xi16>
    %44 = llvm.bitcast %43 : vector<2xi16> to i32
    %45 = llvm.insertelement %44, %23[%24 : i64] : vector<2xi32>
    %46 = llvm.bitcast %45 : vector<2xi32> to vector<8xi8>
    %47 = llvm.trunc %46 : vector<8xi8> to vector<8xi6>
    return
  }
  func.func @cvt_float_f32_to_e8m0_rz(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f8x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<2xi16>
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f8x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.insertelement %19, %12[%20 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : vector<2xi16> to i32
    %23 = llvm.insertelement %22, %1[%2 : i64] : vector<2xi32>
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.mlir.undef : vector<2xi16>
    %26 = llvm.mlir.constant(6 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<8xi32>
    %28 = llvm.mlir.constant(7 : i64) : i64
    %29 = llvm.extractelement %0[%28 : i64] : vector<8xi32>
    %30 = llvm.bitcast %27 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f8x2 %31, %30 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %33 = llvm.mlir.constant(1 : i64) : i64
    %34 = llvm.insertelement %32, %25[%33 : i64] : vector<2xi16>
    %35 = llvm.mlir.constant(4 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.mlir.constant(5 : i64) : i64
    %38 = llvm.extractelement %0[%37 : i64] : vector<8xi32>
    %39 = llvm.bitcast %36 : i32 to f32
    %40 = llvm.bitcast %38 : i32 to f32
    %41 = nvvm.convert.f32x2.to.f8x2 %40, %39 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.insertelement %41, %34[%42 : i64] : vector<2xi16>
    %44 = llvm.bitcast %43 : vector<2xi16> to i32
    %45 = llvm.insertelement %44, %23[%24 : i64] : vector<2xi32>
    %46 = llvm.bitcast %45 : vector<2xi32> to vector<8xi8>
    return
  }
  func.func @cvt_float_f32_to_e8m0_rp(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f8x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<2xi16>
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f8x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.insertelement %19, %12[%20 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : vector<2xi16> to i32
    %23 = llvm.insertelement %22, %1[%2 : i64] : vector<2xi32>
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.mlir.undef : vector<2xi16>
    %26 = llvm.mlir.constant(6 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<8xi32>
    %28 = llvm.mlir.constant(7 : i64) : i64
    %29 = llvm.extractelement %0[%28 : i64] : vector<8xi32>
    %30 = llvm.bitcast %27 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f8x2 %31, %30 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %33 = llvm.mlir.constant(1 : i64) : i64
    %34 = llvm.insertelement %32, %25[%33 : i64] : vector<2xi16>
    %35 = llvm.mlir.constant(4 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.mlir.constant(5 : i64) : i64
    %38 = llvm.extractelement %0[%37 : i64] : vector<8xi32>
    %39 = llvm.bitcast %36 : i32 to f32
    %40 = llvm.bitcast %38 : i32 to f32
    %41 = nvvm.convert.f32x2.to.f8x2 %40, %39 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.insertelement %41, %34[%42 : i64] : vector<2xi16>
    %44 = llvm.bitcast %43 : vector<2xi16> to i32
    %45 = llvm.insertelement %44, %23[%24 : i64] : vector<2xi32>
    %46 = llvm.bitcast %45 : vector<2xi32> to vector<8xi8>
    return
  }
  func.func @fptrunc_scalar_f32_to_f16(%arg0: f32) -> f16 {
    %0 = vector.broadcast %arg0 : f32 to vector<1xf32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf32> into vector<2xf32>
    %2 = llvm.bitcast %1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<1xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %2[%5 : i64] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.extractelement %2[%7 : i64] : vector<2xi32>
    %9 = llvm.bitcast %6 : i32 to f32
    %10 = llvm.bitcast %8 : i32 to f32
    %11 = nvvm.convert.f32x2.to.f16x2 %10, %9 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.insertelement %12, %3[%4 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : vector<1xi32> to vector<2xf16>
    %15 = vector.extract_strided_slice %14 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %16 = vector.extract %15[0] : f16 from vector<1xf16>
    return %16 : f16
  }
  func.func @fptrunc_scalar_f32_to_bf16(%arg0: f32) -> bf16 {
    %0 = vector.broadcast %arg0 : f32 to vector<1xf32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf32> into vector<2xf32>
    %2 = llvm.bitcast %1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<1xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %2[%5 : i64] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.extractelement %2[%7 : i64] : vector<2xi32>
    %9 = llvm.bitcast %6 : i32 to f32
    %10 = llvm.bitcast %8 : i32 to f32
    %11 = nvvm.convert.f32x2.to.bf16x2 %10, %9 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %12 = llvm.bitcast %11 : vector<2xbf16> to i32
    %13 = llvm.insertelement %12, %3[%4 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : vector<1xi32> to vector<2xbf16>
    %15 = vector.extract_strided_slice %14 {offsets = [0], sizes = [1], strides = [1]} : vector<2xbf16> to vector<1xbf16>
    %16 = vector.extract %15[0] : bf16 from vector<1xbf16>
    return %16 : bf16
  }
  func.func @fptrunc_scalar_f64_to_f32(%arg0: f64) -> f32 {
    %0 = vector.broadcast %arg0 : f64 to vector<1xf64>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf64>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf64> into vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    %3 = vector.extract_strided_slice %2 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %4 = vector.extract %3[0] : f32 from vector<1xf32>
    return %4 : f32
  }
  func.func @fptrunc_v2x4_f32_to_f16(%arg0: vector<2x4xf32>) -> vector<2x4xf16> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf32> to vector<8xf32>
    %1 = llvm.bitcast %0 : vector<8xf32> to vector<8xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %1[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.extractelement %1[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f16x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.insertelement %11, %2[%3 : i64] : vector<4xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.extractelement %1[%14 : i64] : vector<8xi32>
    %16 = llvm.mlir.constant(3 : i64) : i64
    %17 = llvm.extractelement %1[%16 : i64] : vector<8xi32>
    %18 = llvm.bitcast %15 : i32 to f32
    %19 = llvm.bitcast %17 : i32 to f32
    %20 = nvvm.convert.f32x2.to.f16x2 %19, %18 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %21 = llvm.bitcast %20 : vector<2xf16> to i32
    %22 = llvm.insertelement %21, %12[%13 : i64] : vector<4xi32>
    %23 = llvm.mlir.constant(2 : i64) : i64
    %24 = llvm.mlir.constant(4 : i64) : i64
    %25 = llvm.extractelement %1[%24 : i64] : vector<8xi32>
    %26 = llvm.mlir.constant(5 : i64) : i64
    %27 = llvm.extractelement %1[%26 : i64] : vector<8xi32>
    %28 = llvm.bitcast %25 : i32 to f32
    %29 = llvm.bitcast %27 : i32 to f32
    %30 = nvvm.convert.f32x2.to.f16x2 %29, %28 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %31 = llvm.bitcast %30 : vector<2xf16> to i32
    %32 = llvm.insertelement %31, %22[%23 : i64] : vector<4xi32>
    %33 = llvm.mlir.constant(3 : i64) : i64
    %34 = llvm.mlir.constant(6 : i64) : i64
    %35 = llvm.extractelement %1[%34 : i64] : vector<8xi32>
    %36 = llvm.mlir.constant(7 : i64) : i64
    %37 = llvm.extractelement %1[%36 : i64] : vector<8xi32>
    %38 = llvm.bitcast %35 : i32 to f32
    %39 = llvm.bitcast %37 : i32 to f32
    %40 = nvvm.convert.f32x2.to.f16x2 %39, %38 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %41 = llvm.bitcast %40 : vector<2xf16> to i32
    %42 = llvm.insertelement %41, %32[%33 : i64] : vector<4xi32>
    %43 = llvm.bitcast %42 : vector<4xi32> to vector<8xf16>
    %44 = vector.shape_cast %43 : vector<8xf16> to vector<2x4xf16>
    return %44 : vector<2x4xf16>
  }
  func.func @fptrunc_v4x2_f32_to_f8(%arg0: vector<4x2xf32>) -> vector<4x2xf8E4M3FN> {
    %0 = vector.shape_cast %arg0 : vector<4x2xf32> to vector<8xf32>
    %1 = llvm.bitcast %0 : vector<8xf32> to vector<8xi32>
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : vector<2xi16>
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.extractelement %1[%5 : i64] : vector<8xi32>
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.extractelement %1[%7 : i64] : vector<8xi32>
    %9 = llvm.bitcast %6 : i32 to f32
    %10 = llvm.bitcast %8 : i32 to f32
    %11 = nvvm.convert.f32x2.to.f8x2 %10, %9 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.insertelement %11, %4[%12 : i64] : vector<2xi16>
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.extractelement %1[%14 : i64] : vector<8xi32>
    %16 = llvm.mlir.constant(1 : i64) : i64
    %17 = llvm.extractelement %1[%16 : i64] : vector<8xi32>
    %18 = llvm.bitcast %15 : i32 to f32
    %19 = llvm.bitcast %17 : i32 to f32
    %20 = nvvm.convert.f32x2.to.f8x2 %19, %18 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %21 = llvm.mlir.constant(0 : i64) : i64
    %22 = llvm.insertelement %20, %13[%21 : i64] : vector<2xi16>
    %23 = llvm.bitcast %22 : vector<2xi16> to i32
    %24 = llvm.insertelement %23, %2[%3 : i64] : vector<2xi32>
    %25 = llvm.mlir.constant(1 : i64) : i64
    %26 = llvm.mlir.undef : vector<2xi16>
    %27 = llvm.mlir.constant(6 : i64) : i64
    %28 = llvm.extractelement %1[%27 : i64] : vector<8xi32>
    %29 = llvm.mlir.constant(7 : i64) : i64
    %30 = llvm.extractelement %1[%29 : i64] : vector<8xi32>
    %31 = llvm.bitcast %28 : i32 to f32
    %32 = llvm.bitcast %30 : i32 to f32
    %33 = nvvm.convert.f32x2.to.f8x2 %32, %31 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %34 = llvm.mlir.constant(1 : i64) : i64
    %35 = llvm.insertelement %33, %26[%34 : i64] : vector<2xi16>
    %36 = llvm.mlir.constant(4 : i64) : i64
    %37 = llvm.extractelement %1[%36 : i64] : vector<8xi32>
    %38 = llvm.mlir.constant(5 : i64) : i64
    %39 = llvm.extractelement %1[%38 : i64] : vector<8xi32>
    %40 = llvm.bitcast %37 : i32 to f32
    %41 = llvm.bitcast %39 : i32 to f32
    %42 = nvvm.convert.f32x2.to.f8x2 %41, %40 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %43 = llvm.mlir.constant(0 : i64) : i64
    %44 = llvm.insertelement %42, %35[%43 : i64] : vector<2xi16>
    %45 = llvm.bitcast %44 : vector<2xi16> to i32
    %46 = llvm.insertelement %45, %24[%25 : i64] : vector<2xi32>
    %47 = llvm.bitcast %46 : vector<2xi32> to vector<8xi8>
    %48 = builtin.unrealized_conversion_cast %47 : vector<8xi8> to vector<8xf8E4M3FN>
    %49 = vector.shape_cast %48 : vector<8xf8E4M3FN> to vector<4x2xf8E4M3FN>
    return %49 : vector<4x2xf8E4M3FN>
  }
  func.func @fptrunc_v1f32_to_v1f16(%arg0: vector<1xf32>) -> vector<1xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<1xf32> into vector<2xf32>
    %1 = llvm.bitcast %0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<1xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %1[%4 : i64] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.extractelement %1[%6 : i64] : vector<2xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f16x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.insertelement %11, %2[%3 : i64] : vector<1xi32>
    %13 = llvm.bitcast %12 : vector<1xi32> to vector<2xf16>
    %14 = vector.extract_strided_slice %13 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    return %14 : vector<1xf16>
  }
  func.func @fptrunc_v3f16_to_v3f8(%arg0: vector<3xf16>) -> vector<3xf8E4M3FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf16>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<3xf16> into vector<4xf16>
    %1 = llvm.bitcast %0 : vector<4xf16> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<1xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %1[%5 : i64] : vector<2xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xf16>
    %8 = nvvm.convert.f16x2.to.f8x2 %7 : vector<2xf16> -> i16(f8E4M3FN)
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.insertelement %8, %4[%9 : i64] : vector<2xi16>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.extractelement %1[%11 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xf16>
    %14 = nvvm.convert.f16x2.to.f8x2 %13 : vector<2xf16> -> i16(f8E4M3FN)
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.insertelement %14, %10[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : vector<2xi16> to i32
    %18 = llvm.insertelement %17, %2[%3 : i64] : vector<1xi32>
    %19 = llvm.bitcast %18 : vector<1xi32> to vector<4xi8>
    %20 = builtin.unrealized_conversion_cast %19 : vector<4xi8> to vector<4xf8E4M3FN>
    %21 = vector.extract_strided_slice %20 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf8E4M3FN> to vector<3xf8E4M3FN>
    return %21 : vector<3xf8E4M3FN>
  }
  func.func @fptrunc_v3x1_f32_to_f16(%arg0: vector<3x1xf32>) -> vector<3x1xf16> {
    %0 = vector.shape_cast %arg0 : vector<3x1xf32> to vector<3xf32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<3xf32> into vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<4xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %2[%5 : i64] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.extractelement %2[%7 : i64] : vector<4xi32>
    %9 = llvm.bitcast %6 : i32 to f32
    %10 = llvm.bitcast %8 : i32 to f32
    %11 = nvvm.convert.f32x2.to.f16x2 %10, %9 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.insertelement %12, %3[%4 : i64] : vector<2xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.mlir.constant(2 : i64) : i64
    %16 = llvm.extractelement %2[%15 : i64] : vector<4xi32>
    %17 = llvm.mlir.constant(3 : i64) : i64
    %18 = llvm.extractelement %2[%17 : i64] : vector<4xi32>
    %19 = llvm.bitcast %16 : i32 to f32
    %20 = llvm.bitcast %18 : i32 to f32
    %21 = nvvm.convert.f32x2.to.f16x2 %20, %19 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %22 = llvm.bitcast %21 : vector<2xf16> to i32
    %23 = llvm.insertelement %22, %13[%14 : i64] : vector<2xi32>
    %24 = llvm.bitcast %23 : vector<2xi32> to vector<4xf16>
    %25 = vector.extract_strided_slice %24 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf16> to vector<3xf16>
    %26 = vector.shape_cast %25 : vector<3xf16> to vector<3x1xf16>
    return %26 : vector<3x1xf16>
  }
  func.func @fptrunc_f64_to_f32(%arg0: vector<4xf64>) -> vector<4xf32> {
    %0 = llvm.fptrunc %arg0 : vector<4xf64> to vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @fptrunc_f64_to_f16(%arg0: vector<2xf64>) -> vector<2xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf64>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<2xf64> into vector<4xf64>
    %1 = llvm.fptrunc %0 : vector<4xf64> to vector<4xf16>
    %2 = vector.extract_strided_slice %1 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf16> to vector<2xf16>
    return %2 : vector<2xf16>
  }
  func.func @fptrunc_f64_to_bf16(%arg0: vector<2xf64>) -> vector<2xbf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf64>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<2xf64> into vector<4xf64>
    %1 = llvm.fptrunc %0 : vector<4xf64> to vector<4xbf16>
    %2 = vector.extract_strided_slice %1 {offsets = [0], sizes = [2], strides = [1]} : vector<4xbf16> to vector<2xbf16>
    return %2 : vector<2xbf16>
  }
  func.func @fptrunc_f64_to_f8(%arg0: vector<4xf64>) -> vector<4xf8E4M3FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<8xf64>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<4xf64> into vector<8xf64>
    %1 = llvm.fptrunc %0 : vector<8xf64> to vector<8xf32>
    %2 = llvm.bitcast %1 : vector<8xf32> to vector<8xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.undef : vector<2xi16>
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.extractelement %2[%6 : i64] : vector<8xi32>
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.extractelement %2[%8 : i64] : vector<8xi32>
    %10 = llvm.bitcast %7 : i32 to f32
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = nvvm.convert.f32x2.to.f8x2 %11, %10 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.insertelement %12, %5[%13 : i64] : vector<2xi16>
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.extractelement %2[%15 : i64] : vector<8xi32>
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.extractelement %2[%17 : i64] : vector<8xi32>
    %19 = llvm.bitcast %16 : i32 to f32
    %20 = llvm.bitcast %18 : i32 to f32
    %21 = nvvm.convert.f32x2.to.f8x2 %20, %19 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %22 = llvm.mlir.constant(0 : i64) : i64
    %23 = llvm.insertelement %21, %14[%22 : i64] : vector<2xi16>
    %24 = llvm.bitcast %23 : vector<2xi16> to i32
    %25 = llvm.insertelement %24, %3[%4 : i64] : vector<2xi32>
    %26 = llvm.mlir.constant(1 : i64) : i64
    %27 = llvm.mlir.undef : vector<2xi16>
    %28 = llvm.mlir.constant(6 : i64) : i64
    %29 = llvm.extractelement %2[%28 : i64] : vector<8xi32>
    %30 = llvm.mlir.constant(7 : i64) : i64
    %31 = llvm.extractelement %2[%30 : i64] : vector<8xi32>
    %32 = llvm.bitcast %29 : i32 to f32
    %33 = llvm.bitcast %31 : i32 to f32
    %34 = nvvm.convert.f32x2.to.f8x2 %33, %32 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %35 = llvm.mlir.constant(1 : i64) : i64
    %36 = llvm.insertelement %34, %27[%35 : i64] : vector<2xi16>
    %37 = llvm.mlir.constant(4 : i64) : i64
    %38 = llvm.extractelement %2[%37 : i64] : vector<8xi32>
    %39 = llvm.mlir.constant(5 : i64) : i64
    %40 = llvm.extractelement %2[%39 : i64] : vector<8xi32>
    %41 = llvm.bitcast %38 : i32 to f32
    %42 = llvm.bitcast %40 : i32 to f32
    %43 = nvvm.convert.f32x2.to.f8x2 %42, %41 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %44 = llvm.mlir.constant(0 : i64) : i64
    %45 = llvm.insertelement %43, %36[%44 : i64] : vector<2xi16>
    %46 = llvm.bitcast %45 : vector<2xi16> to i32
    %47 = llvm.insertelement %46, %25[%26 : i64] : vector<2xi32>
    %48 = llvm.bitcast %47 : vector<2xi32> to vector<8xi8>
    %49 = builtin.unrealized_conversion_cast %48 : vector<8xi8> to vector<8xf8E4M3FN>
    %50 = vector.extract_strided_slice %49 {offsets = [0], sizes = [4], strides = [1]} : vector<8xf8E4M3FN> to vector<4xf8E4M3FN>
    return %50 : vector<4xf8E4M3FN>
  }
  func.func @fptrunc_f32_to_f8_satfinite(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f8x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<2xi16>
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f8x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.insertelement %19, %12[%20 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : vector<2xi16> to i32
    %23 = llvm.insertelement %22, %1[%2 : i64] : vector<2xi32>
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.mlir.undef : vector<2xi16>
    %26 = llvm.mlir.constant(6 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<8xi32>
    %28 = llvm.mlir.constant(7 : i64) : i64
    %29 = llvm.extractelement %0[%28 : i64] : vector<8xi32>
    %30 = llvm.bitcast %27 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f8x2 %31, %30 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %33 = llvm.mlir.constant(1 : i64) : i64
    %34 = llvm.insertelement %32, %25[%33 : i64] : vector<2xi16>
    %35 = llvm.mlir.constant(4 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.mlir.constant(5 : i64) : i64
    %38 = llvm.extractelement %0[%37 : i64] : vector<8xi32>
    %39 = llvm.bitcast %36 : i32 to f32
    %40 = llvm.bitcast %38 : i32 to f32
    %41 = nvvm.convert.f32x2.to.f8x2 %40, %39 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.insertelement %41, %34[%42 : i64] : vector<2xi16>
    %44 = llvm.bitcast %43 : vector<2xi16> to i32
    %45 = llvm.insertelement %44, %23[%24 : i64] : vector<2xi32>
    %46 = llvm.bitcast %45 : vector<2xi32> to vector<8xi8>
    return
  }
  func.func @fptrunc_f32_to_f16_relu(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7 {relu = true, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17 {relu = true, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    return
  }
  func.func @fptrunc_f32_to_f8_default_sat(%arg0: vector<8xf32>) {
    %0 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.extractelement %0[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f8x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<2xi16>
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<8xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<8xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f8x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.insertelement %19, %12[%20 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : vector<2xi16> to i32
    %23 = llvm.insertelement %22, %1[%2 : i64] : vector<2xi32>
    %24 = llvm.mlir.constant(1 : i64) : i64
    %25 = llvm.mlir.undef : vector<2xi16>
    %26 = llvm.mlir.constant(6 : i64) : i64
    %27 = llvm.extractelement %0[%26 : i64] : vector<8xi32>
    %28 = llvm.mlir.constant(7 : i64) : i64
    %29 = llvm.extractelement %0[%28 : i64] : vector<8xi32>
    %30 = llvm.bitcast %27 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f8x2 %31, %30 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %33 = llvm.mlir.constant(1 : i64) : i64
    %34 = llvm.insertelement %32, %25[%33 : i64] : vector<2xi16>
    %35 = llvm.mlir.constant(4 : i64) : i64
    %36 = llvm.extractelement %0[%35 : i64] : vector<8xi32>
    %37 = llvm.mlir.constant(5 : i64) : i64
    %38 = llvm.extractelement %0[%37 : i64] : vector<8xi32>
    %39 = llvm.bitcast %36 : i32 to f32
    %40 = llvm.bitcast %38 : i32 to f32
    %41 = nvvm.convert.f32x2.to.f8x2 %40, %39 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.insertelement %41, %34[%42 : i64] : vector<2xi16>
    %44 = llvm.bitcast %43 : vector<2xi16> to i32
    %45 = llvm.insertelement %44, %23[%24 : i64] : vector<2xi32>
    %46 = llvm.bitcast %45 : vector<2xi32> to vector<8xi8>
    return
  }
  func.func @fptrunc_f32_to_f16_default_sat(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    return
  }
  func.func @fptrunc_f32_to_f16_explicit_none(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rn>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rn>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    return
  }
  func.func @fptrunc_f32_to_f16_rs(%arg0: vector<4xf32>, %arg1: i32) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7, %arg1 {rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17, %arg1 {rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    return
  }
  func.func @fptrunc_f32_to_bf16_rs(%arg0: vector<4xf32>, %arg1: i32) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.bf16x2 %8, %7, %arg1 {rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %10 = llvm.bitcast %9 : vector<2xbf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.bf16x2 %18, %17, %arg1 {rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %20 = llvm.bitcast %19 : vector<2xbf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xbf16>
    return
  }
  func.func @fptrunc_f32_to_f16_rz(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.f16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.f16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    return
  }
  func.func @fptrunc_f32_to_bf16_rz(%arg0: vector<4xf32>) {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.mlir.undef : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %0[%3 : i64] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %0[%5 : i64] : vector<4xi32>
    %7 = llvm.bitcast %4 : i32 to f32
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = nvvm.convert.f32x2.to.bf16x2 %8, %7 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %10 = llvm.bitcast %9 : vector<2xbf16> to i32
    %11 = llvm.insertelement %10, %1[%2 : i64] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %0[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.extractelement %0[%15 : i64] : vector<4xi32>
    %17 = llvm.bitcast %14 : i32 to f32
    %18 = llvm.bitcast %16 : i32 to f32
    %19 = nvvm.convert.f32x2.to.bf16x2 %18, %17 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %20 = llvm.bitcast %19 : vector<2xbf16> to i32
    %21 = llvm.insertelement %20, %11[%12 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xbf16>
    return
  }
  func.func @e2e_scalar_f32_to_f16(%arg0: f32) -> f16 {
    %0 = vector.broadcast %arg0 : f32 to vector<1xf32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf32> into vector<2xf32>
    %2 = llvm.bitcast %1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<1xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %2[%5 : i64] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.extractelement %2[%7 : i64] : vector<2xi32>
    %9 = llvm.bitcast %6 : i32 to f32
    %10 = llvm.bitcast %8 : i32 to f32
    %11 = nvvm.convert.f32x2.to.f16x2 %10, %9 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.insertelement %12, %3[%4 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : vector<1xi32> to vector<2xf16>
    %15 = vector.extract_strided_slice %14 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %16 = vector.extract %15[0] : f16 from vector<1xf16>
    return %16 : f16
  }
  func.func @e2e_v2x4_f32_to_f16(%arg0: vector<2x4xf32>) -> vector<2x4xf16> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf32> to vector<8xf32>
    %1 = llvm.bitcast %0 : vector<8xf32> to vector<8xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %1[%4 : i64] : vector<8xi32>
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.extractelement %1[%6 : i64] : vector<8xi32>
    %8 = llvm.bitcast %5 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f16x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.insertelement %11, %2[%3 : i64] : vector<4xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.extractelement %1[%14 : i64] : vector<8xi32>
    %16 = llvm.mlir.constant(3 : i64) : i64
    %17 = llvm.extractelement %1[%16 : i64] : vector<8xi32>
    %18 = llvm.bitcast %15 : i32 to f32
    %19 = llvm.bitcast %17 : i32 to f32
    %20 = nvvm.convert.f32x2.to.f16x2 %19, %18 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %21 = llvm.bitcast %20 : vector<2xf16> to i32
    %22 = llvm.insertelement %21, %12[%13 : i64] : vector<4xi32>
    %23 = llvm.mlir.constant(2 : i64) : i64
    %24 = llvm.mlir.constant(4 : i64) : i64
    %25 = llvm.extractelement %1[%24 : i64] : vector<8xi32>
    %26 = llvm.mlir.constant(5 : i64) : i64
    %27 = llvm.extractelement %1[%26 : i64] : vector<8xi32>
    %28 = llvm.bitcast %25 : i32 to f32
    %29 = llvm.bitcast %27 : i32 to f32
    %30 = nvvm.convert.f32x2.to.f16x2 %29, %28 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %31 = llvm.bitcast %30 : vector<2xf16> to i32
    %32 = llvm.insertelement %31, %22[%23 : i64] : vector<4xi32>
    %33 = llvm.mlir.constant(3 : i64) : i64
    %34 = llvm.mlir.constant(6 : i64) : i64
    %35 = llvm.extractelement %1[%34 : i64] : vector<8xi32>
    %36 = llvm.mlir.constant(7 : i64) : i64
    %37 = llvm.extractelement %1[%36 : i64] : vector<8xi32>
    %38 = llvm.bitcast %35 : i32 to f32
    %39 = llvm.bitcast %37 : i32 to f32
    %40 = nvvm.convert.f32x2.to.f16x2 %39, %38 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %41 = llvm.bitcast %40 : vector<2xf16> to i32
    %42 = llvm.insertelement %41, %32[%33 : i64] : vector<4xi32>
    %43 = llvm.bitcast %42 : vector<4xi32> to vector<8xf16>
    %44 = vector.shape_cast %43 : vector<8xf16> to vector<2x4xf16>
    return %44 : vector<2x4xf16>
  }
  func.func @e2e_v3f16_to_v3f8(%arg0: vector<3xf16>) -> vector<3xf8E4M3FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf16>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<3xf16> into vector<4xf16>
    %1 = llvm.bitcast %0 : vector<4xf16> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<1xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %1[%5 : i64] : vector<2xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xf16>
    %8 = nvvm.convert.f16x2.to.f8x2 %7 : vector<2xf16> -> i16(f8E4M3FN)
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.insertelement %8, %4[%9 : i64] : vector<2xi16>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.extractelement %1[%11 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xf16>
    %14 = nvvm.convert.f16x2.to.f8x2 %13 : vector<2xf16> -> i16(f8E4M3FN)
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.insertelement %14, %10[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : vector<2xi16> to i32
    %18 = llvm.insertelement %17, %2[%3 : i64] : vector<1xi32>
    %19 = llvm.bitcast %18 : vector<1xi32> to vector<4xi8>
    %20 = builtin.unrealized_conversion_cast %19 : vector<4xi8> to vector<4xf8E4M3FN>
    %21 = vector.extract_strided_slice %20 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf8E4M3FN> to vector<3xf8E4M3FN>
    return %21 : vector<3xf8E4M3FN>
  }
}

