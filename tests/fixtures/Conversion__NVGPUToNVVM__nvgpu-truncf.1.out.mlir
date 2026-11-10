module {
  func.func @cvt_float_f32_to_f16(%arg0: vector<4xf32>) {
    return
  }
  func.func @cvt_float_f32_to_f16_v8(%arg0: vector<8xf32>) {
    return
  }
  func.func @cvt_float_f32_to_bf16(%arg0: vector<4xf32>) {
    return
  }
  func.func @cvt_float_f32_to_e4m3(%arg0: vector<8xf32>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %9 = llvm.extractelement %8[%6 : i64] : vector<8xi32>
    %10 = llvm.extractelement %8[%5 : i64] : vector<8xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f8x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %14 = llvm.extractelement %8[%7 : i64] : vector<8xi32>
    %15 = llvm.extractelement %8[%4 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f8x2 %17, %16 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %19 = llvm.extractelement %8[%3 : i64] : vector<8xi32>
    %20 = llvm.extractelement %8[%2 : i64] : vector<8xi32>
    %21 = llvm.bitcast %19 : i32 to f32
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = nvvm.convert.f32x2.to.f8x2 %22, %21 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %24 = llvm.extractelement %8[%1 : i64] : vector<8xi32>
    %25 = llvm.extractelement %8[%0 : i64] : vector<8xi32>
    %26 = llvm.bitcast %24 : i32 to f32
    %27 = llvm.bitcast %25 : i32 to f32
    %28 = nvvm.convert.f32x2.to.f8x2 %27, %26 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    return
  }
  func.func @cvt_float_f16_to_e2m3(%arg0: vector<8xf16>) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.bitcast %arg0 : vector<8xf16> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xf16>
    %7 = nvvm.convert.f16x2.to.f6x2 %6 : vector<2xf16> -> i16(f6E2M3FN)
    %8 = llvm.extractelement %4[%3 : i64] : vector<4xi32>
    %9 = llvm.bitcast %8 : i32 to vector<2xf16>
    %10 = nvvm.convert.f16x2.to.f6x2 %9 : vector<2xf16> -> i16(f6E2M3FN)
    %11 = llvm.extractelement %4[%1 : i64] : vector<4xi32>
    %12 = llvm.bitcast %11 : i32 to vector<2xf16>
    %13 = nvvm.convert.f16x2.to.f6x2 %12 : vector<2xf16> -> i16(f6E2M3FN)
    %14 = llvm.extractelement %4[%0 : i64] : vector<4xi32>
    %15 = llvm.bitcast %14 : i32 to vector<2xf16>
    %16 = nvvm.convert.f16x2.to.f6x2 %15 : vector<2xf16> -> i16(f6E2M3FN)
    return
  }
  func.func @cvt_float_bf16_to_e3m2(%arg0: vector<8xbf16>) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.bitcast %arg0 : vector<8xbf16> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xbf16>
    %7 = nvvm.convert.bf16x2.to.f6x2 %6 : vector<2xbf16> -> i16(f6E3M2FN)
    %8 = llvm.extractelement %4[%3 : i64] : vector<4xi32>
    %9 = llvm.bitcast %8 : i32 to vector<2xbf16>
    %10 = nvvm.convert.bf16x2.to.f6x2 %9 : vector<2xbf16> -> i16(f6E3M2FN)
    %11 = llvm.extractelement %4[%1 : i64] : vector<4xi32>
    %12 = llvm.bitcast %11 : i32 to vector<2xbf16>
    %13 = nvvm.convert.bf16x2.to.f6x2 %12 : vector<2xbf16> -> i16(f6E3M2FN)
    %14 = llvm.extractelement %4[%0 : i64] : vector<4xi32>
    %15 = llvm.bitcast %14 : i32 to vector<2xbf16>
    %16 = nvvm.convert.bf16x2.to.f6x2 %15 : vector<2xbf16> -> i16(f6E3M2FN)
    return
  }
  func.func @cvt_float_f32_to_e2m3(%arg0: vector<8xf32>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %9 = llvm.extractelement %8[%6 : i64] : vector<8xi32>
    %10 = llvm.extractelement %8[%5 : i64] : vector<8xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f6x2 %12, %11 : i16(f6E2M3FN)
    %14 = llvm.extractelement %8[%7 : i64] : vector<8xi32>
    %15 = llvm.extractelement %8[%4 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f6x2 %17, %16 : i16(f6E2M3FN)
    %19 = llvm.extractelement %8[%3 : i64] : vector<8xi32>
    %20 = llvm.extractelement %8[%2 : i64] : vector<8xi32>
    %21 = llvm.bitcast %19 : i32 to f32
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = nvvm.convert.f32x2.to.f6x2 %22, %21 : i16(f6E2M3FN)
    %24 = llvm.extractelement %8[%1 : i64] : vector<8xi32>
    %25 = llvm.extractelement %8[%0 : i64] : vector<8xi32>
    %26 = llvm.bitcast %24 : i32 to f32
    %27 = llvm.bitcast %25 : i32 to f32
    %28 = nvvm.convert.f32x2.to.f6x2 %27, %26 : i16(f6E2M3FN)
    return
  }
  func.func @cvt_float_f32_to_e8m0_rz(%arg0: vector<8xf32>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %9 = llvm.extractelement %8[%6 : i64] : vector<8xi32>
    %10 = llvm.extractelement %8[%5 : i64] : vector<8xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f8x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %14 = llvm.extractelement %8[%7 : i64] : vector<8xi32>
    %15 = llvm.extractelement %8[%4 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f8x2 %17, %16 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %19 = llvm.extractelement %8[%3 : i64] : vector<8xi32>
    %20 = llvm.extractelement %8[%2 : i64] : vector<8xi32>
    %21 = llvm.bitcast %19 : i32 to f32
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = nvvm.convert.f32x2.to.f8x2 %22, %21 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %24 = llvm.extractelement %8[%1 : i64] : vector<8xi32>
    %25 = llvm.extractelement %8[%0 : i64] : vector<8xi32>
    %26 = llvm.bitcast %24 : i32 to f32
    %27 = llvm.bitcast %25 : i32 to f32
    %28 = nvvm.convert.f32x2.to.f8x2 %27, %26 {rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    return
  }
  func.func @cvt_float_f32_to_e8m0_rp(%arg0: vector<8xf32>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %9 = llvm.extractelement %8[%6 : i64] : vector<8xi32>
    %10 = llvm.extractelement %8[%5 : i64] : vector<8xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f8x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %14 = llvm.extractelement %8[%7 : i64] : vector<8xi32>
    %15 = llvm.extractelement %8[%4 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f8x2 %17, %16 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %19 = llvm.extractelement %8[%3 : i64] : vector<8xi32>
    %20 = llvm.extractelement %8[%2 : i64] : vector<8xi32>
    %21 = llvm.bitcast %19 : i32 to f32
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = nvvm.convert.f32x2.to.f8x2 %22, %21 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    %24 = llvm.extractelement %8[%1 : i64] : vector<8xi32>
    %25 = llvm.extractelement %8[%0 : i64] : vector<8xi32>
    %26 = llvm.bitcast %24 : i32 to f32
    %27 = llvm.bitcast %25 : i32 to f32
    %28 = nvvm.convert.f32x2.to.f8x2 %27, %26 {rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E8M0FNU)
    return
  }
  func.func @fptrunc_scalar_f32_to_f16(%arg0: f32) -> f16 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<1xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %3 = llvm.mlir.poison : vector<1xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %arg0, %3[%4 : i32] : vector<1xf32>
    %6 = llvm.shufflevector %5, %5 [0, 0] : vector<1xf32> 
    %7 = llvm.shufflevector %6, %cst [0, 3] : vector<2xf32> 
    %8 = llvm.bitcast %7 : vector<2xf32> to vector<2xi32>
    %9 = llvm.extractelement %8[%1 : i64] : vector<2xi32>
    %10 = llvm.extractelement %8[%0 : i64] : vector<2xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f16x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %14 = llvm.bitcast %13 : vector<2xf16> to i32
    %15 = llvm.insertelement %14, %2[%1 : i64] : vector<1xi32>
    %16 = llvm.bitcast %15 : vector<1xi32> to vector<2xf16>
    %17 = llvm.mlir.constant(0 : i64) : i64
    %18 = llvm.extractelement %16[%17 : i64] : vector<2xf16>
    return %18 : f16
  }
  func.func @fptrunc_scalar_f32_to_bf16(%arg0: f32) -> bf16 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<1xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %3 = llvm.mlir.poison : vector<1xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %arg0, %3[%4 : i32] : vector<1xf32>
    %6 = llvm.shufflevector %5, %5 [0, 0] : vector<1xf32> 
    %7 = llvm.shufflevector %6, %cst [0, 3] : vector<2xf32> 
    %8 = llvm.bitcast %7 : vector<2xf32> to vector<2xi32>
    %9 = llvm.extractelement %8[%1 : i64] : vector<2xi32>
    %10 = llvm.extractelement %8[%0 : i64] : vector<2xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.bf16x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xbf16>
    %14 = llvm.bitcast %13 : vector<2xbf16> to i32
    %15 = llvm.insertelement %14, %2[%1 : i64] : vector<1xi32>
    %16 = llvm.bitcast %15 : vector<1xi32> to vector<2xbf16>
    %17 = llvm.mlir.constant(0 : i64) : i64
    %18 = llvm.extractelement %16[%17 : i64] : vector<2xbf16>
    return %18 : bf16
  }
  func.func @fptrunc_scalar_f64_to_f32(%arg0: f64) -> f32 {
    %cst = arith.constant dense<0.000000e+00> : vector<2xf64>
    %0 = llvm.mlir.poison : vector<1xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<1xf64>
    %3 = llvm.shufflevector %2, %2 [0, 0] : vector<1xf64> 
    %4 = llvm.shufflevector %3, %cst [0, 3] : vector<2xf64> 
    %5 = llvm.fptrunc %4 : vector<2xf64> to vector<2xf32>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xf32>
    return %7 : f32
  }
  func.func @fptrunc_v2x4_f32_to_f16(%arg0: vector<2x4xf32>) -> vector<2x4xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %1 = ub.poison : vector<2x4xf16>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x4xf16> to !llvm.array<2 x vector<4xf16>>
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.undef : vector<4xi32>
    %12 = ub.poison : vector<8xf32>
    %13 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xf32>> 
    %14 = llvm.shufflevector %13, %13 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf32> 
    %15 = llvm.shufflevector %14, %12 [0, 1, 2, 3, -1, -1, -1, -1] : vector<8xf32> 
    %16 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xf32>> 
    %17 = llvm.shufflevector %16, %16 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf32> 
    %18 = llvm.shufflevector %17, %15 [8, 9, 10, 11, 0, 1, 2, 3] : vector<8xf32> 
    %19 = llvm.bitcast %18 : vector<8xf32> to vector<8xi32>
    %20 = llvm.extractelement %19[%10 : i64] : vector<8xi32>
    %21 = llvm.extractelement %19[%9 : i64] : vector<8xi32>
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = llvm.bitcast %21 : i32 to f32
    %24 = nvvm.convert.f32x2.to.f16x2 %23, %22 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %25 = llvm.bitcast %24 : vector<2xf16> to i32
    %26 = llvm.insertelement %25, %11[%10 : i64] : vector<4xi32>
    %27 = llvm.extractelement %19[%8 : i64] : vector<8xi32>
    %28 = llvm.extractelement %19[%7 : i64] : vector<8xi32>
    %29 = llvm.bitcast %27 : i32 to f32
    %30 = llvm.bitcast %28 : i32 to f32
    %31 = nvvm.convert.f32x2.to.f16x2 %30, %29 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %32 = llvm.bitcast %31 : vector<2xf16> to i32
    %33 = llvm.insertelement %32, %26[%9 : i64] : vector<4xi32>
    %34 = llvm.extractelement %19[%6 : i64] : vector<8xi32>
    %35 = llvm.extractelement %19[%5 : i64] : vector<8xi32>
    %36 = llvm.bitcast %34 : i32 to f32
    %37 = llvm.bitcast %35 : i32 to f32
    %38 = nvvm.convert.f32x2.to.f16x2 %37, %36 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %39 = llvm.bitcast %38 : vector<2xf16> to i32
    %40 = llvm.insertelement %39, %33[%8 : i64] : vector<4xi32>
    %41 = llvm.extractelement %19[%4 : i64] : vector<8xi32>
    %42 = llvm.extractelement %19[%3 : i64] : vector<8xi32>
    %43 = llvm.bitcast %41 : i32 to f32
    %44 = llvm.bitcast %42 : i32 to f32
    %45 = nvvm.convert.f32x2.to.f16x2 %44, %43 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %46 = llvm.bitcast %45 : vector<2xf16> to i32
    %47 = llvm.insertelement %46, %40[%7 : i64] : vector<4xi32>
    %48 = llvm.bitcast %47 : vector<4xi32> to vector<8xf16>
    %49 = llvm.shufflevector %48, %48 [0, 1, 2, 3] : vector<8xf16> 
    %50 = llvm.insertvalue %49, %2[0] : !llvm.array<2 x vector<4xf16>> 
    %51 = llvm.shufflevector %48, %48 [4, 5, 6, 7] : vector<8xf16> 
    %52 = llvm.insertvalue %51, %50[1] : !llvm.array<2 x vector<4xf16>> 
    %53 = builtin.unrealized_conversion_cast %52 : !llvm.array<2 x vector<4xf16>> to vector<2x4xf16>
    return %53 : vector<2x4xf16>
  }
  func.func @fptrunc_v4x2_f32_to_f8(%arg0: vector<4x2xf32>) -> vector<4x2xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4x2xf32> to !llvm.array<4 x vector<2xf32>>
    %1 = ub.poison : vector<4x2xf8E4M3FN>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4x2xf8E4M3FN> to !llvm.array<4 x vector<2xi8>>
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(7 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.mlir.constant(2 : i64) : i64
    %10 = llvm.mlir.undef : vector<2xi16>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.undef : vector<2xi32>
    %13 = ub.poison : vector<8xf32>
    %14 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<2xf32>> 
    %15 = llvm.shufflevector %14, %14 [0, 1, 0, 0, 0, 0, 0, 0] : vector<2xf32> 
    %16 = llvm.shufflevector %15, %13 [0, 1, -1, -1, -1, -1, -1, -1] : vector<8xf32> 
    %17 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<2xf32>> 
    %18 = llvm.shufflevector %17, %17 [0, 1, 0, 0, 0, 0, 0, 0] : vector<2xf32> 
    %19 = llvm.shufflevector %18, %16 [8, 9, 0, 1, 12, 13, 14, 15] : vector<8xf32> 
    %20 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<2xf32>> 
    %21 = llvm.shufflevector %20, %20 [0, 1, 0, 0, 0, 0, 0, 0] : vector<2xf32> 
    %22 = llvm.shufflevector %21, %19 [8, 9, 10, 11, 0, 1, 14, 15] : vector<8xf32> 
    %23 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<2xf32>> 
    %24 = llvm.shufflevector %23, %23 [0, 1, 0, 0, 0, 0, 0, 0] : vector<2xf32> 
    %25 = llvm.shufflevector %24, %22 [8, 9, 10, 11, 12, 13, 0, 1] : vector<8xf32> 
    %26 = llvm.bitcast %25 : vector<8xf32> to vector<8xi32>
    %27 = llvm.extractelement %26[%9 : i64] : vector<8xi32>
    %28 = llvm.extractelement %26[%8 : i64] : vector<8xi32>
    %29 = llvm.bitcast %27 : i32 to f32
    %30 = llvm.bitcast %28 : i32 to f32
    %31 = nvvm.convert.f32x2.to.f8x2 %30, %29 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %32 = llvm.insertelement %31, %10[%7 : i64] : vector<2xi16>
    %33 = llvm.extractelement %26[%11 : i64] : vector<8xi32>
    %34 = llvm.extractelement %26[%7 : i64] : vector<8xi32>
    %35 = llvm.bitcast %33 : i32 to f32
    %36 = llvm.bitcast %34 : i32 to f32
    %37 = nvvm.convert.f32x2.to.f8x2 %36, %35 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %38 = llvm.insertelement %37, %32[%11 : i64] : vector<2xi16>
    %39 = llvm.bitcast %38 : vector<2xi16> to i32
    %40 = llvm.insertelement %39, %12[%11 : i64] : vector<2xi32>
    %41 = llvm.extractelement %26[%6 : i64] : vector<8xi32>
    %42 = llvm.extractelement %26[%5 : i64] : vector<8xi32>
    %43 = llvm.bitcast %41 : i32 to f32
    %44 = llvm.bitcast %42 : i32 to f32
    %45 = nvvm.convert.f32x2.to.f8x2 %44, %43 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %46 = llvm.insertelement %45, %10[%7 : i64] : vector<2xi16>
    %47 = llvm.extractelement %26[%4 : i64] : vector<8xi32>
    %48 = llvm.extractelement %26[%3 : i64] : vector<8xi32>
    %49 = llvm.bitcast %47 : i32 to f32
    %50 = llvm.bitcast %48 : i32 to f32
    %51 = nvvm.convert.f32x2.to.f8x2 %50, %49 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %52 = llvm.insertelement %51, %46[%11 : i64] : vector<2xi16>
    %53 = llvm.bitcast %52 : vector<2xi16> to i32
    %54 = llvm.insertelement %53, %40[%7 : i64] : vector<2xi32>
    %55 = llvm.bitcast %54 : vector<2xi32> to vector<8xi8>
    %56 = builtin.unrealized_conversion_cast %55 : vector<8xi8> to vector<8xf8E4M3FN>
    %57 = llvm.shufflevector %55, %55 [0, 1] : vector<8xi8> 
    %58 = llvm.insertvalue %57, %2[0] : !llvm.array<4 x vector<2xi8>> 
    %59 = llvm.shufflevector %55, %55 [2, 3] : vector<8xi8> 
    %60 = llvm.insertvalue %59, %58[1] : !llvm.array<4 x vector<2xi8>> 
    %61 = llvm.shufflevector %55, %55 [4, 5] : vector<8xi8> 
    %62 = llvm.insertvalue %61, %60[2] : !llvm.array<4 x vector<2xi8>> 
    %63 = llvm.shufflevector %55, %55 [6, 7] : vector<8xi8> 
    %64 = llvm.insertvalue %63, %62[3] : !llvm.array<4 x vector<2xi8>> 
    %65 = builtin.unrealized_conversion_cast %64 : !llvm.array<4 x vector<2xi8>> to vector<4x2xf8E4M3FN>
    return %65 : vector<4x2xf8E4M3FN>
  }
  func.func @fptrunc_v1f32_to_v1f16(%arg0: vector<1xf32>) -> vector<1xf16> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<1xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %3 = llvm.shufflevector %arg0, %arg0 [0, 0] : vector<1xf32> 
    %4 = llvm.shufflevector %3, %cst [0, 3] : vector<2xf32> 
    %5 = llvm.bitcast %4 : vector<2xf32> to vector<2xi32>
    %6 = llvm.extractelement %5[%1 : i64] : vector<2xi32>
    %7 = llvm.extractelement %5[%0 : i64] : vector<2xi32>
    %8 = llvm.bitcast %6 : i32 to f32
    %9 = llvm.bitcast %7 : i32 to f32
    %10 = nvvm.convert.f32x2.to.f16x2 %9, %8 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.insertelement %11, %2[%1 : i64] : vector<1xi32>
    %13 = llvm.bitcast %12 : vector<1xi32> to vector<2xf16>
    %14 = llvm.shufflevector %13, %13 [0] : vector<2xf16> 
    return %14 : vector<1xf16>
  }
  func.func @fptrunc_v3f16_to_v3f8(%arg0: vector<3xf16>) -> vector<3xf8E4M3FN> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.undef : vector<2xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<1xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf16>
    %4 = llvm.shufflevector %arg0, %arg0 [0, 1, 2, 0] : vector<3xf16> 
    %5 = llvm.shufflevector %4, %cst [0, 1, 2, 7] : vector<4xf16> 
    %6 = llvm.bitcast %5 : vector<4xf16> to vector<2xi32>
    %7 = llvm.extractelement %6[%0 : i64] : vector<2xi32>
    %8 = llvm.bitcast %7 : i32 to vector<2xf16>
    %9 = nvvm.convert.f16x2.to.f8x2 %8 : vector<2xf16> -> i16(f8E4M3FN)
    %10 = llvm.insertelement %9, %1[%0 : i64] : vector<2xi16>
    %11 = llvm.extractelement %6[%2 : i64] : vector<2xi32>
    %12 = llvm.bitcast %11 : i32 to vector<2xf16>
    %13 = nvvm.convert.f16x2.to.f8x2 %12 : vector<2xf16> -> i16(f8E4M3FN)
    %14 = llvm.insertelement %13, %10[%2 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : vector<2xi16> to i32
    %16 = llvm.insertelement %15, %3[%2 : i64] : vector<1xi32>
    %17 = llvm.bitcast %16 : vector<1xi32> to vector<4xi8>
    %18 = builtin.unrealized_conversion_cast %17 : vector<4xi8> to vector<4xf8E4M3FN>
    %19 = llvm.shufflevector %17, %17 [0, 1, 2] : vector<4xi8> 
    %20 = builtin.unrealized_conversion_cast %19 : vector<3xi8> to vector<3xf8E4M3FN>
    return %20 : vector<3xf8E4M3FN>
  }
  func.func @fptrunc_v3x1_f32_to_f16(%arg0: vector<3x1xf32>) -> vector<3x1xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3x1xf32> to !llvm.array<3 x vector<1xf32>>
    %1 = ub.poison : vector<3x1xf16>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x1xf16> to !llvm.array<3 x vector<1xf16>>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %8 = ub.poison : vector<3xf32>
    %9 = llvm.extractvalue %0[0] : !llvm.array<3 x vector<1xf32>> 
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.extractelement %9[%10 : i64] : vector<1xf32>
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %8[%12 : i64] : vector<3xf32>
    %14 = llvm.extractvalue %0[1] : !llvm.array<3 x vector<1xf32>> 
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.extractelement %14[%15 : i64] : vector<1xf32>
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.insertelement %16, %13[%17 : i64] : vector<3xf32>
    %19 = llvm.extractvalue %0[2] : !llvm.array<3 x vector<1xf32>> 
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.extractelement %19[%20 : i64] : vector<1xf32>
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.insertelement %21, %18[%22 : i64] : vector<3xf32>
    %24 = llvm.shufflevector %23, %23 [0, 1, 2, 0] : vector<3xf32> 
    %25 = llvm.shufflevector %24, %cst [0, 1, 2, 7] : vector<4xf32> 
    %26 = llvm.bitcast %25 : vector<4xf32> to vector<4xi32>
    %27 = llvm.extractelement %26[%6 : i64] : vector<4xi32>
    %28 = llvm.extractelement %26[%5 : i64] : vector<4xi32>
    %29 = llvm.bitcast %27 : i32 to f32
    %30 = llvm.bitcast %28 : i32 to f32
    %31 = nvvm.convert.f32x2.to.f16x2 %30, %29 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %32 = llvm.bitcast %31 : vector<2xf16> to i32
    %33 = llvm.insertelement %32, %7[%6 : i64] : vector<2xi32>
    %34 = llvm.extractelement %26[%4 : i64] : vector<4xi32>
    %35 = llvm.extractelement %26[%3 : i64] : vector<4xi32>
    %36 = llvm.bitcast %34 : i32 to f32
    %37 = llvm.bitcast %35 : i32 to f32
    %38 = nvvm.convert.f32x2.to.f16x2 %37, %36 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %39 = llvm.bitcast %38 : vector<2xf16> to i32
    %40 = llvm.insertelement %39, %33[%5 : i64] : vector<2xi32>
    %41 = llvm.bitcast %40 : vector<2xi32> to vector<4xf16>
    %42 = llvm.mlir.constant(0 : i64) : i64
    %43 = llvm.extractelement %41[%42 : i64] : vector<4xf16>
    %44 = llvm.extractvalue %2[0] : !llvm.array<3 x vector<1xf16>> 
    %45 = llvm.mlir.constant(0 : i64) : i64
    %46 = llvm.insertelement %43, %44[%45 : i64] : vector<1xf16>
    %47 = llvm.insertvalue %46, %2[0] : !llvm.array<3 x vector<1xf16>> 
    %48 = llvm.mlir.constant(1 : i64) : i64
    %49 = llvm.extractelement %41[%48 : i64] : vector<4xf16>
    %50 = llvm.extractvalue %47[1] : !llvm.array<3 x vector<1xf16>> 
    %51 = llvm.mlir.constant(0 : i64) : i64
    %52 = llvm.insertelement %49, %50[%51 : i64] : vector<1xf16>
    %53 = llvm.insertvalue %52, %47[1] : !llvm.array<3 x vector<1xf16>> 
    %54 = llvm.mlir.constant(2 : i64) : i64
    %55 = llvm.extractelement %41[%54 : i64] : vector<4xf16>
    %56 = llvm.extractvalue %53[2] : !llvm.array<3 x vector<1xf16>> 
    %57 = llvm.mlir.constant(0 : i64) : i64
    %58 = llvm.insertelement %55, %56[%57 : i64] : vector<1xf16>
    %59 = llvm.insertvalue %58, %53[2] : !llvm.array<3 x vector<1xf16>> 
    %60 = builtin.unrealized_conversion_cast %59 : !llvm.array<3 x vector<1xf16>> to vector<3x1xf16>
    return %60 : vector<3x1xf16>
  }
  func.func @fptrunc_f64_to_f32(%arg0: vector<4xf64>) -> vector<4xf32> {
    %0 = llvm.fptrunc %arg0 : vector<4xf64> to vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @fptrunc_f64_to_f16(%arg0: vector<2xf64>) -> vector<2xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf64>
    %0 = llvm.shufflevector %arg0, %arg0 [0, 1, 0, 0] : vector<2xf64> 
    %1 = llvm.shufflevector %0, %cst [0, 1, 6, 7] : vector<4xf64> 
    %2 = llvm.fptrunc %1 : vector<4xf64> to vector<4xf16>
    %3 = llvm.shufflevector %2, %2 [0, 1] : vector<4xf16> 
    return %3 : vector<2xf16>
  }
  func.func @fptrunc_f64_to_bf16(%arg0: vector<2xf64>) -> vector<2xbf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf64>
    %0 = llvm.shufflevector %arg0, %arg0 [0, 1, 0, 0] : vector<2xf64> 
    %1 = llvm.shufflevector %0, %cst [0, 1, 6, 7] : vector<4xf64> 
    %2 = llvm.fptrunc %1 : vector<4xf64> to vector<4xbf16>
    %3 = llvm.shufflevector %2, %2 [0, 1] : vector<4xbf16> 
    return %3 : vector<2xbf16>
  }
  func.func @fptrunc_f64_to_f8(%arg0: vector<4xf64>) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.undef : vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<8xf64>
    %10 = llvm.shufflevector %arg0, %arg0 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf64> 
    %11 = llvm.shufflevector %10, %cst [0, 1, 2, 3, 12, 13, 14, 15] : vector<8xf64> 
    %12 = llvm.fptrunc %11 : vector<8xf64> to vector<8xf32>
    %13 = llvm.bitcast %12 : vector<8xf32> to vector<8xi32>
    %14 = llvm.extractelement %13[%6 : i64] : vector<8xi32>
    %15 = llvm.extractelement %13[%5 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f8x2 %17, %16 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %19 = llvm.insertelement %18, %7[%4 : i64] : vector<2xi16>
    %20 = llvm.extractelement %13[%8 : i64] : vector<8xi32>
    %21 = llvm.extractelement %13[%4 : i64] : vector<8xi32>
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = llvm.bitcast %21 : i32 to f32
    %24 = nvvm.convert.f32x2.to.f8x2 %23, %22 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %25 = llvm.insertelement %24, %19[%8 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : vector<2xi16> to i32
    %27 = llvm.insertelement %26, %9[%8 : i64] : vector<2xi32>
    %28 = llvm.extractelement %13[%3 : i64] : vector<8xi32>
    %29 = llvm.extractelement %13[%2 : i64] : vector<8xi32>
    %30 = llvm.bitcast %28 : i32 to f32
    %31 = llvm.bitcast %29 : i32 to f32
    %32 = nvvm.convert.f32x2.to.f8x2 %31, %30 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %33 = llvm.insertelement %32, %7[%4 : i64] : vector<2xi16>
    %34 = llvm.extractelement %13[%1 : i64] : vector<8xi32>
    %35 = llvm.extractelement %13[%0 : i64] : vector<8xi32>
    %36 = llvm.bitcast %34 : i32 to f32
    %37 = llvm.bitcast %35 : i32 to f32
    %38 = nvvm.convert.f32x2.to.f8x2 %37, %36 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %39 = llvm.insertelement %38, %33[%8 : i64] : vector<2xi16>
    %40 = llvm.bitcast %39 : vector<2xi16> to i32
    %41 = llvm.insertelement %40, %27[%4 : i64] : vector<2xi32>
    %42 = llvm.bitcast %41 : vector<2xi32> to vector<8xi8>
    %43 = builtin.unrealized_conversion_cast %42 : vector<8xi8> to vector<8xf8E4M3FN>
    %44 = llvm.shufflevector %42, %42 [0, 1, 2, 3] : vector<8xi8> 
    %45 = builtin.unrealized_conversion_cast %44 : vector<4xi8> to vector<4xf8E4M3FN>
    return %45 : vector<4xf8E4M3FN>
  }
  func.func @fptrunc_f32_to_f8_satfinite(%arg0: vector<8xf32>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %9 = llvm.extractelement %8[%6 : i64] : vector<8xi32>
    %10 = llvm.extractelement %8[%5 : i64] : vector<8xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f8x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %14 = llvm.extractelement %8[%7 : i64] : vector<8xi32>
    %15 = llvm.extractelement %8[%4 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f8x2 %17, %16 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %19 = llvm.extractelement %8[%3 : i64] : vector<8xi32>
    %20 = llvm.extractelement %8[%2 : i64] : vector<8xi32>
    %21 = llvm.bitcast %19 : i32 to f32
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = nvvm.convert.f32x2.to.f8x2 %22, %21 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %24 = llvm.extractelement %8[%1 : i64] : vector<8xi32>
    %25 = llvm.extractelement %8[%0 : i64] : vector<8xi32>
    %26 = llvm.bitcast %24 : i32 to f32
    %27 = llvm.bitcast %25 : i32 to f32
    %28 = nvvm.convert.f32x2.to.f8x2 %27, %26 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    return
  }
  func.func @fptrunc_f32_to_f16_relu(%arg0: vector<4xf32>) {
    return
  }
  func.func @fptrunc_f32_to_f8_default_sat(%arg0: vector<8xf32>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.bitcast %arg0 : vector<8xf32> to vector<8xi32>
    %9 = llvm.extractelement %8[%6 : i64] : vector<8xi32>
    %10 = llvm.extractelement %8[%5 : i64] : vector<8xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f8x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %14 = llvm.extractelement %8[%7 : i64] : vector<8xi32>
    %15 = llvm.extractelement %8[%4 : i64] : vector<8xi32>
    %16 = llvm.bitcast %14 : i32 to f32
    %17 = llvm.bitcast %15 : i32 to f32
    %18 = nvvm.convert.f32x2.to.f8x2 %17, %16 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %19 = llvm.extractelement %8[%3 : i64] : vector<8xi32>
    %20 = llvm.extractelement %8[%2 : i64] : vector<8xi32>
    %21 = llvm.bitcast %19 : i32 to f32
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = nvvm.convert.f32x2.to.f8x2 %22, %21 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    %24 = llvm.extractelement %8[%1 : i64] : vector<8xi32>
    %25 = llvm.extractelement %8[%0 : i64] : vector<8xi32>
    %26 = llvm.bitcast %24 : i32 to f32
    %27 = llvm.bitcast %25 : i32 to f32
    %28 = nvvm.convert.f32x2.to.f8x2 %27, %26 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : i16(f8E4M3FN)
    return
  }
  func.func @fptrunc_f32_to_f16_default_sat(%arg0: vector<4xf32>) {
    return
  }
  func.func @fptrunc_f32_to_f16_explicit_none(%arg0: vector<4xf32>) {
    return
  }
  func.func @fptrunc_f32_to_f16_rs(%arg0: vector<4xf32>, %arg1: i32) {
    return
  }
  func.func @fptrunc_f32_to_bf16_rs(%arg0: vector<4xf32>, %arg1: i32) {
    return
  }
  func.func @fptrunc_f32_to_f16_rz(%arg0: vector<4xf32>) {
    return
  }
  func.func @fptrunc_f32_to_bf16_rz(%arg0: vector<4xf32>) {
    return
  }
  func.func @e2e_scalar_f32_to_f16(%arg0: f32) -> f16 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<1xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<2xf32>
    %3 = llvm.mlir.poison : vector<1xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %arg0, %3[%4 : i32] : vector<1xf32>
    %6 = llvm.shufflevector %5, %5 [0, 0] : vector<1xf32> 
    %7 = llvm.shufflevector %6, %cst [0, 3] : vector<2xf32> 
    %8 = llvm.bitcast %7 : vector<2xf32> to vector<2xi32>
    %9 = llvm.extractelement %8[%1 : i64] : vector<2xi32>
    %10 = llvm.extractelement %8[%0 : i64] : vector<2xi32>
    %11 = llvm.bitcast %9 : i32 to f32
    %12 = llvm.bitcast %10 : i32 to f32
    %13 = nvvm.convert.f32x2.to.f16x2 %12, %11 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %14 = llvm.bitcast %13 : vector<2xf16> to i32
    %15 = llvm.insertelement %14, %2[%1 : i64] : vector<1xi32>
    %16 = llvm.bitcast %15 : vector<1xi32> to vector<2xf16>
    %17 = llvm.mlir.constant(0 : i64) : i64
    %18 = llvm.extractelement %16[%17 : i64] : vector<2xf16>
    return %18 : f16
  }
  func.func @e2e_v2x4_f32_to_f16(%arg0: vector<2x4xf32>) -> vector<2x4xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %1 = ub.poison : vector<2x4xf16>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x4xf16> to !llvm.array<2 x vector<4xf16>>
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.undef : vector<4xi32>
    %12 = ub.poison : vector<8xf32>
    %13 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xf32>> 
    %14 = llvm.shufflevector %13, %13 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf32> 
    %15 = llvm.shufflevector %14, %12 [0, 1, 2, 3, -1, -1, -1, -1] : vector<8xf32> 
    %16 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xf32>> 
    %17 = llvm.shufflevector %16, %16 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xf32> 
    %18 = llvm.shufflevector %17, %15 [8, 9, 10, 11, 0, 1, 2, 3] : vector<8xf32> 
    %19 = llvm.bitcast %18 : vector<8xf32> to vector<8xi32>
    %20 = llvm.extractelement %19[%10 : i64] : vector<8xi32>
    %21 = llvm.extractelement %19[%9 : i64] : vector<8xi32>
    %22 = llvm.bitcast %20 : i32 to f32
    %23 = llvm.bitcast %21 : i32 to f32
    %24 = nvvm.convert.f32x2.to.f16x2 %23, %22 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %25 = llvm.bitcast %24 : vector<2xf16> to i32
    %26 = llvm.insertelement %25, %11[%10 : i64] : vector<4xi32>
    %27 = llvm.extractelement %19[%8 : i64] : vector<8xi32>
    %28 = llvm.extractelement %19[%7 : i64] : vector<8xi32>
    %29 = llvm.bitcast %27 : i32 to f32
    %30 = llvm.bitcast %28 : i32 to f32
    %31 = nvvm.convert.f32x2.to.f16x2 %30, %29 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %32 = llvm.bitcast %31 : vector<2xf16> to i32
    %33 = llvm.insertelement %32, %26[%9 : i64] : vector<4xi32>
    %34 = llvm.extractelement %19[%6 : i64] : vector<8xi32>
    %35 = llvm.extractelement %19[%5 : i64] : vector<8xi32>
    %36 = llvm.bitcast %34 : i32 to f32
    %37 = llvm.bitcast %35 : i32 to f32
    %38 = nvvm.convert.f32x2.to.f16x2 %37, %36 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %39 = llvm.bitcast %38 : vector<2xf16> to i32
    %40 = llvm.insertelement %39, %33[%8 : i64] : vector<4xi32>
    %41 = llvm.extractelement %19[%4 : i64] : vector<8xi32>
    %42 = llvm.extractelement %19[%3 : i64] : vector<8xi32>
    %43 = llvm.bitcast %41 : i32 to f32
    %44 = llvm.bitcast %42 : i32 to f32
    %45 = nvvm.convert.f32x2.to.f16x2 %44, %43 {rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>} : vector<2xf16>
    %46 = llvm.bitcast %45 : vector<2xf16> to i32
    %47 = llvm.insertelement %46, %40[%7 : i64] : vector<4xi32>
    %48 = llvm.bitcast %47 : vector<4xi32> to vector<8xf16>
    %49 = llvm.shufflevector %48, %48 [0, 1, 2, 3] : vector<8xf16> 
    %50 = llvm.insertvalue %49, %2[0] : !llvm.array<2 x vector<4xf16>> 
    %51 = llvm.shufflevector %48, %48 [4, 5, 6, 7] : vector<8xf16> 
    %52 = llvm.insertvalue %51, %50[1] : !llvm.array<2 x vector<4xf16>> 
    %53 = builtin.unrealized_conversion_cast %52 : !llvm.array<2 x vector<4xf16>> to vector<2x4xf16>
    return %53 : vector<2x4xf16>
  }
  func.func @e2e_v3f16_to_v3f8(%arg0: vector<3xf16>) -> vector<3xf8E4M3FN> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.undef : vector<2xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<1xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf16>
    %4 = llvm.shufflevector %arg0, %arg0 [0, 1, 2, 0] : vector<3xf16> 
    %5 = llvm.shufflevector %4, %cst [0, 1, 2, 7] : vector<4xf16> 
    %6 = llvm.bitcast %5 : vector<4xf16> to vector<2xi32>
    %7 = llvm.extractelement %6[%0 : i64] : vector<2xi32>
    %8 = llvm.bitcast %7 : i32 to vector<2xf16>
    %9 = nvvm.convert.f16x2.to.f8x2 %8 : vector<2xf16> -> i16(f8E4M3FN)
    %10 = llvm.insertelement %9, %1[%0 : i64] : vector<2xi16>
    %11 = llvm.extractelement %6[%2 : i64] : vector<2xi32>
    %12 = llvm.bitcast %11 : i32 to vector<2xf16>
    %13 = nvvm.convert.f16x2.to.f8x2 %12 : vector<2xf16> -> i16(f8E4M3FN)
    %14 = llvm.insertelement %13, %10[%2 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : vector<2xi16> to i32
    %16 = llvm.insertelement %15, %3[%2 : i64] : vector<1xi32>
    %17 = llvm.bitcast %16 : vector<1xi32> to vector<4xi8>
    %18 = builtin.unrealized_conversion_cast %17 : vector<4xi8> to vector<4xf8E4M3FN>
    %19 = llvm.shufflevector %17, %17 [0, 1, 2] : vector<4xi8> 
    %20 = builtin.unrealized_conversion_cast %19 : vector<3xi8> to vector<3xf8E4M3FN>
    return %20 : vector<3xf8E4M3FN>
  }
}

