"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "pad_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<4x7xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "pad_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<21x19xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @pad_int, interface = [@pad_int_arg_0, @pad_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<4x7xi8>) -> !spirv.arm.tensor<21x19xi8>, sym_name = "pad_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<4x7xi8>):
    %0 = "spirv.Constant"() <{value = dense<[10, 7, 6, 6]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
    %1 = "spirv.Constant"() <{value = dense<-76> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Tosa.Pad"(%arg0, %0, %1) : (!spirv.arm.tensor<4x7xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<21x19xi8>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<21x19xi8>) -> ()
  }) : () -> ()
}) : () -> ()

