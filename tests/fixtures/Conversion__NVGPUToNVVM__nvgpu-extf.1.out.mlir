module {
  func.func @cvt_float_e4m3fn_to_f16(%arg0: vector<8xf8E4M3FN>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E4M3FN> to vector<8xi8>
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<2xi32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.extractelement %5[%1 : i64] : vector<2xi16>
    %7 = llvm.bitcast %6 : i16 to vector<2xi8>
    %8 = nvvm.convert.f8x2.to.f16x2 %7 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %9 = llvm.extractelement %5[%0 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.extractelement %3[%0 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xi16>
    %14 = llvm.extractelement %13[%1 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %17 = llvm.extractelement %13[%0 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    return
  }
  func.func @cvt_float_e5m2_to_f16(%arg0: vector<8xf8E5M2>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E5M2> to vector<8xi8>
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<2xi32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.extractelement %5[%1 : i64] : vector<2xi16>
    %7 = llvm.bitcast %6 : i16 to vector<2xi8>
    %8 = nvvm.convert.f8x2.to.f16x2 %7 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %9 = llvm.extractelement %5[%0 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %12 = llvm.extractelement %3[%0 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xi16>
    %14 = llvm.extractelement %13[%1 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %17 = llvm.extractelement %13[%0 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    return
  }
  func.func @cvt_float_e8m0_to_bf16(%arg0: vector<8xf8E8M0FNU>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E8M0FNU> to vector<8xi8>
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<2xi32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.extractelement %5[%1 : i64] : vector<2xi16>
    %7 = llvm.bitcast %6 : i16 to vector<2xi8>
    %8 = nvvm.convert.f8x2.to.bf16x2 %7 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %9 = llvm.extractelement %5[%0 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.bf16x2 %10 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %12 = llvm.extractelement %3[%0 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xi16>
    %14 = llvm.extractelement %13[%1 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.bf16x2 %15 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %17 = llvm.extractelement %13[%0 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.bf16x2 %18 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    return
  }
  func.func @cvt_float_e2m3_to_f16(%arg0: vector<8xf6E2M3FN>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf6E2M3FN> to vector<8xi6>
    %3 = llvm.zext %2 : vector<8xi6> to vector<8xi8>
    %4 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %5 = llvm.extractelement %4[%1 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.extractelement %6[%1 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f6x2.to.f16x2 %8 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %10 = llvm.extractelement %6[%0 : i64] : vector<2xi16>
    %11 = llvm.bitcast %10 : i16 to vector<2xi8>
    %12 = nvvm.convert.f6x2.to.f16x2 %11 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %13 = llvm.extractelement %4[%0 : i64] : vector<2xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.f16x2 %16 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %18 = llvm.extractelement %14[%0 : i64] : vector<2xi16>
    %19 = llvm.bitcast %18 : i16 to vector<2xi8>
    %20 = nvvm.convert.f6x2.to.f16x2 %19 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    return
  }
  func.func @cvt_float_e3m2_to_f16(%arg0: vector<8xf6E3M2FN>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf6E3M2FN> to vector<8xi6>
    %3 = llvm.zext %2 : vector<8xi6> to vector<8xi8>
    %4 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %5 = llvm.extractelement %4[%1 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.extractelement %6[%1 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f6x2.to.f16x2 %8 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %10 = llvm.extractelement %6[%0 : i64] : vector<2xi16>
    %11 = llvm.bitcast %10 : i16 to vector<2xi8>
    %12 = nvvm.convert.f6x2.to.f16x2 %11 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %13 = llvm.extractelement %4[%0 : i64] : vector<2xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.f16x2 %16 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %18 = llvm.extractelement %14[%0 : i64] : vector<2xi16>
    %19 = llvm.bitcast %18 : i16 to vector<2xi8>
    %20 = nvvm.convert.f6x2.to.f16x2 %19 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    return
  }
  func.func @cvt_float_e2m1_to_f16(%arg0: vector<16xf4E2M1FN>) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = builtin.unrealized_conversion_cast %arg0 : vector<16xf4E2M1FN> to vector<16xi4>
    %5 = llvm.bitcast %4 : vector<16xi4> to vector<2xi32>
    %6 = llvm.extractelement %5[%3 : i64] : vector<2xi32>
    %7 = llvm.bitcast %6 : i32 to vector<4xi8>
    %8 = llvm.extractelement %7[%3 : i64] : vector<4xi8>
    %9 = nvvm.convert.f4x2.to.f16x2 %8 : i8(f4E2M1FN) -> vector<2xf16>
    %10 = llvm.extractelement %7[%2 : i64] : vector<4xi8>
    %11 = nvvm.convert.f4x2.to.f16x2 %10 : i8(f4E2M1FN) -> vector<2xf16>
    %12 = llvm.extractelement %7[%1 : i64] : vector<4xi8>
    %13 = nvvm.convert.f4x2.to.f16x2 %12 : i8(f4E2M1FN) -> vector<2xf16>
    %14 = llvm.extractelement %7[%0 : i64] : vector<4xi8>
    %15 = nvvm.convert.f4x2.to.f16x2 %14 : i8(f4E2M1FN) -> vector<2xf16>
    %16 = llvm.extractelement %5[%2 : i64] : vector<2xi32>
    %17 = llvm.bitcast %16 : i32 to vector<4xi8>
    %18 = llvm.extractelement %17[%3 : i64] : vector<4xi8>
    %19 = nvvm.convert.f4x2.to.f16x2 %18 : i8(f4E2M1FN) -> vector<2xf16>
    %20 = llvm.extractelement %17[%2 : i64] : vector<4xi8>
    %21 = nvvm.convert.f4x2.to.f16x2 %20 : i8(f4E2M1FN) -> vector<2xf16>
    %22 = llvm.extractelement %17[%1 : i64] : vector<4xi8>
    %23 = nvvm.convert.f4x2.to.f16x2 %22 : i8(f4E2M1FN) -> vector<2xf16>
    %24 = llvm.extractelement %17[%0 : i64] : vector<4xi8>
    %25 = nvvm.convert.f4x2.to.f16x2 %24 : i8(f4E2M1FN) -> vector<2xf16>
    return
  }
  func.func @cvt_float_e2m3_to_bf16(%arg0: vector<8xf6E2M3FN>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf6E2M3FN> to vector<8xi6>
    %3 = llvm.zext %2 : vector<8xi6> to vector<8xi8>
    %4 = llvm.bitcast %3 : vector<8xi8> to vector<2xi32>
    %5 = llvm.extractelement %4[%1 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.extractelement %6[%1 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f6x2.to.bf16x2 %8 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %10 = llvm.extractelement %6[%0 : i64] : vector<2xi16>
    %11 = llvm.bitcast %10 : i16 to vector<2xi8>
    %12 = nvvm.convert.f6x2.to.bf16x2 %11 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %13 = llvm.extractelement %4[%0 : i64] : vector<2xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.bf16x2 %16 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %18 = llvm.extractelement %14[%0 : i64] : vector<2xi16>
    %19 = llvm.bitcast %18 : i16 to vector<2xi8>
    %20 = nvvm.convert.f6x2.to.bf16x2 %19 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    return
  }
  func.func @cvt_float_e2m1_to_bf16(%arg0: vector<16xf4E2M1FN>) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = builtin.unrealized_conversion_cast %arg0 : vector<16xf4E2M1FN> to vector<16xi4>
    %5 = llvm.bitcast %4 : vector<16xi4> to vector<2xi32>
    %6 = llvm.extractelement %5[%3 : i64] : vector<2xi32>
    %7 = llvm.bitcast %6 : i32 to vector<4xi8>
    %8 = llvm.extractelement %7[%3 : i64] : vector<4xi8>
    %9 = nvvm.convert.f4x2.to.bf16x2 %8 : i8(f4E2M1FN) -> vector<2xbf16>
    %10 = llvm.extractelement %7[%2 : i64] : vector<4xi8>
    %11 = nvvm.convert.f4x2.to.bf16x2 %10 : i8(f4E2M1FN) -> vector<2xbf16>
    %12 = llvm.extractelement %7[%1 : i64] : vector<4xi8>
    %13 = nvvm.convert.f4x2.to.bf16x2 %12 : i8(f4E2M1FN) -> vector<2xbf16>
    %14 = llvm.extractelement %7[%0 : i64] : vector<4xi8>
    %15 = nvvm.convert.f4x2.to.bf16x2 %14 : i8(f4E2M1FN) -> vector<2xbf16>
    %16 = llvm.extractelement %5[%2 : i64] : vector<2xi32>
    %17 = llvm.bitcast %16 : i32 to vector<4xi8>
    %18 = llvm.extractelement %17[%3 : i64] : vector<4xi8>
    %19 = nvvm.convert.f4x2.to.bf16x2 %18 : i8(f4E2M1FN) -> vector<2xbf16>
    %20 = llvm.extractelement %17[%2 : i64] : vector<4xi8>
    %21 = nvvm.convert.f4x2.to.bf16x2 %20 : i8(f4E2M1FN) -> vector<2xbf16>
    %22 = llvm.extractelement %17[%1 : i64] : vector<4xi8>
    %23 = nvvm.convert.f4x2.to.bf16x2 %22 : i8(f4E2M1FN) -> vector<2xbf16>
    %24 = llvm.extractelement %17[%0 : i64] : vector<4xi8>
    %25 = nvvm.convert.f4x2.to.bf16x2 %24 : i8(f4E2M1FN) -> vector<2xbf16>
    return
  }
  func.func @fpext_e4m3fn_to_f32(%arg0: vector<4xf8E4M3FN>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %4 = llvm.bitcast %3 : vector<4xi8> to vector<1xi32>
    %5 = llvm.extractelement %4[%1 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.extractelement %6[%1 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %2[%1 : i64] : vector<2xi32>
    %12 = llvm.extractelement %6[%0 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.f16x2 %13 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %11[%0 : i64] : vector<2xi32>
    %17 = llvm.bitcast %16 : vector<2xi32> to vector<4xf16>
    %18 = llvm.fpext %17 : vector<4xf16> to vector<4xf32>
    return %18 : vector<4xf32>
  }
  func.func @fpext_e5m2_to_f32(%arg0: vector<4xf8E5M2>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %4 = llvm.bitcast %3 : vector<4xi8> to vector<1xi32>
    %5 = llvm.extractelement %4[%1 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.extractelement %6[%1 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.insertelement %10, %2[%1 : i64] : vector<2xi32>
    %12 = llvm.extractelement %6[%0 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.f16x2 %13 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %11[%0 : i64] : vector<2xi32>
    %17 = llvm.bitcast %16 : vector<2xi32> to vector<4xf16>
    %18 = llvm.fpext %17 : vector<4xf16> to vector<4xf32>
    return %18 : vector<4xf32>
  }
  func.func @fpext_e8m0_to_f32(%arg0: vector<4xf8E8M0FNU>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E8M0FNU> to vector<4xi8>
    %4 = llvm.bitcast %3 : vector<4xi8> to vector<1xi32>
    %5 = llvm.extractelement %4[%1 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.extractelement %6[%1 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.bf16x2 %8 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %10 = llvm.bitcast %9 : vector<2xbf16> to i32
    %11 = llvm.insertelement %10, %2[%1 : i64] : vector<2xi32>
    %12 = llvm.extractelement %6[%0 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.bf16x2 %13 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %15 = llvm.bitcast %14 : vector<2xbf16> to i32
    %16 = llvm.insertelement %15, %11[%0 : i64] : vector<2xi32>
    %17 = llvm.bitcast %16 : vector<2xi32> to vector<4xbf16>
    %18 = llvm.fpext %17 : vector<4xbf16> to vector<4xf32>
    return %18 : vector<4xf32>
  }
  func.func @fpext_e2m3_to_f32(%arg0: vector<4xf6E2M3FN>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = builtin.unrealized_conversion_cast %arg0 : vector<4xf6E2M3FN> to vector<4xi6>
    %4 = llvm.zext %3 : vector<4xi6> to vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to vector<1xi32>
    %6 = llvm.extractelement %5[%1 : i64] : vector<1xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.extractelement %7[%1 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f6x2.to.f16x2 %9 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.insertelement %11, %2[%1 : i64] : vector<2xi32>
    %13 = llvm.extractelement %7[%0 : i64] : vector<2xi16>
    %14 = llvm.bitcast %13 : i16 to vector<2xi8>
    %15 = nvvm.convert.f6x2.to.f16x2 %14 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %16 = llvm.bitcast %15 : vector<2xf16> to i32
    %17 = llvm.insertelement %16, %12[%0 : i64] : vector<2xi32>
    %18 = llvm.bitcast %17 : vector<2xi32> to vector<4xf16>
    %19 = llvm.fpext %18 : vector<4xf16> to vector<4xf32>
    return %19 : vector<4xf32>
  }
  func.func @fpext_e2m1_to_f32(%arg0: vector<8xf4E2M1FN>) -> vector<8xf32> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %6 = llvm.bitcast %5 : vector<8xi4> to vector<1xi32>
    %7 = llvm.extractelement %6[%3 : i64] : vector<1xi32>
    %8 = llvm.bitcast %7 : i32 to vector<4xi8>
    %9 = llvm.extractelement %8[%3 : i64] : vector<4xi8>
    %10 = nvvm.convert.f4x2.to.f16x2 %9 : i8(f4E2M1FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.insertelement %11, %4[%3 : i64] : vector<4xi32>
    %13 = llvm.extractelement %8[%2 : i64] : vector<4xi8>
    %14 = nvvm.convert.f4x2.to.f16x2 %13 : i8(f4E2M1FN) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %12[%2 : i64] : vector<4xi32>
    %17 = llvm.extractelement %8[%1 : i64] : vector<4xi8>
    %18 = nvvm.convert.f4x2.to.f16x2 %17 : i8(f4E2M1FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.insertelement %19, %16[%1 : i64] : vector<4xi32>
    %21 = llvm.extractelement %8[%0 : i64] : vector<4xi8>
    %22 = nvvm.convert.f4x2.to.f16x2 %21 : i8(f4E2M1FN) -> vector<2xf16>
    %23 = llvm.bitcast %22 : vector<2xf16> to i32
    %24 = llvm.insertelement %23, %20[%0 : i64] : vector<4xi32>
    %25 = llvm.bitcast %24 : vector<4xi32> to vector<8xf16>
    %26 = llvm.fpext %25 : vector<8xf16> to vector<8xf32>
    return %26 : vector<8xf32>
  }
  func.func @fpext_f16_to_f32(%arg0: vector<4xf16>) -> vector<4xf32> {
    %0 = llvm.fpext %arg0 : vector<4xf16> to vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @fpext_bf16_to_f32(%arg0: vector<4xbf16>) -> vector<4xf32> {
    %0 = llvm.fpext %arg0 : vector<4xbf16> to vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @fpext_f16_to_f64(%arg0: vector<4xf16>) -> vector<4xf64> {
    %0 = llvm.fpext %arg0 : vector<4xf16> to vector<4xf64>
    return %0 : vector<4xf64>
  }
  func.func @fpext_bf16_to_f64(%arg0: vector<4xbf16>) -> vector<4xf64> {
    %0 = llvm.fpext %arg0 : vector<4xbf16> to vector<4xf64>
    return %0 : vector<4xf64>
  }
  func.func @fpext_f32_to_f64(%arg0: vector<4xf32>) -> vector<4xf64> {
    %0 = llvm.fpext %arg0 : vector<4xf32> to vector<4xf64>
    return %0 : vector<4xf64>
  }
  func.func @fpext_f8_to_f64(%arg0: vector<4xf8E4M3FN>) -> vector<4xf64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.undef : vector<4xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<8xf8E4M3FN>
    %6 = builtin.unrealized_conversion_cast %cst : vector<8xf8E4M3FN> to vector<8xi8>
    %7 = llvm.shufflevector %0, %0 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %8 = llvm.shufflevector %7, %6 [0, 1, 2, 3, 12, 13, 14, 15] : vector<8xi8> 
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xi8> to vector<8xf8E4M3FN>
    %10 = builtin.unrealized_conversion_cast %9 : vector<8xf8E4M3FN> to vector<8xi8>
    %11 = llvm.bitcast %10 : vector<8xi8> to vector<2xi32>
    %12 = llvm.extractelement %11[%4 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xi16>
    %14 = llvm.extractelement %13[%4 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %17 = llvm.bitcast %16 : vector<2xf16> to i32
    %18 = llvm.insertelement %17, %5[%4 : i64] : vector<4xi32>
    %19 = llvm.extractelement %13[%3 : i64] : vector<2xi16>
    %20 = llvm.bitcast %19 : i16 to vector<2xi8>
    %21 = nvvm.convert.f8x2.to.f16x2 %20 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %22 = llvm.bitcast %21 : vector<2xf16> to i32
    %23 = llvm.insertelement %22, %18[%3 : i64] : vector<4xi32>
    %24 = llvm.extractelement %11[%3 : i64] : vector<2xi32>
    %25 = llvm.bitcast %24 : i32 to vector<2xi16>
    %26 = llvm.extractelement %25[%4 : i64] : vector<2xi16>
    %27 = llvm.bitcast %26 : i16 to vector<2xi8>
    %28 = nvvm.convert.f8x2.to.f16x2 %27 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %29 = llvm.bitcast %28 : vector<2xf16> to i32
    %30 = llvm.insertelement %29, %23[%2 : i64] : vector<4xi32>
    %31 = llvm.extractelement %25[%3 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : i16 to vector<2xi8>
    %33 = nvvm.convert.f8x2.to.f16x2 %32 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %34 = llvm.bitcast %33 : vector<2xf16> to i32
    %35 = llvm.insertelement %34, %30[%1 : i64] : vector<4xi32>
    %36 = llvm.bitcast %35 : vector<4xi32> to vector<8xf16>
    %37 = llvm.fpext %36 : vector<8xf16> to vector<8xf64>
    %38 = llvm.shufflevector %37, %37 [0, 1, 2, 3] : vector<8xf64> 
    return %38 : vector<4xf64>
  }
  func.func @fpext_f4_to_f64(%arg0: vector<8xf4E2M1FN>) -> vector<8xf64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.mlir.undef : vector<8xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<16xf4E2M1FN>
    %10 = builtin.unrealized_conversion_cast %cst : vector<16xf4E2M1FN> to vector<16xi4>
    %11 = llvm.shufflevector %0, %0 [0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi4> 
    %12 = llvm.shufflevector %11, %10 [0, 1, 2, 3, 4, 5, 6, 7, 24, 25, 26, 27, 28, 29, 30, 31] : vector<16xi4> 
    %13 = builtin.unrealized_conversion_cast %12 : vector<16xi4> to vector<16xf4E2M1FN>
    %14 = builtin.unrealized_conversion_cast %13 : vector<16xf4E2M1FN> to vector<16xi4>
    %15 = llvm.bitcast %14 : vector<16xi4> to vector<2xi32>
    %16 = llvm.extractelement %15[%8 : i64] : vector<2xi32>
    %17 = llvm.bitcast %16 : i32 to vector<4xi8>
    %18 = llvm.extractelement %17[%8 : i64] : vector<4xi8>
    %19 = nvvm.convert.f4x2.to.f16x2 %18 : i8(f4E2M1FN) -> vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %9[%8 : i64] : vector<8xi32>
    %22 = llvm.extractelement %17[%7 : i64] : vector<4xi8>
    %23 = nvvm.convert.f4x2.to.f16x2 %22 : i8(f4E2M1FN) -> vector<2xf16>
    %24 = llvm.bitcast %23 : vector<2xf16> to i32
    %25 = llvm.insertelement %24, %21[%7 : i64] : vector<8xi32>
    %26 = llvm.extractelement %17[%6 : i64] : vector<4xi8>
    %27 = nvvm.convert.f4x2.to.f16x2 %26 : i8(f4E2M1FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.insertelement %28, %25[%6 : i64] : vector<8xi32>
    %30 = llvm.extractelement %17[%5 : i64] : vector<4xi8>
    %31 = nvvm.convert.f4x2.to.f16x2 %30 : i8(f4E2M1FN) -> vector<2xf16>
    %32 = llvm.bitcast %31 : vector<2xf16> to i32
    %33 = llvm.insertelement %32, %29[%5 : i64] : vector<8xi32>
    %34 = llvm.extractelement %15[%7 : i64] : vector<2xi32>
    %35 = llvm.bitcast %34 : i32 to vector<4xi8>
    %36 = llvm.extractelement %35[%8 : i64] : vector<4xi8>
    %37 = nvvm.convert.f4x2.to.f16x2 %36 : i8(f4E2M1FN) -> vector<2xf16>
    %38 = llvm.bitcast %37 : vector<2xf16> to i32
    %39 = llvm.insertelement %38, %33[%4 : i64] : vector<8xi32>
    %40 = llvm.extractelement %35[%7 : i64] : vector<4xi8>
    %41 = nvvm.convert.f4x2.to.f16x2 %40 : i8(f4E2M1FN) -> vector<2xf16>
    %42 = llvm.bitcast %41 : vector<2xf16> to i32
    %43 = llvm.insertelement %42, %39[%3 : i64] : vector<8xi32>
    %44 = llvm.extractelement %35[%6 : i64] : vector<4xi8>
    %45 = nvvm.convert.f4x2.to.f16x2 %44 : i8(f4E2M1FN) -> vector<2xf16>
    %46 = llvm.bitcast %45 : vector<2xf16> to i32
    %47 = llvm.insertelement %46, %43[%2 : i64] : vector<8xi32>
    %48 = llvm.extractelement %35[%5 : i64] : vector<4xi8>
    %49 = nvvm.convert.f4x2.to.f16x2 %48 : i8(f4E2M1FN) -> vector<2xf16>
    %50 = llvm.bitcast %49 : vector<2xf16> to i32
    %51 = llvm.insertelement %50, %47[%1 : i64] : vector<8xi32>
    %52 = llvm.bitcast %51 : vector<8xi32> to vector<16xf16>
    %53 = llvm.fpext %52 : vector<16xf16> to vector<16xf64>
    %54 = llvm.shufflevector %53, %53 [0, 1, 2, 3, 4, 5, 6, 7] : vector<16xf64> 
    return %54 : vector<8xf64>
  }
  func.func @fpext_e2m3_to_f64(%arg0: vector<4xf6E2M3FN>) -> vector<4xf64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf6E2M3FN> to vector<4xi6>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.undef : vector<4xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<8xf6E2M3FN>
    %6 = builtin.unrealized_conversion_cast %cst : vector<8xf6E2M3FN> to vector<8xi6>
    %7 = llvm.shufflevector %0, %0 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi6> 
    %8 = llvm.shufflevector %7, %6 [0, 1, 2, 3, 12, 13, 14, 15] : vector<8xi6> 
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xi6> to vector<8xf6E2M3FN>
    %10 = builtin.unrealized_conversion_cast %9 : vector<8xf6E2M3FN> to vector<8xi6>
    %11 = llvm.zext %10 : vector<8xi6> to vector<8xi8>
    %12 = llvm.bitcast %11 : vector<8xi8> to vector<2xi32>
    %13 = llvm.extractelement %12[%4 : i64] : vector<2xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%4 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.f16x2 %16 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.insertelement %18, %5[%4 : i64] : vector<4xi32>
    %20 = llvm.extractelement %14[%3 : i64] : vector<2xi16>
    %21 = llvm.bitcast %20 : i16 to vector<2xi8>
    %22 = nvvm.convert.f6x2.to.f16x2 %21 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %23 = llvm.bitcast %22 : vector<2xf16> to i32
    %24 = llvm.insertelement %23, %19[%3 : i64] : vector<4xi32>
    %25 = llvm.extractelement %12[%3 : i64] : vector<2xi32>
    %26 = llvm.bitcast %25 : i32 to vector<2xi16>
    %27 = llvm.extractelement %26[%4 : i64] : vector<2xi16>
    %28 = llvm.bitcast %27 : i16 to vector<2xi8>
    %29 = nvvm.convert.f6x2.to.f16x2 %28 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %30 = llvm.bitcast %29 : vector<2xf16> to i32
    %31 = llvm.insertelement %30, %24[%2 : i64] : vector<4xi32>
    %32 = llvm.extractelement %26[%3 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f6x2.to.f16x2 %33 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.insertelement %35, %31[%1 : i64] : vector<4xi32>
    %37 = llvm.bitcast %36 : vector<4xi32> to vector<8xf16>
    %38 = llvm.fpext %37 : vector<8xf16> to vector<8xf64>
    %39 = llvm.shufflevector %38, %38 [0, 1, 2, 3] : vector<8xf64> 
    return %39 : vector<4xf64>
  }
  func.func @fpext_scalar_f8_to_f16(%arg0: f8E4M3FN) -> f16 {
    %0 = builtin.unrealized_conversion_cast %arg0 : f8E4M3FN to i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E4M3FN> to vector<4xi8>
    %5 = llvm.mlir.poison : vector<1xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<1xi8>
    %8 = llvm.shufflevector %7, %7 [0, 0, 0, 0] : vector<1xi8> 
    %9 = llvm.shufflevector %8, %4 [0, 5, 6, 7] : vector<4xi8> 
    %10 = builtin.unrealized_conversion_cast %9 : vector<4xi8> to vector<4xf8E4M3FN>
    %11 = builtin.unrealized_conversion_cast %10 : vector<4xf8E4M3FN> to vector<4xi8>
    %12 = llvm.bitcast %11 : vector<4xi8> to vector<1xi32>
    %13 = llvm.extractelement %12[%2 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%2 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.insertelement %18, %3[%2 : i64] : vector<2xi32>
    %20 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %21 = llvm.bitcast %20 : i16 to vector<2xi8>
    %22 = nvvm.convert.f8x2.to.f16x2 %21 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %23 = llvm.bitcast %22 : vector<2xf16> to i32
    %24 = llvm.insertelement %23, %19[%1 : i64] : vector<2xi32>
    %25 = llvm.bitcast %24 : vector<2xi32> to vector<4xf16>
    %26 = llvm.mlir.constant(0 : i64) : i64
    %27 = llvm.extractelement %25[%26 : i64] : vector<4xf16>
    return %27 : f16
  }
  func.func @fpext_scalar_f8_to_f32(%arg0: f8E4M3FN) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : f8E4M3FN to i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E4M3FN> to vector<4xi8>
    %5 = llvm.mlir.poison : vector<1xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<1xi8>
    %8 = llvm.shufflevector %7, %7 [0, 0, 0, 0] : vector<1xi8> 
    %9 = llvm.shufflevector %8, %4 [0, 5, 6, 7] : vector<4xi8> 
    %10 = builtin.unrealized_conversion_cast %9 : vector<4xi8> to vector<4xf8E4M3FN>
    %11 = builtin.unrealized_conversion_cast %10 : vector<4xf8E4M3FN> to vector<4xi8>
    %12 = llvm.bitcast %11 : vector<4xi8> to vector<1xi32>
    %13 = llvm.extractelement %12[%2 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%2 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.insertelement %18, %3[%2 : i64] : vector<2xi32>
    %20 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %21 = llvm.bitcast %20 : i16 to vector<2xi8>
    %22 = nvvm.convert.f8x2.to.f16x2 %21 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %23 = llvm.bitcast %22 : vector<2xf16> to i32
    %24 = llvm.insertelement %23, %19[%1 : i64] : vector<2xi32>
    %25 = llvm.bitcast %24 : vector<2xi32> to vector<4xf16>
    %26 = llvm.fpext %25 : vector<4xf16> to vector<4xf32>
    %27 = llvm.mlir.constant(0 : i64) : i64
    %28 = llvm.extractelement %26[%27 : i64] : vector<4xf32>
    return %28 : f32
  }
  func.func @fpext_v2x4_f8_to_f16(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf8E4M3FN> to !llvm.array<2 x vector<4xi8>>
    %1 = ub.poison : vector<2x4xf16>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x4xf16> to !llvm.array<2 x vector<4xf16>>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : vector<4xi32>
    %8 = ub.poison : vector<8xf8E4M3FN>
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xf8E4M3FN> to vector<8xi8>
    %10 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xi8>> 
    %11 = llvm.shufflevector %10, %10 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %12 = llvm.shufflevector %11, %9 [0, 1, 2, 3, -1, -1, -1, -1] : vector<8xi8> 
    %13 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xi8>> 
    %14 = llvm.shufflevector %13, %13 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %15 = llvm.shufflevector %14, %12 [8, 9, 10, 11, 0, 1, 2, 3] : vector<8xi8> 
    %16 = builtin.unrealized_conversion_cast %15 : vector<8xi8> to vector<8xf8E4M3FN>
    %17 = builtin.unrealized_conversion_cast %16 : vector<8xf8E4M3FN> to vector<8xi8>
    %18 = llvm.bitcast %17 : vector<8xi8> to vector<2xi32>
    %19 = llvm.extractelement %18[%6 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : i32 to vector<2xi16>
    %21 = llvm.extractelement %20[%6 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : i16 to vector<2xi8>
    %23 = nvvm.convert.f8x2.to.f16x2 %22 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %24 = llvm.bitcast %23 : vector<2xf16> to i32
    %25 = llvm.insertelement %24, %7[%6 : i64] : vector<4xi32>
    %26 = llvm.extractelement %20[%5 : i64] : vector<2xi16>
    %27 = llvm.bitcast %26 : i16 to vector<2xi8>
    %28 = nvvm.convert.f8x2.to.f16x2 %27 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %29 = llvm.bitcast %28 : vector<2xf16> to i32
    %30 = llvm.insertelement %29, %25[%5 : i64] : vector<4xi32>
    %31 = llvm.extractelement %18[%5 : i64] : vector<2xi32>
    %32 = llvm.bitcast %31 : i32 to vector<2xi16>
    %33 = llvm.extractelement %32[%6 : i64] : vector<2xi16>
    %34 = llvm.bitcast %33 : i16 to vector<2xi8>
    %35 = nvvm.convert.f8x2.to.f16x2 %34 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %36 = llvm.bitcast %35 : vector<2xf16> to i32
    %37 = llvm.insertelement %36, %30[%4 : i64] : vector<4xi32>
    %38 = llvm.extractelement %32[%5 : i64] : vector<2xi16>
    %39 = llvm.bitcast %38 : i16 to vector<2xi8>
    %40 = nvvm.convert.f8x2.to.f16x2 %39 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %41 = llvm.bitcast %40 : vector<2xf16> to i32
    %42 = llvm.insertelement %41, %37[%3 : i64] : vector<4xi32>
    %43 = llvm.bitcast %42 : vector<4xi32> to vector<8xf16>
    %44 = llvm.shufflevector %43, %43 [0, 1, 2, 3] : vector<8xf16> 
    %45 = llvm.insertvalue %44, %2[0] : !llvm.array<2 x vector<4xf16>> 
    %46 = llvm.shufflevector %43, %43 [4, 5, 6, 7] : vector<8xf16> 
    %47 = llvm.insertvalue %46, %45[1] : !llvm.array<2 x vector<4xf16>> 
    %48 = builtin.unrealized_conversion_cast %47 : !llvm.array<2 x vector<4xf16>> to vector<2x4xf16>
    return %48 : vector<2x4xf16>
  }
  func.func @fpext_v2x4_f8_to_f32(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf8E4M3FN> to !llvm.array<2 x vector<4xi8>>
    %1 = ub.poison : vector<2x4xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : vector<4xi32>
    %8 = ub.poison : vector<8xf8E4M3FN>
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xf8E4M3FN> to vector<8xi8>
    %10 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xi8>> 
    %11 = llvm.shufflevector %10, %10 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %12 = llvm.shufflevector %11, %9 [0, 1, 2, 3, -1, -1, -1, -1] : vector<8xi8> 
    %13 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xi8>> 
    %14 = llvm.shufflevector %13, %13 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %15 = llvm.shufflevector %14, %12 [8, 9, 10, 11, 0, 1, 2, 3] : vector<8xi8> 
    %16 = builtin.unrealized_conversion_cast %15 : vector<8xi8> to vector<8xf8E4M3FN>
    %17 = builtin.unrealized_conversion_cast %16 : vector<8xf8E4M3FN> to vector<8xi8>
    %18 = llvm.bitcast %17 : vector<8xi8> to vector<2xi32>
    %19 = llvm.extractelement %18[%6 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : i32 to vector<2xi16>
    %21 = llvm.extractelement %20[%6 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : i16 to vector<2xi8>
    %23 = nvvm.convert.f8x2.to.f16x2 %22 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %24 = llvm.bitcast %23 : vector<2xf16> to i32
    %25 = llvm.insertelement %24, %7[%6 : i64] : vector<4xi32>
    %26 = llvm.extractelement %20[%5 : i64] : vector<2xi16>
    %27 = llvm.bitcast %26 : i16 to vector<2xi8>
    %28 = nvvm.convert.f8x2.to.f16x2 %27 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %29 = llvm.bitcast %28 : vector<2xf16> to i32
    %30 = llvm.insertelement %29, %25[%5 : i64] : vector<4xi32>
    %31 = llvm.extractelement %18[%5 : i64] : vector<2xi32>
    %32 = llvm.bitcast %31 : i32 to vector<2xi16>
    %33 = llvm.extractelement %32[%6 : i64] : vector<2xi16>
    %34 = llvm.bitcast %33 : i16 to vector<2xi8>
    %35 = nvvm.convert.f8x2.to.f16x2 %34 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %36 = llvm.bitcast %35 : vector<2xf16> to i32
    %37 = llvm.insertelement %36, %30[%4 : i64] : vector<4xi32>
    %38 = llvm.extractelement %32[%5 : i64] : vector<2xi16>
    %39 = llvm.bitcast %38 : i16 to vector<2xi8>
    %40 = nvvm.convert.f8x2.to.f16x2 %39 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %41 = llvm.bitcast %40 : vector<2xf16> to i32
    %42 = llvm.insertelement %41, %37[%3 : i64] : vector<4xi32>
    %43 = llvm.bitcast %42 : vector<4xi32> to vector<8xf16>
    %44 = llvm.fpext %43 : vector<8xf16> to vector<8xf32>
    %45 = llvm.shufflevector %44, %44 [0, 1, 2, 3] : vector<8xf32> 
    %46 = llvm.insertvalue %45, %2[0] : !llvm.array<2 x vector<4xf32>> 
    %47 = llvm.shufflevector %44, %44 [4, 5, 6, 7] : vector<8xf32> 
    %48 = llvm.insertvalue %47, %46[1] : !llvm.array<2 x vector<4xf32>> 
    %49 = builtin.unrealized_conversion_cast %48 : !llvm.array<2 x vector<4xf32>> to vector<2x4xf32>
    return %49 : vector<2x4xf32>
  }
  func.func @fpext_v3f8_to_v3f16(%arg0: vector<3xf8E5M2>) -> vector<3xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3xf8E5M2> to vector<3xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E5M2> to vector<4xi8>
    %5 = llvm.shufflevector %0, %0 [0, 1, 2, 0] : vector<3xi8> 
    %6 = llvm.shufflevector %5, %4 [0, 1, 2, 7] : vector<4xi8> 
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xf8E5M2> to vector<4xi8>
    %9 = llvm.bitcast %8 : vector<4xi8> to vector<1xi32>
    %10 = llvm.extractelement %9[%2 : i64] : vector<1xi32>
    %11 = llvm.bitcast %10 : i32 to vector<2xi16>
    %12 = llvm.extractelement %11[%2 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.f16x2 %13 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %3[%2 : i64] : vector<2xi32>
    %17 = llvm.extractelement %11[%1 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %16[%1 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = llvm.shufflevector %22, %22 [0, 1, 2] : vector<4xf16> 
    return %23 : vector<3xf16>
  }
  func.func @fpext_v3_f8_to_f32(%arg0: vector<3xf8E5M2>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3xf8E5M2> to vector<3xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E5M2> to vector<4xi8>
    %5 = llvm.shufflevector %0, %0 [0, 1, 2, 0] : vector<3xi8> 
    %6 = llvm.shufflevector %5, %4 [0, 1, 2, 7] : vector<4xi8> 
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xf8E5M2> to vector<4xi8>
    %9 = llvm.bitcast %8 : vector<4xi8> to vector<1xi32>
    %10 = llvm.extractelement %9[%2 : i64] : vector<1xi32>
    %11 = llvm.bitcast %10 : i32 to vector<2xi16>
    %12 = llvm.extractelement %11[%2 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.f16x2 %13 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %3[%2 : i64] : vector<2xi32>
    %17 = llvm.extractelement %11[%1 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %16[%1 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = llvm.fpext %22 : vector<4xf16> to vector<4xf32>
    %24 = llvm.shufflevector %23, %23 [0, 1, 2] : vector<4xf32> 
    return %24 : vector<3xf32>
  }
  func.func @fpext_v3x1_f8_to_f16(%arg0: vector<3x1xf8E4M3FN>) -> vector<3x1xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3x1xf8E4M3FN> to !llvm.array<3 x vector<1xi8>>
    %1 = ub.poison : vector<3x1xf16>
    %2 = builtin.unrealized_conversion_cast %1 : vector<3x1xf16> to !llvm.array<3 x vector<1xf16>>
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %6 = builtin.unrealized_conversion_cast %cst : vector<4xf8E4M3FN> to vector<4xi8>
    %7 = ub.poison : vector<3xf8E4M3FN>
    %8 = builtin.unrealized_conversion_cast %7 : vector<3xf8E4M3FN> to vector<3xi8>
    %9 = llvm.extractvalue %0[0] : !llvm.array<3 x vector<1xi8>> 
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.extractelement %9[%10 : i64] : vector<1xi8>
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %8[%12 : i64] : vector<3xi8>
    %14 = llvm.extractvalue %0[1] : !llvm.array<3 x vector<1xi8>> 
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.extractelement %14[%15 : i64] : vector<1xi8>
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.insertelement %16, %13[%17 : i64] : vector<3xi8>
    %19 = llvm.extractvalue %0[2] : !llvm.array<3 x vector<1xi8>> 
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.extractelement %19[%20 : i64] : vector<1xi8>
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.insertelement %21, %18[%22 : i64] : vector<3xi8>
    %24 = llvm.shufflevector %23, %23 [0, 1, 2, 0] : vector<3xi8> 
    %25 = llvm.shufflevector %24, %6 [0, 1, 2, 7] : vector<4xi8> 
    %26 = builtin.unrealized_conversion_cast %25 : vector<4xi8> to vector<4xf8E4M3FN>
    %27 = builtin.unrealized_conversion_cast %26 : vector<4xf8E4M3FN> to vector<4xi8>
    %28 = llvm.bitcast %27 : vector<4xi8> to vector<1xi32>
    %29 = llvm.extractelement %28[%4 : i64] : vector<1xi32>
    %30 = llvm.bitcast %29 : i32 to vector<2xi16>
    %31 = llvm.extractelement %30[%4 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : i16 to vector<2xi8>
    %33 = nvvm.convert.f8x2.to.f16x2 %32 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %34 = llvm.bitcast %33 : vector<2xf16> to i32
    %35 = llvm.insertelement %34, %5[%4 : i64] : vector<2xi32>
    %36 = llvm.extractelement %30[%3 : i64] : vector<2xi16>
    %37 = llvm.bitcast %36 : i16 to vector<2xi8>
    %38 = nvvm.convert.f8x2.to.f16x2 %37 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %39 = llvm.bitcast %38 : vector<2xf16> to i32
    %40 = llvm.insertelement %39, %35[%3 : i64] : vector<2xi32>
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
  func.func @fpext_f8_to_f16_relu(%arg0: vector<8xf8E4M3FN>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E4M3FN> to vector<8xi8>
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<2xi32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.extractelement %5[%1 : i64] : vector<2xi16>
    %7 = llvm.bitcast %6 : i16 to vector<2xi8>
    %8 = nvvm.convert.f8x2.to.f16x2 %7 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %9 = llvm.extractelement %5[%0 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.extractelement %3[%0 : i64] : vector<2xi32>
    %13 = llvm.bitcast %12 : i32 to vector<2xi16>
    %14 = llvm.extractelement %13[%1 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %17 = llvm.extractelement %13[%0 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    return
  }
  func.func @e2e_scalar_f8_to_f16(%arg0: f8E4M3FN) -> f16 {
    %0 = builtin.unrealized_conversion_cast %arg0 : f8E4M3FN to i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E4M3FN> to vector<4xi8>
    %5 = llvm.mlir.poison : vector<1xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<1xi8>
    %8 = llvm.shufflevector %7, %7 [0, 0, 0, 0] : vector<1xi8> 
    %9 = llvm.shufflevector %8, %4 [0, 5, 6, 7] : vector<4xi8> 
    %10 = builtin.unrealized_conversion_cast %9 : vector<4xi8> to vector<4xf8E4M3FN>
    %11 = builtin.unrealized_conversion_cast %10 : vector<4xf8E4M3FN> to vector<4xi8>
    %12 = llvm.bitcast %11 : vector<4xi8> to vector<1xi32>
    %13 = llvm.extractelement %12[%2 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%2 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.insertelement %18, %3[%2 : i64] : vector<2xi32>
    %20 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %21 = llvm.bitcast %20 : i16 to vector<2xi8>
    %22 = nvvm.convert.f8x2.to.f16x2 %21 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %23 = llvm.bitcast %22 : vector<2xf16> to i32
    %24 = llvm.insertelement %23, %19[%1 : i64] : vector<2xi32>
    %25 = llvm.bitcast %24 : vector<2xi32> to vector<4xf16>
    %26 = llvm.mlir.constant(0 : i64) : i64
    %27 = llvm.extractelement %25[%26 : i64] : vector<4xf16>
    return %27 : f16
  }
  func.func @e2e_v2x4_f8_to_f16(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf8E4M3FN> to !llvm.array<2 x vector<4xi8>>
    %1 = ub.poison : vector<2x4xf16>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x4xf16> to !llvm.array<2 x vector<4xf16>>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : vector<4xi32>
    %8 = ub.poison : vector<8xf8E4M3FN>
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xf8E4M3FN> to vector<8xi8>
    %10 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xi8>> 
    %11 = llvm.shufflevector %10, %10 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %12 = llvm.shufflevector %11, %9 [0, 1, 2, 3, -1, -1, -1, -1] : vector<8xi8> 
    %13 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xi8>> 
    %14 = llvm.shufflevector %13, %13 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %15 = llvm.shufflevector %14, %12 [8, 9, 10, 11, 0, 1, 2, 3] : vector<8xi8> 
    %16 = builtin.unrealized_conversion_cast %15 : vector<8xi8> to vector<8xf8E4M3FN>
    %17 = builtin.unrealized_conversion_cast %16 : vector<8xf8E4M3FN> to vector<8xi8>
    %18 = llvm.bitcast %17 : vector<8xi8> to vector<2xi32>
    %19 = llvm.extractelement %18[%6 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : i32 to vector<2xi16>
    %21 = llvm.extractelement %20[%6 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : i16 to vector<2xi8>
    %23 = nvvm.convert.f8x2.to.f16x2 %22 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %24 = llvm.bitcast %23 : vector<2xf16> to i32
    %25 = llvm.insertelement %24, %7[%6 : i64] : vector<4xi32>
    %26 = llvm.extractelement %20[%5 : i64] : vector<2xi16>
    %27 = llvm.bitcast %26 : i16 to vector<2xi8>
    %28 = nvvm.convert.f8x2.to.f16x2 %27 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %29 = llvm.bitcast %28 : vector<2xf16> to i32
    %30 = llvm.insertelement %29, %25[%5 : i64] : vector<4xi32>
    %31 = llvm.extractelement %18[%5 : i64] : vector<2xi32>
    %32 = llvm.bitcast %31 : i32 to vector<2xi16>
    %33 = llvm.extractelement %32[%6 : i64] : vector<2xi16>
    %34 = llvm.bitcast %33 : i16 to vector<2xi8>
    %35 = nvvm.convert.f8x2.to.f16x2 %34 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %36 = llvm.bitcast %35 : vector<2xf16> to i32
    %37 = llvm.insertelement %36, %30[%4 : i64] : vector<4xi32>
    %38 = llvm.extractelement %32[%5 : i64] : vector<2xi16>
    %39 = llvm.bitcast %38 : i16 to vector<2xi8>
    %40 = nvvm.convert.f8x2.to.f16x2 %39 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %41 = llvm.bitcast %40 : vector<2xf16> to i32
    %42 = llvm.insertelement %41, %37[%3 : i64] : vector<4xi32>
    %43 = llvm.bitcast %42 : vector<4xi32> to vector<8xf16>
    %44 = llvm.shufflevector %43, %43 [0, 1, 2, 3] : vector<8xf16> 
    %45 = llvm.insertvalue %44, %2[0] : !llvm.array<2 x vector<4xf16>> 
    %46 = llvm.shufflevector %43, %43 [4, 5, 6, 7] : vector<8xf16> 
    %47 = llvm.insertvalue %46, %45[1] : !llvm.array<2 x vector<4xf16>> 
    %48 = builtin.unrealized_conversion_cast %47 : !llvm.array<2 x vector<4xf16>> to vector<2x4xf16>
    return %48 : vector<2x4xf16>
  }
  func.func @e2e_v3f8_to_v3f16(%arg0: vector<3xf8E5M2>) -> vector<3xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3xf8E5M2> to vector<3xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E5M2> to vector<4xi8>
    %5 = llvm.shufflevector %0, %0 [0, 1, 2, 0] : vector<3xi8> 
    %6 = llvm.shufflevector %5, %4 [0, 1, 2, 7] : vector<4xi8> 
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xf8E5M2> to vector<4xi8>
    %9 = llvm.bitcast %8 : vector<4xi8> to vector<1xi32>
    %10 = llvm.extractelement %9[%2 : i64] : vector<1xi32>
    %11 = llvm.bitcast %10 : i32 to vector<2xi16>
    %12 = llvm.extractelement %11[%2 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.f16x2 %13 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %3[%2 : i64] : vector<2xi32>
    %17 = llvm.extractelement %11[%1 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %16[%1 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = llvm.shufflevector %22, %22 [0, 1, 2] : vector<4xf16> 
    return %23 : vector<3xf16>
  }
  func.func @e2e_scalar_f8_to_f32(%arg0: f8E4M3FN) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : f8E4M3FN to i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E4M3FN> to vector<4xi8>
    %5 = llvm.mlir.poison : vector<1xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<1xi8>
    %8 = llvm.shufflevector %7, %7 [0, 0, 0, 0] : vector<1xi8> 
    %9 = llvm.shufflevector %8, %4 [0, 5, 6, 7] : vector<4xi8> 
    %10 = builtin.unrealized_conversion_cast %9 : vector<4xi8> to vector<4xf8E4M3FN>
    %11 = builtin.unrealized_conversion_cast %10 : vector<4xf8E4M3FN> to vector<4xi8>
    %12 = llvm.bitcast %11 : vector<4xi8> to vector<1xi32>
    %13 = llvm.extractelement %12[%2 : i64] : vector<1xi32>
    %14 = llvm.bitcast %13 : i32 to vector<2xi16>
    %15 = llvm.extractelement %14[%2 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.insertelement %18, %3[%2 : i64] : vector<2xi32>
    %20 = llvm.extractelement %14[%1 : i64] : vector<2xi16>
    %21 = llvm.bitcast %20 : i16 to vector<2xi8>
    %22 = nvvm.convert.f8x2.to.f16x2 %21 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %23 = llvm.bitcast %22 : vector<2xf16> to i32
    %24 = llvm.insertelement %23, %19[%1 : i64] : vector<2xi32>
    %25 = llvm.bitcast %24 : vector<2xi32> to vector<4xf16>
    %26 = llvm.fpext %25 : vector<4xf16> to vector<4xf32>
    %27 = llvm.mlir.constant(0 : i64) : i64
    %28 = llvm.extractelement %26[%27 : i64] : vector<4xf32>
    return %28 : f32
  }
  func.func @e2e_v2x4_f8_to_f32(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf8E4M3FN> to !llvm.array<2 x vector<4xi8>>
    %1 = ub.poison : vector<2x4xf32>
    %2 = builtin.unrealized_conversion_cast %1 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.undef : vector<4xi32>
    %8 = ub.poison : vector<8xf8E4M3FN>
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xf8E4M3FN> to vector<8xi8>
    %10 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xi8>> 
    %11 = llvm.shufflevector %10, %10 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %12 = llvm.shufflevector %11, %9 [0, 1, 2, 3, -1, -1, -1, -1] : vector<8xi8> 
    %13 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xi8>> 
    %14 = llvm.shufflevector %13, %13 [0, 1, 2, 3, 0, 0, 0, 0] : vector<4xi8> 
    %15 = llvm.shufflevector %14, %12 [8, 9, 10, 11, 0, 1, 2, 3] : vector<8xi8> 
    %16 = builtin.unrealized_conversion_cast %15 : vector<8xi8> to vector<8xf8E4M3FN>
    %17 = builtin.unrealized_conversion_cast %16 : vector<8xf8E4M3FN> to vector<8xi8>
    %18 = llvm.bitcast %17 : vector<8xi8> to vector<2xi32>
    %19 = llvm.extractelement %18[%6 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : i32 to vector<2xi16>
    %21 = llvm.extractelement %20[%6 : i64] : vector<2xi16>
    %22 = llvm.bitcast %21 : i16 to vector<2xi8>
    %23 = nvvm.convert.f8x2.to.f16x2 %22 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %24 = llvm.bitcast %23 : vector<2xf16> to i32
    %25 = llvm.insertelement %24, %7[%6 : i64] : vector<4xi32>
    %26 = llvm.extractelement %20[%5 : i64] : vector<2xi16>
    %27 = llvm.bitcast %26 : i16 to vector<2xi8>
    %28 = nvvm.convert.f8x2.to.f16x2 %27 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %29 = llvm.bitcast %28 : vector<2xf16> to i32
    %30 = llvm.insertelement %29, %25[%5 : i64] : vector<4xi32>
    %31 = llvm.extractelement %18[%5 : i64] : vector<2xi32>
    %32 = llvm.bitcast %31 : i32 to vector<2xi16>
    %33 = llvm.extractelement %32[%6 : i64] : vector<2xi16>
    %34 = llvm.bitcast %33 : i16 to vector<2xi8>
    %35 = nvvm.convert.f8x2.to.f16x2 %34 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %36 = llvm.bitcast %35 : vector<2xf16> to i32
    %37 = llvm.insertelement %36, %30[%4 : i64] : vector<4xi32>
    %38 = llvm.extractelement %32[%5 : i64] : vector<2xi16>
    %39 = llvm.bitcast %38 : i16 to vector<2xi8>
    %40 = nvvm.convert.f8x2.to.f16x2 %39 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %41 = llvm.bitcast %40 : vector<2xf16> to i32
    %42 = llvm.insertelement %41, %37[%3 : i64] : vector<4xi32>
    %43 = llvm.bitcast %42 : vector<4xi32> to vector<8xf16>
    %44 = llvm.fpext %43 : vector<8xf16> to vector<8xf32>
    %45 = llvm.shufflevector %44, %44 [0, 1, 2, 3] : vector<8xf32> 
    %46 = llvm.insertvalue %45, %2[0] : !llvm.array<2 x vector<4xf32>> 
    %47 = llvm.shufflevector %44, %44 [4, 5, 6, 7] : vector<8xf32> 
    %48 = llvm.insertvalue %47, %46[1] : !llvm.array<2 x vector<4xf32>> 
    %49 = builtin.unrealized_conversion_cast %48 : !llvm.array<2 x vector<4xf32>> to vector<2x4xf32>
    return %49 : vector<2x4xf32>
  }
  func.func @e2e_v3f8_to_v3f32(%arg0: vector<3xf8E5M2>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<3xf8E5M2> to vector<3xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi32>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %4 = builtin.unrealized_conversion_cast %cst : vector<4xf8E5M2> to vector<4xi8>
    %5 = llvm.shufflevector %0, %0 [0, 1, 2, 0] : vector<3xi8> 
    %6 = llvm.shufflevector %5, %4 [0, 1, 2, 7] : vector<4xi8> 
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xf8E5M2> to vector<4xi8>
    %9 = llvm.bitcast %8 : vector<4xi8> to vector<1xi32>
    %10 = llvm.extractelement %9[%2 : i64] : vector<1xi32>
    %11 = llvm.bitcast %10 : i32 to vector<2xi16>
    %12 = llvm.extractelement %11[%2 : i64] : vector<2xi16>
    %13 = llvm.bitcast %12 : i16 to vector<2xi8>
    %14 = nvvm.convert.f8x2.to.f16x2 %13 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.insertelement %15, %3[%2 : i64] : vector<2xi32>
    %17 = llvm.extractelement %11[%1 : i64] : vector<2xi16>
    %18 = llvm.bitcast %17 : i16 to vector<2xi8>
    %19 = nvvm.convert.f8x2.to.f16x2 %18 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %20 = llvm.bitcast %19 : vector<2xf16> to i32
    %21 = llvm.insertelement %20, %16[%1 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = llvm.fpext %22 : vector<4xf16> to vector<4xf32>
    %24 = llvm.shufflevector %23, %23 [0, 1, 2] : vector<4xf32> 
    return %24 : vector<3xf32>
  }
}

