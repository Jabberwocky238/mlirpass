"spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses, Linkage], [SPV_KHR_physical_storage_buffer]>}> ({
  "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<Aliased>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, PhysicalStorageBuffer>) -> (), sym_name = "func_arg_decoration_aliased"}> ({
  ^bb0(%arg0: !spirv.ptr<i32, PhysicalStorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

