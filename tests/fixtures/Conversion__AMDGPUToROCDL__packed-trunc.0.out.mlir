module {
  func.func @packed_scaled_trunc_f8e4m3_f32(%arg0: vector<2xf32>, %arg1: f32) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.extractelement %arg0[%1 : i32] : vector<2xf32>
    %4 = llvm.extractelement %arg0[%2 : i32] : vector<2xf32>
    %5 = rocdl.cvt.scalef32.pk.fp8.f32 %3, %4, %arg1 -> %0[false] : vector<2xi16>
    %6 = llvm.bitcast %5 : vector<2xi16> to vector<4xi8>
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E4M3FN>
    return %7 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_f8e4m3_f32_vec1(%arg0: vector<1xf32>, %arg1: f32) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xf32>
    %3 = llvm.mlir.zero : vector<2xf32>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.extractelement %4[%5 : i32] : vector<2xf32>
    %8 = llvm.extractelement %4[%6 : i32] : vector<2xf32>
    %9 = rocdl.cvt.scalef32.pk.fp8.f32 %7, %8, %arg1 -> %0[false] : vector<2xi16>
    %10 = llvm.bitcast %9 : vector<2xi16> to vector<4xi8>
    %11 = builtin.unrealized_conversion_cast %10 : vector<4xi8> to vector<4xf8E4M3FN>
    return %11 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_into_f8e4m3_f32(%arg0: vector<2xf32>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> vector<4xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.extractelement %arg0[%2 : i32] : vector<2xf32>
    %5 = llvm.extractelement %arg0[%3 : i32] : vector<2xf32>
    %6 = rocdl.cvt.scalef32.pk.fp8.f32 %4, %5, %arg2 -> %1[false] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to vector<4xi8>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xi8> to vector<4xf8E4M3FN>
    return %8 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_into_f8e4m3_f32_vec1(%arg0: vector<1xf32>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> vector<4xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xf32>
    %4 = llvm.mlir.zero : vector<2xf32>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.extractelement %5[%6 : i32] : vector<2xf32>
    %9 = llvm.extractelement %5[%7 : i32] : vector<2xf32>
    %10 = rocdl.cvt.scalef32.pk.fp8.f32 %8, %9, %arg2 -> %1[false] : vector<2xi16>
    %11 = llvm.bitcast %10 : vector<2xi16> to vector<4xi8>
    %12 = builtin.unrealized_conversion_cast %11 : vector<4xi8> to vector<4xf8E4M3FN>
    return %12 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_f8e4m3_f16(%arg0: vector<2xf16>, %arg1: f32) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = rocdl.cvt.scalef32.pk.fp8.f16 %arg0, %arg1 -> %0[false] : vector<2xi16>
    %2 = llvm.bitcast %1 : vector<2xi16> to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi8> to vector<4xf8E4M3FN>
    return %3 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_f8e4m3_f16_vec1(%arg0: vector<1xf16>, %arg1: f32) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xf16>
    %3 = llvm.mlir.zero : vector<2xf16>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xf16>
    %5 = rocdl.cvt.scalef32.pk.fp8.f16 %4, %arg1 -> %0[false] : vector<2xi16>
    %6 = llvm.bitcast %5 : vector<2xi16> to vector<4xi8>
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E4M3FN>
    return %7 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_into_f8e4m3_f16(%arg0: vector<2xf16>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> vector<4xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = rocdl.cvt.scalef32.pk.fp8.f16 %arg0, %arg2 -> %1[false] : vector<2xi16>
    %3 = llvm.bitcast %2 : vector<2xi16> to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E4M3FN>
    return %4 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_into_f8e4m3_f16_vec1(%arg0: vector<1xf16>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> vector<4xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xf16>
    %4 = llvm.mlir.zero : vector<2xf16>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xf16>
    %6 = rocdl.cvt.scalef32.pk.fp8.f16 %5, %arg2 -> %1[false] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to vector<4xi8>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xi8> to vector<4xf8E4M3FN>
    return %8 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_f8e4m3_bf16(%arg0: vector<2xbf16>, %arg1: f32) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = rocdl.cvt.scalef32.pk.fp8.bf16 %arg0, %arg1 -> %0[false] : vector<2xi16>
    %2 = llvm.bitcast %1 : vector<2xi16> to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi8> to vector<4xf8E4M3FN>
    return %3 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_f8e4m3_bf16_vec1(%arg0: vector<1xbf16>, %arg1: f32) -> vector<4xf8E4M3FN> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xbf16>
    %3 = llvm.mlir.zero : vector<2xbf16>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xbf16>
    %5 = rocdl.cvt.scalef32.pk.fp8.bf16 %4, %arg1 -> %0[false] : vector<2xi16>
    %6 = llvm.bitcast %5 : vector<2xi16> to vector<4xi8>
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E4M3FN>
    return %7 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_into_f8e4m3_bf16(%arg0: vector<2xbf16>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> vector<4xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = rocdl.cvt.scalef32.pk.fp8.bf16 %arg0, %arg2 -> %1[false] : vector<2xi16>
    %3 = llvm.bitcast %2 : vector<2xi16> to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E4M3FN>
    return %4 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_into_f8e4m3_bf16_vec1(%arg0: vector<1xbf16>, %arg1: vector<4xf8E4M3FN>, %arg2: f32) -> vector<4xf8E4M3FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E4M3FN> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xbf16>
    %4 = llvm.mlir.zero : vector<2xbf16>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xbf16>
    %6 = rocdl.cvt.scalef32.pk.fp8.bf16 %5, %arg2 -> %1[false] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to vector<4xi8>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xi8> to vector<4xf8E4M3FN>
    return %8 : vector<4xf8E4M3FN>
  }
  func.func @packed_scaled_trunc_f8e5m2_f32(%arg0: vector<2xf32>, %arg1: f32) -> vector<4xf8E5M2> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.extractelement %arg0[%1 : i32] : vector<2xf32>
    %4 = llvm.extractelement %arg0[%2 : i32] : vector<2xf32>
    %5 = rocdl.cvt.scalef32.pk.bf8.f32 %3, %4, %arg1 -> %0[false] : vector<2xi16>
    %6 = llvm.bitcast %5 : vector<2xi16> to vector<4xi8>
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    return %7 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_f8e5m2_f32_vec1(%arg0: vector<1xf32>, %arg1: f32) -> vector<4xf8E5M2> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xf32>
    %3 = llvm.mlir.zero : vector<2xf32>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.extractelement %4[%5 : i32] : vector<2xf32>
    %8 = llvm.extractelement %4[%6 : i32] : vector<2xf32>
    %9 = rocdl.cvt.scalef32.pk.bf8.f32 %7, %8, %arg1 -> %0[false] : vector<2xi16>
    %10 = llvm.bitcast %9 : vector<2xi16> to vector<4xi8>
    %11 = builtin.unrealized_conversion_cast %10 : vector<4xi8> to vector<4xf8E5M2>
    return %11 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_into_f8e5m2_f32(%arg0: vector<2xf32>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> vector<4xf8E5M2> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.extractelement %arg0[%2 : i32] : vector<2xf32>
    %5 = llvm.extractelement %arg0[%3 : i32] : vector<2xf32>
    %6 = rocdl.cvt.scalef32.pk.bf8.f32 %4, %5, %arg2 -> %1[false] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to vector<4xi8>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xi8> to vector<4xf8E5M2>
    return %8 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_into_f8e5m2_f32_vec1(%arg0: vector<1xf32>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> vector<4xf8E5M2> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xf32>
    %4 = llvm.mlir.zero : vector<2xf32>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.extractelement %5[%6 : i32] : vector<2xf32>
    %9 = llvm.extractelement %5[%7 : i32] : vector<2xf32>
    %10 = rocdl.cvt.scalef32.pk.bf8.f32 %8, %9, %arg2 -> %1[false] : vector<2xi16>
    %11 = llvm.bitcast %10 : vector<2xi16> to vector<4xi8>
    %12 = builtin.unrealized_conversion_cast %11 : vector<4xi8> to vector<4xf8E5M2>
    return %12 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_f8e5m2_f16(%arg0: vector<2xf16>, %arg1: f32) -> vector<4xf8E5M2> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = rocdl.cvt.scalef32.pk.bf8.f16 %arg0, %arg1 -> %0[false] : vector<2xi16>
    %2 = llvm.bitcast %1 : vector<2xi16> to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi8> to vector<4xf8E5M2>
    return %3 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_f8e5m2_f16_vec1(%arg0: vector<1xf16>, %arg1: f32) -> vector<4xf8E5M2> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xf16>
    %3 = llvm.mlir.zero : vector<2xf16>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xf16>
    %5 = rocdl.cvt.scalef32.pk.bf8.f16 %4, %arg1 -> %0[false] : vector<2xi16>
    %6 = llvm.bitcast %5 : vector<2xi16> to vector<4xi8>
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    return %7 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_into_f8e5m2_f16(%arg0: vector<2xf16>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> vector<4xf8E5M2> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = rocdl.cvt.scalef32.pk.bf8.f16 %arg0, %arg2 -> %1[false] : vector<2xi16>
    %3 = llvm.bitcast %2 : vector<2xi16> to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E5M2>
    return %4 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_into_f8e5m2_f16_vec1(%arg0: vector<1xf16>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> vector<4xf8E5M2> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xf16>
    %4 = llvm.mlir.zero : vector<2xf16>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xf16>
    %6 = rocdl.cvt.scalef32.pk.bf8.f16 %5, %arg2 -> %1[false] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to vector<4xi8>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xi8> to vector<4xf8E5M2>
    return %8 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_f8e5m2_bf16(%arg0: vector<2xbf16>, %arg1: f32) -> vector<4xf8E5M2> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = rocdl.cvt.scalef32.pk.bf8.bf16 %arg0, %arg1 -> %0[false] : vector<2xi16>
    %2 = llvm.bitcast %1 : vector<2xi16> to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi8> to vector<4xf8E5M2>
    return %3 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_f8e5m2_bf16_vec1(%arg0: vector<1xbf16>, %arg1: f32) -> vector<4xf8E5M2> {
    %0 = llvm.mlir.zero : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xbf16>
    %3 = llvm.mlir.zero : vector<2xbf16>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xbf16>
    %5 = rocdl.cvt.scalef32.pk.bf8.bf16 %4, %arg1 -> %0[false] : vector<2xi16>
    %6 = llvm.bitcast %5 : vector<2xi16> to vector<4xi8>
    %7 = builtin.unrealized_conversion_cast %6 : vector<4xi8> to vector<4xf8E5M2>
    return %7 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_into_f8e5m2_bf16(%arg0: vector<2xbf16>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> vector<4xf8E5M2> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = rocdl.cvt.scalef32.pk.bf8.bf16 %arg0, %arg2 -> %1[false] : vector<2xi16>
    %3 = llvm.bitcast %2 : vector<2xi16> to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E5M2>
    return %4 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_into_f8e5m2_bf16_vec1(%arg0: vector<1xbf16>, %arg1: vector<4xf8E5M2>, %arg2: f32) -> vector<4xf8E5M2> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<4xf8E5M2> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to vector<2xi16>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xbf16>
    %4 = llvm.mlir.zero : vector<2xbf16>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xbf16>
    %6 = rocdl.cvt.scalef32.pk.bf8.bf16 %5, %arg2 -> %1[false] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to vector<4xi8>
    %8 = builtin.unrealized_conversion_cast %7 : vector<4xi8> to vector<4xf8E5M2>
    return %8 : vector<4xf8E5M2>
  }
  func.func @packed_scaled_trunc_f4e2m1_f32(%arg0: vector<2xf32>, %arg1: f32) -> vector<8xf4E2M1FN> {
    %0 = llvm.mlir.zero : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.extractelement %arg0[%1 : i32] : vector<2xf32>
    %4 = llvm.extractelement %arg0[%2 : i32] : vector<2xf32>
    %5 = rocdl.cvt.scalef32.pk.fp4.f32 %3, %4, %arg1 -> %0[0] : i32
    %6 = llvm.bitcast %5 : i32 to vector<8xi4>
    %7 = builtin.unrealized_conversion_cast %6 : vector<8xi4> to vector<8xf4E2M1FN>
    return %7 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_f4e2m1_f32_vec1(%arg0: vector<1xf32>, %arg1: f32) -> vector<8xf4E2M1FN> {
    %0 = llvm.mlir.zero : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xf32>
    %3 = llvm.mlir.zero : vector<2xf32>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.extractelement %4[%5 : i32] : vector<2xf32>
    %8 = llvm.extractelement %4[%6 : i32] : vector<2xf32>
    %9 = rocdl.cvt.scalef32.pk.fp4.f32 %7, %8, %arg1 -> %0[0] : i32
    %10 = llvm.bitcast %9 : i32 to vector<8xi4>
    %11 = builtin.unrealized_conversion_cast %10 : vector<8xi4> to vector<8xf4E2M1FN>
    return %11 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_into_f4e2m1_f32(%arg0: vector<2xf32>, %arg1: vector<8xf4E2M1FN>, %arg2: f32) -> vector<8xf4E2M1FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.extractelement %arg0[%2 : i32] : vector<2xf32>
    %5 = llvm.extractelement %arg0[%3 : i32] : vector<2xf32>
    %6 = rocdl.cvt.scalef32.pk.fp4.f32 %4, %5, %arg2 -> %1[0] : i32
    %7 = llvm.bitcast %6 : i32 to vector<8xi4>
    %8 = builtin.unrealized_conversion_cast %7 : vector<8xi4> to vector<8xf4E2M1FN>
    return %8 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_into_f4e2m1_f32_vec1(%arg0: vector<1xf32>, %arg1: vector<8xf4E2M1FN>, %arg2: f32) -> vector<8xf4E2M1FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xf32>
    %4 = llvm.mlir.zero : vector<2xf32>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.extractelement %5[%6 : i32] : vector<2xf32>
    %9 = llvm.extractelement %5[%7 : i32] : vector<2xf32>
    %10 = rocdl.cvt.scalef32.pk.fp4.f32 %8, %9, %arg2 -> %1[0] : i32
    %11 = llvm.bitcast %10 : i32 to vector<8xi4>
    %12 = builtin.unrealized_conversion_cast %11 : vector<8xi4> to vector<8xf4E2M1FN>
    return %12 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_f4e2m1_f16(%arg0: vector<2xf16>, %arg1: f32) -> vector<8xf4E2M1FN> {
    %0 = llvm.mlir.zero : i32
    %1 = rocdl.cvt.scalef32.pk.fp4.f16 %arg0, %arg1 -> %0[0] : i32
    %2 = llvm.bitcast %1 : i32 to vector<8xi4>
    %3 = builtin.unrealized_conversion_cast %2 : vector<8xi4> to vector<8xf4E2M1FN>
    return %3 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_f4e2m1_f16_vec1(%arg0: vector<1xf16>, %arg1: f32) -> vector<8xf4E2M1FN> {
    %0 = llvm.mlir.zero : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xf16>
    %3 = llvm.mlir.zero : vector<2xf16>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xf16>
    %5 = rocdl.cvt.scalef32.pk.fp4.f16 %4, %arg1 -> %0[0] : i32
    %6 = llvm.bitcast %5 : i32 to vector<8xi4>
    %7 = builtin.unrealized_conversion_cast %6 : vector<8xi4> to vector<8xf4E2M1FN>
    return %7 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_into_f4e2m1_f16(%arg0: vector<2xf16>, %arg1: vector<8xf4E2M1FN>, %arg2: f32) -> vector<8xf4E2M1FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = rocdl.cvt.scalef32.pk.fp4.f16 %arg0, %arg2 -> %1[0] : i32
    %3 = llvm.bitcast %2 : i32 to vector<8xi4>
    %4 = builtin.unrealized_conversion_cast %3 : vector<8xi4> to vector<8xf4E2M1FN>
    return %4 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_into_f4e2m1_f16_vec1(%arg0: vector<1xf16>, %arg1: vector<8xf4E2M1FN>, %arg2: f32) -> vector<8xf4E2M1FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xf16>
    %4 = llvm.mlir.zero : vector<2xf16>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xf16>
    %6 = rocdl.cvt.scalef32.pk.fp4.f16 %5, %arg2 -> %1[0] : i32
    %7 = llvm.bitcast %6 : i32 to vector<8xi4>
    %8 = builtin.unrealized_conversion_cast %7 : vector<8xi4> to vector<8xf4E2M1FN>
    return %8 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_f4e2m1_bf16(%arg0: vector<2xbf16>, %arg1: f32) -> vector<8xf4E2M1FN> {
    %0 = llvm.mlir.zero : i32
    %1 = rocdl.cvt.scalef32.pk.fp4.bf16 %arg0, %arg1 -> %0[0] : i32
    %2 = llvm.bitcast %1 : i32 to vector<8xi4>
    %3 = builtin.unrealized_conversion_cast %2 : vector<8xi4> to vector<8xf4E2M1FN>
    return %3 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_f4e2m1_bf16_vec1(%arg0: vector<1xbf16>, %arg1: f32) -> vector<8xf4E2M1FN> {
    %0 = llvm.mlir.zero : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%1 : i32] : vector<1xbf16>
    %3 = llvm.mlir.zero : vector<2xbf16>
    %4 = llvm.insertelement %2, %3[%1 : i32] : vector<2xbf16>
    %5 = rocdl.cvt.scalef32.pk.fp4.bf16 %4, %arg1 -> %0[0] : i32
    %6 = llvm.bitcast %5 : i32 to vector<8xi4>
    %7 = builtin.unrealized_conversion_cast %6 : vector<8xi4> to vector<8xf4E2M1FN>
    return %7 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_into_f4e2m1_bf16(%arg0: vector<2xbf16>, %arg1: vector<8xf4E2M1FN>, %arg2: f32) -> vector<8xf4E2M1FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = rocdl.cvt.scalef32.pk.fp4.bf16 %arg0, %arg2 -> %1[0] : i32
    %3 = llvm.bitcast %2 : i32 to vector<8xi4>
    %4 = builtin.unrealized_conversion_cast %3 : vector<8xi4> to vector<8xf4E2M1FN>
    return %4 : vector<8xf4E2M1FN>
  }
  func.func @packed_scaled_trunc_into_f4e2m1_bf16_vec1(%arg0: vector<1xbf16>, %arg1: vector<8xf4E2M1FN>, %arg2: f32) -> vector<8xf4E2M1FN> {
    %0 = builtin.unrealized_conversion_cast %arg1 : vector<8xf4E2M1FN> to vector<8xi4>
    %1 = llvm.bitcast %0 : vector<8xi4> to i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<1xbf16>
    %4 = llvm.mlir.zero : vector<2xbf16>
    %5 = llvm.insertelement %3, %4[%2 : i32] : vector<2xbf16>
    %6 = rocdl.cvt.scalef32.pk.fp4.bf16 %5, %arg2 -> %1[0] : i32
    %7 = llvm.bitcast %6 : i32 to vector<8xi4>
    %8 = builtin.unrealized_conversion_cast %7 : vector<8xi4> to vector<8xf4E2M1FN>
    return %8 : vector<8xf4E2M1FN>
  }
}

