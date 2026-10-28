"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "var0", type = !spirv.ptr<f32, Input>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "var1", type = !spirv.ptr<f32, Output>}> : () -> ()
  "spirv.GlobalVariable"() <{built_in = "GlobalInvocationId", sym_name = "var2", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
  "spirv.GlobalVariable"() <{built_in = "GlobalInvocationId", sym_name = "var3", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
}) : () -> ()

