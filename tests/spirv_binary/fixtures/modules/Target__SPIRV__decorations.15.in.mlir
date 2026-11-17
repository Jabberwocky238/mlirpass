"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "fadd_decorations"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.FAdd"(%arg0, %arg0) {fp_fast_math_mode = #spirv.fastmath_mode<NotNaN|NotInf|NSZ>} : (f32, f32) -> f32
    "spirv.ReturnValue"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

