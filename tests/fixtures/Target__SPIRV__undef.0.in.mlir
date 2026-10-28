"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], [SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
    %0 = "spirv.Undef"() : () -> f32
    %1 = "spirv.Undef"() : () -> f32
    %2 = "spirv.FAdd"(%0, %1) : (f32, f32) -> f32
    %3 = "spirv.Undef"() : () -> vector<4xi32>
    %4 = "spirv.CompositeExtract"(%3) <{indices = [1 : i32]}> : (vector<4xi32>) -> i32
    %5 = "spirv.Undef"() : () -> !spirv.array<4 x !spirv.array<4 x i32>>
    %6 = "spirv.CompositeExtract"(%5) <{indices = [1 : i32, 2 : i32]}> : (!spirv.array<4 x !spirv.array<4 x i32>>) -> i32
    %7 = "spirv.Undef"() : () -> !spirv.ptr<!spirv.struct<(f32), Block>, StorageBuffer>
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.AccessChain"(%7, %8) : (!spirv.ptr<!spirv.struct<(f32), Block>, StorageBuffer>, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

