"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "ignore_unused_undef"}> ({
    %0 = "spirv.Undef"() : () -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

