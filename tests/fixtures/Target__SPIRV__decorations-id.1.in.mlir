"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.2, [Kernel, Addresses, Linkage], []>}> ({
  "spirv.SpecConstant"() <{default_value = 1024 : i32, sym_name = "sc_offset"}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "var", type = !spirv.ptr<f32, CrossWorkgroup>}> {max_byte_offset_id = @sc_offset} : () -> ()
}) : () -> ()

