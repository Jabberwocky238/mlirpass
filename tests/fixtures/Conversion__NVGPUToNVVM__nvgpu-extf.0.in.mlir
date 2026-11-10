"builtin.module"() ({
  "func.func"() <{function_type = (vector<8xf8E4M3FN>) -> (), sym_name = "cvt_float_e4m3fn_to_f16"}> ({
  ^bb0(%arg34: vector<8xf8E4M3FN>):
    %34 = "nvgpu.extf"(%arg34) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf8E4M3FN>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E5M2>) -> (), sym_name = "cvt_float_e5m2_to_f16"}> ({
  ^bb0(%arg33: vector<8xf8E5M2>):
    %33 = "nvgpu.extf"(%arg33) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf8E5M2>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E8M0FNU>) -> (), sym_name = "cvt_float_e8m0_to_bf16"}> ({
  ^bb0(%arg32: vector<8xf8E8M0FNU>):
    %32 = "nvgpu.extf"(%arg32) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf8E8M0FNU>) -> vector<8xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E2M3FN>) -> (), sym_name = "cvt_float_e2m3_to_f16"}> ({
  ^bb0(%arg31: vector<8xf6E2M3FN>):
    %31 = "nvgpu.extf"(%arg31) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf6E2M3FN>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E3M2FN>) -> (), sym_name = "cvt_float_e3m2_to_f16"}> ({
  ^bb0(%arg30: vector<8xf6E3M2FN>):
    %30 = "nvgpu.extf"(%arg30) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf6E3M2FN>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), sym_name = "cvt_float_e2m1_to_f16"}> ({
  ^bb0(%arg29: vector<16xf4E2M1FN>):
    %29 = "nvgpu.extf"(%arg29) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<16xf4E2M1FN>) -> vector<16xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf6E2M3FN>) -> (), sym_name = "cvt_float_e2m3_to_bf16"}> ({
  ^bb0(%arg28: vector<8xf6E2M3FN>):
    %28 = "nvgpu.extf"(%arg28) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf6E2M3FN>) -> vector<8xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf4E2M1FN>) -> (), sym_name = "cvt_float_e2m1_to_bf16"}> ({
  ^bb0(%arg27: vector<16xf4E2M1FN>):
    %27 = "nvgpu.extf"(%arg27) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<16xf4E2M1FN>) -> vector<16xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<4xf32>, sym_name = "fpext_e4m3fn_to_f32"}> ({
  ^bb0(%arg26: vector<4xf8E4M3FN>):
    %26 = "nvgpu.extf"(%arg26) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf8E4M3FN>) -> vector<4xf32>
    "func.return"(%26) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>) -> vector<4xf32>, sym_name = "fpext_e5m2_to_f32"}> ({
  ^bb0(%arg25: vector<4xf8E5M2>):
    %25 = "nvgpu.extf"(%arg25) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf8E5M2>) -> vector<4xf32>
    "func.return"(%25) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E8M0FNU>) -> vector<4xf32>, sym_name = "fpext_e8m0_to_f32"}> ({
  ^bb0(%arg24: vector<4xf8E8M0FNU>):
    %24 = "nvgpu.extf"(%arg24) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf8E8M0FNU>) -> vector<4xf32>
    "func.return"(%24) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf6E2M3FN>) -> vector<4xf32>, sym_name = "fpext_e2m3_to_f32"}> ({
  ^bb0(%arg23: vector<4xf6E2M3FN>):
    %23 = "nvgpu.extf"(%arg23) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf6E2M3FN>) -> vector<4xf32>
    "func.return"(%23) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>) -> vector<8xf32>, sym_name = "fpext_e2m1_to_f32"}> ({
  ^bb0(%arg22: vector<8xf4E2M1FN>):
    %22 = "nvgpu.extf"(%arg22) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf4E2M1FN>) -> vector<8xf32>
    "func.return"(%22) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf32>, sym_name = "fpext_f16_to_f32"}> ({
  ^bb0(%arg21: vector<4xf16>):
    %21 = "nvgpu.extf"(%arg21) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf16>) -> vector<4xf32>
    "func.return"(%21) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xf32>, sym_name = "fpext_bf16_to_f32"}> ({
  ^bb0(%arg20: vector<4xbf16>):
    %20 = "nvgpu.extf"(%arg20) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xbf16>) -> vector<4xf32>
    "func.return"(%20) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf64>, sym_name = "fpext_f16_to_f64"}> ({
  ^bb0(%arg19: vector<4xf16>):
    %19 = "nvgpu.extf"(%arg19) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf16>) -> vector<4xf64>
    "func.return"(%19) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xbf16>) -> vector<4xf64>, sym_name = "fpext_bf16_to_f64"}> ({
  ^bb0(%arg18: vector<4xbf16>):
    %18 = "nvgpu.extf"(%arg18) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xbf16>) -> vector<4xf64>
    "func.return"(%18) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf64>, sym_name = "fpext_f32_to_f64"}> ({
  ^bb0(%arg17: vector<4xf32>):
    %17 = "nvgpu.extf"(%arg17) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf32>) -> vector<4xf64>
    "func.return"(%17) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<4xf64>, sym_name = "fpext_f8_to_f64"}> ({
  ^bb0(%arg16: vector<4xf8E4M3FN>):
    %16 = "nvgpu.extf"(%arg16) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf8E4M3FN>) -> vector<4xf64>
    "func.return"(%16) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf4E2M1FN>) -> vector<8xf64>, sym_name = "fpext_f4_to_f64"}> ({
  ^bb0(%arg15: vector<8xf4E2M1FN>):
    %15 = "nvgpu.extf"(%arg15) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf4E2M1FN>) -> vector<8xf64>
    "func.return"(%15) : (vector<8xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf6E2M3FN>) -> vector<4xf64>, sym_name = "fpext_e2m3_to_f64"}> ({
  ^bb0(%arg14: vector<4xf6E2M3FN>):
    %14 = "nvgpu.extf"(%arg14) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<4xf6E2M3FN>) -> vector<4xf64>
    "func.return"(%14) : (vector<4xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f16, sym_name = "fpext_scalar_f8_to_f16"}> ({
  ^bb0(%arg13: f8E4M3FN):
    %13 = "nvgpu.extf"(%arg13) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (f8E4M3FN) -> f16
    "func.return"(%13) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f32, sym_name = "fpext_scalar_f8_to_f32"}> ({
  ^bb0(%arg12: f8E4M3FN):
    %12 = "nvgpu.extf"(%arg12) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (f8E4M3FN) -> f32
    "func.return"(%12) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>, sym_name = "fpext_v2x4_f8_to_f16"}> ({
  ^bb0(%arg11: vector<2x4xf8E4M3FN>):
    %11 = "nvgpu.extf"(%arg11) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>
    "func.return"(%11) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>, sym_name = "fpext_v2x4_f8_to_f32"}> ({
  ^bb0(%arg10: vector<2x4xf8E4M3FN>):
    %10 = "nvgpu.extf"(%arg10) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>
    "func.return"(%10) : (vector<2x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf16>, sym_name = "fpext_v3f8_to_v3f16"}> ({
  ^bb0(%arg9: vector<3xf8E5M2>):
    %9 = "nvgpu.extf"(%arg9) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<3xf8E5M2>) -> vector<3xf16>
    "func.return"(%9) : (vector<3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf32>, sym_name = "fpext_v3_f8_to_f32"}> ({
  ^bb0(%arg8: vector<3xf8E5M2>):
    %8 = "nvgpu.extf"(%arg8) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<3xf8E5M2>) -> vector<3xf32>
    "func.return"(%8) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3x1xf8E4M3FN>) -> vector<3x1xf16>, sym_name = "fpext_v3x1_f8_to_f16"}> ({
  ^bb0(%arg7: vector<3x1xf8E4M3FN>):
    %7 = "nvgpu.extf"(%arg7) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<3x1xf8E4M3FN>) -> vector<3x1xf16>
    "func.return"(%7) : (vector<3x1xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf8E4M3FN>) -> (), sym_name = "fpext_f8_to_f16_relu"}> ({
  ^bb0(%arg6: vector<8xf8E4M3FN>):
    %6 = "nvgpu.extf"(%arg6) <{relu = true, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<8xf8E4M3FN>) -> vector<8xf16>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f16, sym_name = "e2e_scalar_f8_to_f16"}> ({
  ^bb0(%arg5: f8E4M3FN):
    %5 = "nvgpu.extf"(%arg5) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (f8E4M3FN) -> f16
    "func.return"(%5) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>, sym_name = "e2e_v2x4_f8_to_f16"}> ({
  ^bb0(%arg4: vector<2x4xf8E4M3FN>):
    %4 = "nvgpu.extf"(%arg4) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<2x4xf8E4M3FN>) -> vector<2x4xf16>
    "func.return"(%4) : (vector<2x4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf16>, sym_name = "e2e_v3f8_to_v3f16"}> ({
  ^bb0(%arg3: vector<3xf8E5M2>):
    %3 = "nvgpu.extf"(%arg3) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<3xf8E5M2>) -> vector<3xf16>
    "func.return"(%3) : (vector<3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f8E4M3FN) -> f32, sym_name = "e2e_scalar_f8_to_f32"}> ({
  ^bb0(%arg2: f8E4M3FN):
    %2 = "nvgpu.extf"(%arg2) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (f8E4M3FN) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>, sym_name = "e2e_v2x4_f8_to_f32"}> ({
  ^bb0(%arg1: vector<2x4xf8E4M3FN>):
    %1 = "nvgpu.extf"(%arg1) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<2x4xf8E4M3FN>) -> vector<2x4xf32>
    "func.return"(%1) : (vector<2x4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xf8E5M2>) -> vector<3xf32>, sym_name = "e2e_v3f8_to_v3f32"}> ({
  ^bb0(%arg0: vector<3xf8E5M2>):
    %0 = "nvgpu.extf"(%arg0) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>}> : (vector<3xf8E5M2>) -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

