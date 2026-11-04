"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf16>, vector<16xf32>, vector<4xf32>, vector<8xbf16>, vector<16xi8>, vector<16xi32>, vector<4xi32>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<32xf6E2M3FN>, vector<32xf6E3M2FN>, vector<32xf4E2M1FN>) -> (), sym_name = "mfma_to_rocdl"}> ({
  ^bb0(%arg9: vector<8xf16>, %arg10: vector<16xf32>, %arg11: vector<4xf32>, %arg12: vector<8xbf16>, %arg13: vector<16xi8>, %arg14: vector<16xi32>, %arg15: vector<4xi32>, %arg16: vector<32xf8E4M3FN>, %arg17: vector<32xf8E5M2>, %arg18: vector<32xf6E2M3FN>, %arg19: vector<32xf6E3M2FN>, %arg20: vector<32xf4E2M1FN>):
    %29 = "builtin.unrealized_conversion_cast"(%arg20) : (vector<32xf4E2M1FN>) -> vector<32xi4>
    %30 = "builtin.unrealized_conversion_cast"(%arg19) : (vector<32xf6E3M2FN>) -> vector<32xi6>
    %31 = "builtin.unrealized_conversion_cast"(%arg18) : (vector<32xf6E2M3FN>) -> vector<32xi6>
    %32 = "builtin.unrealized_conversion_cast"(%arg17) : (vector<32xf8E5M2>) -> vector<32xi8>
    %33 = "builtin.unrealized_conversion_cast"(%arg16) : (vector<32xf8E4M3FN>) -> vector<32xi8>
    %34 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %35 = "rocdl.mfma.f32.32x32x16.f16"(%arg9, %arg9, %arg10, %34, %34, %34) : (vector<8xf16>, vector<8xf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %36 = "rocdl.mfma.f32.16x16x32.f16"(%arg9, %arg9, %arg11, %34, %34, %34) : (vector<8xf16>, vector<8xf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %37 = "rocdl.mfma.f32.32x32x16.bf16"(%arg12, %arg12, %arg10, %34, %34, %34) : (vector<8xbf16>, vector<8xbf16>, vector<16xf32>, i32, i32, i32) -> vector<16xf32>
    %38 = "rocdl.mfma.f32.16x16x32.bf16"(%arg12, %arg12, %arg11, %34, %34, %34) : (vector<8xbf16>, vector<8xbf16>, vector<4xf32>, i32, i32, i32) -> vector<4xf32>
    %39 = "llvm.bitcast"(%arg13) : (vector<16xi8>) -> vector<4xi32>
    %40 = "rocdl.mfma.i32.32x32x32.i8"(%39, %39, %arg14, %34, %34, %34) : (vector<4xi32>, vector<4xi32>, vector<16xi32>, i32, i32, i32) -> vector<16xi32>
    %41 = "rocdl.mfma.i32.16x16x64.i8"(%39, %39, %arg15, %34, %34, %34) : (vector<4xi32>, vector<4xi32>, vector<4xi32>, i32, i32, i32) -> vector<4xi32>
    %42 = "llvm.bitcast"(%33) : (vector<32xi8>) -> vector<8xi32>
    %43 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%42, %42, %arg10, %34, %34, %34, %34, %34, %34) : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %44 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%42, %42, %arg11, %34, %34, %34, %34, %34, %34) : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %45 = "llvm.bitcast"(%32) : (vector<32xi8>) -> vector<8xi32>
    %46 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %47 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%45, %45, %arg10, %46, %46, %34, %34, %34, %34) : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %48 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%45, %45, %arg11, %46, %46, %34, %34, %34, %34) : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %49 = "llvm.bitcast"(%31) : (vector<32xi6>) -> vector<6xi32>
    %50 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %51 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%49, %49, %arg10, %50, %50, %34, %34, %34, %34) : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %52 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%49, %49, %arg11, %50, %50, %34, %34, %34, %34) : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %53 = "llvm.bitcast"(%30) : (vector<32xi6>) -> vector<6xi32>
    %54 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %55 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%53, %53, %arg10, %54, %54, %34, %34, %34, %34) : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %56 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%53, %53, %arg11, %54, %54, %34, %34, %34, %34) : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %57 = "llvm.bitcast"(%29) : (vector<32xi4>) -> vector<4xi32>
    %58 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %59 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%57, %57, %arg10, %58, %58, %34, %34, %34, %34) : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %60 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%57, %57, %arg11, %58, %58, %34, %34, %34, %34) : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %61 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%49, %57, %arg10, %50, %58, %34, %34, %34, %34) : (vector<6xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %62 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%49, %57, %arg11, %50, %58, %34, %34, %34, %34) : (vector<6xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
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
    %8 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %10 = "llvm.bitcast"(%5) : (vector<4xi8>) -> i32
    %11 = "llvm.zext"(%4) : (i8) -> i32
    %12 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%7, %7, %arg0, %8, %8, %8, %10, %9, %11) : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %13 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%7, %7, %arg1, %8, %8, %8, %10, %9, %11) : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %14 = "llvm.bitcast"(%3) : (vector<32xi8>) -> vector<8xi32>
    %15 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%14, %14, %arg0, %9, %9, %8, %10, %9, %11) : (vector<8xi32>, vector<8xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %16 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%14, %14, %arg1, %9, %9, %8, %10, %9, %11) : (vector<8xi32>, vector<8xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %17 = "llvm.bitcast"(%2) : (vector<32xi6>) -> vector<6xi32>
    %18 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %19 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%17, %17, %arg0, %18, %18, %8, %10, %9, %11) : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %20 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%17, %17, %arg1, %18, %18, %8, %10, %9, %11) : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %21 = "llvm.bitcast"(%1) : (vector<32xi6>) -> vector<6xi32>
    %22 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    %23 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%21, %21, %arg0, %22, %22, %8, %10, %9, %11) : (vector<6xi32>, vector<6xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %24 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%21, %21, %arg1, %22, %22, %8, %10, %9, %11) : (vector<6xi32>, vector<6xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    %25 = "llvm.bitcast"(%0) : (vector<32xi4>) -> vector<4xi32>
    %26 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %27 = "rocdl.mfma.scale.f32.32x32x64.f8f6f4"(%25, %25, %arg0, %26, %26, %8, %10, %9, %11) : (vector<4xi32>, vector<4xi32>, vector<16xf32>, i32, i32, i32, i32, i32, i32) -> vector<16xf32>
    %28 = "rocdl.mfma.scale.f32.16x16x128.f8f6f4"(%25, %25, %arg1, %26, %26, %8, %10, %9, %11) : (vector<4xi32>, vector<4xi32>, vector<4xf32>, i32, i32, i32, i32, i32, i32) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

