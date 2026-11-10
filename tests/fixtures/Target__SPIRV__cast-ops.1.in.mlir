"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.6, [Shader, Linkage, CooperativeMatrixKHR, VulkanMemoryModel], [SPV_KHR_cooperative_matrix, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>) -> (), sym_name = "bit_cast_coop"}> ({
  ^bb0(%arg0: !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>):
    %0 = "spirv.Bitcast"(%arg0) : (!spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xi32, Subgroup, MatrixA>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

