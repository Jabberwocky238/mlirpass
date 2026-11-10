"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.6, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_non_semantic_info]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x16x16x1xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_arg_1", type = !spirv.ptr<!spirv.arm.tensor<8x3x3x1xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_arg_2", type = !spirv.ptr<!spirv.arm.tensor<8xi32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 3 : i32, descriptor_set = 0 : i32, sym_name = "conv2d_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x14x14x8xi32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @conv2d, interface = [@conv2d_arg_0, @conv2d_arg_1, @conv2d_arg_2, @conv2d_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x16x16x1xi8>, !spirv.arm.tensor<8x3x3x1xi8>, !spirv.arm.tensor<8xi32>) -> !spirv.arm.tensor<1x14x14x8xi32>, sym_name = "conv2d"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x16x16x1xi8>, %arg1: !spirv.arm.tensor<8x3x3x1xi8>, %arg2: !spirv.arm.tensor<8xi32>):
    %0 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %1 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Tosa.Conv2D"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<1> : !spirv.arm.tensor<2xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x16x16x1xi8>, !spirv.arm.tensor<8x3x3x1xi8>, !spirv.arm.tensor<8xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x14x14x8xi32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x14x14x8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

