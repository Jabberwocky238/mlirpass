"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, Int8], []>}> ({
  "spirv.SpecConstant"() <{default_value = 1 : i8, sym_name = "sc0"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 2 : i8, sym_name = "sc1"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 3 : i8, sym_name = "sc2"}> : () -> ()
  "spirv.SpecConstantComposite"() <{constituents = [@sc0, @sc1, @sc2], sym_name = "scc", type = !spirv.array<3 x i8>}> : () -> ()
  "spirv.GlobalVariable"() <{initializer = @scc, sym_name = "var", type = !spirv.ptr<!spirv.array<3 x i8>, Uniform>}> : () -> ()
}) : () -> ()

