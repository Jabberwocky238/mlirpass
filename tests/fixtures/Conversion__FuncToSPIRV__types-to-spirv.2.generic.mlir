"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, si32, ui32) -> (), sym_name = "integer8"}> ({
  ^bb0(%arg7: i32, %arg8: si32, %arg9: ui32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, si32, ui32) -> (), sym_name = "integer16"}> ({
  ^bb0(%arg4: i32, %arg5: si32, %arg6: ui32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, si64, ui64) -> (), sym_name = "integer64"}> ({
  ^bb0(%arg1: i64, %arg2: si64, %arg3: ui64):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i128) -> (), sym_name = "integer128"}> ({
  ^bb0(%arg0: i128):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i8, si8, ui8) -> (), sym_name = "integer8"}> ({
  ^bb0(%arg6: i8, %arg7: si8, %arg8: ui8):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, si16, ui16) -> (), sym_name = "integer16"}> ({
  ^bb0(%arg3: i16, %arg4: si16, %arg5: ui16):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, si64, ui64) -> (), sym_name = "integer64"}> ({
  ^bb0(%arg0: i64, %arg1: si64, %arg2: ui64):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "integer2"}> ({
  ^bb0(%arg2: i32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "integer4"}> ({
  ^bb0(%arg1: i32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>) -> (), sym_name = "v3i4"}> ({
  ^bb0(%arg0: vector<3xi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i3) -> (), sym_name = "integer3"}> ({
  ^bb0(%arg3: i3):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i13) -> (), sym_name = "integer4"}> ({
  ^bb0(%arg2: i13):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i128) -> (), sym_name = "integer128"}> ({
  ^bb0(%arg1: i128):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i42) -> (), sym_name = "integer42"}> ({
  ^bb0(%arg0: i42):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "index_type"}> ({
  ^bb0(%arg0: i32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "float16"}> ({
  ^bb0(%arg3: f32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> (), sym_name = "float64"}> ({
  ^bb0(%arg2: f64):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "bfloat16"}> ({
  ^bb0(%arg1: f32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80) -> (), sym_name = "float80"}> ({
  ^bb0(%arg0: f80):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f16) -> (), sym_name = "float16"}> ({
  ^bb0(%arg1: f16):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> (), sym_name = "float64"}> ({
  ^bb0(%arg0: f64):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf64>) -> (), sym_name = "complex_types"}> ({
  ^bb0(%arg2: vector<2xf32>, %arg3: vector<2xf64>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<2xf16>, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x vector<2xf16>, stride=4> [0])>, Uniform>) -> (), sym_name = "memref_complex_types_with_cap"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<2xf16>, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x vector<2xf16>, stride=4> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float64, StorageUniform16, StorageBuffer16BitAccess], [SPV_KHR_16bit_storage, SPV_KHR_8bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_complex_types_no_cap"}> ({
  ^bb0(%arg0: memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, %arg1: memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>, vector<3xsi32>) -> (), sym_name = "int_vector"}> ({
  ^bb0(%arg3: vector<2xi32>, %arg4: vector<3xsi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "float_vector"}> ({
  ^bb0(%arg2: vector<2xf32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "one_element_vector"}> ({
  ^bb0(%arg1: i32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>) -> (), sym_name = "index_vector"}> ({
  ^bb0(%arg0: vector<4xi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi8>, vector<3xsi16>, vector<4xui64>) -> (), sym_name = "int_vector"}> ({
  ^bb0(%arg4: vector<2xi8>, %arg5: vector<3xsi16>, %arg6: vector<4xui64>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf16>, vector<3xf64>) -> (), sym_name = "float_vector"}> ({
  ^bb0(%arg2: vector<2xf16>, %arg3: vector<3xf64>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "one_element_vector"}> ({
  ^bb0(%arg1: i32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "zerod_vector"}> ({
  ^bb0(%arg0: f32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1024xi32>) -> (), sym_name = "large_vector"}> ({
  ^bb0(%arg0: vector<1024xi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, Uniform>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Workgroup>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, PushConstant>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Private>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Function>) -> (), sym_name = "memref_mem_space"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, %arg5: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, Uniform>, %arg6: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Workgroup>, %arg7: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, PushConstant>, %arg8: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Private>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Function>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<8 x i32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32>)>, Function>) -> (), sym_name = "memref_1bit_type"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32, stride=4> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32>)>, Function>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32>)>, Function>) -> (), sym_name = "memref_index_type"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32>)>, Function>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> (), sym_name = "numeric_memref_mem_space1"}> ({
  ^bb0(%arg1: memref<4xf32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, 3>) -> (), sym_name = "numeric_memref_mem_space2"}> ({
  ^bb0(%arg0: memref<4xf32, 3>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<2 x i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_1bit_type"}> ({
  ^bb0(%arg15: !spirv.ptr<!spirv.struct<(!spirv.array<2 x i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<3 x i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_2bit_type"}> ({
  ^bb0(%arg14: !spirv.ptr<!spirv.struct<(!spirv.array<3 x i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<2 x i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_4bit_type"}> ({
  ^bb0(%arg13: !spirv.ptr<!spirv.struct<(!spirv.array<2 x i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_8bit_StorageBuffer"}> ({
  ^bb0(%arg12: !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x si32, stride=4> [0])>, Uniform>) -> (), sym_name = "memref_8bit_Uniform"}> ({
  ^bb0(%arg11: !spirv.ptr<!spirv.struct<(!spirv.array<4 x si32, stride=4> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x ui32, stride=4> [0])>, PushConstant>) -> (), sym_name = "memref_8bit_PushConstant"}> ({
  ^bb0(%arg10: !spirv.ptr<!spirv.struct<(!spirv.array<4 x ui32, stride=4> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<8 x i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_16bit_StorageBuffer"}> ({
  ^bb0(%arg9: !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<8 x si32, stride=4> [0])>, Uniform>) -> (), sym_name = "memref_16bit_Uniform"}> ({
  ^bb0(%arg8: !spirv.ptr<!spirv.struct<(!spirv.array<8 x si32, stride=4> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<8 x ui32, stride=4> [0])>, PushConstant>) -> (), sym_name = "memref_16bit_PushConstant"}> ({
  ^bb0(%arg7: !spirv.ptr<!spirv.struct<(!spirv.array<8 x ui32, stride=4> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<8 x f32>)>, Input>) -> (), sym_name = "memref_16bit_Input"}> ({
  ^bb0(%arg6: !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32>)>, Input>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<8 x f32>)>, Output>) -> (), sym_name = "memref_16bit_Output"}> ({
  ^bb0(%arg5: !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32>)>, Output>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_64bit_StorageBuffer"}> ({
  ^bb0(%arg4: memref<16xi64, #spirv.storage_class<StorageBuffer>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xsi64, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_64bit_Uniform"}> ({
  ^bb0(%arg3: memref<16xsi64, #spirv.storage_class<Uniform>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xui64, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_64bit_PushConstant"}> ({
  ^bb0(%arg2: memref<16xui64, #spirv.storage_class<PushConstant>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf64, #spirv.storage_class<Input>>) -> (), sym_name = "memref_64bit_Input"}> ({
  ^bb0(%arg1: memref<16xf64, #spirv.storage_class<Input>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf64, #spirv.storage_class<Output>>) -> (), sym_name = "memref_64bit_Output"}> ({
  ^bb0(%arg0: memref<16xf64, #spirv.storage_class<Output>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, PushConstant>) -> (), sym_name = "memref_8bit_PushConstant"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, PushConstant>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, PushConstant>) -> (), sym_name = "memref_16bit_PushConstant"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, PushConstant>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, PushConstant>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, PushConstant>) -> (), sym_name = "memref_64bit_PushConstant"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, PushConstant>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StoragePushConstant8, StoragePushConstant16, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, StorageBuffer>) -> (), sym_name = "memref_8bit_StorageBuffer"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, StorageBuffer>) -> (), sym_name = "memref_16bit_StorageBuffer"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, StorageBuffer>) -> (), sym_name = "memref_64bit_StorageBuffer"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageBuffer8BitAccess, StorageBuffer16BitAccess, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, Uniform>) -> (), sym_name = "memref_8bit_Uniform"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, Uniform>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, Uniform>) -> (), sym_name = "memref_16bit_Uniform"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, Uniform>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, Uniform>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, Uniform>) -> (), sym_name = "memref_64bit_Uniform"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, Uniform>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [UniformAndStorageBuffer8BitAccess, StorageUniform16, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x f16>)>, Input>) -> (), sym_name = "memref_16bit_Input"}> ({
  ^bb0(%arg5: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16>)>, Input>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i16>)>, Output>) -> (), sym_name = "memref_16bit_Output"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16>)>, Output>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i64>)>, Input>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64>)>, Input>) -> (), sym_name = "memref_64bit_Input"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64>)>, Input>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64>)>, Input>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<16 x i64>)>, Output>, !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64>)>, Output>) -> (), sym_name = "memref_64bit_Output"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64>)>, Output>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64>)>, Output>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageInputOutput16, Int64, Float64], [SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<64 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<72 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<64 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<88 x f32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<64 x f16, stride=2> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<72 x f16, stride=2> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<256 x f16, stride=2> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<64 x f16, stride=2> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<88 x f16, stride=2> [0])>, StorageBuffer>) -> (), sym_name = "memref_offset_strides"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<72 x f32, stride=4> [0])>, StorageBuffer>, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f32, stride=4> [0])>, StorageBuffer>, %arg4: !spirv.ptr<!spirv.struct<(!spirv.array<88 x f32, stride=4> [0])>, StorageBuffer>, %arg5: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f16, stride=2> [0])>, StorageBuffer>, %arg6: !spirv.ptr<!spirv.struct<(!spirv.array<72 x f16, stride=2> [0])>, StorageBuffer>, %arg7: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f16, stride=2> [0])>, StorageBuffer>, %arg8: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f16, stride=2> [0])>, StorageBuffer>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.array<88 x f16, stride=2> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageBuffer16BitAccess], [SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "unranked_memref"}> ({
  ^bb0(%arg13: memref<*xi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_1bit_type"}> ({
  ^bb0(%arg12: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_2bit_type"}> ({
  ^bb0(%arg11: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_4bit_type"}> ({
  ^bb0(%arg10: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "dynamic_dim_memref"}> ({
  ^bb0(%arg8: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_8bit_StorageBuffer"}> ({
  ^bb0(%arg7: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<si32, stride=4> [0])>, Uniform>) -> (), sym_name = "memref_8bit_Uniform"}> ({
  ^bb0(%arg6: !spirv.ptr<!spirv.struct<(!spirv.rtarray<si32, stride=4> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<ui32, stride=4> [0])>, PushConstant>) -> (), sym_name = "memref_8bit_PushConstant"}> ({
  ^bb0(%arg5: !spirv.ptr<!spirv.struct<(!spirv.rtarray<ui32, stride=4> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "memref_16bit_StorageBuffer"}> ({
  ^bb0(%arg4: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<si32, stride=4> [0])>, Uniform>) -> (), sym_name = "memref_16bit_Uniform"}> ({
  ^bb0(%arg3: !spirv.ptr<!spirv.struct<(!spirv.rtarray<si32, stride=4> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<ui32, stride=4> [0])>, PushConstant>) -> (), sym_name = "memref_16bit_PushConstant"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.rtarray<ui32, stride=4> [0])>, PushConstant>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, Input>) -> (), sym_name = "memref_16bit_Input"}> ({
  ^bb0(%arg1: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, Input>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, Output>) -> (), sym_name = "memref_16bit_Output"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, Output>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<2xf32>, stride=8> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>, stride=16> [0])>, Uniform>) -> (), sym_name = "memref_vector"}> ({
  ^bb0(%arg2: !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<2xf32>, stride=8> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>, stride=16> [0])>, Uniform>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xi32>, stride=16> [0])>, StorageBuffer>, !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>) -> (), sym_name = "dynamic_dim_memref_vector"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xi32>, stride=16> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xvector<5xf32>, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_vector_wrong_size"}> ({
  ^bb0(%arg0: memref<4xvector<5xf32>, #spirv.storage_class<StorageBuffer>>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<32 x i64>, !spirv.array<32 x i32>, !spirv.array<32 x i16>, !spirv.array<32 x i8>) -> (), sym_name = "int_tensor_types"}> ({
  ^bb0(%arg3: !spirv.array<32 x i64>, %arg4: !spirv.array<32 x i32>, %arg5: !spirv.array<32 x i16>, %arg6: !spirv.array<32 x i8>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<32 x f64>, !spirv.array<32 x f32>, !spirv.array<32 x f16>) -> (), sym_name = "float_tensor_types"}> ({
  ^bb0(%arg0: !spirv.array<32 x f64>, %arg1: !spirv.array<32 x f32>, %arg2: !spirv.array<32 x f16>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<32 x i32>, !spirv.array<32 x i32>, !spirv.array<32 x i32>) -> (), sym_name = "int_tensor_types"}> ({
  ^bb0(%arg3: !spirv.array<32 x i32>, %arg4: !spirv.array<32 x i32>, %arg5: !spirv.array<32 x i32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<32 x f32>, !spirv.array<32 x f32>) -> (), sym_name = "float_tensor_types"}> ({
  ^bb0(%arg1: !spirv.array<32 x f32>, %arg2: !spirv.array<32 x f32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<20 x i32>) -> (), sym_name = "index_tensor_type"}> ({
  ^bb0(%arg0: !spirv.array<20 x i32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>) -> (), sym_name = "unranked_tensor"}> ({
  ^bb0(%arg1: tensor<*xi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x?xi32>) -> (), sym_name = "dynamic_dim_tensor"}> ({
  ^bb0(%arg0: tensor<8x?xi32>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2, f8E4M3, f8E4M3FN, f8E5M2FNUZ, f8E4M3FNUZ, f8E4M3B11FNUZ, f8E3M4, f8E8M0FNU, vector<4xf8E4M3B11FNUZ>, memref<8xf8E4M3, #spirv.storage_class<StorageBuffer>>, tensor<4xf8E5M2>) -> (), sym_name = "float8_to_integer8"}> ({
  ^bb0(%arg0: f8E5M2, %arg1: f8E4M3, %arg2: f8E4M3FN, %arg3: f8E5M2FNUZ, %arg4: f8E4M3FNUZ, %arg5: f8E4M3B11FNUZ, %arg6: f8E3M4, %arg7: f8E8M0FNU, %arg8: vector<4xf8E4M3B11FNUZ>, %arg9: memref<8xf8E4M3, #spirv.storage_class<StorageBuffer>>, %arg10: tensor<4xf8E5M2>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8], []>, #spirv.resource_limits<>>} : () -> ()

