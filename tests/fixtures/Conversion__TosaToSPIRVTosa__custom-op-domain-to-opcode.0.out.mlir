module {
  spirv.module @_spirv_tosa_mapped_custom Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @mapped_custom(%arg0: !spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %cst = spirv.Constant [84 : i8, 101 : i8, 115 : i8, 116 : i8, 79 : i8, 112 : i8] : !spirv.array<6 x i8>
      %cst_0 = spirv.Constant [123 : i8, 34 : i8, 112 : i8, 97 : i8, 114 : i8, 97 : i8, 109 : i8, 34 : i8, 58 : i8, 34 : i8, 118 : i8, 97 : i8, 108 : i8, 117 : i8, 101 : i8, 34 : i8, 125 : i8] : !spirv.array<17 x i8>
      %0 = spirv.ExperimentalML.Call opcode = 0, %cst, %cst_0, %arg0, %arg1 : (!spirv.array<6 x i8>, !spirv.array<17 x i8>, !spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x16xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_other_custom Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @other_custom(%arg0: !spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant [69 : i8, 120 : i8, 97 : i8, 109 : i8, 112 : i8, 108 : i8, 101 : i8, 79 : i8, 112 : i8] : !spirv.array<9 x i8>
      %cst_0 = spirv.Constant [123 : i8, 125 : i8] : !spirv.array<2 x i8>
      %0 = spirv.ExperimentalML.Call opcode = 42, %cst, %cst_0, %arg0 : (!spirv.array<9 x i8>, !spirv.array<2 x i8>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x16xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_empty_strings Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @empty_strings(%arg0: !spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x16xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant [0 : i8] : !spirv.array<1 x i8>
      %cst_0 = spirv.Constant [0 : i8] : !spirv.array<1 x i8>
      %0 = spirv.ExperimentalML.Call opcode = 0, %cst, %cst_0, %arg0 : (!spirv.array<1 x i8>, !spirv.array<1 x i8>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x16xf32>
    }
  }
}

