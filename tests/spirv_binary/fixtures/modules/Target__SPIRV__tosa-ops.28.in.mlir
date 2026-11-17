"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "bitwisexor_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<4x8x13x9xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "bitwisexor_int_arg_1", type = !spirv.ptr<!spirv.arm.tensor<4x8x1x9xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "bitwisexor_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<4x8x13x9xi16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @bitwisexor_int, interface = [@bitwisexor_int_arg_0, @bitwisexor_int_arg_1, @bitwisexor_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16>) -> !spirv.arm.tensor<4x8x13x9xi16>, sym_name = "bitwisexor_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<4x8x13x9xi16>, %arg1: !spirv.arm.tensor<4x8x1x9xi16>):
    %0 = "spirv.Tosa.BitwiseXor"(%arg0, %arg1) : (!spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16>) -> !spirv.arm.tensor<4x8x13x9xi16>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<4x8x13x9xi16>) -> ()
  }) : () -> ()
}) : () -> ()

