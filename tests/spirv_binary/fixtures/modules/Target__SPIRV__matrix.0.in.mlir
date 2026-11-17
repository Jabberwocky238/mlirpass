"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<Vulkan>, vce_triple = #spirv.vce<v1.3, [Shader, Linkage, CooperativeMatrixKHR, VulkanMemoryModel, Float16, Addresses], [SPV_KHR_cooperative_matrix, SPV_KHR_vulkan_memory_model]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>, sym_name = "matrix_access_chain"}> ({
  ^bb0(%arg17: !spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, %arg18: i32):
    %9 = "spirv.AccessChain"(%arg17, %arg18) : (!spirv.ptr<!spirv.matrix<3 x vector<3xf32>>, Function>, i32) -> !spirv.ptr<vector<3xf32>, Function>
    "spirv.ReturnValue"(%9) : (!spirv.ptr<vector<3xf32>, Function>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<3xf32>>, f32) -> !spirv.matrix<3 x vector<3xf32>>, sym_name = "matrix_times_scalar_1"}> ({
  ^bb0(%arg15: !spirv.matrix<3 x vector<3xf32>>, %arg16: f32):
    %8 = "spirv.MatrixTimesScalar"(%arg15, %arg16) : (!spirv.matrix<3 x vector<3xf32>>, f32) -> !spirv.matrix<3 x vector<3xf32>>
    "spirv.ReturnValue"(%8) : (!spirv.matrix<3 x vector<3xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<3xf16>>, f16) -> !spirv.matrix<3 x vector<3xf16>>, sym_name = "matrix_times_scalar_2"}> ({
  ^bb0(%arg13: !spirv.matrix<3 x vector<3xf16>>, %arg14: f16):
    %7 = "spirv.MatrixTimesScalar"(%arg13, %arg14) : (!spirv.matrix<3 x vector<3xf16>>, f16) -> !spirv.matrix<3 x vector<3xf16>>
    "spirv.ReturnValue"(%7) : (!spirv.matrix<3 x vector<3xf16>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, sym_name = "matrix_times_scalar_3"}> ({
  ^bb0(%arg11: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, %arg12: f16):
    %6 = "spirv.MatrixTimesScalar"(%arg11, %arg12) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
    "spirv.ReturnValue"(%6) : (!spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<2xf32>>) -> !spirv.matrix<2 x vector<3xf32>>, sym_name = "matrix_transpose_1"}> ({
  ^bb0(%arg10: !spirv.matrix<3 x vector<2xf32>>):
    %5 = "spirv.Transpose"(%arg10) : (!spirv.matrix<3 x vector<2xf32>>) -> !spirv.matrix<2 x vector<3xf32>>
    "spirv.ReturnValue"(%5) : (!spirv.matrix<2 x vector<3xf32>>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.matrix<3 x vector<4xf32>>, vector<3xf32>) -> vector<4xf32>, sym_name = "matrix_times_vector_1"}> ({
  ^bb0(%arg8: !spirv.matrix<3 x vector<4xf32>>, %arg9: vector<3xf32>):
    %4 = "spirv.MatrixTimesVector"(%arg8, %arg9) : (!spirv.matrix<3 x vector<4xf32>>, vector<3xf32>) -> vector<4xf32>
    "spirv.ReturnValue"(%4) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>, !spirv.matrix<4 x vector<3xf32>>) -> vector<4xf32>, sym_name = "vector_times_matrix_1"}> ({
  ^bb0(%arg6: vector<3xf32>, %arg7: !spirv.matrix<4 x vector<3xf32>>):
    %3 = "spirv.VectorTimesMatrix"(%arg6, %arg7) : (vector<3xf32>, !spirv.matrix<4 x vector<3xf32>>) -> vector<4xf32>
    "spirv.ReturnValue"(%3) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>, vector<2xf32>) -> !spirv.matrix<2 x vector<3xf32>>, sym_name = "outer_product_1"}> ({
  ^bb0(%arg4: vector<3xf32>, %arg5: vector<2xf32>):
    %2 = "spirv.OuterProduct"(%arg4, %arg5) : (vector<3xf32>, vector<2xf32>) -> !spirv.matrix<2 x vector<3xf32>>
    "spirv.ReturnValue"(%2) : (!spirv.matrix<2 x vector<3xf32>>) -> ()
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

