"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f32"}> ({
  ^bb0(%arg88: vector<2xf32>, %arg89: f32):
    %35 = "amdgpu.packed_scaled_trunc"(%arg88, %arg89) <{index = 0 : i32}> : (vector<2xf32>, f32) -> vector<4xf8E4M3FN>
    "func.return"(%35) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f32_vec1"}> ({
  ^bb0(%arg86: vector<1xf32>, %arg87: f32):
    %34 = "amdgpu.packed_scaled_trunc"(%arg86, %arg87) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E4M3FN>
    "func.return"(%34) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f32"}> ({
  ^bb0(%arg83: vector<2xf32>, %arg84: vector<4xf8E4M3FN>, %arg85: f32):
    %33 = "amdgpu.packed_scaled_trunc"(%arg83, %arg85, %arg84) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%33) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f32_vec1"}> ({
  ^bb0(%arg80: vector<1xf32>, %arg81: vector<4xf8E4M3FN>, %arg82: f32):
    %32 = "amdgpu.packed_scaled_trunc"(%arg80, %arg82, %arg81) <{index = 0 : i32}> : (vector<1xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%32) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f16"}> ({
  ^bb0(%arg78: vector<2xf16>, %arg79: f32):
    %31 = "amdgpu.packed_scaled_trunc"(%arg78, %arg79) <{index = 0 : i32}> : (vector<2xf16>, f32) -> vector<4xf8E4M3FN>
    "func.return"(%31) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_f16_vec1"}> ({
  ^bb0(%arg76: vector<1xf16>, %arg77: f32):
    %30 = "amdgpu.packed_scaled_trunc"(%arg76, %arg77) <{index = 0 : i32}> : (vector<1xf16>, f32) -> vector<4xf8E4M3FN>
    "func.return"(%30) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f16"}> ({
  ^bb0(%arg73: vector<2xf16>, %arg74: vector<4xf8E4M3FN>, %arg75: f32):
    %29 = "amdgpu.packed_scaled_trunc"(%arg73, %arg75, %arg74) <{index = 0 : i32}> : (vector<2xf16>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%29) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_f16_vec1"}> ({
  ^bb0(%arg70: vector<1xf16>, %arg71: vector<4xf8E4M3FN>, %arg72: f32):
    %28 = "amdgpu.packed_scaled_trunc"(%arg70, %arg72, %arg71) <{index = 0 : i32}> : (vector<1xf16>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%28) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_bf16"}> ({
  ^bb0(%arg68: vector<2xbf16>, %arg69: f32):
    %27 = "amdgpu.packed_scaled_trunc"(%arg68, %arg69) <{index = 0 : i32}> : (vector<2xbf16>, f32) -> vector<4xf8E4M3FN>
    "func.return"(%27) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_f8e4m3_bf16_vec1"}> ({
  ^bb0(%arg66: vector<1xbf16>, %arg67: f32):
    %26 = "amdgpu.packed_scaled_trunc"(%arg66, %arg67) <{index = 0 : i32}> : (vector<1xbf16>, f32) -> vector<4xf8E4M3FN>
    "func.return"(%26) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_bf16"}> ({
  ^bb0(%arg63: vector<2xbf16>, %arg64: vector<4xf8E4M3FN>, %arg65: f32):
    %25 = "amdgpu.packed_scaled_trunc"(%arg63, %arg65, %arg64) <{index = 0 : i32}> : (vector<2xbf16>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%25) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, vector<4xf8E4M3FN>, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_scaled_trunc_into_f8e4m3_bf16_vec1"}> ({
  ^bb0(%arg60: vector<1xbf16>, %arg61: vector<4xf8E4M3FN>, %arg62: f32):
    %24 = "amdgpu.packed_scaled_trunc"(%arg60, %arg62, %arg61) <{index = 0 : i32}> : (vector<1xbf16>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    "func.return"(%24) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f32"}> ({
  ^bb0(%arg58: vector<2xf32>, %arg59: f32):
    %23 = "amdgpu.packed_scaled_trunc"(%arg58, %arg59) <{index = 0 : i32}> : (vector<2xf32>, f32) -> vector<4xf8E5M2>
    "func.return"(%23) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f32_vec1"}> ({
  ^bb0(%arg56: vector<1xf32>, %arg57: f32):
    %22 = "amdgpu.packed_scaled_trunc"(%arg56, %arg57) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E5M2>
    "func.return"(%22) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f32"}> ({
  ^bb0(%arg53: vector<2xf32>, %arg54: vector<4xf8E5M2>, %arg55: f32):
    %21 = "amdgpu.packed_scaled_trunc"(%arg53, %arg55, %arg54) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%21) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f32_vec1"}> ({
  ^bb0(%arg50: vector<1xf32>, %arg51: vector<4xf8E5M2>, %arg52: f32):
    %20 = "amdgpu.packed_scaled_trunc"(%arg50, %arg52, %arg51) <{index = 0 : i32}> : (vector<1xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%20) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f16"}> ({
  ^bb0(%arg48: vector<2xf16>, %arg49: f32):
    %19 = "amdgpu.packed_scaled_trunc"(%arg48, %arg49) <{index = 0 : i32}> : (vector<2xf16>, f32) -> vector<4xf8E5M2>
    "func.return"(%19) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_f16_vec1"}> ({
  ^bb0(%arg46: vector<1xf16>, %arg47: f32):
    %18 = "amdgpu.packed_scaled_trunc"(%arg46, %arg47) <{index = 0 : i32}> : (vector<1xf16>, f32) -> vector<4xf8E5M2>
    "func.return"(%18) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f16"}> ({
  ^bb0(%arg43: vector<2xf16>, %arg44: vector<4xf8E5M2>, %arg45: f32):
    %17 = "amdgpu.packed_scaled_trunc"(%arg43, %arg45, %arg44) <{index = 0 : i32}> : (vector<2xf16>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%17) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_f16_vec1"}> ({
  ^bb0(%arg40: vector<1xf16>, %arg41: vector<4xf8E5M2>, %arg42: f32):
    %16 = "amdgpu.packed_scaled_trunc"(%arg40, %arg42, %arg41) <{index = 0 : i32}> : (vector<1xf16>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%16) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_bf16"}> ({
  ^bb0(%arg38: vector<2xbf16>, %arg39: f32):
    %15 = "amdgpu.packed_scaled_trunc"(%arg38, %arg39) <{index = 0 : i32}> : (vector<2xbf16>, f32) -> vector<4xf8E5M2>
    "func.return"(%15) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_f8e5m2_bf16_vec1"}> ({
  ^bb0(%arg36: vector<1xbf16>, %arg37: f32):
    %14 = "amdgpu.packed_scaled_trunc"(%arg36, %arg37) <{index = 0 : i32}> : (vector<1xbf16>, f32) -> vector<4xf8E5M2>
    "func.return"(%14) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_bf16"}> ({
  ^bb0(%arg33: vector<2xbf16>, %arg34: vector<4xf8E5M2>, %arg35: f32):
    %13 = "amdgpu.packed_scaled_trunc"(%arg33, %arg35, %arg34) <{index = 0 : i32}> : (vector<2xbf16>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%13) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, vector<4xf8E5M2>, f32) -> vector<4xf8E5M2>, sym_name = "packed_scaled_trunc_into_f8e5m2_bf16_vec1"}> ({
  ^bb0(%arg30: vector<1xbf16>, %arg31: vector<4xf8E5M2>, %arg32: f32):
    %12 = "amdgpu.packed_scaled_trunc"(%arg30, %arg32, %arg31) <{index = 0 : i32}> : (vector<1xbf16>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%12) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f32"}> ({
  ^bb0(%arg28: vector<2xf32>, %arg29: f32):
    %11 = "amdgpu.packed_scaled_trunc"(%arg28, %arg29) <{index = 0 : i32}> : (vector<2xf32>, f32) -> vector<8xf4E2M1FN>
    "func.return"(%11) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f32_vec1"}> ({
  ^bb0(%arg26: vector<1xf32>, %arg27: f32):
    %10 = "amdgpu.packed_scaled_trunc"(%arg26, %arg27) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<8xf4E2M1FN>
    "func.return"(%10) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f32"}> ({
  ^bb0(%arg23: vector<2xf32>, %arg24: vector<8xf4E2M1FN>, %arg25: f32):
    %9 = "amdgpu.packed_scaled_trunc"(%arg23, %arg25, %arg24) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    "func.return"(%9) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f32_vec1"}> ({
  ^bb0(%arg20: vector<1xf32>, %arg21: vector<8xf4E2M1FN>, %arg22: f32):
    %8 = "amdgpu.packed_scaled_trunc"(%arg20, %arg22, %arg21) <{index = 0 : i32}> : (vector<1xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    "func.return"(%8) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f16"}> ({
  ^bb0(%arg18: vector<2xf16>, %arg19: f32):
    %7 = "amdgpu.packed_scaled_trunc"(%arg18, %arg19) <{index = 0 : i32}> : (vector<2xf16>, f32) -> vector<8xf4E2M1FN>
    "func.return"(%7) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_f16_vec1"}> ({
  ^bb0(%arg16: vector<1xf16>, %arg17: f32):
    %6 = "amdgpu.packed_scaled_trunc"(%arg16, %arg17) <{index = 0 : i32}> : (vector<1xf16>, f32) -> vector<8xf4E2M1FN>
    "func.return"(%6) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f16"}> ({
  ^bb0(%arg13: vector<2xf16>, %arg14: vector<8xf4E2M1FN>, %arg15: f32):
    %5 = "amdgpu.packed_scaled_trunc"(%arg13, %arg15, %arg14) <{index = 0 : i32}> : (vector<2xf16>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    "func.return"(%5) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_f16_vec1"}> ({
  ^bb0(%arg10: vector<1xf16>, %arg11: vector<8xf4E2M1FN>, %arg12: f32):
    %4 = "amdgpu.packed_scaled_trunc"(%arg10, %arg12, %arg11) <{index = 0 : i32}> : (vector<1xf16>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    "func.return"(%4) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_bf16"}> ({
  ^bb0(%arg8: vector<2xbf16>, %arg9: f32):
    %3 = "amdgpu.packed_scaled_trunc"(%arg8, %arg9) <{index = 0 : i32}> : (vector<2xbf16>, f32) -> vector<8xf4E2M1FN>
    "func.return"(%3) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_f4e2m1_bf16_vec1"}> ({
  ^bb0(%arg6: vector<1xbf16>, %arg7: f32):
    %2 = "amdgpu.packed_scaled_trunc"(%arg6, %arg7) <{index = 0 : i32}> : (vector<1xbf16>, f32) -> vector<8xf4E2M1FN>
    "func.return"(%2) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xbf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_bf16"}> ({
  ^bb0(%arg3: vector<2xbf16>, %arg4: vector<8xf4E2M1FN>, %arg5: f32):
    %1 = "amdgpu.packed_scaled_trunc"(%arg3, %arg5, %arg4) <{index = 0 : i32}> : (vector<2xbf16>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    "func.return"(%1) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xbf16>, vector<8xf4E2M1FN>, f32) -> vector<8xf4E2M1FN>, sym_name = "packed_scaled_trunc_into_f4e2m1_bf16_vec1"}> ({
  ^bb0(%arg0: vector<1xbf16>, %arg1: vector<8xf4E2M1FN>, %arg2: f32):
    %0 = "amdgpu.packed_scaled_trunc"(%arg0, %arg2, %arg1) <{index = 0 : i32}> : (vector<1xbf16>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    "func.return"(%0) : (vector<8xf4E2M1FN>) -> ()
  }) : () -> ()
}) : () -> ()

