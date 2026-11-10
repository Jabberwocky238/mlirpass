module {
  gpu.module @random_container {
    spirv.module @_spirv_tosa_nested Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
      spirv.ARM.Graph @nested(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
        spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1xi8>
      }
    }
  }
}

// -----
module @random_container {
  module @yet_anther_random_container {
    gpu.module @another_random_container {
      spirv.module @_spirv_tosa_nested Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
        spirv.ARM.Graph @nested(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
          spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1xi8>
        }
      }
    }
  }
}

