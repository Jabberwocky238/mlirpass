"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f32) -> f32, sym_name = "dot_fdot2"}> ({
  ^bb0(%arg21: vector<2xf16>, %arg22: vector<2xf16>, %arg23: f32):
    %7 = "amdgpu.dot"(%arg21, %arg22, %arg23) : (vector<2xf16>, vector<2xf16>, f32) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f32) -> f32, sym_name = "dot_fdot2_clamp"}> ({
  ^bb0(%arg18: vector<2xf16>, %arg19: vector<2xf16>, %arg20: f32):
    %6 = "amdgpu.dot"(%arg18, %arg19, %arg20) <{clamp}> : (vector<2xf16>, vector<2xf16>, f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi16>, i32) -> i32, sym_name = "dot_sdot2"}> ({
  ^bb0(%arg15: vector<2xi16>, %arg16: vector<2xi16>, %arg17: i32):
    %5 = "amdgpu.dot"(%arg15, %arg16, %arg17) : (vector<2xi16>, vector<2xi16>, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi16>, i32) -> i32, sym_name = "dot_udot2_clamp"}> ({
  ^bb0(%arg12: vector<2xi16>, %arg13: vector<2xi16>, %arg14: i32):
    %4 = "amdgpu.dot"(%arg12, %arg13, %arg14) <{clamp, unsignedA, unsignedB}> : (vector<2xi16>, vector<2xi16>, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sdot4"}> ({
  ^bb0(%arg9: vector<4xi8>, %arg10: vector<4xi8>, %arg11: i32):
    %3 = "amdgpu.dot"(%arg9, %arg10, %arg11) : (vector<4xi8>, vector<4xi8>, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_udot4_clamp"}> ({
  ^bb0(%arg6: vector<4xi8>, %arg7: vector<4xi8>, %arg8: i32):
    %2 = "amdgpu.dot"(%arg6, %arg7, %arg8) <{clamp, unsignedA, unsignedB}> : (vector<4xi8>, vector<4xi8>, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi4>, vector<8xi4>, i32) -> i32, sym_name = "dot_sdot8"}> ({
  ^bb0(%arg3: vector<8xi4>, %arg4: vector<8xi4>, %arg5: i32):
    %1 = "amdgpu.dot"(%arg3, %arg4, %arg5) : (vector<8xi4>, vector<8xi4>, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi4>, vector<8xi4>, i32) -> i32, sym_name = "dot_udot8"}> ({
  ^bb0(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32):
    %0 = "amdgpu.dot"(%arg0, %arg1, %arg2) <{unsignedA, unsignedB}> : (vector<8xi4>, vector<8xi4>, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

