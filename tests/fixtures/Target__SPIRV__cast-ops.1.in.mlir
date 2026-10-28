"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, BFloat16TypeKHR, Float64, Int64], [SPV_KHR_bfloat16]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i32, sym_name = "convert_f_to_s"}> ({
  ^bb0(%arg16: f32):
    %16 = "spirv.ConvertFToS"(%arg16) : (f32) -> i32
    "spirv.ReturnValue"(%16) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> i32, sym_name = "convert_f64_to_s32"}> ({
  ^bb0(%arg15: f64):
    %15 = "spirv.ConvertFToS"(%arg15) : (f64) -> i32
    "spirv.ReturnValue"(%15) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (bf16) -> i32, sym_name = "convert_bf16_to_s32"}> ({
  ^bb0(%arg14: bf16):
    %14 = "spirv.ConvertFToS"(%arg14) : (bf16) -> i32
    "spirv.ReturnValue"(%14) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i32, sym_name = "convert_f_to_u"}> ({
  ^bb0(%arg13: f32):
    %13 = "spirv.ConvertFToU"(%arg13) : (f32) -> i32
    "spirv.ReturnValue"(%13) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> i32, sym_name = "convert_f64_to_u32"}> ({
  ^bb0(%arg12: f64):
    %12 = "spirv.ConvertFToU"(%arg12) : (f64) -> i32
    "spirv.ReturnValue"(%12) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (bf16) -> i32, sym_name = "convert_bf16_to_u32"}> ({
  ^bb0(%arg11: bf16):
    %11 = "spirv.ConvertFToU"(%arg11) : (bf16) -> i32
    "spirv.ReturnValue"(%11) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "convert_s_to_f"}> ({
  ^bb0(%arg10: i32):
    %10 = "spirv.ConvertSToF"(%arg10) : (i32) -> f32
    "spirv.ReturnValue"(%10) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> f32, sym_name = "convert_s64_to_f32"}> ({
  ^bb0(%arg9: i64):
    %9 = "spirv.ConvertSToF"(%arg9) : (i64) -> f32
    "spirv.ReturnValue"(%9) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> bf16, sym_name = "convert_s64_to_bf16"}> ({
  ^bb0(%arg8: i64):
    %8 = "spirv.ConvertSToF"(%arg8) : (i64) -> bf16
    "spirv.ReturnValue"(%8) : (bf16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> f32, sym_name = "convert_u_to_f"}> ({
  ^bb0(%arg7: i32):
    %7 = "spirv.ConvertUToF"(%arg7) : (i32) -> f32
    "spirv.ReturnValue"(%7) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> f32, sym_name = "convert_u64_to_f32"}> ({
  ^bb0(%arg6: i64):
    %6 = "spirv.ConvertUToF"(%arg6) : (i64) -> f32
    "spirv.ReturnValue"(%6) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> bf16, sym_name = "convert_u64_to_bf16"}> ({
  ^bb0(%arg5: i64):
    %5 = "spirv.ConvertUToF"(%arg5) : (i64) -> bf16
    "spirv.ReturnValue"(%5) : (bf16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f64, sym_name = "convert_f32_to_f64"}> ({
  ^bb0(%arg4: f32):
    %4 = "spirv.FConvert"(%arg4) : (f32) -> f64
    "spirv.ReturnValue"(%4) : (f64) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> bf16, sym_name = "convert_f32_to_bf16"}> ({
  ^bb0(%arg3: f32):
    %3 = "spirv.FConvert"(%arg3) : (f32) -> bf16
    "spirv.ReturnValue"(%3) : (bf16) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (bf16) -> f32, sym_name = "convert_bf16_to_f32"}> ({
  ^bb0(%arg2: bf16):
    %2 = "spirv.FConvert"(%arg2) : (bf16) -> f32
    "spirv.ReturnValue"(%2) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "s_convert"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.SConvert"(%arg1) : (i32) -> i64
    "spirv.ReturnValue"(%1) : (i64) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i64, sym_name = "u_convert"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.UConvert"(%arg0) : (i32) -> i64
    "spirv.ReturnValue"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

