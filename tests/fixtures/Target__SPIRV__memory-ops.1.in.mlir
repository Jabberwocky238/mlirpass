"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, i32, i32) -> (), sym_name = "access_chain"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, %arg1: i32, %arg2: i32):
    %0 = "spirv.AccessChain"(%arg0, %arg1) : (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, i32) -> !spirv.ptr<!spirv.array<4 x f32>, Function>
    %1 = "spirv.AccessChain"(%arg0, %arg1, %arg2) : (!spirv.ptr<!spirv.array<4 x !spirv.array<4 x f32>>, Function>, i32, i32) -> !spirv.ptr<f32, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

