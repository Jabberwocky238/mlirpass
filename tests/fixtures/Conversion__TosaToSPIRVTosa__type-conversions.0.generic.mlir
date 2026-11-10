"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_i48_to_i64"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x2x3x4xi64>) -> !spirv.arm.tensor<1x2x3x4xi64>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "i48_to_i64"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x2x3x4xi64>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1x2x3x4xi64>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_i4_to_i8"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "i4_to_i8"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_scalar_tensor_to_rank1_tensor"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "scalar_tensor_to_rank1_tensor"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<1xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<0xi8>) -> tensor<0xi8>, sym_name = "zero_sized_tensor"}> ({
  ^bb0(%arg0: tensor<0xi8>):
    "func.return"(%arg0) : (tensor<0xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x0x2xi8>) -> tensor<1x0x2xi8>, sym_name = "mixed_zero_sized_tensor"}> ({
  ^bb0(%arg0: tensor<1x0x2xi8>):
    "func.return"(%arg0) : (tensor<1x0x2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_partially_shaped_tensor_to_unshaped_tensor"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<?x?xi8>) -> !spirv.arm.tensor<?x?xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "partially_shaped_tensor_to_unshaped_tensor"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<?x?xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<?x?xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_unranked_tensor"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<*xi8>) -> !spirv.arm.tensor<*xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "unranked_tensor"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<*xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<*xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
