"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_full_f8e4m3_f32"}> ({
  ^bb0(%arg70: vector<4xf8E4M3FN>, %arg71: f32):
    %35 = "amdgpu.scaled_ext_packed"(%arg70, %arg71) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    "func.return"(%35) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_full_f8e4m3_f16"}> ({
  ^bb0(%arg68: vector<4xf8E4M3FN>, %arg69: f32):
    %34 = "amdgpu.scaled_ext_packed"(%arg68, %arg69) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf16>
    "func.return"(%34) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_full_f8e4m3_bf16"}> ({
  ^bb0(%arg66: vector<4xf8E4M3FN>, %arg67: f32):
    %33 = "amdgpu.scaled_ext_packed"(%arg66, %arg67) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xbf16>
    "func.return"(%33) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_half_f8e4m3_f32"}> ({
  ^bb0(%arg64: vector<2xf8E4M3FN>, %arg65: f32):
    %32 = "amdgpu.scaled_ext_packed"(%arg64, %arg65) <{index = 0 : i32}> : (vector<2xf8E4M3FN>, f32) -> vector<2xf32>
    "func.return"(%32) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_half_f8e4m3_f16"}> ({
  ^bb0(%arg62: vector<2xf8E4M3FN>, %arg63: f32):
    %31 = "amdgpu.scaled_ext_packed"(%arg62, %arg63) <{index = 0 : i32}> : (vector<2xf8E4M3FN>, f32) -> vector<2xf16>
    "func.return"(%31) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_half_f8e4m3_bf16"}> ({
  ^bb0(%arg60: vector<2xf8E4M3FN>, %arg61: f32):
    %30 = "amdgpu.scaled_ext_packed"(%arg60, %arg61) <{index = 0 : i32}> : (vector<2xf8E4M3FN>, f32) -> vector<2xbf16>
    "func.return"(%30) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_scalar_f8e4m3_f32"}> ({
  ^bb0(%arg58: vector<2xf8E4M3FN>, %arg59: f32):
    %29 = "amdgpu.scaled_ext_packed"(%arg58, %arg59) <{index = 0 : i32}> : (vector<2xf8E4M3FN>, f32) -> vector<2xf32>
    "func.return"(%29) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_scalar_f8e4m3_f16"}> ({
  ^bb0(%arg56: vector<2xf8E4M3FN>, %arg57: f32):
    %28 = "amdgpu.scaled_ext_packed"(%arg56, %arg57) <{index = 0 : i32}> : (vector<2xf8E4M3FN>, f32) -> vector<2xf16>
    "func.return"(%28) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_scalar_f8e4m3_bf16"}> ({
  ^bb0(%arg54: vector<2xf8E4M3FN>, %arg55: f32):
    %27 = "amdgpu.scaled_ext_packed"(%arg54, %arg55) <{index = 0 : i32}> : (vector<2xf8E4M3FN>, f32) -> vector<2xbf16>
    "func.return"(%27) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_full_f8e5m2_f32"}> ({
  ^bb0(%arg52: vector<4xf8E5M2>, %arg53: f32):
    %26 = "amdgpu.scaled_ext_packed"(%arg52, %arg53) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    "func.return"(%26) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_full_f8e5m2_f16"}> ({
  ^bb0(%arg50: vector<4xf8E5M2>, %arg51: f32):
    %25 = "amdgpu.scaled_ext_packed"(%arg50, %arg51) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf16>
    "func.return"(%25) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_full_f8e5m2_bf16"}> ({
  ^bb0(%arg48: vector<4xf8E5M2>, %arg49: f32):
    %24 = "amdgpu.scaled_ext_packed"(%arg48, %arg49) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xbf16>
    "func.return"(%24) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_half_f8e5m2_f32"}> ({
  ^bb0(%arg46: vector<2xf8E5M2>, %arg47: f32):
    %23 = "amdgpu.scaled_ext_packed"(%arg46, %arg47) <{index = 0 : i32}> : (vector<2xf8E5M2>, f32) -> vector<2xf32>
    "func.return"(%23) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_half_f8e5m2_f16"}> ({
  ^bb0(%arg44: vector<2xf8E5M2>, %arg45: f32):
    %22 = "amdgpu.scaled_ext_packed"(%arg44, %arg45) <{index = 0 : i32}> : (vector<2xf8E5M2>, f32) -> vector<2xf16>
    "func.return"(%22) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_half_f8e5m2_bf16"}> ({
  ^bb0(%arg42: vector<2xf8E5M2>, %arg43: f32):
    %21 = "amdgpu.scaled_ext_packed"(%arg42, %arg43) <{index = 0 : i32}> : (vector<2xf8E5M2>, f32) -> vector<2xbf16>
    "func.return"(%21) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_scalar_f8e5m2_f32"}> ({
  ^bb0(%arg40: vector<2xf8E5M2>, %arg41: f32):
    %20 = "amdgpu.scaled_ext_packed"(%arg40, %arg41) <{index = 0 : i32}> : (vector<2xf8E5M2>, f32) -> vector<2xf32>
    "func.return"(%20) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_scalar_f8e5m2_f16"}> ({
  ^bb0(%arg38: vector<2xf8E5M2>, %arg39: f32):
    %19 = "amdgpu.scaled_ext_packed"(%arg38, %arg39) <{index = 0 : i32}> : (vector<2xf8E5M2>, f32) -> vector<2xf16>
    "func.return"(%19) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_scalar_f8e5m2_bf16"}> ({
  ^bb0(%arg36: vector<2xf8E5M2>, %arg37: f32):
    %18 = "amdgpu.scaled_ext_packed"(%arg36, %arg37) <{index = 0 : i32}> : (vector<2xf8E5M2>, f32) -> vector<2xbf16>
    "func.return"(%18) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_full_f4e2m1_f32"}> ({
  ^bb0(%arg34: vector<8xf4E2M1FN>, %arg35: f32):
    %17 = "amdgpu.scaled_ext_packed"(%arg34, %arg35) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    "func.return"(%17) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_full_f4e2m1_f16"}> ({
  ^bb0(%arg32: vector<8xf4E2M1FN>, %arg33: f32):
    %16 = "amdgpu.scaled_ext_packed"(%arg32, %arg33) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf16>
    "func.return"(%16) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_full_f4e2m1_bf16"}> ({
  ^bb0(%arg30: vector<8xf4E2M1FN>, %arg31: f32):
    %15 = "amdgpu.scaled_ext_packed"(%arg30, %arg31) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xbf16>
    "func.return"(%15) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_half_f4e2m1_f32"}> ({
  ^bb0(%arg28: vector<8xf4E2M1FN>, %arg29: f32):
    %14 = "amdgpu.scaled_ext_packed"(%arg28, %arg29) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    "func.return"(%14) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_half_f4e2m1_f16"}> ({
  ^bb0(%arg26: vector<4xf4E2M1FN>, %arg27: f32):
    %13 = "amdgpu.scaled_ext_packed"(%arg26, %arg27) <{index = 0 : i32}> : (vector<4xf4E2M1FN>, f32) -> vector<2xf16>
    "func.return"(%13) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_half_f4e2m1_bf16"}> ({
  ^bb0(%arg24: vector<4xf4E2M1FN>, %arg25: f32):
    %12 = "amdgpu.scaled_ext_packed"(%arg24, %arg25) <{index = 0 : i32}> : (vector<4xf4E2M1FN>, f32) -> vector<2xbf16>
    "func.return"(%12) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_scalar_f4e2m1_f32"}> ({
  ^bb0(%arg22: vector<2xf4E2M1FN>, %arg23: f32):
    %11 = "amdgpu.scaled_ext_packed"(%arg22, %arg23) <{index = 0 : i32}> : (vector<2xf4E2M1FN>, f32) -> vector<2xf32>
    "func.return"(%11) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_scalar_f4e2m1_f16"}> ({
  ^bb0(%arg20: vector<2xf4E2M1FN>, %arg21: f32):
    %10 = "amdgpu.scaled_ext_packed"(%arg20, %arg21) <{index = 0 : i32}> : (vector<2xf4E2M1FN>, f32) -> vector<2xf16>
    "func.return"(%10) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_scalar_f4e2m1_bf16"}> ({
  ^bb0(%arg18: vector<2xf4E2M1FN>, %arg19: f32):
    %9 = "amdgpu.scaled_ext_packed"(%arg18, %arg19) <{index = 0 : i32}> : (vector<2xf4E2M1FN>, f32) -> vector<2xbf16>
    "func.return"(%9) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E4M3FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_one_f8e4m3_f32"}> ({
  ^bb0(%arg16: vector<1xf8E4M3FN>, %arg17: f32):
    %8 = "amdgpu.scaled_ext_packed"(%arg16, %arg17) <{index = 0 : i32}> : (vector<1xf8E4M3FN>, f32) -> vector<2xf32>
    "func.return"(%8) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E4M3FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_one_f8e4m3_f16"}> ({
  ^bb0(%arg14: vector<1xf8E4M3FN>, %arg15: f32):
    %7 = "amdgpu.scaled_ext_packed"(%arg14, %arg15) <{index = 0 : i32}> : (vector<1xf8E4M3FN>, f32) -> vector<2xf16>
    "func.return"(%7) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E4M3FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_one_f8e4m3_bf16"}> ({
  ^bb0(%arg12: vector<1xf8E4M3FN>, %arg13: f32):
    %6 = "amdgpu.scaled_ext_packed"(%arg12, %arg13) <{index = 0 : i32}> : (vector<1xf8E4M3FN>, f32) -> vector<2xbf16>
    "func.return"(%6) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E5M2>, f32) -> vector<2xf32>, sym_name = "scaled_ext_one_f8e5m2_f32"}> ({
  ^bb0(%arg10: vector<1xf8E5M2>, %arg11: f32):
    %5 = "amdgpu.scaled_ext_packed"(%arg10, %arg11) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf32>
    "func.return"(%5) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E5M2>, f32) -> vector<2xf16>, sym_name = "scaled_ext_one_f8e5m2_f16"}> ({
  ^bb0(%arg8: vector<1xf8E5M2>, %arg9: f32):
    %4 = "amdgpu.scaled_ext_packed"(%arg8, %arg9) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf16>
    "func.return"(%4) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf8E5M2>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_one_f8e5m2_bf16"}> ({
  ^bb0(%arg6: vector<1xf8E5M2>, %arg7: f32):
    %3 = "amdgpu.scaled_ext_packed"(%arg6, %arg7) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xbf16>
    "func.return"(%3) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf4E2M1FN>, f32) -> vector<2xf32>, sym_name = "scaled_ext_one_f4e2m1_f32"}> ({
  ^bb0(%arg4: vector<1xf4E2M1FN>, %arg5: f32):
    %2 = "amdgpu.scaled_ext_packed"(%arg4, %arg5) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf32>
    "func.return"(%2) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf4E2M1FN>, f32) -> vector<2xf16>, sym_name = "scaled_ext_one_f4e2m1_f16"}> ({
  ^bb0(%arg2: vector<1xf4E2M1FN>, %arg3: f32):
    %1 = "amdgpu.scaled_ext_packed"(%arg2, %arg3) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf16>
    "func.return"(%1) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf4E2M1FN>, f32) -> vector<2xbf16>, sym_name = "scaled_ext_one_f4e2m1_bf16"}> ({
  ^bb0(%arg0: vector<1xf4E2M1FN>, %arg1: f32):
    %0 = "amdgpu.scaled_ext_packed"(%arg0, %arg1) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xbf16>
    "func.return"(%0) : (vector<2xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

