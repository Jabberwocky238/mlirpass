"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, TensorsARM, GraphARM], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.GlobalVariable"() <{binding = 0 : i32, descriptor_set = 0 : i32, sym_name = "concat_int_arg_0", type = !spirv.ptr<!spirv.arm.tensor<12x13x3x14xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 1 : i32, descriptor_set = 0 : i32, sym_name = "concat_int_arg_1", type = !spirv.ptr<!spirv.arm.tensor<12x13x3x14xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 2 : i32, descriptor_set = 0 : i32, sym_name = "concat_int_arg_2", type = !spirv.ptr<!spirv.arm.tensor<12x13x3x14xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 3 : i32, descriptor_set = 0 : i32, sym_name = "concat_int_arg_3", type = !spirv.ptr<!spirv.arm.tensor<12x13x3x14xi8>, UniformConstant>}> : () -> ()
  "spirv.GlobalVariable"() <{binding = 4 : i32, descriptor_set = 0 : i32, sym_name = "concat_int_res_0", type = !spirv.ptr<!spirv.arm.tensor<12x13x12x14xi8>, UniformConstant>}> : () -> ()
  "spirv.ARM.GraphEntryPoint"() <{fn = @concat_int, interface = [@concat_int_arg_0, @concat_int_arg_1, @concat_int_arg_2, @concat_int_arg_3, @concat_int_res_0]}> : () -> ()
  "spirv.ARM.Graph"() <{function_type = (!spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>) -> !spirv.arm.tensor<12x13x12x14xi8>, sym_name = "concat_int"}> ({
  ^bb0(%arg0: !spirv.arm.tensor<12x13x3x14xi8>, %arg1: !spirv.arm.tensor<12x13x3x14xi8>, %arg2: !spirv.arm.tensor<12x13x3x14xi8>, %arg3: !spirv.arm.tensor<12x13x3x14xi8>):
    %0 = "spirv.Tosa.Concat"(%arg0, %arg1, %arg2, %arg3) <{axis = 2 : i32}> : (!spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>, !spirv.arm.tensor<12x13x3x14xi8>) -> !spirv.arm.tensor<12x13x12x14xi8>
    "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<12x13x12x14xi8>) -> ()
  }) : () -> ()
}) : () -> ()

