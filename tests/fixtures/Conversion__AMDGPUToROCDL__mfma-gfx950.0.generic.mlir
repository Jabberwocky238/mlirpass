"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf16>, vector<16xf32>, vector<4xf32>, vector<8xbf16>, vector<16xi8>, vector<16xi32>, vector<4xi32>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<32xf6E2M3FN>, vector<32xf6E3M2FN>, vector<32xf4E2M1FN>) -> (), sym_name = "mfma_to_rocdl"}> ({
  ^bb0(%arg9: vector<8xf16>, %arg10: vector<16xf32>, %arg11: vector<4xf32>, %arg12: vector<8xbf16>, %arg13: vector<16xi8>, %arg14: vector<16xi32>, %arg15: vector<4xi32>, %arg16: vector<32xf8E4M3FN>, %arg17: vector<32xf8E5M2>, %arg18: vector<32xf6E2M3FN>, %arg19: vector<32xf6E3M2FN>, %arg20: vector<32xf4E2M1FN>):
    %24 = "builtin.unrealized_conversion_cast"(%arg20) : (vector<32xf4E2M1FN>) -> vector<32xi4>
    %25 = "builtin.unrealized_conversion_cast"(%arg19) : (vector<32xf6E3M2FN>) -> vector<32xi6>
    %26 = "builtin.unrealized_conversion_cast"(%arg18) : (vector<32xf6E2M3FN>) -> vector<32xi6>
    %27 = "builtin.unrealized_conversion_cast"(%arg17) : (vector<32xf8E5M2>) -> vector<32xi8>
    %28 = "builtin.unrealized_conversion_cast"(%arg16) : (vector<32xf8E4M3FN>) -> vector<32xi8>
    %29 = "rocdl.mfma.f32.32x32x16.f16"(%arg9, %arg9, %arg10) <{abid = 0 : i32, blgp = #rocdl<mfma_perm_b none>, cbsz = 0 : i32}> : (vector<8xf16>, vector<8xf16>, vector<16xf32>) -> vector<16xf32>
    %30 = "rocdl.mfma.f32.16x16x32.f16"(%arg9, %arg9, %arg11) <{abid = 0 : i32, blgp = #rocdl<mfma_perm_b none>, cbsz = 0 : i32}> : (vector<8xf16>, vector<8xf16>, vector<4xf32>) -> vector<4xf32>
    %31 = "rocdl.mfma.f32.32x32x16.bf16"(%arg12, %arg12, %arg10) <{abid = 0 : i32, blgp = #rocdl<mfma_perm_b none>, cbsz = 0 : i32}> : (vector<8xbf16>, vector<8xbf16>, vector<16xf32>) -> vector<16xf32>
    %32 = "rocdl.mfma.f32.16x16x32.bf16"(%arg12, %arg12, %arg11) <{abid = 0 : i32, blgp = #rocdl<mfma_perm_b none>, cbsz = 0 : i32}> : (vector<8xbf16>, vector<8xbf16>, vector<4xf32>) -> vector<4xf32>
    %33 = "llvm.bitcast"(%arg13) : (vector<16xi8>) -> vector<4xi32>
    %34 = "rocdl.mfma.i32.32x32x32.i8"(%33, %33, %arg14) <{abid = 0 : i32, blgp = #rocdl<mfma_perm_b none>, cbsz = 0 : i32}> : (vector<4xi32>, vector<4xi32>, vector<16xi32>) -> vector<16xi32>
    %35 = "rocdl.mfma.i32.16x16x64.i8"(%33, %33, %arg15) <{abid = 0 : i32, blgp = #rocdl<mfma_perm_b none>, cbsz = 0 : i32}> : (vector<4xi32>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %36 = "llvm.bitcast"(%28) : (vector<32xi8>) -> vector<8xi32>
    %37 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %38 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%36, %36, %arg10, %37, %37) <{blgp = #rocdl<matrix_format fp8_e4m3>, cbsz = #rocdl<matrix_format fp8_e4m3>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %39 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%36, %36, %arg11, %37, %37) <{blgp = #rocdl<matrix_format fp8_e4m3>, cbsz = #rocdl<matrix_format fp8_e4m3>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %40 = "llvm.bitcast"(%27) : (vector<32xi8>) -> vector<8xi32>
    %41 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%40, %40, %arg10, %37, %37) <{blgp = #rocdl<matrix_format fp8_e5m2>, cbsz = #rocdl<matrix_format fp8_e5m2>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %42 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%40, %40, %arg11, %37, %37) <{blgp = #rocdl<matrix_format fp8_e5m2>, cbsz = #rocdl<matrix_format fp8_e5m2>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %43 = "llvm.bitcast"(%26) : (vector<32xi6>) -> vector<6xi32>
    %44 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%43, %43, %arg10, %37, %37) <{blgp = #rocdl<matrix_format fp6_e2m3>, cbsz = #rocdl<matrix_format fp6_e2m3>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %45 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%43, %43, %arg11, %37, %37) <{blgp = #rocdl<matrix_format fp6_e2m3>, cbsz = #rocdl<matrix_format fp6_e2m3>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %46 = "llvm.bitcast"(%25) : (vector<32xi6>) -> vector<6xi32>
    %47 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%46, %46, %arg10, %37, %37) <{blgp = #rocdl<matrix_format fp6_e3m2>, cbsz = #rocdl<matrix_format fp6_e3m2>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %48 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%46, %46, %arg11, %37, %37) <{blgp = #rocdl<matrix_format fp6_e3m2>, cbsz = #rocdl<matrix_format fp6_e3m2>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %49 = "llvm.bitcast"(%24) : (vector<32xi4>) -> vector<4xi32>
    %50 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%49, %49, %arg10, %37, %37) <{blgp = #rocdl<matrix_format fp4_e2m1>, cbsz = #rocdl<matrix_format fp4_e2m1>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %51 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%49, %49, %arg11, %37, %37) <{blgp = #rocdl<matrix_format fp4_e2m1>, cbsz = #rocdl<matrix_format fp4_e2m1>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %52 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%43, %49, %arg10, %37, %37) <{blgp = #rocdl<matrix_format fp4_e2m1>, cbsz = #rocdl<matrix_format fp6_e2m3>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<6xi32>, vector<4xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %53 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%43, %49, %arg11, %37, %37) <{blgp = #rocdl<matrix_format fp4_e2m1>, cbsz = #rocdl<matrix_format fp6_e2m3>, opselA = 0 : i32, opselB = 0 : i32}> : (vector<6xi32>, vector<4xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>, vector<4xf32>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<32xf6E2M3FN>, vector<32xf6E3M2FN>, vector<32xf4E2M1FN>, vector<4xf8E8M0FNU>, f8E8M0FNU) -> (), sym_name = "scaled_mfma_to_rocdl"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<4xf32>, %arg2: vector<32xf8E4M3FN>, %arg3: vector<32xf8E5M2>, %arg4: vector<32xf6E2M3FN>, %arg5: vector<32xf6E3M2FN>, %arg6: vector<32xf4E2M1FN>, %arg7: vector<4xf8E8M0FNU>, %arg8: f8E8M0FNU):
    %0 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<32xf4E2M1FN>) -> vector<32xi4>
    %1 = "builtin.unrealized_conversion_cast"(%arg5) : (vector<32xf6E3M2FN>) -> vector<32xi6>
    %2 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<32xf6E2M3FN>) -> vector<32xi6>
    %3 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<32xf8E5M2>) -> vector<32xi8>
    %4 = "builtin.unrealized_conversion_cast"(%arg8) : (f8E8M0FNU) -> i8
    %5 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<4xf8E8M0FNU>) -> vector<4xi8>
    %6 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<32xf8E4M3FN>) -> vector<32xi8>
    %7 = "llvm.bitcast"(%6) : (vector<32xi8>) -> vector<8xi32>
    %8 = "llvm.bitcast"(%5) : (vector<4xi8>) -> i32
    %9 = "llvm.zext"(%4) : (i8) -> i32
    %10 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%7, %7, %arg0, %8, %9) <{blgp = #rocdl<matrix_format fp8_e4m3>, cbsz = #rocdl<matrix_format fp8_e4m3>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %11 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%7, %7, %arg1, %8, %9) <{blgp = #rocdl<matrix_format fp8_e4m3>, cbsz = #rocdl<matrix_format fp8_e4m3>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %12 = "llvm.bitcast"(%3) : (vector<32xi8>) -> vector<8xi32>
    %13 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%12, %12, %arg0, %8, %9) <{blgp = #rocdl<matrix_format fp8_e5m2>, cbsz = #rocdl<matrix_format fp8_e5m2>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %14 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%12, %12, %arg1, %8, %9) <{blgp = #rocdl<matrix_format fp8_e5m2>, cbsz = #rocdl<matrix_format fp8_e5m2>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %15 = "llvm.bitcast"(%2) : (vector<32xi6>) -> vector<6xi32>
    %16 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%15, %15, %arg0, %8, %9) <{blgp = #rocdl<matrix_format fp6_e2m3>, cbsz = #rocdl<matrix_format fp6_e2m3>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %17 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%15, %15, %arg1, %8, %9) <{blgp = #rocdl<matrix_format fp6_e2m3>, cbsz = #rocdl<matrix_format fp6_e2m3>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %18 = "llvm.bitcast"(%1) : (vector<32xi6>) -> vector<6xi32>
    %19 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%18, %18, %arg0, %8, %9) <{blgp = #rocdl<matrix_format fp6_e3m2>, cbsz = #rocdl<matrix_format fp6_e3m2>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %20 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%18, %18, %arg1, %8, %9) <{blgp = #rocdl<matrix_format fp6_e3m2>, cbsz = #rocdl<matrix_format fp6_e3m2>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    %21 = "llvm.bitcast"(%0) : (vector<32xi4>) -> vector<4xi32>
    %22 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%21, %21, %arg0, %8, %9) <{blgp = #rocdl<matrix_format fp4_e2m1>, cbsz = #rocdl<matrix_format fp4_e2m1>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32) -> vector<16xf32>
    %23 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%21, %21, %arg1, %8, %9) <{blgp = #rocdl<matrix_format fp4_e2m1>, cbsz = #rocdl<matrix_format fp4_e2m1>, opselA = 0 : i32, opselB = 1 : i32}> : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

