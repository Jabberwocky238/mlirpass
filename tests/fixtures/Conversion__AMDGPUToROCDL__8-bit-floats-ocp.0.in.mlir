"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2) -> f32, sym_name = "ext_scalar"}> ({
  ^bb0(%arg15: f8E5M2):
    %9 = "amdgpu.ext_packed_fp8"(%arg15) <{index = 0 : i32}> : (f8E5M2) -> f32
    "func.return"(%9) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>) -> f32, sym_name = "ext_short_vec"}> ({
  ^bb0(%arg14: vector<2xf8E4M3FN>):
    %8 = "amdgpu.ext_packed_fp8"(%arg14) <{index = 1 : i32}> : (vector<2xf8E4M3FN>) -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> f32, sym_name = "ext_full_vec"}> ({
  ^bb0(%arg13: vector<4xf8E4M3FN>):
    %7 = "amdgpu.ext_packed_fp8"(%arg13) <{index = 3 : i32}> : (vector<4xf8E4M3FN>) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>) -> vector<2xf32>, sym_name = "ext_packed_2xfp8"}> ({
  ^bb0(%arg12: vector<2xf8E4M3FN>):
    %6 = "amdgpu.ext_packed_fp8"(%arg12) <{index = 0 : i32}> : (vector<2xf8E4M3FN>) -> vector<2xf32>
    "func.return"(%6) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<2xf32>, sym_name = "ext_packed_4xfp8"}> ({
  ^bb0(%arg11: vector<4xf8E4M3FN>):
    %5 = "amdgpu.ext_packed_fp8"(%arg11) <{index = 1 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    "func.return"(%5) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> vector<4xf8E4M3FN>, sym_name = "packed_trunc"}> ({
  ^bb0(%arg10: f32):
    %4 = "amdgpu.packed_trunc_2xfp8"(%arg10) <{operandSegmentSizes = array<i32: 1, 0, 0>, wordIndex = 0 : i32}> : (f32) -> vector<4xf8E4M3FN>
    "func.return"(%4) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_truncx2"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %3 = "amdgpu.packed_trunc_2xfp8"(%arg8, %arg9) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E4M3FN>
    "func.return"(%3) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>, sym_name = "packed_truncx2_into"}> ({
  ^bb0(%arg5: f32, %arg6: f32, %arg7: vector<4xf8E5M2>):
    %2 = "amdgpu.packed_trunc_2xfp8"(%arg5, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 1>, wordIndex = 1 : i32}> : (f32, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%2) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> vector<4xf8E4M3FN>, sym_name = "packed_stoch_round"}> ({
  ^bb0(%arg3: f32, %arg4: i32):
    %1 = "amdgpu.packed_stoch_round_fp8"(%arg3, %arg4) <{storeIndex = 0 : i32}> : (f32, i32) -> vector<4xf8E4M3FN>
    "func.return"(%1) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, vector<4xf8E5M2>) -> vector<4xf8E5M2>, sym_name = "packed_stoch_round_into"}> ({
  ^bb0(%arg0: f32, %arg1: i32, %arg2: vector<4xf8E5M2>):
    %0 = "amdgpu.packed_stoch_round_fp8"(%arg0, %arg1, %arg2) <{storeIndex = 1 : i32}> : (f32, i32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%0) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

