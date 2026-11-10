"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "transpose_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<14x28x1x61xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "transpose_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x14x28x61xi16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @transpose_int, interface = [@transpose_int_arg_0, @transpose_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<14x28x1x61xi16>) -> !spirv.arm.tensor<1x14x28x61xi16>, sym_name = "transpose_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<14x28x1x61xi16>):
    %0 = "spirv.Tosa.Transpose"(%arg0) <{perms = dense<[2, 0, 1, 3]> : !spirv.arm.tensor<4xi32>}> : (!spirv.arm.tensor<14x28x1x61xi16>) -> !spirv.arm.tensor<1x14x28x61xi16>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x14x28x61xi16>) -> ()
  }) : () -> ()
}) : () -> ()

