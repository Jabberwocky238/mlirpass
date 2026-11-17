"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], [SPV_KHR_storage_buffer_storage_class]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>) -> (), sym_name = "load_store_zero_rank_float"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>):
    %7 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %8 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %9 = "spirv.AccessChain"(%arg2, %7, %8) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    %10 = "spirv.Load"(%9) : (!spirv.ptr<f32, StorageBuffer>) -> f32
    %11 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %12 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %13 = "spirv.AccessChain"(%arg3, %11, %12) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
    "spirv.Store"(%13, %10) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>) -> (), sym_name = "load_store_zero_rank_int"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.AccessChain"(%arg0, %0, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    %3 = "spirv.Load"(%2) : (!spirv.ptr<i32, StorageBuffer>) -> i32
    %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %5 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %6 = "spirv.AccessChain"(%arg1, %4, %5) : (!spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0]), Block>, StorageBuffer>, i32, i32) -> !spirv.ptr<i32, StorageBuffer>
    "spirv.Store"(%6, %3) : (!spirv.ptr<i32, StorageBuffer>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()