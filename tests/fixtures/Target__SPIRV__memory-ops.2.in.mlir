"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], [SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>):
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.AccessChain"(%arg2, %5, %5) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %7 = "spirv.Load"(%6) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.AccessChain"(%arg3, %8, %8) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%9, %7) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.AccessChain"(%arg0, %0, %0) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %2 = "spirv.Load"(%1) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %4 = "spirv.AccessChain"(%arg1, %3, %3) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%4, %2) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

