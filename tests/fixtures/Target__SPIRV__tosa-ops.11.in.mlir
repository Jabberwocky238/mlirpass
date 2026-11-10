"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "matmul_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<8x2x3xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "matmul_int_arg_1", type = !spirv.ptr<!spirv.arm.tensor<8x3x8xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 1 : i32, sym_name = "matmul_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<8x2x8xi32>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @matmul_int, interface = [@matmul_int_arg_0, @matmul_int_arg_1, @matmul_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<8x2x3xi8>, !spirv.arm.tensor<8x3x8xi8>) -> !spirv.arm.tensor<8x2x8xi32>, sym_name = "matmul_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<8x2x3xi8>, %arg1: !spirv.arm.tensor<8x3x8xi8>):
    %0 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %1 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
    %2 = "spirv.Tosa.MatMul"(%arg0, %arg1, %0, %1) : (!spirv.arm.tensor<8x2x3xi8>, !spirv.arm.tensor<8x3x8xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<8x2x8xi32>
    "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<8x2x8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

