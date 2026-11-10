"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, vector<4xf8E4M3FN>, f32) -> f32, sym_name = "dot_fp8_fp8"}> ({
  ^bb0(%arg9: vector<4xf8E4M3FN>, %arg10: vector<4xf8E4M3FN>, %arg11: f32):
    %3 = "amdgpu.dot"(%arg9, %arg10, %arg11) : (vector<4xf8E4M3FN>, vector<4xf8E4M3FN>, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, vector<4xf8E5M2>, f32) -> f32, sym_name = "dot_fp8_bf8"}> ({
  ^bb0(%arg6: vector<4xf8E4M3FN>, %arg7: vector<4xf8E5M2>, %arg8: f32):
    %2 = "amdgpu.dot"(%arg6, %arg7, %arg8) : (vector<4xf8E4M3FN>, vector<4xf8E5M2>, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, vector<4xf8E4M3FN>, f32) -> f32, sym_name = "dot_bf8_fp8"}> ({
  ^bb0(%arg3: vector<4xf8E5M2>, %arg4: vector<4xf8E4M3FN>, %arg5: f32):
    %1 = "amdgpu.dot"(%arg3, %arg4, %arg5) : (vector<4xf8E5M2>, vector<4xf8E4M3FN>, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, vector<4xf8E5M2>, f32) -> f32, sym_name = "dot_bf8_bf8"}> ({
  ^bb0(%arg0: vector<4xf8E5M2>, %arg1: vector<4xf8E5M2>, %arg2: f32):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) : (vector<4xf8E5M2>, vector<4xf8E5M2>, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

