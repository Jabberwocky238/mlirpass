"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f16) -> f16, sym_name = "dot_fdot2_f16_f16"}> ({
  ^bb0(%arg18: vector<2xf16>, %arg19: vector<2xf16>, %arg20: f16):
    %14 = "rocdl.fdot2.f16.f16"(%arg18, %arg19, %arg20) : (vector<2xf16>, vector<2xf16>, f16) -> f16
    "func.return"(%14) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<2xbf16>, bf16) -> bf16, sym_name = "dot_fdot2_bf16_bf16"}> ({
  ^bb0(%arg15: vector<2xbf16>, %arg16: vector<2xbf16>, %arg17: bf16):
    %13 = "rocdl.fdot2.bf16.bf16"(%arg15, %arg16, %arg17) : (vector<2xbf16>, vector<2xbf16>, bf16) -> bf16
    "func.return"(%13) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<2xbf16>, f32) -> f32, sym_name = "dot_fdot2_f32_bf16"}> ({
  ^bb0(%arg12: vector<2xbf16>, %arg13: vector<2xbf16>, %arg14: f32):
    %12 = "rocdl.fdot2.f32.bf16"(%arg12, %arg13, %arg14) <{clamp = false}> : (vector<2xbf16>, vector<2xbf16>, f32) -> f32
    "func.return"(%12) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sdot4_gfx11_uniform_sign"}> ({
  ^bb0(%arg9: vector<4xi8>, %arg10: vector<4xi8>, %arg11: i32):
    %9 = "llvm.bitcast"(%arg9) : (vector<4xi8>) -> i32
    %10 = "llvm.bitcast"(%arg10) : (vector<4xi8>) -> i32
    %11 = "rocdl.sdot4"(%9, %10, %arg11) <{clamp = false}> : (i32, i32, i32) -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sudot4_signA_unsignedB"}> ({
  ^bb0(%arg6: vector<4xi8>, %arg7: vector<4xi8>, %arg8: i32):
    %6 = "llvm.bitcast"(%arg6) : (vector<4xi8>) -> i32
    %7 = "llvm.bitcast"(%arg7) : (vector<4xi8>) -> i32
    %8 = "rocdl.sudot4"(%6, %7, %arg8) <{clamp = false, signA = true, signB = false}> : (i32, i32, i32) -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sudot4_unsignedA_signB_clamp"}> ({
  ^bb0(%arg3: vector<4xi8>, %arg4: vector<4xi8>, %arg5: i32):
    %3 = "llvm.bitcast"(%arg3) : (vector<4xi8>) -> i32
    %4 = "llvm.bitcast"(%arg4) : (vector<4xi8>) -> i32
    %5 = "rocdl.sudot4"(%3, %4, %arg5) <{clamp = true, signA = false, signB = true}> : (i32, i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi4>, vector<8xi4>, i32) -> i32, sym_name = "dot_sudot8"}> ({
  ^bb0(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32):
    %0 = "llvm.bitcast"(%arg0) : (vector<8xi4>) -> i32
    %1 = "llvm.bitcast"(%arg1) : (vector<8xi4>) -> i32
    %2 = "rocdl.sudot8"(%0, %1, %arg2) <{clamp = false, signA = true, signB = false}> : (i32, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

