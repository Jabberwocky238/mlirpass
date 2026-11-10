"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "cvt_float_f32_to_f16"}> ({
  ^bb0(%arg34: vector<4xf32>):
    %32 = "nvgpu.truncf"(%arg34) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_f16_v8"}> ({
  ^bb0(%arg33: vector<8xf32>):
    %31 = "nvgpu.truncf"(%arg33) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "cvt_float_f32_to_bf16"}> ({
  ^bb0(%arg32: vector<4xf32>):
    %30 = "nvgpu.truncf"(%arg32) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>) -> vector<4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e4m3"}> ({
  ^bb0(%arg31: vector<8xf32>):
    %29 = "nvgpu.truncf"(%arg31) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf8E4M3FN>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf16>) -> (), sym_name = "cvt_float_f16_to_e2m3"}> ({
  ^bb0(%arg30: vector<8xf16>):
    %28 = "nvgpu.truncf"(%arg30) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf16>) -> vector<8xf6E2M3FN>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xbf16>) -> (), sym_name = "cvt_float_bf16_to_e3m2"}> ({
  ^bb0(%arg29: vector<8xbf16>):
    %27 = "nvgpu.truncf"(%arg29) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xbf16>) -> vector<8xf6E3M2FN>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e2m3"}> ({
  ^bb0(%arg28: vector<8xf32>):
    %26 = "nvgpu.truncf"(%arg28) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf6E2M3FN>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e8m0_rz"}> ({
  ^bb0(%arg27: vector<8xf32>):
    %25 = "nvgpu.truncf"(%arg27) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf8E8M0FNU>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "cvt_float_f32_to_e8m0_rp"}> ({
  ^bb0(%arg26: vector<8xf32>):
    %24 = "nvgpu.truncf"(%arg26) <{relu = false, rnd = #nvvm.fp_rnd_mode<rp>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf8E8M0FNU>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "fptrunc_scalar_f32_to_f16"}> ({
  ^bb0(%arg25: f32):
    %23 = "nvgpu.truncf"(%arg25) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32) -> f16
    "func.return"(%23) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> bf16, sym_name = "fptrunc_scalar_f32_to_bf16"}> ({
  ^bb0(%arg24: f32):
    %22 = "nvgpu.truncf"(%arg24) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32) -> bf16
    "func.return"(%22) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> f32, sym_name = "fptrunc_scalar_f64_to_f32"}> ({
  ^bb0(%arg23: f64):
    %21 = "nvgpu.truncf"(%arg23) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f64) -> f32
    "func.return"(%21) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<2x4xf16>, sym_name = "fptrunc_v2x4_f32_to_f16"}> ({
  ^bb0(%arg22: vector<2x4xf32>):
    %20 = "nvgpu.truncf"(%arg22) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<2x4xf32>) -> vector<2x4xf16>
    "func.return"(%20) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4x2xf32>) -> vector<4x2xf8E4M3FN>, sym_name = "fptrunc_v4x2_f32_to_f8"}> ({
  ^bb0(%arg21: vector<4x2xf32>):
    %19 = "nvgpu.truncf"(%arg21) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4x2xf32>) -> vector<4x2xf8E4M3FN>
    "func.return"(%19) : (vector<4x2xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xf32>) -> vector<1xf16>, sym_name = "fptrunc_v1f32_to_v1f16"}> ({
  ^bb0(%arg20: vector<1xf32>):
    %18 = "nvgpu.truncf"(%arg20) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<1xf32>) -> vector<1xf16>
    "func.return"(%18) : (vector<1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf16>) -> vector<3xf8E4M3FN>, sym_name = "fptrunc_v3f16_to_v3f8"}> ({
  ^bb0(%arg19: vector<3xf16>):
    %17 = "nvgpu.truncf"(%arg19) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<3xf16>) -> vector<3xf8E4M3FN>
    "func.return"(%17) : (vector<3xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1xf32>) -> vector<3x1xf16>, sym_name = "fptrunc_v3x1_f32_to_f16"}> ({
  ^bb0(%arg18: vector<3x1xf32>):
    %16 = "nvgpu.truncf"(%arg18) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<3x1xf32>) -> vector<3x1xf16>
    "func.return"(%16) : (vector<3x1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf32>, sym_name = "fptrunc_f64_to_f32"}> ({
  ^bb0(%arg17: vector<4xf64>):
    %15 = "nvgpu.truncf"(%arg17) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf64>) -> vector<4xf32>
    "func.return"(%15) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xf16>, sym_name = "fptrunc_f64_to_f16"}> ({
  ^bb0(%arg16: vector<2xf64>):
    %14 = "nvgpu.truncf"(%arg16) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<2xf64>) -> vector<2xf16>
    "func.return"(%14) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xbf16>, sym_name = "fptrunc_f64_to_bf16"}> ({
  ^bb0(%arg15: vector<2xf64>):
    %13 = "nvgpu.truncf"(%arg15) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<2xf64>) -> vector<2xbf16>
    "func.return"(%13) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf8E4M3FN>, sym_name = "fptrunc_f64_to_f8"}> ({
  ^bb0(%arg14: vector<4xf64>):
    %12 = "nvgpu.truncf"(%arg14) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf64>) -> vector<4xf8E4M3FN>
    "func.return"(%12) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "fptrunc_f32_to_f8_satfinite"}> ({
  ^bb0(%arg13: vector<8xf32>):
    %11 = "nvgpu.truncf"(%arg13) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf8E4M3FN>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_relu"}> ({
  ^bb0(%arg12: vector<4xf32>):
    %10 = "nvgpu.truncf"(%arg12) <{relu = true, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> (), sym_name = "fptrunc_f32_to_f8_default_sat"}> ({
  ^bb0(%arg11: vector<8xf32>):
    %9 = "nvgpu.truncf"(%arg11) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<8xf32>) -> vector<8xf8E4M3FN>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_default_sat"}> ({
  ^bb0(%arg10: vector<4xf32>):
    %8 = "nvgpu.truncf"(%arg10) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_explicit_none"}> ({
  ^bb0(%arg9: vector<4xf32>):
    %7 = "nvgpu.truncf"(%arg9) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<none>}> : (vector<4xf32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, i32) -> (), sym_name = "fptrunc_f32_to_f16_rs"}> ({
  ^bb0(%arg7: vector<4xf32>, %arg8: i32):
    %6 = "nvgpu.truncf"(%arg7, %arg8) <{relu = false, rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>, i32) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, i32) -> (), sym_name = "fptrunc_f32_to_bf16_rs"}> ({
  ^bb0(%arg5: vector<4xf32>, %arg6: i32):
    %5 = "nvgpu.truncf"(%arg5, %arg6) <{relu = false, rnd = #nvvm.fp_rnd_mode<rs>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>, i32) -> vector<4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_f16_rz"}> ({
  ^bb0(%arg4: vector<4xf32>):
    %4 = "nvgpu.truncf"(%arg4) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>) -> vector<4xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "fptrunc_f32_to_bf16_rz"}> ({
  ^bb0(%arg3: vector<4xf32>):
    %3 = "nvgpu.truncf"(%arg3) <{relu = false, rnd = #nvvm.fp_rnd_mode<rz>, sat = #nvvm.sat_mode<satfinite>}> : (vector<4xf32>) -> vector<4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "e2e_scalar_f32_to_f16"}> ({
  ^bb0(%arg2: f32):
    %2 = "nvgpu.truncf"(%arg2) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (f32) -> f16
    "func.return"(%2) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf32>) -> vector<2x4xf16>, sym_name = "e2e_v2x4_f32_to_f16"}> ({
  ^bb0(%arg1: vector<2x4xf32>):
    %1 = "nvgpu.truncf"(%arg1) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<2x4xf32>) -> vector<2x4xf16>
    "func.return"(%1) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf16>) -> vector<3xf8E4M3FN>, sym_name = "e2e_v3f16_to_v3f8"}> ({
  ^bb0(%arg0: vector<3xf16>):
    %0 = "nvgpu.truncf"(%arg0) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<3xf16>) -> vector<3xf8E4M3FN>
    "func.return"(%0) : (vector<3xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()

