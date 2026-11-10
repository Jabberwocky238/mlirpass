module {
  func.func @cvt_float_e4m3fn_to_f16(%arg0: vector<8xf8E4M3FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E4M3FN> to vector<8xi8>
    %1 = llvm.bitcast %0 : vector<8xi8> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<4xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %17 = llvm.bitcast %16 : vector<2xf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<4xi32>
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.extractelement %1[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : i32 to vector<2xi16>
    %23 = llvm.mlir.constant(0 : i64) : i64
    %24 = llvm.extractelement %22[%23 : i64] : vector<2xi16>
    %25 = llvm.bitcast %24 : i16 to vector<2xi8>
    %26 = nvvm.convert.f8x2.to.f16x2 %25 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %27 = llvm.bitcast %26 : vector<2xf16> to i32
    %28 = llvm.mlir.constant(2 : i64) : i64
    %29 = llvm.insertelement %27, %19[%28 : i64] : vector<4xi32>
    %30 = llvm.mlir.constant(1 : i64) : i64
    %31 = llvm.extractelement %22[%30 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : i16 to vector<2xi8>
    %33 = nvvm.convert.f8x2.to.f16x2 %32 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %34 = llvm.bitcast %33 : vector<2xf16> to i32
    %35 = llvm.mlir.constant(3 : i64) : i64
    %36 = llvm.insertelement %34, %29[%35 : i64] : vector<4xi32>
    %37 = llvm.bitcast %36 : vector<4xi32> to vector<8xf16>
    return
  }
  func.func @cvt_float_e5m2_to_f16(%arg0: vector<8xf8E5M2>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E5M2> to vector<8xi8>
    %1 = llvm.bitcast %0 : vector<8xi8> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<4xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %17 = llvm.bitcast %16 : vector<2xf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<4xi32>
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.extractelement %1[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : i32 to vector<2xi16>
    %23 = llvm.mlir.constant(0 : i64) : i64
    %24 = llvm.extractelement %22[%23 : i64] : vector<2xi16>
    %25 = llvm.bitcast %24 : i16 to vector<2xi8>
    %26 = nvvm.convert.f8x2.to.f16x2 %25 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %27 = llvm.bitcast %26 : vector<2xf16> to i32
    %28 = llvm.mlir.constant(2 : i64) : i64
    %29 = llvm.insertelement %27, %19[%28 : i64] : vector<4xi32>
    %30 = llvm.mlir.constant(1 : i64) : i64
    %31 = llvm.extractelement %22[%30 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : i16 to vector<2xi8>
    %33 = nvvm.convert.f8x2.to.f16x2 %32 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %34 = llvm.bitcast %33 : vector<2xf16> to i32
    %35 = llvm.mlir.constant(3 : i64) : i64
    %36 = llvm.insertelement %34, %29[%35 : i64] : vector<4xi32>
    %37 = llvm.bitcast %36 : vector<4xi32> to vector<8xf16>
    return
  }
  func.func @cvt_float_e8m0_to_bf16(%arg0: vector<8xf8E8M0FNU>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E8M0FNU> to vector<8xi8>
    %1 = llvm.bitcast %0 : vector<8xi8> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.bf16x2 %8 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %10 = llvm.bitcast %9 : vector<2xbf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<4xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.bf16x2 %15 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %17 = llvm.bitcast %16 : vector<2xbf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<4xi32>
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.extractelement %1[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : i32 to vector<2xi16>
    %23 = llvm.mlir.constant(0 : i64) : i64
    %24 = llvm.extractelement %22[%23 : i64] : vector<2xi16>
    %25 = llvm.bitcast %24 : i16 to vector<2xi8>
    %26 = nvvm.convert.f8x2.to.bf16x2 %25 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %27 = llvm.bitcast %26 : vector<2xbf16> to i32
    %28 = llvm.mlir.constant(2 : i64) : i64
    %29 = llvm.insertelement %27, %19[%28 : i64] : vector<4xi32>
    %30 = llvm.mlir.constant(1 : i64) : i64
    %31 = llvm.extractelement %22[%30 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : i16 to vector<2xi8>
    %33 = nvvm.convert.f8x2.to.bf16x2 %32 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %34 = llvm.bitcast %33 : vector<2xbf16> to i32
    %35 = llvm.mlir.constant(3 : i64) : i64
    %36 = llvm.insertelement %34, %29[%35 : i64] : vector<4xi32>
    %37 = llvm.bitcast %36 : vector<4xi32> to vector<8xbf16>
    return
  }
  func.func @cvt_float_e2m3_to_f16(%arg0: vector<8xf6E2M3FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf6E2M3FN> to vector<8xi6>
    %1 = llvm.zext %0 : vector<8xi6> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f6x2.to.f16x2 %9 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.f16x2 %16 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f6x2.to.f16x2 %26 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f6x2.to.f16x2 %33 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    return
  }
  func.func @cvt_float_e3m2_to_f16(%arg0: vector<8xf6E3M2FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf6E3M2FN> to vector<8xi6>
    %1 = llvm.zext %0 : vector<8xi6> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f6x2.to.f16x2 %9 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.f16x2 %16 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f6x2.to.f16x2 %26 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f6x2.to.f16x2 %33 : vector<2xi8>(f6E3M2FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    return
  }
  func.func @cvt_float_e2m1_to_f16(%arg0: vector<16xf4E2M1FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<16xf4E2M1FN> to vector<16xi4>
    %1 = llvm.bitcast %0 : vector<16xi4> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<4xi8>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<4xi8>
    %8 = nvvm.convert.f4x2.to.f16x2 %7 : i8(f4E2M1FN) -> vector<2xf16>
    %9 = llvm.bitcast %8 : vector<2xf16> to i32
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.insertelement %9, %2[%10 : i64] : vector<8xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.extractelement %5[%12 : i64] : vector<4xi8>
    %14 = nvvm.convert.f4x2.to.f16x2 %13 : i8(f4E2M1FN) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.mlir.constant(1 : i64) : i64
    %17 = llvm.insertelement %15, %11[%16 : i64] : vector<8xi32>
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.extractelement %5[%18 : i64] : vector<4xi8>
    %20 = nvvm.convert.f4x2.to.f16x2 %19 : i8(f4E2M1FN) -> vector<2xf16>
    %21 = llvm.bitcast %20 : vector<2xf16> to i32
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.insertelement %21, %17[%22 : i64] : vector<8xi32>
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.extractelement %5[%24 : i64] : vector<4xi8>
    %26 = nvvm.convert.f4x2.to.f16x2 %25 : i8(f4E2M1FN) -> vector<2xf16>
    %27 = llvm.bitcast %26 : vector<2xf16> to i32
    %28 = llvm.mlir.constant(3 : i64) : i64
    %29 = llvm.insertelement %27, %23[%28 : i64] : vector<8xi32>
    %30 = llvm.mlir.constant(1 : i64) : i64
    %31 = llvm.extractelement %1[%30 : i64] : vector<2xi32>
    %32 = llvm.bitcast %31 : i32 to vector<4xi8>
    %33 = llvm.mlir.constant(0 : i64) : i64
    %34 = llvm.extractelement %32[%33 : i64] : vector<4xi8>
    %35 = nvvm.convert.f4x2.to.f16x2 %34 : i8(f4E2M1FN) -> vector<2xf16>
    %36 = llvm.bitcast %35 : vector<2xf16> to i32
    %37 = llvm.mlir.constant(4 : i64) : i64
    %38 = llvm.insertelement %36, %29[%37 : i64] : vector<8xi32>
    %39 = llvm.mlir.constant(1 : i64) : i64
    %40 = llvm.extractelement %32[%39 : i64] : vector<4xi8>
    %41 = nvvm.convert.f4x2.to.f16x2 %40 : i8(f4E2M1FN) -> vector<2xf16>
    %42 = llvm.bitcast %41 : vector<2xf16> to i32
    %43 = llvm.mlir.constant(5 : i64) : i64
    %44 = llvm.insertelement %42, %38[%43 : i64] : vector<8xi32>
    %45 = llvm.mlir.constant(2 : i64) : i64
    %46 = llvm.extractelement %32[%45 : i64] : vector<4xi8>
    %47 = nvvm.convert.f4x2.to.f16x2 %46 : i8(f4E2M1FN) -> vector<2xf16>
    %48 = llvm.bitcast %47 : vector<2xf16> to i32
    %49 = llvm.mlir.constant(6 : i64) : i64
    %50 = llvm.insertelement %48, %44[%49 : i64] : vector<8xi32>
    %51 = llvm.mlir.constant(3 : i64) : i64
    %52 = llvm.extractelement %32[%51 : i64] : vector<4xi8>
    %53 = nvvm.convert.f4x2.to.f16x2 %52 : i8(f4E2M1FN) -> vector<2xf16>
    %54 = llvm.bitcast %53 : vector<2xf16> to i32
    %55 = llvm.mlir.constant(7 : i64) : i64
    %56 = llvm.insertelement %54, %50[%55 : i64] : vector<8xi32>
    %57 = llvm.bitcast %56 : vector<8xi32> to vector<16xf16>
    return
  }
  func.func @cvt_float_e2m3_to_bf16(%arg0: vector<8xf6E2M3FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf6E2M3FN> to vector<8xi6>
    %1 = llvm.zext %0 : vector<8xi6> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f6x2.to.bf16x2 %9 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %11 = llvm.bitcast %10 : vector<2xbf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.bf16x2 %16 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %18 = llvm.bitcast %17 : vector<2xbf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f6x2.to.bf16x2 %26 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %28 = llvm.bitcast %27 : vector<2xbf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f6x2.to.bf16x2 %33 : vector<2xi8>(f6E2M3FN) -> vector<2xbf16>
    %35 = llvm.bitcast %34 : vector<2xbf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xbf16>
    return
  }
  func.func @cvt_float_e2m1_to_bf16(%arg0: vector<16xf4E2M1FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<16xf4E2M1FN> to vector<16xi4>
    %1 = llvm.bitcast %0 : vector<16xi4> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<4xi8>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<4xi8>
    %8 = nvvm.convert.f4x2.to.bf16x2 %7 : i8(f4E2M1FN) -> vector<2xbf16>
    %9 = llvm.bitcast %8 : vector<2xbf16> to i32
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.insertelement %9, %2[%10 : i64] : vector<8xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.extractelement %5[%12 : i64] : vector<4xi8>
    %14 = nvvm.convert.f4x2.to.bf16x2 %13 : i8(f4E2M1FN) -> vector<2xbf16>
    %15 = llvm.bitcast %14 : vector<2xbf16> to i32
    %16 = llvm.mlir.constant(1 : i64) : i64
    %17 = llvm.insertelement %15, %11[%16 : i64] : vector<8xi32>
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.extractelement %5[%18 : i64] : vector<4xi8>
    %20 = nvvm.convert.f4x2.to.bf16x2 %19 : i8(f4E2M1FN) -> vector<2xbf16>
    %21 = llvm.bitcast %20 : vector<2xbf16> to i32
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.insertelement %21, %17[%22 : i64] : vector<8xi32>
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.extractelement %5[%24 : i64] : vector<4xi8>
    %26 = nvvm.convert.f4x2.to.bf16x2 %25 : i8(f4E2M1FN) -> vector<2xbf16>
    %27 = llvm.bitcast %26 : vector<2xbf16> to i32
    %28 = llvm.mlir.constant(3 : i64) : i64
    %29 = llvm.insertelement %27, %23[%28 : i64] : vector<8xi32>
    %30 = llvm.mlir.constant(1 : i64) : i64
    %31 = llvm.extractelement %1[%30 : i64] : vector<2xi32>
    %32 = llvm.bitcast %31 : i32 to vector<4xi8>
    %33 = llvm.mlir.constant(0 : i64) : i64
    %34 = llvm.extractelement %32[%33 : i64] : vector<4xi8>
    %35 = nvvm.convert.f4x2.to.bf16x2 %34 : i8(f4E2M1FN) -> vector<2xbf16>
    %36 = llvm.bitcast %35 : vector<2xbf16> to i32
    %37 = llvm.mlir.constant(4 : i64) : i64
    %38 = llvm.insertelement %36, %29[%37 : i64] : vector<8xi32>
    %39 = llvm.mlir.constant(1 : i64) : i64
    %40 = llvm.extractelement %32[%39 : i64] : vector<4xi8>
    %41 = nvvm.convert.f4x2.to.bf16x2 %40 : i8(f4E2M1FN) -> vector<2xbf16>
    %42 = llvm.bitcast %41 : vector<2xbf16> to i32
    %43 = llvm.mlir.constant(5 : i64) : i64
    %44 = llvm.insertelement %42, %38[%43 : i64] : vector<8xi32>
    %45 = llvm.mlir.constant(2 : i64) : i64
    %46 = llvm.extractelement %32[%45 : i64] : vector<4xi8>
    %47 = nvvm.convert.f4x2.to.bf16x2 %46 : i8(f4E2M1FN) -> vector<2xbf16>
    %48 = llvm.bitcast %47 : vector<2xbf16> to i32
    %49 = llvm.mlir.constant(6 : i64) : i64
    %50 = llvm.insertelement %48, %44[%49 : i64] : vector<8xi32>
    %51 = llvm.mlir.constant(3 : i64) : i64
    %52 = llvm.extractelement %32[%51 : i64] : vector<4xi8>
    %53 = nvvm.convert.f4x2.to.bf16x2 %52 : i8(f4E2M1FN) -> vector<2xbf16>
    %54 = llvm.bitcast %53 : vector<2xbf16> to i32
    %55 = llvm.mlir.constant(7 : i64) : i64
    %56 = llvm.insertelement %54, %50[%55 : i64] : vector<8xi32>
    %57 = llvm.bitcast %56 : vector<8xi32> to vector<16xbf16>
    return
  }
  func.func @fpext_e4m3fn_to_f32(%arg0: vector<4xf8E4M3FN>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<1xi32>
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<1xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<2xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %17 = llvm.bitcast %16 : vector<2xf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : vector<2xi32> to vector<4xf16>
    %21 = llvm.fpext %20 : vector<4xf16> to vector<4xf32>
    return %21 : vector<4xf32>
  }
  func.func @fpext_e5m2_to_f32(%arg0: vector<4xf8E5M2>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<1xi32>
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<1xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<2xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %17 = llvm.bitcast %16 : vector<2xf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : vector<2xi32> to vector<4xf16>
    %21 = llvm.fpext %20 : vector<4xf16> to vector<4xf32>
    return %21 : vector<4xf32>
  }
  func.func @fpext_e8m0_to_f32(%arg0: vector<4xf8E8M0FNU>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E8M0FNU> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<1xi32>
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<1xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.bf16x2 %8 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %10 = llvm.bitcast %9 : vector<2xbf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<2xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.bf16x2 %15 : vector<2xi8>(f8E8M0FNU) -> vector<2xbf16>
    %17 = llvm.bitcast %16 : vector<2xbf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<2xi32>
    %20 = llvm.bitcast %19 : vector<2xi32> to vector<4xbf16>
    %21 = llvm.fpext %20 : vector<4xbf16> to vector<4xf32>
    return %21 : vector<4xf32>
  }
  func.func @fpext_e2m3_to_f32(%arg0: vector<4xf6E2M3FN>) -> vector<4xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf6E2M3FN> to vector<4xi6>
    %1 = llvm.zext %0 : vector<4xi6> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to vector<1xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f6x2.to.f16x2 %9 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<2xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f6x2.to.f16x2 %16 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<2xi32>
    %21 = llvm.bitcast %20 : vector<2xi32> to vector<4xf16>
    %22 = llvm.fpext %21 : vector<4xf16> to vector<4xf32>
    return %22 : vector<4xf32>
  }
  func.func @fpext_e2m1_to_f32(%arg0: vector<8xf4E2M1FN>) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to vector<1xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<1xi32>
    %5 = llvm.bitcast %4 : i32 to vector<4xi8>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<4xi8>
    %8 = nvvm.convert.f4x2.to.f16x2 %7 : i8(f4E2M1FN) -> vector<2xf16>
    %9 = llvm.bitcast %8 : vector<2xf16> to i32
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.insertelement %9, %2[%10 : i64] : vector<4xi32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.extractelement %5[%12 : i64] : vector<4xi8>
    %14 = nvvm.convert.f4x2.to.f16x2 %13 : i8(f4E2M1FN) -> vector<2xf16>
    %15 = llvm.bitcast %14 : vector<2xf16> to i32
    %16 = llvm.mlir.constant(1 : i64) : i64
    %17 = llvm.insertelement %15, %11[%16 : i64] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.extractelement %5[%18 : i64] : vector<4xi8>
    %20 = nvvm.convert.f4x2.to.f16x2 %19 : i8(f4E2M1FN) -> vector<2xf16>
    %21 = llvm.bitcast %20 : vector<2xf16> to i32
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.insertelement %21, %17[%22 : i64] : vector<4xi32>
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.extractelement %5[%24 : i64] : vector<4xi8>
    %26 = nvvm.convert.f4x2.to.f16x2 %25 : i8(f4E2M1FN) -> vector<2xf16>
    %27 = llvm.bitcast %26 : vector<2xf16> to i32
    %28 = llvm.mlir.constant(3 : i64) : i64
    %29 = llvm.insertelement %27, %23[%28 : i64] : vector<4xi32>
    %30 = llvm.bitcast %29 : vector<4xi32> to vector<8xf16>
    %31 = llvm.fpext %30 : vector<8xf16> to vector<8xf32>
    return %31 : vector<8xf32>
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
    %cst = arith.constant dense<0.000000e+00> : vector<8xf8E4M3FN>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<4xf8E4M3FN> into vector<8xf8E4M3FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<8xf8E4M3FN> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f8x2.to.f16x2 %26 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f8x2.to.f16x2 %33 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    %39 = llvm.fpext %38 : vector<8xf16> to vector<8xf64>
    %40 = vector.extract_strided_slice %39 {offsets = [0], sizes = [4], strides = [1]} : vector<8xf64> to vector<4xf64>
    return %40 : vector<4xf64>
  }
  func.func @fpext_f4_to_f64(%arg0: vector<8xf4E2M1FN>) -> vector<8xf64> {
    %cst = arith.constant dense<0.000000e+00> : vector<16xf4E2M1FN>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<8xf4E2M1FN> into vector<16xf4E2M1FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<16xf4E2M1FN> to vector<16xi4>
    %2 = llvm.bitcast %1 : vector<16xi4> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<8xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<4xi8>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<4xi8>
    %9 = nvvm.convert.f4x2.to.f16x2 %8 : i8(f4E2M1FN) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %3[%11 : i64] : vector<8xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %6[%13 : i64] : vector<4xi8>
    %15 = nvvm.convert.f4x2.to.f16x2 %14 : i8(f4E2M1FN) -> vector<2xf16>
    %16 = llvm.bitcast %15 : vector<2xf16> to i32
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.insertelement %16, %12[%17 : i64] : vector<8xi32>
    %19 = llvm.mlir.constant(2 : i64) : i64
    %20 = llvm.extractelement %6[%19 : i64] : vector<4xi8>
    %21 = nvvm.convert.f4x2.to.f16x2 %20 : i8(f4E2M1FN) -> vector<2xf16>
    %22 = llvm.bitcast %21 : vector<2xf16> to i32
    %23 = llvm.mlir.constant(2 : i64) : i64
    %24 = llvm.insertelement %22, %18[%23 : i64] : vector<8xi32>
    %25 = llvm.mlir.constant(3 : i64) : i64
    %26 = llvm.extractelement %6[%25 : i64] : vector<4xi8>
    %27 = nvvm.convert.f4x2.to.f16x2 %26 : i8(f4E2M1FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(3 : i64) : i64
    %30 = llvm.insertelement %28, %24[%29 : i64] : vector<8xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %2[%31 : i64] : vector<2xi32>
    %33 = llvm.bitcast %32 : i32 to vector<4xi8>
    %34 = llvm.mlir.constant(0 : i64) : i64
    %35 = llvm.extractelement %33[%34 : i64] : vector<4xi8>
    %36 = nvvm.convert.f4x2.to.f16x2 %35 : i8(f4E2M1FN) -> vector<2xf16>
    %37 = llvm.bitcast %36 : vector<2xf16> to i32
    %38 = llvm.mlir.constant(4 : i64) : i64
    %39 = llvm.insertelement %37, %30[%38 : i64] : vector<8xi32>
    %40 = llvm.mlir.constant(1 : i64) : i64
    %41 = llvm.extractelement %33[%40 : i64] : vector<4xi8>
    %42 = nvvm.convert.f4x2.to.f16x2 %41 : i8(f4E2M1FN) -> vector<2xf16>
    %43 = llvm.bitcast %42 : vector<2xf16> to i32
    %44 = llvm.mlir.constant(5 : i64) : i64
    %45 = llvm.insertelement %43, %39[%44 : i64] : vector<8xi32>
    %46 = llvm.mlir.constant(2 : i64) : i64
    %47 = llvm.extractelement %33[%46 : i64] : vector<4xi8>
    %48 = nvvm.convert.f4x2.to.f16x2 %47 : i8(f4E2M1FN) -> vector<2xf16>
    %49 = llvm.bitcast %48 : vector<2xf16> to i32
    %50 = llvm.mlir.constant(6 : i64) : i64
    %51 = llvm.insertelement %49, %45[%50 : i64] : vector<8xi32>
    %52 = llvm.mlir.constant(3 : i64) : i64
    %53 = llvm.extractelement %33[%52 : i64] : vector<4xi8>
    %54 = nvvm.convert.f4x2.to.f16x2 %53 : i8(f4E2M1FN) -> vector<2xf16>
    %55 = llvm.bitcast %54 : vector<2xf16> to i32
    %56 = llvm.mlir.constant(7 : i64) : i64
    %57 = llvm.insertelement %55, %51[%56 : i64] : vector<8xi32>
    %58 = llvm.bitcast %57 : vector<8xi32> to vector<16xf16>
    %59 = llvm.fpext %58 : vector<16xf16> to vector<16xf64>
    %60 = vector.extract_strided_slice %59 {offsets = [0], sizes = [8], strides = [1]} : vector<16xf64> to vector<8xf64>
    return %60 : vector<8xf64>
  }
  func.func @fpext_e2m3_to_f64(%arg0: vector<4xf6E2M3FN>) -> vector<4xf64> {
    %cst = arith.constant dense<0.000000e+00> : vector<8xf6E2M3FN>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<4xf6E2M3FN> into vector<8xf6E2M3FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<8xf6E2M3FN> to vector<8xi6>
    %2 = llvm.zext %1 : vector<8xi6> to vector<8xi8>
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<2xi32>
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %3[%5 : i64] : vector<2xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.extractelement %7[%8 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f6x2.to.f16x2 %10 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.insertelement %12, %4[%13 : i64] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %7[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : i16 to vector<2xi8>
    %18 = nvvm.convert.f6x2.to.f16x2 %17 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.insertelement %19, %14[%20 : i64] : vector<4xi32>
    %22 = llvm.mlir.constant(1 : i64) : i64
    %23 = llvm.extractelement %3[%22 : i64] : vector<2xi32>
    %24 = llvm.bitcast %23 : i32 to vector<2xi16>
    %25 = llvm.mlir.constant(0 : i64) : i64
    %26 = llvm.extractelement %24[%25 : i64] : vector<2xi16>
    %27 = llvm.bitcast %26 : i16 to vector<2xi8>
    %28 = nvvm.convert.f6x2.to.f16x2 %27 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %29 = llvm.bitcast %28 : vector<2xf16> to i32
    %30 = llvm.mlir.constant(2 : i64) : i64
    %31 = llvm.insertelement %29, %21[%30 : i64] : vector<4xi32>
    %32 = llvm.mlir.constant(1 : i64) : i64
    %33 = llvm.extractelement %24[%32 : i64] : vector<2xi16>
    %34 = llvm.bitcast %33 : i16 to vector<2xi8>
    %35 = nvvm.convert.f6x2.to.f16x2 %34 : vector<2xi8>(f6E2M3FN) -> vector<2xf16>
    %36 = llvm.bitcast %35 : vector<2xf16> to i32
    %37 = llvm.mlir.constant(3 : i64) : i64
    %38 = llvm.insertelement %36, %31[%37 : i64] : vector<4xi32>
    %39 = llvm.bitcast %38 : vector<4xi32> to vector<8xf16>
    %40 = llvm.fpext %39 : vector<8xf16> to vector<8xf64>
    %41 = vector.extract_strided_slice %40 {offsets = [0], sizes = [4], strides = [1]} : vector<8xf64> to vector<4xf64>
    return %41 : vector<4xf64>
  }
  func.func @fpext_scalar_f8_to_f16(%arg0: f8E4M3FN) -> f16 {
    %0 = vector.broadcast %arg0 : f8E4M3FN to vector<1xf8E4M3FN>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf8E4M3FN> into vector<4xf8E4M3FN>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4xf8E4M3FN> to vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %3[%5 : i64] : vector<1xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.extractelement %7[%8 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.insertelement %12, %4[%13 : i64] : vector<2xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %7[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : i16 to vector<2xi8>
    %18 = nvvm.convert.f8x2.to.f16x2 %17 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.insertelement %19, %14[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = vector.extract_strided_slice %22 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf16> to vector<1xf16>
    %24 = vector.extract %23[0] : f16 from vector<1xf16>
    return %24 : f16
  }
  func.func @fpext_scalar_f8_to_f32(%arg0: f8E4M3FN) -> f32 {
    %0 = vector.broadcast %arg0 : f8E4M3FN to vector<1xf8E4M3FN>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf8E4M3FN> into vector<4xf8E4M3FN>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4xf8E4M3FN> to vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %3[%5 : i64] : vector<1xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.extractelement %7[%8 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.insertelement %12, %4[%13 : i64] : vector<2xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %7[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : i16 to vector<2xi8>
    %18 = nvvm.convert.f8x2.to.f16x2 %17 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.insertelement %19, %14[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = llvm.fpext %22 : vector<4xf16> to vector<4xf32>
    %24 = vector.extract_strided_slice %23 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf32> to vector<1xf32>
    %25 = vector.extract %24[0] : f32 from vector<1xf32>
    return %25 : f32
  }
  func.func @fpext_v2x4_f8_to_f16(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf16> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf8E4M3FN> to vector<8xf8E4M3FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<8xf8E4M3FN> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f8x2.to.f16x2 %26 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f8x2.to.f16x2 %33 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    %39 = vector.shape_cast %38 : vector<8xf16> to vector<2x4xf16>
    return %39 : vector<2x4xf16>
  }
  func.func @fpext_v2x4_f8_to_f32(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf32> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf8E4M3FN> to vector<8xf8E4M3FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<8xf8E4M3FN> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f8x2.to.f16x2 %26 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f8x2.to.f16x2 %33 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    %39 = llvm.fpext %38 : vector<8xf16> to vector<8xf32>
    %40 = vector.shape_cast %39 : vector<8xf32> to vector<2x4xf32>
    return %40 : vector<2x4xf32>
  }
  func.func @fpext_v3f8_to_v3f16(%arg0: vector<3xf8E5M2>) -> vector<3xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<3xf8E5M2> into vector<4xf8E5M2>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4xf8E5M2> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to vector<1xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<2xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<2xi32>
    %21 = llvm.bitcast %20 : vector<2xi32> to vector<4xf16>
    %22 = vector.extract_strided_slice %21 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf16> to vector<3xf16>
    return %22 : vector<3xf16>
  }
  func.func @fpext_v3_f8_to_f32(%arg0: vector<3xf8E5M2>) -> vector<3xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<3xf8E5M2> into vector<4xf8E5M2>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4xf8E5M2> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to vector<1xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<2xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<2xi32>
    %21 = llvm.bitcast %20 : vector<2xi32> to vector<4xf16>
    %22 = llvm.fpext %21 : vector<4xf16> to vector<4xf32>
    %23 = vector.extract_strided_slice %22 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf32> to vector<3xf32>
    return %23 : vector<3xf32>
  }
  func.func @fpext_v3x1_f8_to_f16(%arg0: vector<3x1xf8E4M3FN>) -> vector<3x1xf16> {
    %0 = vector.shape_cast %arg0 : vector<3x1xf8E4M3FN> to vector<3xf8E4M3FN>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<3xf8E4M3FN> into vector<4xf8E4M3FN>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4xf8E4M3FN> to vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %3[%5 : i64] : vector<1xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.extractelement %7[%8 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.insertelement %12, %4[%13 : i64] : vector<2xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %7[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : i16 to vector<2xi8>
    %18 = nvvm.convert.f8x2.to.f16x2 %17 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.insertelement %19, %14[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = vector.extract_strided_slice %22 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf16> to vector<3xf16>
    %24 = vector.shape_cast %23 : vector<3xf16> to vector<3x1xf16>
    return %24 : vector<3x1xf16>
  }
  func.func @fpext_f8_to_f16_relu(%arg0: vector<8xf8E4M3FN>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf8E4M3FN> to vector<8xi8>
    %1 = llvm.bitcast %0 : vector<8xi8> to vector<2xi32>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.extractelement %1[%3 : i64] : vector<2xi32>
    %5 = llvm.bitcast %4 : i32 to vector<2xi16>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.extractelement %5[%6 : i64] : vector<2xi16>
    %8 = llvm.bitcast %7 : i16 to vector<2xi8>
    %9 = nvvm.convert.f8x2.to.f16x2 %8 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %10 = llvm.bitcast %9 : vector<2xf16> to i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.insertelement %10, %2[%11 : i64] : vector<4xi32>
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.extractelement %5[%13 : i64] : vector<2xi16>
    %15 = llvm.bitcast %14 : i16 to vector<2xi8>
    %16 = nvvm.convert.f8x2.to.f16x2 %15 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %17 = llvm.bitcast %16 : vector<2xf16> to i32
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.insertelement %17, %12[%18 : i64] : vector<4xi32>
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.extractelement %1[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : i32 to vector<2xi16>
    %23 = llvm.mlir.constant(0 : i64) : i64
    %24 = llvm.extractelement %22[%23 : i64] : vector<2xi16>
    %25 = llvm.bitcast %24 : i16 to vector<2xi8>
    %26 = nvvm.convert.f8x2.to.f16x2 %25 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %27 = llvm.bitcast %26 : vector<2xf16> to i32
    %28 = llvm.mlir.constant(2 : i64) : i64
    %29 = llvm.insertelement %27, %19[%28 : i64] : vector<4xi32>
    %30 = llvm.mlir.constant(1 : i64) : i64
    %31 = llvm.extractelement %22[%30 : i64] : vector<2xi16>
    %32 = llvm.bitcast %31 : i16 to vector<2xi8>
    %33 = nvvm.convert.f8x2.to.f16x2 %32 {relu = true} : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %34 = llvm.bitcast %33 : vector<2xf16> to i32
    %35 = llvm.mlir.constant(3 : i64) : i64
    %36 = llvm.insertelement %34, %29[%35 : i64] : vector<4xi32>
    %37 = llvm.bitcast %36 : vector<4xi32> to vector<8xf16>
    return
  }
  func.func @e2e_scalar_f8_to_f16(%arg0: f8E4M3FN) -> f16 {
    %0 = vector.broadcast %arg0 : f8E4M3FN to vector<1xf8E4M3FN>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf8E4M3FN> into vector<4xf8E4M3FN>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4xf8E4M3FN> to vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %3[%5 : i64] : vector<1xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.extractelement %7[%8 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.insertelement %12, %4[%13 : i64] : vector<2xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %7[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : i16 to vector<2xi8>
    %18 = nvvm.convert.f8x2.to.f16x2 %17 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.insertelement %19, %14[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = vector.extract_strided_slice %22 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf16> to vector<1xf16>
    %24 = vector.extract %23[0] : f16 from vector<1xf16>
    return %24 : f16
  }
  func.func @e2e_v2x4_f8_to_f16(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf16> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf8E4M3FN> to vector<8xf8E4M3FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<8xf8E4M3FN> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f8x2.to.f16x2 %26 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f8x2.to.f16x2 %33 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    %39 = vector.shape_cast %38 : vector<8xf16> to vector<2x4xf16>
    return %39 : vector<2x4xf16>
  }
  func.func @e2e_v3f8_to_v3f16(%arg0: vector<3xf8E5M2>) -> vector<3xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<3xf8E5M2> into vector<4xf8E5M2>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4xf8E5M2> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to vector<1xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<2xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<2xi32>
    %21 = llvm.bitcast %20 : vector<2xi32> to vector<4xf16>
    %22 = vector.extract_strided_slice %21 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf16> to vector<3xf16>
    return %22 : vector<3xf16>
  }
  func.func @e2e_scalar_f8_to_f32(%arg0: f8E4M3FN) -> f32 {
    %0 = vector.broadcast %arg0 : f8E4M3FN to vector<1xf8E4M3FN>
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %1 = vector.insert_strided_slice %0, %cst {offsets = [0], strides = [1]} : vector<1xf8E4M3FN> into vector<4xf8E4M3FN>
    %2 = builtin.unrealized_conversion_cast %1 : vector<4xf8E4M3FN> to vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.extractelement %3[%5 : i64] : vector<1xi32>
    %7 = llvm.bitcast %6 : i32 to vector<2xi16>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.extractelement %7[%8 : i64] : vector<2xi16>
    %10 = llvm.bitcast %9 : i16 to vector<2xi8>
    %11 = nvvm.convert.f8x2.to.f16x2 %10 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %12 = llvm.bitcast %11 : vector<2xf16> to i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.insertelement %12, %4[%13 : i64] : vector<2xi32>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.extractelement %7[%15 : i64] : vector<2xi16>
    %17 = llvm.bitcast %16 : i16 to vector<2xi8>
    %18 = nvvm.convert.f8x2.to.f16x2 %17 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %19 = llvm.bitcast %18 : vector<2xf16> to i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.insertelement %19, %14[%20 : i64] : vector<2xi32>
    %22 = llvm.bitcast %21 : vector<2xi32> to vector<4xf16>
    %23 = llvm.fpext %22 : vector<4xf16> to vector<4xf32>
    %24 = vector.extract_strided_slice %23 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf32> to vector<1xf32>
    %25 = vector.extract %24[0] : f32 from vector<1xf32>
    return %25 : f32
  }
  func.func @e2e_v2x4_f8_to_f32(%arg0: vector<2x4xf8E4M3FN>) -> vector<2x4xf32> {
    %0 = vector.shape_cast %arg0 : vector<2x4xf8E4M3FN> to vector<8xf8E4M3FN>
    %1 = builtin.unrealized_conversion_cast %0 : vector<8xf8E4M3FN> to vector<8xi8>
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<2xi32>
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<4xi32>
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.extractelement %2[%21 : i64] : vector<2xi32>
    %23 = llvm.bitcast %22 : i32 to vector<2xi16>
    %24 = llvm.mlir.constant(0 : i64) : i64
    %25 = llvm.extractelement %23[%24 : i64] : vector<2xi16>
    %26 = llvm.bitcast %25 : i16 to vector<2xi8>
    %27 = nvvm.convert.f8x2.to.f16x2 %26 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %28 = llvm.bitcast %27 : vector<2xf16> to i32
    %29 = llvm.mlir.constant(2 : i64) : i64
    %30 = llvm.insertelement %28, %20[%29 : i64] : vector<4xi32>
    %31 = llvm.mlir.constant(1 : i64) : i64
    %32 = llvm.extractelement %23[%31 : i64] : vector<2xi16>
    %33 = llvm.bitcast %32 : i16 to vector<2xi8>
    %34 = nvvm.convert.f8x2.to.f16x2 %33 : vector<2xi8>(f8E4M3FN) -> vector<2xf16>
    %35 = llvm.bitcast %34 : vector<2xf16> to i32
    %36 = llvm.mlir.constant(3 : i64) : i64
    %37 = llvm.insertelement %35, %30[%36 : i64] : vector<4xi32>
    %38 = llvm.bitcast %37 : vector<4xi32> to vector<8xf16>
    %39 = llvm.fpext %38 : vector<8xf16> to vector<8xf32>
    %40 = vector.shape_cast %39 : vector<8xf32> to vector<2x4xf32>
    return %40 : vector<2x4xf32>
  }
  func.func @e2e_v3f8_to_v3f32(%arg0: vector<3xf8E5M2>) -> vector<3xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %0 = vector.insert_strided_slice %arg0, %cst {offsets = [0], strides = [1]} : vector<3xf8E5M2> into vector<4xf8E5M2>
    %1 = builtin.unrealized_conversion_cast %0 : vector<4xf8E5M2> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to vector<1xi32>
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<1xi32>
    %6 = llvm.bitcast %5 : i32 to vector<2xi16>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.extractelement %6[%7 : i64] : vector<2xi16>
    %9 = llvm.bitcast %8 : i16 to vector<2xi8>
    %10 = nvvm.convert.f8x2.to.f16x2 %9 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %11 = llvm.bitcast %10 : vector<2xf16> to i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.insertelement %11, %3[%12 : i64] : vector<2xi32>
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.extractelement %6[%14 : i64] : vector<2xi16>
    %16 = llvm.bitcast %15 : i16 to vector<2xi8>
    %17 = nvvm.convert.f8x2.to.f16x2 %16 : vector<2xi8>(f8E5M2) -> vector<2xf16>
    %18 = llvm.bitcast %17 : vector<2xf16> to i32
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.insertelement %18, %13[%19 : i64] : vector<2xi32>
    %21 = llvm.bitcast %20 : vector<2xi32> to vector<4xf16>
    %22 = llvm.fpext %21 : vector<4xf16> to vector<4xf32>
    %23 = vector.extract_strided_slice %22 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf32> to vector<3xf32>
    return %23 : vector<3xf32>
  }
}

