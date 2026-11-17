"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "tile_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<10x28x21xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "tile_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<10x28x63xi16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @tile_int, interface = [@tile_int_arg_0, @tile_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<10x28x21xi16>) -> !spirv.arm.tensor<10x28x63xi16>, sym_name = "tile_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<10x28x21xi16>):
    %0 = "spirv.Constant"() <{value = dense<[1, 1, 3]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
    %1 = "spirv.Tosa.Tile"(%arg0, %0) : (!spirv.arm.tensor<10x28x21xi16>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<10x28x63xi16>
    "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<10x28x63xi16>) -> ()
  }) : () -> ()
}) : () -> ()

