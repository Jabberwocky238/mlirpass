"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "reshape_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<25x6x29x35xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "reshape_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<125x6x7x29xi16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @reshape_int, interface = [@reshape_int_arg_0, @reshape_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<25x6x29x35xi16>) -> !spirv.arm.tensor<125x6x7x29xi16>, sym_name = "reshape_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<25x6x29x35xi16>):
    %0 = "spirv.Constant"() <{value = dense<[125, 6, 7, 29]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %1 = "spirv.Tosa.Reshape"(%arg0, %0) : (!spirv.arm.tensor<25x6x29x35xi16>, !spirv.arm.tensor<4xi32>) -> !spirv.arm.tensor<125x6x7x29xi16>
    "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<125x6x7x29xi16>) -> ()
  }) : () -> ()
}) : () -> ()

