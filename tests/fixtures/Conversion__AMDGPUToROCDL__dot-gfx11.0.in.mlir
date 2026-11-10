"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f16) -> f16, sym_name = "dot_fdot2_f16_f16"}> ({
  ^bb0(%arg18: vector<2xf16>, %arg19: vector<2xf16>, %arg20: f16):
    %6 = "amdgpu.dot"(%arg18, %arg19, %arg20) : (vector<2xf16>, vector<2xf16>, f16) -> f16
    "func.return"(%6) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<2xbf16>, bf16) -> bf16, sym_name = "dot_fdot2_bf16_bf16"}> ({
  ^bb0(%arg15: vector<2xbf16>, %arg16: vector<2xbf16>, %arg17: bf16):
    %5 = "amdgpu.dot"(%arg15, %arg16, %arg17) : (vector<2xbf16>, vector<2xbf16>, bf16) -> bf16
    "func.return"(%5) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<2xbf16>, f32) -> f32, sym_name = "dot_fdot2_f32_bf16"}> ({
  ^bb0(%arg12: vector<2xbf16>, %arg13: vector<2xbf16>, %arg14: f32):
    %4 = "amdgpu.dot"(%arg12, %arg13, %arg14) : (vector<2xbf16>, vector<2xbf16>, f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sdot4_gfx11_uniform_sign"}> ({
  ^bb0(%arg9: vector<4xi8>, %arg10: vector<4xi8>, %arg11: i32):
    %3 = "amdgpu.dot"(%arg9, %arg10, %arg11) : (vector<4xi8>, vector<4xi8>, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sudot4_signA_unsignedB"}> ({
  ^bb0(%arg6: vector<4xi8>, %arg7: vector<4xi8>, %arg8: i32):
    %2 = "amdgpu.dot"(%arg6, %arg7, %arg8) <{unsignedB}> : (vector<4xi8>, vector<4xi8>, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sudot4_unsignedA_signB_clamp"}> ({
  ^bb0(%arg3: vector<4xi8>, %arg4: vector<4xi8>, %arg5: i32):
    %1 = "amdgpu.dot"(%arg3, %arg4, %arg5) <{clamp, unsignedA}> : (vector<4xi8>, vector<4xi8>, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi4>, vector<8xi4>, i32) -> i32, sym_name = "dot_sudot8"}> ({
  ^bb0(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) <{unsignedB}> : (vector<8xi4>, vector<8xi4>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

