"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x34x18x27xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<11x1x1x27xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_fp_arg_2", type = !spirv.ptr<!spirv.arm.tensor<11xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "conv2d_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x34x18x11xf16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @conv2d_fp, interface = [@conv2d_fp_arg_0, @conv2d_fp_arg_1, @conv2d_fp_arg_2, @conv2d_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x34x18x27xf16>, !spirv.arm.tensor<11x1x1x27xf16>, !spirv.arm.tensor<11xf16>) -> !spirv.arm.tensor<1x34x18x11xf16>, sym_name = "conv2d_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x34x18x27xf16>, %arg1: !spirv.arm.tensor<11x1x1x27xf16>, %arg2: !spirv.arm.tensor<11xf16>):
    %0 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %2 = "spirv.Tosa.Conv2D"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = #spirv.tosa_ext_acc_type<FP16>, dilation = dense<1> : !spirv.arm.tensor<2xi32>, local_bound = true, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x34x18x27xf16>, !spirv.arm.tensor<11x1x1x27xf16>, !spirv.arm.tensor<11xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<1x34x18x11xf16>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x34x18x11xf16>) -> ()
  }) : () -> ()
}) : () -> ()

