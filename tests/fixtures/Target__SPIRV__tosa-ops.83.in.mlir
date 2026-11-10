"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "reverse_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<20x5x28x31xi32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "reverse_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<20x5x28x31xi32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @reverse_int, interface = [@reverse_int_arg_0, @reverse_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<20x5x28x31xi32>) -> !spirv.arm.tensor<20x5x28x31xi32>, sym_name = "reverse_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<20x5x28x31xi32>):
    %0 = "spirv.Tosa.Reverse"(%arg0) <{axis = 2 : i32}> : (!spirv.arm.tensor<20x5x28x31xi32>) -> !spirv.arm.tensor<20x5x28x31xi32>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<20x5x28x31xi32>) -> ()
  }) : () -> ()
}) : () -> ()

