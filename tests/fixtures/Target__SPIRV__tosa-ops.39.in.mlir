"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "mul_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<34x21x39xi32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "mul_int_arg_1", type = !spirv.ptr<!spirv.arm.tensor<34x21x1xi32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "mul_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<34x21x39xi32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @mul_int, interface = [@mul_int_arg_0, @mul_int_arg_1, @mul_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<34x21x39xi32>, !spirv.arm.tensor<34x21x1xi32>) -> !spirv.arm.tensor<34x21x39xi32>, sym_name = "mul_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<34x21x39xi32>, %arg1: !spirv.arm.tensor<34x21x1xi32>):
    %0 = "spirv.Constant"() <{value = dense<31> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %1 = "spirv.Tosa.Mul"(%arg0, %arg1, %0) : (!spirv.arm.tensor<34x21x39xi32>, !spirv.arm.tensor<34x21x1xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<34x21x39xi32>
    "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<34x21x39xi32>) -> ()
  }) : () -> ()
}) : () -> ()

