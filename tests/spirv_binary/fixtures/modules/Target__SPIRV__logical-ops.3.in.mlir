"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.6, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, !spirv.array<4 x i32>, !spirv.array<4 x i32>) -> (), sym_name = "select_op_array"}> ({
  ^bb0(%arg6: i1, %arg7: !spirv.array<4 x i32>, %arg8: !spirv.array<4 x i32>):
    %2 = "spirv.Select"(%arg6, %arg7, %arg8) : (i1, !spirv.array<4 x i32>, !spirv.array<4 x i32>) -> !spirv.array<4 x i32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, !spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> (), sym_name = "select_op_struct"}> ({
  ^bb0(%arg3: i1, %arg4: !spirv.struct<(i32, i32)>, %arg5: !spirv.struct<(i32, i32)>):
    %1 = "spirv.Select"(%arg3, %arg4, %arg5) : (i1, !spirv.struct<(i32, i32)>, !spirv.struct<(i32, i32)>) -> !spirv.struct<(i32, i32)>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, !spirv.matrix<4 x vector<3xf32>>, !spirv.matrix<4 x vector<3xf32>>) -> (), sym_name = "select_op_matrix"}> ({
  ^bb0(%arg0: i1, %arg1: !spirv.matrix<4 x vector<3xf32>>, %arg2: !spirv.matrix<4 x vector<3xf32>>):
    %0 = "spirv.Select"(%arg0, %arg1, %arg2) : (i1, !spirv.matrix<4 x vector<3xf32>>, !spirv.matrix<4 x vector<3xf32>>) -> !spirv.matrix<4 x vector<3xf32>>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

