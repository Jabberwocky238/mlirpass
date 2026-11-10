module {
  spirv.module @_spirv_tosa_i48_to_i64 Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @i48_to_i64(%arg0: !spirv.arm.tensor<1x2x3x4xi64> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x2x3x4xi64> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1x2x3x4xi64>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_i4_to_i8 Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @i4_to_i8(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_scalar_tensor_to_rank1_tensor Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @scalar_tensor_to_rank1_tensor(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<1xi8>
    }
  }
}

// -----
module {
  func.func @zero_sized_tensor(%arg0: tensor<0xi8>) -> tensor<0xi8> {
    return %arg0 : tensor<0xi8>
  }
}

// -----
module {
  func.func @mixed_zero_sized_tensor(%arg0: tensor<1x0x2xi8>) -> tensor<1x0x2xi8> {
    return %arg0 : tensor<1x0x2xi8>
  }
}

// -----
module {
  spirv.module @_spirv_tosa_partially_shaped_tensor_to_unshaped_tensor Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @partially_shaped_tensor_to_unshaped_tensor(%arg0: !spirv.arm.tensor<?x?xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<?x?xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<?x?xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_unranked_tensor Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @unranked_tensor(%arg0: !spirv.arm.tensor<*xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<*xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<*xi8>
    }
  }
}

// -----
