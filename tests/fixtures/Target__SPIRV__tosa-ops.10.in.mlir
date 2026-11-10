"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "fft2d_fft_arg_0", type = !spirv.ptr<!spirv.arm.tensor<1x32x32xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "fft2d_fft_arg_1", type = !spirv.ptr<!spirv.arm.tensor<1x32x32xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "fft2d_fft_res_0", type = !spirv.ptr<!spirv.arm.tensor<1x32x32xf32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 3 : i32, descriptor_set = 0 : i32, sym_name = "fft2d_fft_res_1", type = !spirv.ptr<!spirv.arm.tensor<1x32x32xf32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @fft2d_fft, interface = [@fft2d_fft_arg_0, @fft2d_fft_arg_1, @fft2d_fft_res_0, @fft2d_fft_res_1]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>), sym_name = "fft2d_fft"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<1x32x32xf32>, %arg1: !spirv.arm.tensor<1x32x32xf32>):
    %0 = "spirv.Tosa.FFT2D"(%arg0, %arg1) <{inverse = true, local_bound = false}> : (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> !spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>) -> !spirv.arm.tensor<1x32x32xf32>
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>) -> !spirv.arm.tensor<1x32x32xf32>
    "spirv.ARM.GraphOutputs"(%1, %2) : (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

