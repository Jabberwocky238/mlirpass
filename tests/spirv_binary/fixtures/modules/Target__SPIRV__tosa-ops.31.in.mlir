"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "logicalleftshift_any_arg_0", type = !spirv.ptr<!spirv.arm.tensor<7x1x11x4xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "logicalleftshift_any_arg_1", type = !spirv.ptr<!spirv.arm.tensor<7x8x11x4xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "logicalleftshift_any_res_0", type = !spirv.ptr<!spirv.arm.tensor<7x8x11x4xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @logicalleftshift_any, interface = [@logicalleftshift_any_arg_0, @logicalleftshift_any_arg_1, @logicalleftshift_any_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8>) -> !spirv.arm.tensor<7x8x11x4xi8>, sym_name = "logicalleftshift_any"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<7x1x11x4xi8>, %arg1: !spirv.arm.tensor<7x8x11x4xi8>):
    %0 = "spirv.Tosa.LogicalLeftShift"(%arg0, %arg1) : (!spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8>) -> !spirv.arm.tensor<7x8x11x4xi8>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<7x8x11x4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

