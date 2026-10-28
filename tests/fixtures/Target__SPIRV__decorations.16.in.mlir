"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage, Float16], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f16, sym_name = "fp_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.FConvert"(%arg0) {fp_rounding_mode = #spirv.fp_rounding_mode<RTN>} : (f32) -> f16
    "spirv.ReturnValue"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

