"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "reducemin_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<2x5x5x1xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "reducemin_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<2x5x1x1xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @reducemin_int, interface = [@reducemin_int_arg_0, @reducemin_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<2x5x5x1xi8>) -> !spirv.arm.tensor<2x5x1x1xi8>, sym_name = "reducemin_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<2x5x5x1xi8>):
    %0 = "spirv.Tosa.ReduceMin"(%arg0) <{axis = 2 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<2x5x5x1xi8>) -> !spirv.arm.tensor<2x5x1x1xi8>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x5x1x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

