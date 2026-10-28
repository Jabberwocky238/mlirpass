"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, Int8], []>}> ({
  "spirv.SpecConstant"() <{default_value = 1 : i8, sym_name = "sc"}> : () -> ()
  "spirv.GlobalVariable"() <{initializer = @sc, sym_name = "var", type = !spirv.ptr<i8, Uniform>}> : () -> ()
}) : () -> ()

