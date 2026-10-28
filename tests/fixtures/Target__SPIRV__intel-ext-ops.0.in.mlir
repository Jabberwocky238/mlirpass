"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, Bfloat16ConversionINTEL, Int16], [SPV_INTEL_bfloat16_conversion]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "f32_to_bf16"}> ({
  ^bb0(%arg3: f32):
    %3 = "spirv.INTEL.ConvertFToBF16"(%arg3) : (f32) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "f32_to_bf16_vec"}> ({
  ^bb0(%arg2: vector<2xf32>):
    %2 = "spirv.INTEL.ConvertFToBF16"(%arg2) : (vector<2xf32>) -> vector<2xi16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> (), sym_name = "bf16_to_f32"}> ({
  ^bb0(%arg1: i16):
    %1 = "spirv.INTEL.ConvertBF16ToF"(%arg1) : (i16) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi16>) -> (), sym_name = "bf16_to_f32_vec"}> ({
  ^bb0(%arg0: vector<2xi16>):
    %0 = "spirv.INTEL.ConvertBF16ToF"(%arg0) : (vector<2xi16>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

