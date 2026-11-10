module {
  spirv.module @_spirv_tosa_default_interface_var_abi Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @default_interface_var_abi(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_custom_grapharm_abi Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @custom_grapharm_abi(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(3, 9)>}) -> (!spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(7, 11)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1xi8>
    }
  }
}

