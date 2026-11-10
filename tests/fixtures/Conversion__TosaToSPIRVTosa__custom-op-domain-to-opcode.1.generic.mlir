"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_mapped_custom"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "mapped_custom"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x16xf32>, %arg1: !spirv.arm.tensor<1x16xf32>):
      %0 = "spirv.Constant"() <{value = [84 : i8, 101 : i8, 115 : i8, 116 : i8, 79 : i8, 112 : i8]}> : () -> !spirv.array<6 x i8>
      %1 = "spirv.Constant"() <{value = [123 : i8, 34 : i8, 112 : i8, 97 : i8, 114 : i8, 97 : i8, 109 : i8, 34 : i8, 58 : i8, 34 : i8, 118 : i8, 97 : i8, 108 : i8, 117 : i8, 101 : i8, 34 : i8, 125 : i8]}> : () -> !spirv.array<17 x i8>
      %2 = "spirv.ExperimentalML.Call"(%0, %1, %arg0, %arg1) <{opcode = 7 : i32}> : (!spirv.array<6 x i8>, !spirv.array<17 x i8>, !spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
      "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x16xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_other_custom"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "other_custom"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x16xf32>):
      %0 = "spirv.Constant"() <{value = [69 : i8, 120 : i8, 97 : i8, 109 : i8, 112 : i8, 108 : i8, 101 : i8, 79 : i8, 112 : i8]}> : () -> !spirv.array<9 x i8>
      %1 = "spirv.Constant"() <{value = [123 : i8, 125 : i8]}> : () -> !spirv.array<2 x i8>
      %2 = "spirv.ExperimentalML.Call"(%0, %1, %arg0) <{opcode = 42 : i32}> : (!spirv.array<9 x i8>, !spirv.array<2 x i8>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
      "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x16xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_empty_strings"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "empty_strings"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x16xf32>):
      %0 = "spirv.Constant"() <{value = [0 : i8]}> : () -> !spirv.array<1 x i8>
      %1 = "spirv.Constant"() <{value = [0 : i8]}> : () -> !spirv.array<1 x i8>
      %2 = "spirv.ExperimentalML.Call"(%0, %1, %arg0) <{opcode = 7 : i32}> : (!spirv.array<1 x i8>, !spirv.array<1 x i8>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
      "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x16xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

