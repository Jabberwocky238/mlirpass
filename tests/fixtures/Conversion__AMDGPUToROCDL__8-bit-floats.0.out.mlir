module {
  func.func @ext_scalar(%arg0: f8E5M2FNUZ) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : f8E5M2FNUZ to i8
    %1 = llvm.mlir.undef : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : vector<4xi8>
    %4 = llvm.bitcast %3 : vector<4xi8> to i32
    %5 = rocdl.cvt.f32.bf8 %4[0] : f32
    return %5 : f32
  }
  func.func @ext_short_vec(%arg0: vector<2xf8E4M3FNUZ>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FNUZ> to vector<2xi8>
    %1 = llvm.mlir.undef : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.f32.fp8 %8[1] : f32
    return %9 : f32
  }
  func.func @ext_full_vec(%arg0: vector<4xf8E4M3FNUZ>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FNUZ> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.f32.fp8 %1[3] : f32
    return %2 : f32
  }
  func.func @ext_packed_2xfp8(%arg0: vector<2xf8E4M3FNUZ>) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2xf8E4M3FNUZ> to vector<2xi8>
    %1 = llvm.mlir.undef : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %0[%2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.extractelement %0[%5 : i32] : vector<2xi8>
    %7 = llvm.insertelement %6, %4[%5 : i32] : vector<4xi8>
    %8 = llvm.bitcast %7 : vector<4xi8> to i32
    %9 = rocdl.cvt.pk.f32.fp8 %8[false] : vector<2xf32>
    return %9 : vector<2xf32>
  }
  func.func @ext_packed_4xfp8(%arg0: vector<4xf8E4M3FNUZ>) -> vector<2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<4xf8E4M3FNUZ> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.pk.f32.fp8 %1[true] : vector<2xf32>
    return %2 : vector<2xf32>
  }
  func.func @packed_trunc(%arg0: f32) -> vector<4xf8E4M3FNUZ> {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.undef : i32
    %2 = rocdl.cvt.pk.fp8.f32 %arg0, %0 -> %1[false] : i32
    %3 = llvm.bitcast %2 : i32 to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E4M3FNUZ>
    return %4 : vector<4xf8E4M3FNUZ>
  }
  func.func @packed_truncx2(%arg0: f32, %arg1: f32) -> vector<4xf8E4M3FNUZ> {
    %0 = llvm.mlir.undef : i32
    %1 = rocdl.cvt.pk.fp8.f32 %arg0, %arg1 -> %0[false] : i32
    %2 = llvm.bitcast %1 : i32 to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi8> to vector<4xf8E4M3FNUZ>
    return %3 : vector<4xf8E4M3FNUZ>
  }
  func.func @packed_truncx2_into(%arg0: f32, %arg1: f32, %arg2: vector<4xf8E5M2FNUZ>) -> vector<4xf8E5M2FNUZ> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<4xf8E5M2FNUZ> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.pk.bf8.f32 %arg0, %arg1 -> %1[true] : i32
    %3 = llvm.bitcast %2 : i32 to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E5M2FNUZ>
    return %4 : vector<4xf8E5M2FNUZ>
  }
  func.func @packed_stoch_round(%arg0: f32, %arg1: i32) -> vector<4xf8E4M3FNUZ> {
    %0 = llvm.mlir.undef : i32
    %1 = rocdl.cvt.sr.fp8.f32 %arg0, %arg1 -> %0[0] : i32
    %2 = llvm.bitcast %1 : i32 to vector<4xi8>
    %3 = builtin.unrealized_conversion_cast %2 : vector<4xi8> to vector<4xf8E4M3FNUZ>
    return %3 : vector<4xf8E4M3FNUZ>
  }
  func.func @packed_stoch_round_into(%arg0: f32, %arg1: i32, %arg2: vector<4xf8E5M2FNUZ>) -> vector<4xf8E5M2FNUZ> {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<4xf8E5M2FNUZ> to vector<4xi8>
    %1 = llvm.bitcast %0 : vector<4xi8> to i32
    %2 = rocdl.cvt.sr.bf8.f32 %arg0, %arg1 -> %1[1] : i32
    %3 = llvm.bitcast %2 : i32 to vector<4xi8>
    %4 = builtin.unrealized_conversion_cast %3 : vector<4xi8> to vector<4xf8E5M2FNUZ>
    return %4 : vector<4xf8E5M2FNUZ>
  }
}

