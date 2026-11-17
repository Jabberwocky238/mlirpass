"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "bit_cast"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.Bitcast"(%arg0) : (f32) -> i32
    %1 = "spirv.Bitcast"(%0) : (i32) -> si32
    %2 = "spirv.Bitcast"(%1) : (si32) -> ui32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

