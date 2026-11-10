"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, vector<4xf8E4M3FN>, f32) -> f32, sym_name = "dot_fp8_requires_gfx12"}> ({
  ^bb0(%arg0: vector<4xf8E4M3FN>, %arg1: vector<4xf8E4M3FN>, %arg2: f32):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) : (vector<4xf8E4M3FN>, vector<4xf8E4M3FN>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f16) -> f16, sym_name = "dot_f16_f16_requires_gfx11"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: f16):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) : (vector<2xf16>, vector<2xf16>, f16) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xbf16>, vector<2xbf16>, f32) -> f32, sym_name = "dot_f32_bf16_requires_gfx11_or_gfx950"}> ({
  ^bb0(%arg0: vector<2xbf16>, %arg1: vector<2xbf16>, %arg2: f32):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) : (vector<2xbf16>, vector<2xbf16>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_mixed_sign_requires_gfx11"}> ({
  ^bb0(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i32):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) <{unsignedB}> : (vector<4xi8>, vector<4xi8>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

