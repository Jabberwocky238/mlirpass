"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "matmul_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<15x39x50xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "matmul_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<15x50x24xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "matmul_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<15x39x24xf16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @matmul_fp, interface = [@matmul_fp_arg_0, @matmul_fp_arg_1, @matmul_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<15x39x50xf16>, !spirv.arm.tensor<15x50x24xf16>) -> !spirv.arm.tensor<15x39x24xf16>, sym_name = "matmul_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<15x39x50xf16>, %arg1: !spirv.arm.tensor<15x50x24xf16>):
    %0 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %1 = "spirv.Constant"() <{value = dense<0.000000e+00> : !spirv.arm.tensor<1xf16>}> : () -> !spirv.arm.tensor<1xf16>
    %2 = "spirv.Tosa.MatMul"(%arg0, %arg1, %0, %1) : (!spirv.arm.tensor<15x39x50xf16>, !spirv.arm.tensor<15x50x24xf16>, !spirv.arm.tensor<1xf16>, !spirv.arm.tensor<1xf16>) -> !spirv.arm.tensor<15x39x24xf16>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<15x39x24xf16>) -> ()
  }) : () -> ()
}) : () -> ()

