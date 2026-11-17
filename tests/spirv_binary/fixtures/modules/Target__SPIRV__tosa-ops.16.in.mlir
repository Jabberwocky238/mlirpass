"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "transposeconv2d_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x13x33x3xi16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "transposeconv2d_int_arg_1", type = !spirv.ptr<!spirv.arm.tensor<11x1x3x3xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "transposeconv2d_int_arg_2", type = !spirv.ptr<!spirv.arm.tensor<1xi64>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "transposeconv2d_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x13x35x11xi64>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @transposeconv2d_int, interface = [@transposeconv2d_int_arg_0, @transposeconv2d_int_arg_1, @transposeconv2d_int_arg_2, @transposeconv2d_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x13x33x3xi16>, !spirv.arm.tensor<11x1x3x3xi8>, !spirv.arm.tensor<1xi64>) -> !spirv.arm.tensor<1x13x35x11xi64>, sym_name = "transposeconv2d_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x13x33x3xi16>, %arg1: !spirv.arm.tensor<11x1x3x3xi8>, %arg2: !spirv.arm.tensor<1xi64>):
    %0 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
    %1 = "spirv.Constant"() <{value = dense<88> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Tosa.TransposeConv2D"(%arg0, %arg1, %arg2, %0, %1) <{acc_type = #spirv.tosa_ext_acc_type<INT48>, local_bound = false, out_pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x13x33x3xi16>, !spirv.arm.tensor<11x1x3x3xi8>, !spirv.arm.tensor<1xi64>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x13x35x11xi64>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<1x13x35x11xi64>) -> ()
  }) : () -> ()
}) : () -> ()

