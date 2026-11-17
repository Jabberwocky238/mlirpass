"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.array<4 x f32>, Input>, !spirv.ptr<!spirv.array<4 x f32>, Output>) -> (), sym_name = "copy_memory_different_storage_classes"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.array<4 x f32>, Input>, %arg1: !spirv.ptr<!spirv.array<4 x f32>, Output>):
    "spirv.CopyMemory"(%arg1, %arg0) : (!spirv.ptr<!spirv.array<4 x f32>, Output>, !spirv.ptr<!spirv.array<4 x f32>, Input>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

