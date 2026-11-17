"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "greater_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<6x3x12x4xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "greater_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<6x3x1x4xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "greater_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<6x3x12x4xi1>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @greater_fp, interface = [@greater_fp_arg_0, @greater_fp_arg_1, @greater_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<6x3x12x4xf16>, !spirv.arm.tensor<6x3x1x4xf16>) -> !spirv.arm.tensor<6x3x12x4xi1>, sym_name = "greater_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<6x3x12x4xf16>, %arg1: !spirv.arm.tensor<6x3x1x4xf16>):
    %0 = "spirv.Tosa.Greater"(%arg0, %arg1) : (!spirv.arm.tensor<6x3x12x4xf16>, !spirv.arm.tensor<6x3x1x4xf16>) -> !spirv.arm.tensor<6x3x12x4xi1>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<6x3x12x4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

