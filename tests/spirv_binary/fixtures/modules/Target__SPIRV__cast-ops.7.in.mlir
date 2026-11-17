"spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, PhysicalStorageBufferAddresses, Linkage], [SPV_EXT_physical_storage_buffer]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "covert_u_to_ptr_PhysicalStorageBuffer"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.ConvertUToPtr"(%arg0) : (i32) -> !spirv.ptr<i32, PhysicalStorageBuffer>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

