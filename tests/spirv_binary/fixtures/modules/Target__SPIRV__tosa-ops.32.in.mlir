"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "logicalrightshift_any_arg_0", type = !spirv.ptr<!spirv.arm.tensor<6x13x1x19xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "logicalrightshift_any_arg_1", type = !spirv.ptr<!spirv.arm.tensor<6x13x6x19xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "logicalrightshift_any_res_0", type = !spirv.ptr<!spirv.arm.tensor<6x13x6x19xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @logicalrightshift_any, interface = [@logicalrightshift_any_arg_0, @logicalrightshift_any_arg_1, @logicalrightshift_any_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8>) -> !spirv.arm.tensor<6x13x6x19xi8>, sym_name = "logicalrightshift_any"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<6x13x1x19xi8>, %arg1: !spirv.arm.tensor<6x13x6x19xi8>):
    %0 = "spirv.Tosa.LogicalRightShift"(%arg0, %arg1) : (!spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8>) -> !spirv.arm.tensor<6x13x6x19xi8>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<6x13x6x19xi8>) -> ()
  }) : () -> ()
}) : () -> ()

