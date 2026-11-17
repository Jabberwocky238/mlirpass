"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.SpecConstant"() <{default_value = 1.500000e+00 : f32, sym_name = "sc_f32_1"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 2.500000e+00 : f32, sym_name = "sc_f32_2"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 3.500000e+00 : f32, sym_name = "sc_f32_3"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 1 : i32, sym_name = "sc_i32_1"}> : () -> ()
  "spirv.SpecConstantComposite"() <{constituents = [@sc_f32_1, @sc_f32_2, @sc_f32_3], sym_name = "scc_array", type = !spirv.array<3 x f32>}> : () -> ()
  "spirv.SpecConstantComposite"() <{constituents = [@sc_i32_1, @sc_f32_2, @sc_f32_3], sym_name = "scc_struct", type = !spirv.struct<(i32, f32, f32)>}> : () -> ()
  "spirv.SpecConstantComposite"() <{constituents = [@sc_f32_1, @sc_f32_2, @sc_f32_3], sym_name = "scc_vector", type = vector<3xf32>}> : () -> ()
}) : () -> ()

