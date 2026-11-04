module {
  func.func @scaled_ext_full_f8e4m3_f32(%arg0: vector<4xf8E4M3FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.scalef32.pk.f32.fp8 %1[false], %arg1 : vector<2xf32>
    return %2 : vector<2xf32>
  }
  func.func @scaled_ext_full_f8e4m3_f16(%arg0: vector<4xf8E4M3FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.scalef32.pk.f16.fp8 %1[false], %arg1 : vector<2xf16>
    return %2 : vector<2xf16>
  }
  func.func @scaled_ext_full_f8e4m3_bf16(%arg0: vector<4xf8E4M3FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.scalef32.pk.bf16.fp8 %1[false], %arg1 : vector<2xbf16>
    return %2 : vector<2xbf16>
  }
  func.func @scaled_ext_half_f8e4m3_f32(%arg0: vector<2xf8E4M3FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FN> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f32.fp8 %8[false], %arg1 : vector<2xf32>
    return %9 : vector<2xf32>
  }
  func.func @scaled_ext_half_f8e4m3_f16(%arg0: vector<2xf8E4M3FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FN> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f16.fp8 %8[false], %arg1 : vector<2xf16>
    return %9 : vector<2xf16>
  }
  func.func @scaled_ext_half_f8e4m3_bf16(%arg0: vector<2xf8E4M3FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FN> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.bf16.fp8 %8[false], %arg1 : vector<2xbf16>
    return %9 : vector<2xbf16>
  }
  func.func @scaled_ext_scalar_f8e4m3_f32(%arg0: vector<2xf8E4M3FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FN> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f32.fp8 %8[false], %arg1 : vector<2xf32>
    return %9 : vector<2xf32>
  }
  func.func @scaled_ext_scalar_f8e4m3_f16(%arg0: vector<2xf8E4M3FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FN> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f16.fp8 %8[false], %arg1 : vector<2xf16>
    return %9 : vector<2xf16>
  }
  func.func @scaled_ext_scalar_f8e4m3_bf16(%arg0: vector<2xf8E4M3FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FN> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.bf16.fp8 %8[false], %arg1 : vector<2xbf16>
    return %9 : vector<2xbf16>
  }
  func.func @scaled_ext_full_f8e5m2_f32(%arg0: vector<4xf8E5M2>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.scalef32.pk.f32.bf8 %1[false], %arg1 : vector<2xf32>
    return %2 : vector<2xf32>
  }
  func.func @scaled_ext_full_f8e5m2_f16(%arg0: vector<4xf8E5M2>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.scalef32.pk.f16.bf8 %1[false], %arg1 : vector<2xf16>
    return %2 : vector<2xf16>
  }
  func.func @scaled_ext_full_f8e5m2_bf16(%arg0: vector<4xf8E5M2>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.scalef32.pk.bf16.bf8 %1[false], %arg1 : vector<2xbf16>
    return %2 : vector<2xbf16>
  }
  func.func @scaled_ext_half_f8e5m2_f32(%arg0: vector<2xf8E5M2>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E5M2> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f32.bf8 %8[false], %arg1 : vector<2xf32>
    return %9 : vector<2xf32>
  }
  func.func @scaled_ext_half_f8e5m2_f16(%arg0: vector<2xf8E5M2>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E5M2> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f16.bf8 %8[false], %arg1 : vector<2xf16>
    return %9 : vector<2xf16>
  }
  func.func @scaled_ext_half_f8e5m2_bf16(%arg0: vector<2xf8E5M2>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E5M2> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.bf16.bf8 %8[false], %arg1 : vector<2xbf16>
    return %9 : vector<2xbf16>
  }
  func.func @scaled_ext_scalar_f8e5m2_f32(%arg0: vector<2xf8E5M2>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E5M2> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f32.bf8 %8[false], %arg1 : vector<2xf32>
    return %9 : vector<2xf32>
  }
  func.func @scaled_ext_scalar_f8e5m2_f16(%arg0: vector<2xf8E5M2>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E5M2> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.f16.bf8 %8[false], %arg1 : vector<2xf16>
    return %9 : vector<2xf16>
  }
  func.func @scaled_ext_scalar_f8e5m2_bf16(%arg0: vector<2xf8E5M2>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E5M2> to vector<2xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.scalef32.pk.bf16.bf8 %8[false], %arg1 : vector<2xbf16>
    return %9 : vector<2xbf16>
  }
  func.func @scaled_ext_full_f4e2m1_f32(%arg0: vector<8xf4E2M1FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = rocdl.cvt.scalef32.pk.f32.fp4 %1[0], %arg1 : vector<2xf32>
    return %2 : vector<2xf32>
  }
  func.func @scaled_ext_full_f4e2m1_f16(%arg0: vector<8xf4E2M1FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = rocdl.cvt.scalef32.pk.f16.fp4 %1[0], %arg1 : vector<2xf16>
    return %2 : vector<2xf16>
  }
  func.func @scaled_ext_full_f4e2m1_bf16(%arg0: vector<8xf4E2M1FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = rocdl.cvt.scalef32.pk.bf16.fp4 %1[0], %arg1 : vector<2xbf16>
    return %2 : vector<2xbf16>
  }
  func.func @scaled_ext_half_f4e2m1_f32(%arg0: vector<8xf4E2M1FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = rocdl.cvt.scalef32.pk.f32.fp4 %1[0], %arg1 : vector<2xf32>
    return %2 : vector<2xf32>
  }
  func.func @scaled_ext_half_f4e2m1_f16(%arg0: vector<4xf4E2M1FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf4E2M1FN> to vector<4xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<4xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<4xi4>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<8xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.extractelement %0[%8 : i32] : vector<4xi4>
    %10 = llvm.insertelement %9, %7[%8 : i32] : vector<8xi4>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.extractelement %0[%11 : i32] : vector<4xi4>
    %13 = llvm.insertelement %12, %10[%11 : i32] : vector<8xi4>
    %14 = llvm.bitcast %13 : vector<8xi4> to i32
    %15 = rocdl.cvt.scalef32.pk.f16.fp4 %14[0], %arg1 : vector<2xf16>
    return %15 : vector<2xf16>
  }
  func.func @scaled_ext_half_f4e2m1_bf16(%arg0: vector<4xf4E2M1FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf4E2M1FN> to vector<4xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<4xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<4xi4>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<8xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.extractelement %0[%8 : i32] : vector<4xi4>
    %10 = llvm.insertelement %9, %7[%8 : i32] : vector<8xi4>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.extractelement %0[%11 : i32] : vector<4xi4>
    %13 = llvm.insertelement %12, %10[%11 : i32] : vector<8xi4>
    %14 = llvm.bitcast %13 : vector<8xi4> to i32
    %15 = rocdl.cvt.scalef32.pk.bf16.fp4 %14[0], %arg1 : vector<2xbf16>
    return %15 : vector<2xbf16>
  }
  func.func @scaled_ext_scalar_f4e2m1_f32(%arg0: vector<2xf4E2M1FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf4E2M1FN> to vector<2xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi4>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<8xi4>
    %8 = llvm.bitcast %7 : vector<8xi4> to i32
    %9 = rocdl.cvt.scalef32.pk.f32.fp4 %8[0], %arg1 : vector<2xf32>
    return %9 : vector<2xf32>
  }
  func.func @scaled_ext_scalar_f4e2m1_f16(%arg0: vector<2xf4E2M1FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf4E2M1FN> to vector<2xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi4>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<8xi4>
    %8 = llvm.bitcast %7 : vector<8xi4> to i32
    %9 = rocdl.cvt.scalef32.pk.f16.fp4 %8[0], %arg1 : vector<2xf16>
    return %9 : vector<2xf16>
  }
  func.func @scaled_ext_scalar_f4e2m1_bf16(%arg0: vector<2xf4E2M1FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf4E2M1FN> to vector<2xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi4>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<8xi4>
    %8 = llvm.bitcast %7 : vector<8xi4> to i32
    %9 = rocdl.cvt.scalef32.pk.bf16.fp4 %8[0], %arg1 : vector<2xbf16>
    return %9 : vector<2xbf16>
  }
  func.func @scaled_ext_one_f8e4m3_f32(%arg0: vector<1xf8E4M3FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf8E4M3FN> to vector<1xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = rocdl.cvt.scalef32.pk.f32.fp8 %5[false], %arg1 : vector<2xf32>
    return %6 : vector<2xf32>
  }
  func.func @scaled_ext_one_f8e4m3_f16(%arg0: vector<1xf8E4M3FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf8E4M3FN> to vector<1xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = rocdl.cvt.scalef32.pk.f16.fp8 %5[false], %arg1 : vector<2xf16>
    return %6 : vector<2xf16>
  }
  func.func @scaled_ext_one_f8e4m3_bf16(%arg0: vector<1xf8E4M3FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf8E4M3FN> to vector<1xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = rocdl.cvt.scalef32.pk.bf16.fp8 %5[false], %arg1 : vector<2xbf16>
    return %6 : vector<2xbf16>
  }
  func.func @scaled_ext_one_f8e5m2_f32(%arg0: vector<1xf8E5M2>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf8E5M2> to vector<1xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = rocdl.cvt.scalef32.pk.f32.bf8 %5[false], %arg1 : vector<2xf32>
    return %6 : vector<2xf32>
  }
  func.func @scaled_ext_one_f8e5m2_f16(%arg0: vector<1xf8E5M2>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf8E5M2> to vector<1xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = rocdl.cvt.scalef32.pk.f16.bf8 %5[false], %arg1 : vector<2xf16>
    return %6 : vector<2xf16>
  }
  func.func @scaled_ext_one_f8e5m2_bf16(%arg0: vector<1xf8E5M2>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf8E5M2> to vector<1xi8>
    %1 = llvm.mlir.zero : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = rocdl.cvt.scalef32.pk.bf16.bf8 %5[false], %arg1 : vector<2xbf16>
    return %6 : vector<2xbf16>
  }
  func.func @scaled_ext_one_f4e2m1_f32(%arg0: vector<1xf4E2M1FN>, %arg1: f32) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf4E2M1FN> to vector<1xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.bitcast %4 : vector<8xi4> to i32
    %6 = rocdl.cvt.scalef32.pk.f32.fp4 %5[0], %arg1 : vector<2xf32>
    return %6 : vector<2xf32>
  }
  func.func @scaled_ext_one_f4e2m1_f16(%arg0: vector<1xf4E2M1FN>, %arg1: f32) -> vector<2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf4E2M1FN> to vector<1xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.bitcast %4 : vector<8xi4> to i32
    %6 = rocdl.cvt.scalef32.pk.f16.fp4 %5[0], %arg1 : vector<2xf16>
    return %6 : vector<2xf16>
  }
  func.func @scaled_ext_one_f4e2m1_bf16(%arg0: vector<1xf4E2M1FN>, %arg1: f32) -> vector<2xbf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1xf4E2M1FN> to vector<1xi4>
    %1 = llvm.mlir.zero : vector<8xi4>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<1xi4>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<8xi4>
    %5 = llvm.bitcast %4 : vector<8xi4> to i32
    %6 = rocdl.cvt.scalef32.pk.bf16.fp4 %5[0], %arg1 : vector<2xbf16>
    return %6 : vector<2xbf16>
  }
}

