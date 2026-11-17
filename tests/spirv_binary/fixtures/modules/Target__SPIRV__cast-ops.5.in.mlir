"spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Addresses, PhysicalStorageBufferAddresses, Linkage], [SPV_EXT_physical_storage_buffer]>}> ({
  "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<Aliased>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, PhysicalStorageBuffer>) -> (), sym_name = "covert_ptr_to_u_PhysicalStorageBuffer"}> ({
  ^bb0(%arg0: !spirv.ptr<i32, PhysicalStorageBuffer>):
    %0 = "spirv.ConvertPtrToU"(%arg0) : (!spirv.ptr<i32, PhysicalStorageBuffer>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

