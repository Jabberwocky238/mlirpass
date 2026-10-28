"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, Float16], [SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.GlobalVariable"() <{sym_name = "var0", type = !spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, StorageBuffer>}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "var1", type = !spirv.ptr<!spirv.matrix<2 x vector<3xf32>>, StorageBuffer>}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "var2", type = !spirv.ptr<!spirv.matrix<4 x vector<4xf16>>, StorageBuffer>}> : () -> ()
}) : () -> ()

