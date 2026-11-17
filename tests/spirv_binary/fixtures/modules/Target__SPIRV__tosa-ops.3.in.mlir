"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "avgpool2d_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x2x65533x2xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "avgpool2d_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x2x65532x2xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @avgpool2d_fp, interface = [@avgpool2d_fp_arg_0, @avgpool2d_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x2x65533x2xf32>) -> !spirv.arm.tensor<1x2x65532x2xf32>, sym_name = "avgpool2d_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x2x65533x2xf32>):
    %0 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %2 = "spirv.Tosa.AvgPool2D"(%arg0, %0, %1) <{acc_type = #spirv.tosa_ext_acc_type<FP32>, kernel = dense<2> : !spirv.arm.tensor<2xi32>, pad = dense<[1, 0, 0, 0]> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x2x65533x2xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x2x65532x2xf32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x2x65532x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

