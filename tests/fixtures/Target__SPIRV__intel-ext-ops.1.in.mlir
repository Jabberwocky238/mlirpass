"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, TensorFloat32RoundingINTEL], [SPV_INTEL_tensor_float32_conversion]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "f32_to_tf32"}> ({
  ^bb0(%arg1: f32):
    %1 = "spirv.INTEL.RoundFToTF32"(%arg1) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "f32_to_tf32_vec"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "spirv.INTEL.RoundFToTF32"(%arg0) : (vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

