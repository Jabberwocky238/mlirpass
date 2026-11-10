"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "avgpool2d_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x3x65537x1xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "avgpool2d_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x2x32768x1xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @avgpool2d_int, interface = [@avgpool2d_int_arg_0, @avgpool2d_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x3x65537x1xi8>) -> !spirv.arm.tensor<1x2x32768x1xi8>, sym_name = "avgpool2d_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x3x65537x1xi8>):
    %0 = "spirv.Constant"() <{value = dense<125> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %1 = "spirv.Constant"() <{value = dense<-90> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Tosa.AvgPool2D"(%arg0, %0, %1) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, kernel = dense<3> : !spirv.arm.tensor<2xi32>, pad = dense<[0, 1, 0, 0]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x3x65537x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x32768x1xi8>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x2x32768x1xi8>) -> ()
  }) : () -> ()
}) : () -> ()

