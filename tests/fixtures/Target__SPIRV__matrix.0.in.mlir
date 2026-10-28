"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [Shader, Linkage, CooperativeMatrixKHR, VulkanMemoryModel, Float16, Addresses], [SPV_KHR_cooperative_matrix, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>, sym_name = "matrix_access_chain"}> ({
  ^bb0(%arg15: !spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, %arg16: i32):
    %8 = "spirv.AccessChain"(%arg15, %arg16) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
    "spirv.ReturnValue"(%8) : (!spirv.ptr<vector<3xf32>, Function>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<3xf32>>, f32) -> !spirv.matrix<3 x vector<3xf32>>, sym_name = "matrix_times_scalar_1"}> ({
  ^bb0(%arg13: !spirv.matrix<3 x vector<3xf32>>, %arg14: f32):
    %7 = "spirv.MatrixTimesScalar"(%arg13, %arg14) : (!spirv.matrix<3 x vector<3xf32>>, f32) -> !spirv.matrix<3 x vector<3xf32>>
    "spirv.ReturnValue"(%7) : (!spirv.matrix<3 x vector<3xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<3xf16>>, f16) -> !spirv.matrix<3 x vector<3xf16>>, sym_name = "matrix_times_scalar_2"}> ({
  ^bb0(%arg11: !spirv.matrix<3 x vector<3xf16>>, %arg12: f16):
    %6 = "spirv.MatrixTimesScalar"(%arg11, %arg12) : (!spirv.matrix<3 x vector<3xf16>>, f16) -> !spirv.matrix<3 x vector<3xf16>>
    "spirv.ReturnValue"(%6) : (!spirv.matrix<3 x vector<3xf16>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, sym_name = "matrix_times_scalar_3"}> ({
  ^bb0(%arg9: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg10: f16):
    %5 = "spirv.MatrixTimesScalar"(%arg9, %arg10) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%5) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<2xf32>>) -> !spirv.matrix<2 x vector<3xf32>>, sym_name = "matrix_transpose_1"}> ({
  ^bb0(%arg8: !spirv.matrix<3 x vector<2xf32>>):
    %4 = "spirv.Transpose"(%arg8) : (!spirv.matrix<3 x vector<2xf32>>) -> !spirv.matrix<2 x vector<3xf32>>
    "spirv.ReturnValue"(%4) : (!spirv.matrix<2 x vector<3xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<4xf32>>, vector<3xf32>) -> vector<4xf32>, sym_name = "matrix_times_vector_1"}> ({
  ^bb0(%arg6: !spirv.matrix<3 x vector<4xf32>>, %arg7: vector<3xf32>):
    %3 = "spirv.MatrixTimesVector"(%arg6, %arg7) : (!spirv.matrix<3 x vector<4xf32>>, vector<3xf32>) -> vector<4xf32>
    "spirv.ReturnValue"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>, !spirv.matrix<4 x vector<3xf32>>) -> vector<4xf32>, sym_name = "vector_times_matrix_1"}> ({
  ^bb0(%arg4: vector<3xf32>, %arg5: !spirv.matrix<4 x vector<3xf32>>):
    %2 = "spirv.VectorTimesMatrix"(%arg4, %arg5) : (vector<3xf32>, !spirv.matrix<4 x vector<3xf32>>) -> vector<4xf32>
    "spirv.ReturnValue"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<3xf32>>, !spirv.matrix<3 x vector<3xf32>>) -> !spirv.matrix<3 x vector<3xf32>>, sym_name = "matrix_times_matrix_1"}> ({
  ^bb0(%arg2: !spirv.matrix<3 x vector<3xf32>>, %arg3: !spirv.matrix<3 x vector<3xf32>>):
    %1 = "spirv.MatrixTimesMatrix"(%arg2, %arg3) : (!spirv.matrix<3 x vector<3xf32>>, !spirv.matrix<3 x vector<3xf32>>) -> !spirv.matrix<3 x vector<3xf32>>
    "spirv.ReturnValue"(%1) : (!spirv.matrix<3 x vector<3xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<2xf32>>, !spirv.matrix<2 x vector<3xf32>>) -> !spirv.matrix<2 x vector<2xf32>>, sym_name = "matrix_times_matrix_2"}> ({
  ^bb0(%arg0: !spirv.matrix<3 x vector<2xf32>>, %arg1: !spirv.matrix<2 x vector<3xf32>>):
    %0 = "spirv.MatrixTimesMatrix"(%arg0, %arg1) : (!spirv.matrix<3 x vector<2xf32>>, !spirv.matrix<2 x vector<3xf32>>) -> !spirv.matrix<2 x vector<2xf32>>
    "spirv.ReturnValue"(%0) : (!spirv.matrix<2 x vector<2xf32>>) -> ()
  }) : () -> ()
}) : () -> ()

