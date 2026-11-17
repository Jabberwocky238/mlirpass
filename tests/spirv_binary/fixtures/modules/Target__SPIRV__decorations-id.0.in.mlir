"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.2, [Kernel, Addresses, Linkage], []>}> ({
  "spirv.SpecConstant"() <{default_value = 16 : i32, sym_name = "sc_align"}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "var", type = !spirv.ptr<f32, CrossWorkgroup>}> {alignment_id = @sc_align} : () -> ()
}) : () -> ()

