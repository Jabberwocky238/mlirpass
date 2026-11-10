"builtin.module"() ({
  "func.func"() <{function_type = (vector<64xi8>, vector<64xf8E4M3FN>, vector<64xf8E5M2>, vector<32xf16>, vector<32xbf16>, vector<32xi8>, vector<32xi4>, vector<32xf8E4M3FN>, vector<32xf8E5M2>, vector<16xf16>, vector<16xbf16>, vector<16xf8E4M3FN>, vector<16xf8E5M2>, vector<8xf32>, vector<8xi32>, vector<8xf16>, vector<8xbf16>, vector<8xi8>, vector<8xi4>, vector<4xi8>) -> (), sym_name = "rocdl.swmmac"}> ({
  ^bb0(%arg0: vector<64xi8>, %arg1: vector<64xf8E4M3FN>, %arg2: vector<64xf8E5M2>, %arg3: vector<32xf16>, %arg4: vector<32xbf16>, %arg5: vector<32xi8>, %arg6: vector<32xi4>, %arg7: vector<32xf8E4M3FN>, %arg8: vector<32xf8E5M2>, %arg9: vector<16xf16>, %arg10: vector<16xbf16>, %arg11: vector<16xf8E4M3FN>, %arg12: vector<16xf8E5M2>, %arg13: vector<8xf32>, %arg14: vector<8xi32>, %arg15: vector<8xf16>, %arg16: vector<8xbf16>, %arg17: vector<8xi8>, %arg18: vector<8xi4>, %arg19: vector<4xi8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg8) : (vector<32xf8E5M2>) -> vector<32xi8>
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<64xf8E5M2>) -> vector<64xi8>
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<64xf8E4M3FN>) -> vector<64xi8>
    %3 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<32xf8E4M3FN>) -> vector<32xi8>
    %4 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %5 = "rocdl.swmmac.f32.16x16x64.f16"(%arg9, %arg3, %arg13, %4) : (vector<16xf16>, vector<32xf16>, vector<8xf32>, i32) -> vector<8xf32>
    %6 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %7 = "rocdl.swmmac.f32.16x16x64.bf16"(%arg10, %arg4, %arg13, %6) : (vector<16xbf16>, vector<32xbf16>, vector<8xf32>, i32) -> vector<8xf32>
    %8 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %9 = "rocdl.swmmac.f16.16x16x64.f16"(%arg9, %arg3, %arg15, %8) : (vector<16xf16>, vector<32xf16>, vector<8xf16>, i32) -> vector<8xf16>
    %10 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %11 = "rocdl.swmmac.bf16.16x16x64.bf16"(%arg10, %arg4, %arg16, %10) : (vector<16xbf16>, vector<32xbf16>, vector<8xbf16>, i32) -> vector<8xbf16>
    %12 = "llvm.bitcast"(%3) : (vector<32xi8>) -> vector<8xi32>
    %13 = "llvm.bitcast"(%2) : (vector<64xi8>) -> vector<16xi32>
    %14 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %15 = "rocdl.swmmac.f32.16x16x128.fp8.fp8"(%12, %13, %arg13, %14) : (vector<8xi32>, vector<16xi32>, vector<8xf32>, i32) -> vector<8xf32>
    %16 = "llvm.bitcast"(%3) : (vector<32xi8>) -> vector<8xi32>
    %17 = "llvm.bitcast"(%1) : (vector<64xi8>) -> vector<16xi32>
    %18 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %19 = "rocdl.swmmac.f32.16x16x128.fp8.bf8"(%16, %17, %arg13, %18) : (vector<8xi32>, vector<16xi32>, vector<8xf32>, i32) -> vector<8xf32>
    %20 = "llvm.bitcast"(%0) : (vector<32xi8>) -> vector<8xi32>
    %21 = "llvm.bitcast"(%2) : (vector<64xi8>) -> vector<16xi32>
    %22 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %23 = "rocdl.swmmac.f32.16x16x128.bf8.fp8"(%20, %21, %arg13, %22) : (vector<8xi32>, vector<16xi32>, vector<8xf32>, i32) -> vector<8xf32>
    %24 = "llvm.bitcast"(%0) : (vector<32xi8>) -> vector<8xi32>
    %25 = "llvm.bitcast"(%1) : (vector<64xi8>) -> vector<16xi32>
    %26 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %27 = "rocdl.swmmac.f32.16x16x128.bf8.bf8"(%24, %25, %arg13, %26) : (vector<8xi32>, vector<16xi32>, vector<8xf32>, i32) -> vector<8xf32>
    %28 = "llvm.bitcast"(%3) : (vector<32xi8>) -> vector<8xi32>
    %29 = "llvm.bitcast"(%2) : (vector<64xi8>) -> vector<16xi32>
    %30 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %31 = "rocdl.swmmac.f16.16x16x128.fp8.fp8"(%28, %29, %arg15, %30) : (vector<8xi32>, vector<16xi32>, vector<8xf16>, i32) -> vector<8xf16>
    %32 = "llvm.bitcast"(%3) : (vector<32xi8>) -> vector<8xi32>
    %33 = "llvm.bitcast"(%1) : (vector<64xi8>) -> vector<16xi32>
    %34 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %35 = "rocdl.swmmac.f16.16x16x128.fp8.bf8"(%32, %33, %arg15, %34) : (vector<8xi32>, vector<16xi32>, vector<8xf16>, i32) -> vector<8xf16>
    %36 = "llvm.bitcast"(%0) : (vector<32xi8>) -> vector<8xi32>
    %37 = "llvm.bitcast"(%2) : (vector<64xi8>) -> vector<16xi32>
    %38 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %39 = "rocdl.swmmac.f16.16x16x128.bf8.fp8"(%36, %37, %arg15, %38) : (vector<8xi32>, vector<16xi32>, vector<8xf16>, i32) -> vector<8xf16>
    %40 = "llvm.bitcast"(%0) : (vector<32xi8>) -> vector<8xi32>
    %41 = "llvm.bitcast"(%1) : (vector<64xi8>) -> vector<16xi32>
    %42 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %43 = "rocdl.swmmac.f16.16x16x128.bf8.bf8"(%40, %41, %arg15, %42) : (vector<8xi32>, vector<16xi32>, vector<8xf16>, i32) -> vector<8xf16>
    %44 = "llvm.bitcast"(%arg5) : (vector<32xi8>) -> vector<8xi32>
    %45 = "llvm.bitcast"(%arg0) : (vector<64xi8>) -> vector<16xi32>
    %46 = "llvm.bitcast"(%arg19) : (vector<4xi8>) -> i32
    %47 = "rocdl.swmmac.i32.16x16x128.iu8"(%44, %45, %arg14, %46) : (vector<8xi32>, vector<16xi32>, vector<8xi32>, i32) -> vector<8xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

