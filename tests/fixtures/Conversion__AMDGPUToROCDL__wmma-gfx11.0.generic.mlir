"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf16>, vector<8xf32>, vector<4xf32>, vector<16xbf16>, vector<8xf16>, vector<8xbf16>, vector<16xi8>, vector<8xi32>, vector<4xi32>, vector<16xui8>, vector<16xi4>, vector<8xi4>) -> (), sym_name = "wmma_to_rocdl"}> ({
  ^bb0(%arg0: vector<16xf16>, %arg1: vector<8xf32>, %arg2: vector<4xf32>, %arg3: vector<16xbf16>, %arg4: vector<8xf16>, %arg5: vector<8xbf16>, %arg6: vector<16xi8>, %arg7: vector<8xi32>, %arg8: vector<4xi32>, %arg9: vector<16xui8>, %arg10: vector<16xi4>, %arg11: vector<8xi4>):
    %0 = "builtin.unrealized_conversion_cast"(%arg9) : (vector<16xui8>) -> vector<16xi8>
    %1 = "rocdl.wmma.f32.16x16x16.f16"(%arg0, %arg0, %arg1) : (vector<16xf16>, vector<16xf16>, vector<8xf32>) -> vector<8xf32>
    %2 = "rocdl.wmma.f32.16x16x16.f16"(%arg0, %arg0, %arg2) : (vector<16xf16>, vector<16xf16>, vector<4xf32>) -> vector<4xf32>
    %3 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %4 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %5 = "rocdl.wmma.f32.16x16x16.bf16"(%3, %4, %arg1) : (vector<16xi16>, vector<16xi16>, vector<8xf32>) -> vector<8xf32>
    %6 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %7 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %8 = "rocdl.wmma.f32.16x16x16.bf16"(%6, %7, %arg2) : (vector<16xi16>, vector<16xi16>, vector<4xf32>) -> vector<4xf32>
    %9 = "rocdl.wmma.f16.16x16x16.f16"(%arg0, %arg0, %arg0) <{opsel = true}> : (vector<16xf16>, vector<16xf16>, vector<16xf16>) -> vector<16xf16>
    %10 = "rocdl.wmma.f16.16x16x16.f16"(%arg0, %arg0, %arg4) <{opsel = false}> : (vector<16xf16>, vector<16xf16>, vector<8xf16>) -> vector<8xf16>
    %11 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %12 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %13 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %14 = "rocdl.wmma.bf16.16x16x16.bf16"(%11, %12, %13) <{opsel = true}> : (vector<16xi16>, vector<16xi16>, vector<16xi16>) -> vector<16xi16>
    %15 = "llvm.bitcast"(%14) : (vector<16xi16>) -> vector<16xbf16>
    %16 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %17 = "llvm.bitcast"(%arg3) : (vector<16xbf16>) -> vector<16xi16>
    %18 = "llvm.bitcast"(%arg5) : (vector<8xbf16>) -> vector<8xi16>
    %19 = "rocdl.wmma.bf16.16x16x16.bf16"(%16, %17, %18) <{opsel = false}> : (vector<16xi16>, vector<16xi16>, vector<8xi16>) -> vector<8xi16>
    %20 = "llvm.bitcast"(%19) : (vector<8xi16>) -> vector<8xbf16>
    %21 = "llvm.bitcast"(%arg6) : (vector<16xi8>) -> vector<4xi32>
    %22 = "llvm.bitcast"(%arg6) : (vector<16xi8>) -> vector<4xi32>
    %23 = "rocdl.wmma.i32.16x16x16.iu8"(%21, %22, %arg7) <{clamp = true, signA = true, signB = true}> : (vector<4xi32>, vector<4xi32>, vector<8xi32>) -> vector<8xi32>
    %24 = "llvm.bitcast"(%0) : (vector<16xi8>) -> vector<4xi32>
    %25 = "llvm.bitcast"(%0) : (vector<16xi8>) -> vector<4xi32>
    %26 = "rocdl.wmma.i32.16x16x16.iu8"(%24, %25, %arg8) <{clamp = true, signA = false, signB = false}> : (vector<4xi32>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %27 = "llvm.bitcast"(%arg10) : (vector<16xi4>) -> vector<2xi32>
    %28 = "llvm.bitcast"(%arg10) : (vector<16xi4>) -> vector<2xi32>
    %29 = "rocdl.wmma.i32.16x16x16.iu4"(%27, %28, %arg7) <{clamp = true, signA = true, signB = true}> : (vector<2xi32>, vector<2xi32>, vector<8xi32>) -> vector<8xi32>
    %30 = "llvm.bitcast"(%arg11) : (vector<8xi4>) -> i32
    %31 = "llvm.bitcast"(%arg11) : (vector<8xi4>) -> i32
    %32 = "rocdl.wmma.i32.16x16x16.iu4"(%30, %31, %arg8) <{clamp = true, signA = true, signB = true}> : (i32, i32, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

