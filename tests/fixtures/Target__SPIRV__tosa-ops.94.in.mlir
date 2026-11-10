"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "scatter_fp_arg_0", type = !spirv.ptr<!spirv.arm.tensor<18x34x25xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "scatter_fp_arg_1", type = !spirv.ptr<!spirv.arm.tensor<18x20xi32>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "scatter_fp_arg_2", type = !spirv.ptr<!spirv.arm.tensor<18x20x25xf16>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "scatter_fp_res_0", type = !spirv.ptr<!spirv.arm.tensor<18x34x25xf16>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @scatter_fp, interface = [@scatter_fp_arg_0, @scatter_fp_arg_1, @scatter_fp_arg_2, @scatter_fp_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<18x34x25xf16>, !spirv.arm.tensor<18x20xi32>, !spirv.arm.tensor<18x20x25xf16>) -> !spirv.arm.tensor<18x34x25xf16>, sym_name = "scatter_fp"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<18x34x25xf16>, %arg1: !spirv.arm.tensor<18x20xi32>, %arg2: !spirv.arm.tensor<18x20x25xf16>):
    %0 = "spirv.Tosa.Scatter"(%arg0, %arg1, %arg2) : (!spirv.arm.tensor<18x34x25xf16>, !spirv.arm.tensor<18x20xi32>, !spirv.arm.tensor<18x20x25xf16>) -> !spirv.arm.tensor<18x34x25xf16>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<18x34x25xf16>) -> ()
  }) : () -> ()
}) : () -> ()

