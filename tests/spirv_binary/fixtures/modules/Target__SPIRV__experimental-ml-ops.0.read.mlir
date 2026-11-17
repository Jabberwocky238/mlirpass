"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "main_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x16xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "main_arg_1", type = !spirv.ptr<!spirv.arm.tensor<1x16xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "main_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x16xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @main, interface = [@main_arg_0, @main_arg_1, @main_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{entry_point = true, function_type = (!spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>, sym_name = "main"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x16xf32>, %arg1: !spirv.arm.tensor<1x16xf32>):
    %0 = "spirv.Constant"() <{value = [83 : i8, 101 : i8, 108 : i8, 102 : i8, 65 : i8, 116 : i8, 116 : i8, 101 : i8, 110 : i8, 116 : i8, 105 : i8, 111 : i8, 110 : i8, 79 : i8, 112 : i8]}> : () -> !spirv.array<15 x i8>
    %1 = "spirv.Constant"() <{value = [123 : i8, 34 : i8, 111 : i8, 112 : i8, 101 : i8, 114 : i8, 97 : i8, 116 : i8, 111 : i8, 114 : i8, 95 : i8, 110 : i8, 97 : i8, 109 : i8, 101 : i8, 34 : i8, 58 : i8, 34 : i8, 83 : i8, 101 : i8, 108 : i8, 102 : i8, 65 : i8, 116 : i8, 116 : i8, 101 : i8, 110 : i8, 116 : i8, 105 : i8, 111 : i8, 110 : i8, 79 : i8, 112 : i8, 34 : i8, 125 : i8]}> : () -> !spirv.array<35 x i8>
    %2 = "spirv.ExperimentalML.Call"(%0, %1, %arg0, %arg1) <{opcode = 0 : i32}> : (!spirv.array<15 x i8>, !spirv.array<35 x i8>, !spirv.arm.tensor<1x16xf32>, !spirv.arm.tensor<1x16xf32>) -> !spirv.arm.tensor<1x16xf32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()