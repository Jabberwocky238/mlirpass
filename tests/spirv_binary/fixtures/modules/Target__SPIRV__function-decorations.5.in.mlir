"spirv.module"() <{addressing_model = #spirv.addressing_model<PhysicalStorageBuffer64>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses, Linkage], [SPV_KHR_physical_storage_buffer]>}> ({
  "spirv.func"() <{arg_attrs = [{}, {spirv.decoration = #spirv.decoration<Aliased>}], function_control = #spirv.function_control<None>, function_type = (i32, !spirv.ptr<i32, PhysicalStorageBuffer>) -> (), sym_name = "fn1"}> ({
  ^bb0(%arg2: i32, %arg3: !spirv.ptr<i32, PhysicalStorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{arg_attrs = [{spirv.decoration = #spirv.decoration<Aliased>}, {spirv.decoration = #spirv.decoration<Restrict>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, PhysicalStorageBuffer>, !spirv.ptr<i32, PhysicalStorageBuffer>) -> (), sym_name = "fn2"}> ({
  ^bb0(%arg0: !spirv.ptr<i32, PhysicalStorageBuffer>, %arg1: !spirv.ptr<i32, PhysicalStorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

