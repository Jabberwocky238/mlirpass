"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_default_interface_var_abi"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "default_interface_var_abi"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_custom_grapharm_abi"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(3, 9)>}], entry_point = true, function_type = (!spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(7, 11)>}], sym_name = "custom_grapharm_abi"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

