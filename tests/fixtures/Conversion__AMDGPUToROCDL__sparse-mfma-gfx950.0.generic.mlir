"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf16>, vector<16xf16>, vector<4xf32>, vector<16xf32>, vector<8xbf16>, vector<16xbf16>, vector<16xi8>, vector<32xi8>, vector<4xi32>, vector<16xi32>, vector<16xf8E4M3FN>, vector<16xf8E5M2>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<4xi8>, vector<2xi16>) -> (), sym_name = "sparse_mfma_to_rocdl"}> ({
  ^bb0(%arg0: vector<8xf16>, %arg1: vector<16xf16>, %arg2: vector<4xf32>, %arg3: vector<16xf32>, %arg4: vector<8xbf16>, %arg5: vector<16xbf16>, %arg6: vector<16xi8>, %arg7: vector<32xi8>, %arg8: vector<4xi32>, %arg9: vector<16xi32>, %arg10: vector<16xf8E4M3FN>, %arg11: vector<16xf8E5M2>, %arg12: vector<32xf8E4M3FN>, %arg13: vector<32xf8E5M2>, %arg14: vector<4xi8>, %arg15: vector<2xi16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg13) : (vector<32xf8E5M2>) -> vector<32xi8>
    %1 = "builtin.unrealized_conversion_cast"(%arg11) : (vector<16xf8E5M2>) -> vector<16xi8>
    %2 = "builtin.unrealized_conversion_cast"(%arg12) : (vector<32xf8E4M3FN>) -> vector<32xi8>
    %3 = "builtin.unrealized_conversion_cast"(%arg10) : (vector<16xf8E4M3FN>) -> vector<16xi8>
    %4 = "llvm.bitcast"(%arg14) : (vector<4xi8>) -> i32
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "rocdl.smfmac.f32.16x16x64.f16"(%arg0, %arg1, %arg2, %4, %5, %5) : (vector<8xf16>, vector<16xf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %7 = "rocdl.smfmac.f32.16x16x64.bf16"(%arg4, %arg5, %arg2, %4, %5, %5) : (vector<8xbf16>, vector<16xbf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %8 = "llvm.bitcast"(%arg6) : (vector<16xi8>) -> vector<4xi32>
    %9 = "llvm.bitcast"(%arg7) : (vector<32xi8>) -> vector<8xi32>
    %10 = "llvm.bitcast"(%arg15) : (vector<2xi16>) -> i32
    %11 = "rocdl.smfmac.i32.16x16x128.i8"(%8, %9, %arg8, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %12 = "llvm.bitcast"(%3) : (vector<16xi8>) -> vector<4xi32>
    %13 = "llvm.bitcast"(%2) : (vector<32xi8>) -> vector<8xi32>
    %14 = "rocdl.smfmac.f32.16x16x128.fp8.fp8"(%12, %13, %arg2, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %15 = "llvm.bitcast"(%1) : (vector<16xi8>) -> vector<4xi32>
    %16 = "llvm.bitcast"(%0) : (vector<32xi8>) -> vector<8xi32>
    %17 = "rocdl.smfmac.f32.16x16x128.bf8.bf8"(%15, %16, %arg2, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %18 = "rocdl.smfmac.f32.16x16x128.fp8.bf8"(%12, %16, %arg2, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %19 = "rocdl.smfmac.f32.16x16x128.bf8.fp8"(%15, %13, %arg2, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %20 = "rocdl.smfmac.f32.32x32x32.f16"(%arg0, %arg1, %arg3, %4, %5, %5) : (vector<8xf16>, vector<16xf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %21 = "rocdl.smfmac.f32.32x32x32.bf16"(%arg4, %arg5, %arg3, %4, %5, %5) : (vector<8xbf16>, vector<16xbf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %22 = "rocdl.smfmac.i32.32x32x64.i8"(%8, %9, %arg9, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %23 = "rocdl.smfmac.f32.32x32x64.fp8.fp8"(%12, %13, %arg3, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %24 = "rocdl.smfmac.f32.32x32x64.bf8.bf8"(%15, %16, %arg3, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %25 = "rocdl.smfmac.f32.32x32x64.fp8.bf8"(%12, %16, %arg3, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %26 = "rocdl.smfmac.f32.32x32x64.bf8.fp8"(%15, %13, %arg3, %10, %5, %5) : (vector<4xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

