"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, ReplicatedCompositesEXT], [SPV_EXT_replicated_composites]>}> ({
  "spirv.SpecConstant"() <{default_value = 1 : i32, sym_name = "sc_i32_1"}> : () -> ()
  "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_array_of_i32", type = !spirv.array<3 x i32>}> : () -> ()
  "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_struct_of_i32", type = !spirv.struct<(i32, i32, i32)>}> : () -> ()
  "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_i32_1, sym_name = "scc_splat_vector_of_i32", type = vector<3xi32>}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 1.000000e+00 : f32, sym_name = "sc_f32_1"}> : () -> ()
  "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_array_of_f32", type = !spirv.array<3 x f32>}> : () -> ()
  "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_struct_of_f32", type = !spirv.struct<(f32, f32, f32)>}> : () -> ()
  "spirv.EXT.SpecConstantCompositeReplicate"() <{constituent = @sc_f32_1, sym_name = "scc_splat_vector_of_f32", type = vector<3xf32>}> : () -> ()
}) : () -> ()

