"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, Float16], [SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.rtarray<f32, stride=4>, StorageBuffer>}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.rtarray<vector<4xf16>>, Input>}> : () -> ()
}) : () -> ()

