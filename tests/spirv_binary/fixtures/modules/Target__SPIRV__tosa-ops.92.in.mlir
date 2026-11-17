"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "gather_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<59x61x19xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "gather_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<59x65xi32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "gather_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<59x65x19xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @gather_fp, interface = [@gather_fp_arg_0, @gather_fp_arg_1, @gather_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<59x61x19xf32>, !spirv.arm.tensor<59x65xi32>) -> !spirv.arm.tensor<59x65x19xf32>, sym_name = "gather_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<59x61x19xf32>, %arg1: !spirv.arm.tensor<59x65xi32>):
    %0 = "spirv.Tosa.Gather"(%arg0, %arg1) : (!spirv.arm.tensor<59x61x19xf32>, !spirv.arm.tensor<59x65xi32>) -> !spirv.arm.tensor<59x65x19xf32>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<59x65x19xf32>) -> ()
  }) : () -> ()
}) : () -> ()

