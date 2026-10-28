"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "main_arg_0", type = !spirv.ptr<!spirv.arm.tensor<14x19xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "main_res_0", type = !spirv.ptr<!spirv.arm.tensor<2x3xi16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @main, interface = [@main_arg_0, @main_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{entry_point = true, function_type = (!spirv.arm.tensor<14x19xi16>) -> !spirv.arm.tensor<2x3xi16>, sym_name = "main"}> ({
  ^bb0(%arg1: !spirv.arm.tensor<14x19xi16>):
    %0 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 42 : i32}> : () -> !spirv.arm.tensor<2x3xi16>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x3xi16>) -> ()
  }) : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x16x16x16xi8>) -> !spirv.arm.tensor<1x16x16x16xi8>, sym_name = "empty_graph"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x16x16x16xi8>):
    "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1x16x16x16xi8>) -> ()
  }) : () -> ()
}) : () -> ()

