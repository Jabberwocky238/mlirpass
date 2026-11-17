"spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses, Linkage, GenericPointer], [SPV_KHR_physical_storage_buffer]>}> ({
  "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<AliasedPointer>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.ptr<i32, PhysicalStorageBuffer>, Generic>) -> (), sym_name = "func_arg_decoration_aliased_pointer"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.ptr<i32, PhysicalStorageBuffer>, Generic>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

