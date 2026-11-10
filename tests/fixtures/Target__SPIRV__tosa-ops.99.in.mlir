"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "rescale_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<17x29x19xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "rescale_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<17x29x19xi16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @rescale_int, interface = [@rescale_int_arg_0, @rescale_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<17x29x19xi16>) -> !spirv.arm.tensor<17x29x19xi16>, sym_name = "rescale_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<17x29x19xi16>):
    %0 = "spirv.Constant"() <{value = dense<1866149760> : !spirv.arm.tensor<1xi32>}> : () -> !spirv.arm.tensor<1xi32>
    %1 = "spirv.Constant"() <{value = dense<31> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %3 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %4 = "spirv.Tosa.Rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = true, per_channel = false, rounding_mode = #spirv.tosa_ext_rounding_mode_type<DoubleRound>, scale32 = true}> : (!spirv.arm.tensor<17x29x19xi16>, !spirv.arm.tensor<1xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16>) -> !spirv.arm.tensor<17x29x19xi16>
    "spirv.ARM.GraphOutputs"(%4) : (!spirv.arm.tensor<17x29x19xi16>) -> ()
  }) : () -> ()
}) : () -> ()

