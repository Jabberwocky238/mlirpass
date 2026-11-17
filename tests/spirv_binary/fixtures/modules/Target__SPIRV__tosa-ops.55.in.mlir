"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "negate_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<3x1x65540x1xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "negate_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<3x1x65540x1xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @negate_int, interface = [@negate_int_arg_0, @negate_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<3x1x65540x1xi8>) -> !spirv.arm.tensor<3x1x65540x1xi8>, sym_name = "negate_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<3x1x65540x1xi8>):
    %0 = "spirv.Constant"() <{value = dense<111> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %1 = "spirv.Constant"() <{value = dense<-32> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Tosa.Negate"(%arg0, %0, %1) : (!spirv.arm.tensor<3x1x65540x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<3x1x65540x1xi8>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<3x1x65540x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

