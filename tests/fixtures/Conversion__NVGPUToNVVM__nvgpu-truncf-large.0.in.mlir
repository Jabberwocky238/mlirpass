"builtin.module"() ({
  "func.func"() <{function_type = (vector<400xf32>) -> vector<400xf16>, sym_name = "cvt_large_f32_to_f16"}> ({
  ^bb0(%arg6: vector<400xf32>):
    %6 = "nvgpu.truncf"(%arg6) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xf32>) -> vector<400xf16>
    "func.return"(%6) : (vector<400xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<400xf32>) -> vector<400xbf16>, sym_name = "cvt_large_f32_to_bf16"}> ({
  ^bb0(%arg5: vector<400xf32>):
    %5 = "nvgpu.truncf"(%arg5) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xf32>) -> vector<400xbf16>
    "func.return"(%5) : (vector<400xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<400xf32>) -> vector<400xf8E4M3FN>, sym_name = "cvt_large_f32_to_f8"}> ({
  ^bb0(%arg4: vector<400xf32>):
    %4 = "nvgpu.truncf"(%arg4) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xf32>) -> vector<400xf8E4M3FN>
    "func.return"(%4) : (vector<400xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<400xf32>) -> vector<400xf6E2M3FN>, sym_name = "cvt_large_f32_to_f6"}> ({
  ^bb0(%arg3: vector<400xf32>):
    %3 = "nvgpu.truncf"(%arg3) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xf32>) -> vector<400xf6E2M3FN>
    "func.return"(%3) : (vector<400xf6E2M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<400xf32>) -> vector<400xf4E2M1FN>, sym_name = "cvt_large_f32_to_f4"}> ({
  ^bb0(%arg2: vector<400xf32>):
    %2 = "nvgpu.truncf"(%arg2) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xf32>) -> vector<400xf4E2M1FN>
    "func.return"(%2) : (vector<400xf4E2M1FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<400xf16>) -> vector<400xf8E4M3FN>, sym_name = "cvt_large_f16_to_f8"}> ({
  ^bb0(%arg1: vector<400xf16>):
    %1 = "nvgpu.truncf"(%arg1) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xf16>) -> vector<400xf8E4M3FN>
    "func.return"(%1) : (vector<400xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<400xbf16>) -> vector<400xf6E3M2FN>, sym_name = "cvt_large_bf16_to_f6"}> ({
  ^bb0(%arg0: vector<400xbf16>):
    %0 = "nvgpu.truncf"(%arg0) <{relu = false, rnd = #nvvm.fp_rnd_mode<rn>, sat = #nvvm.sat_mode<satfinite>}> : (vector<400xbf16>) -> vector<400xf6E3M2FN>
    "func.return"(%0) : (vector<400xf6E3M2FN>) -> ()
  }) : () -> ()
}) : () -> ()

