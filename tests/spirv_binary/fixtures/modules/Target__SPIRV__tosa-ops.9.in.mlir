"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "depthwiseconv2d_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x65540x1x3xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "depthwiseconv2d_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<1x1x3x1xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "depthwiseconv2d_fp_arg_2", type = !spirv.ptr<!spirv.arm.tensor<1xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "depthwiseconv2d_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x65541x2x3xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @depthwiseconv2d_fp, interface = [@depthwiseconv2d_fp_arg_0, @depthwiseconv2d_fp_arg_1, @depthwiseconv2d_fp_arg_2, @depthwiseconv2d_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x65540x1x3xf32>, !spirv.arm.tensor<1x1x3x1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x65541x2x3xf32>, sym_name = "depthwiseconv2d_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x65540x1x3xf32>, %arg1: !spirv.arm.tensor<1x1x3x1xf32>, %arg2: !spirv.arm.tensor<1xf32>):
    %0 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf32>}> : () -> !spirv.arm.tensor<1xf32>
    %2 = "spirv.Tosa.DepthwiseConv2D"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = #spirv.tosa_ext_acc_type<FP32>, dilation = dense<[1, 7]> : !spirv.arm.tensor<2xi32>, local_bound = true, pad = dense<[0, 1, 1, 1]> : !spirv.arm.tensor<4xi32>, stride = dense<[1, 2]> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x65540x1x3xf32>, !spirv.arm.tensor<1x1x3x1xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>, !spirv.arm.tensor<1xf32>) -> !spirv.arm.tensor<1x65541x2x3xf32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x65541x2x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

