"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "pad_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<2x9x2x3xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "pad_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<4x9x4x4xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @pad_fp, interface = [@pad_fp_arg_0, @pad_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x9x2x3xf32>) -> !spirv.arm.tensor<4x9x4x4xf32>, sym_name = "pad_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<2x9x2x3xf32>):
    %0 = "spirv.Constant"() <{value = dense<[1, 1, 0, 0, 1, 1, 0, 1]> : !spirv.arm.tensor<8xi32>}> : () -> !spirv.arm.tensor<8xi32>
    %1 = "spirv.Constant"() <{value = dense<1.21630913E+38> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %2 = "spirv.Tosa.Pad"(%arg0, %0, %1) : (!spirv.arm.tensor<2x9x2x3xf32>, !spirv.arm.tensor<8xi32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<4x9x4x4xf32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<4x9x4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

