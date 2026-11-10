"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "slice_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<30x45x29xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "slice_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<5x12x11xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @slice_fp, interface = [@slice_fp_arg_0, @slice_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<30x45x29xf32>) -> !spirv.arm.tensor<5x12x11xf32>, sym_name = "slice_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<30x45x29xf32>):
    %0 = "spirv.Constant"() <{value = dense<[21, 20, 10]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %1 = "spirv.Constant"() <{value = dense<[5, 12, 11]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %2 = "spirv.Tosa.Slice"(%arg0, %0, %1) : (!spirv.arm.tensor<30x45x29xf32>, !spirv.arm.tensor<3xi32>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<5x12x11xf32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<5x12x11xf32>) -> ()
  }) : () -> ()
}) : () -> ()

