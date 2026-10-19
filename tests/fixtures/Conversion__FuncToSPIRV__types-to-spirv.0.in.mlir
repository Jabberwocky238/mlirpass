"builtin.module"() ({
  "func.func"() <{function_type = (i8, si8, ui8) -> (), sym_name = "integer8"}> ({
  ^bb0(%arg7: i8, %arg8: si8, %arg9: ui8):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, si16, ui16) -> (), sym_name = "integer16"}> ({
  ^bb0(%arg4: i16, %arg5: si16, %arg6: ui16):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, si64, ui64) -> (), sym_name = "integer64"}> ({
  ^bb0(%arg1: i64, %arg2: si64, %arg3: ui64):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i128) -> (), sym_name = "integer128"}> ({
  ^bb0(%arg0: i128):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, si8, ui8) -> (), sym_name = "integer8"}> ({
  ^bb0(%arg6: i8, %arg7: si8, %arg8: ui8):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, si16, ui16) -> (), sym_name = "integer16"}> ({
  ^bb0(%arg3: i16, %arg4: si16, %arg5: ui16):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, si64, ui64) -> (), sym_name = "integer64"}> ({
  ^bb0(%arg0: i64, %arg1: si64, %arg2: ui64):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (), sym_name = "integer2"}> ({
  ^bb0(%arg2: i8):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> (), sym_name = "integer4"}> ({
  ^bb0(%arg1: i4):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi4>) -> (), sym_name = "v3i4"}> ({
  ^bb0(%arg0: vector<3xi4>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i3) -> (), sym_name = "integer3"}> ({
  ^bb0(%arg3: i3):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i13) -> (), sym_name = "integer4"}> ({
  ^bb0(%arg2: i13):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i128) -> (), sym_name = "integer128"}> ({
  ^bb0(%arg1: i128):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i42) -> (), sym_name = "integer42"}> ({
  ^bb0(%arg0: i42):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "index_type"}> ({
  ^bb0(%arg0: index):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> (), sym_name = "float16"}> ({
  ^bb0(%arg3: f16):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> (), sym_name = "float64"}> ({
  ^bb0(%arg2: f64):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> (), sym_name = "bfloat16"}> ({
  ^bb0(%arg1: bf16):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80) -> (), sym_name = "float80"}> ({
  ^bb0(%arg0: f80):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> (), sym_name = "float16"}> ({
  ^bb0(%arg1: f16):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> (), sym_name = "float64"}> ({
  ^bb0(%arg0: f64):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (), sym_name = "complex_types"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f64>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_complex_types_with_cap"}> ({
  ^bb0(%arg0: memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, %arg1: memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float64, StorageUniform16, StorageBuffer16BitAccess], [SPV_KHR_16bit_storage, SPV_KHR_8bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_complex_types_no_cap"}> ({
  ^bb0(%arg0: memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, %arg1: memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi8>, vector<3xsi16>) -> (), sym_name = "int_vector"}> ({
  ^bb0(%arg3: vector<2xi8>, %arg4: vector<3xsi16>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>) -> (), sym_name = "float_vector"}> ({
  ^bb0(%arg2: vector<2xf16>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi8>) -> (), sym_name = "one_element_vector"}> ({
  ^bb0(%arg1: vector<1xi8>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xindex>) -> (), sym_name = "index_vector"}> ({
  ^bb0(%arg0: vector<4xindex>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi8>, vector<3xsi16>, vector<4xui64>) -> (), sym_name = "int_vector"}> ({
  ^bb0(%arg4: vector<2xi8>, %arg5: vector<3xsi16>, %arg6: vector<4xui64>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<3xf64>) -> (), sym_name = "float_vector"}> ({
  ^bb0(%arg2: vector<2xf16>, %arg3: vector<3xf64>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1xi32>) -> (), sym_name = "one_element_vector"}> ({
  ^bb0(%arg1: vector<1xi32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "zerod_vector"}> ({
  ^bb0(%arg0: vector<f32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1024xi32>) -> (), sym_name = "large_vector"}> ({
  ^bb0(%arg0: vector<1024xi32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32, #spirv.storage_class<StorageBuffer>>, memref<4xf32, #spirv.storage_class<Uniform>>, memref<4xf32, #spirv.storage_class<Workgroup>>, memref<4xf32, #spirv.storage_class<PushConstant>>, memref<4xf32, #spirv.storage_class<Private>>, memref<4xf32, #spirv.storage_class<Function>>) -> (), sym_name = "memref_mem_space"}> ({
  ^bb0(%arg4: memref<4xf32, #spirv.storage_class<StorageBuffer>>, %arg5: memref<4xf32, #spirv.storage_class<Uniform>>, %arg6: memref<4xf32, #spirv.storage_class<Workgroup>>, %arg7: memref<4xf32, #spirv.storage_class<PushConstant>>, %arg8: memref<4xf32, #spirv.storage_class<Private>>, %arg9: memref<4xf32, #spirv.storage_class<Function>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x8xi1, #spirv.storage_class<StorageBuffer>>, memref<4x8xi1, #spirv.storage_class<Function>>) -> (), sym_name = "memref_1bit_type"}> ({
  ^bb0(%arg2: memref<4x8xi1, #spirv.storage_class<StorageBuffer>>, %arg3: memref<4x8xi1, #spirv.storage_class<Function>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xindex, #spirv.storage_class<StorageBuffer>>, memref<4xindex, #spirv.storage_class<Function>>) -> (), sym_name = "memref_index_type"}> ({
  ^bb0(%arg0: memref<4xindex, #spirv.storage_class<StorageBuffer>>, %arg1: memref<4xindex, #spirv.storage_class<Function>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> (), sym_name = "numeric_memref_mem_space1"}> ({
  ^bb0(%arg1: memref<4xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<4xf32, 3>) -> (), sym_name = "numeric_memref_mem_space2"}> ({
  ^bb0(%arg0: memref<4xf32, 3>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xi1, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_1bit_type"}> ({
  ^bb0(%arg15: memref<5xi1, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<33xi2, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_2bit_type"}> ({
  ^bb0(%arg14: memref<33xi2, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi4, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_4bit_type"}> ({
  ^bb0(%arg13: memref<16xi4, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi8, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_8bit_StorageBuffer"}> ({
  ^bb0(%arg12: memref<16xi8, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xsi8, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_8bit_Uniform"}> ({
  ^bb0(%arg11: memref<16xsi8, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xui8, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_8bit_PushConstant"}> ({
  ^bb0(%arg10: memref<16xui8, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_16bit_StorageBuffer"}> ({
  ^bb0(%arg9: memref<16xi16, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xsi16, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_16bit_Uniform"}> ({
  ^bb0(%arg8: memref<16xsi16, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xui16, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_16bit_PushConstant"}> ({
  ^bb0(%arg7: memref<16xui16, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16, #spirv.storage_class<Input>>) -> (), sym_name = "memref_16bit_Input"}> ({
  ^bb0(%arg6: memref<16xf16, #spirv.storage_class<Input>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16, #spirv.storage_class<Output>>) -> (), sym_name = "memref_16bit_Output"}> ({
  ^bb0(%arg5: memref<16xf16, #spirv.storage_class<Output>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_64bit_StorageBuffer"}> ({
  ^bb0(%arg4: memref<16xi64, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xsi64, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_64bit_Uniform"}> ({
  ^bb0(%arg3: memref<16xsi64, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xui64, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_64bit_PushConstant"}> ({
  ^bb0(%arg2: memref<16xui64, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf64, #spirv.storage_class<Input>>) -> (), sym_name = "memref_64bit_Input"}> ({
  ^bb0(%arg1: memref<16xf64, #spirv.storage_class<Input>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf64, #spirv.storage_class<Output>>) -> (), sym_name = "memref_64bit_Output"}> ({
  ^bb0(%arg0: memref<16xf64, #spirv.storage_class<Output>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xi8, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_8bit_PushConstant"}> ({
  ^bb0(%arg4: memref<16xi8, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi16, #spirv.storage_class<PushConstant>>, memref<16xf16, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_16bit_PushConstant"}> ({
  ^bb0(%arg2: memref<16xi16, #spirv.storage_class<PushConstant>>, %arg3: memref<16xf16, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<PushConstant>>, memref<16xf64, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_64bit_PushConstant"}> ({
  ^bb0(%arg0: memref<16xi64, #spirv.storage_class<PushConstant>>, %arg1: memref<16xf64, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StoragePushConstant8, StoragePushConstant16, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xi8, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_8bit_StorageBuffer"}> ({
  ^bb0(%arg4: memref<16xi8, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi16, #spirv.storage_class<StorageBuffer>>, memref<16xf16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_16bit_StorageBuffer"}> ({
  ^bb0(%arg2: memref<16xi16, #spirv.storage_class<StorageBuffer>>, %arg3: memref<16xf16, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<StorageBuffer>>, memref<16xf64, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_64bit_StorageBuffer"}> ({
  ^bb0(%arg0: memref<16xi64, #spirv.storage_class<StorageBuffer>>, %arg1: memref<16xf64, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageBuffer8BitAccess, StorageBuffer16BitAccess, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xi8, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_8bit_Uniform"}> ({
  ^bb0(%arg4: memref<16xi8, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi16, #spirv.storage_class<Uniform>>, memref<16xf16, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_16bit_Uniform"}> ({
  ^bb0(%arg2: memref<16xi16, #spirv.storage_class<Uniform>>, %arg3: memref<16xf16, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<Uniform>>, memref<16xf64, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_64bit_Uniform"}> ({
  ^bb0(%arg0: memref<16xi64, #spirv.storage_class<Uniform>>, %arg1: memref<16xf64, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [UniformAndStorageBuffer8BitAccess, StorageUniform16, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16xf16, #spirv.storage_class<Input>>) -> (), sym_name = "memref_16bit_Input"}> ({
  ^bb0(%arg5: memref<16xf16, #spirv.storage_class<Input>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi16, #spirv.storage_class<Output>>) -> (), sym_name = "memref_16bit_Output"}> ({
  ^bb0(%arg4: memref<16xi16, #spirv.storage_class<Output>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<Input>>, memref<16xf64, #spirv.storage_class<Input>>) -> (), sym_name = "memref_64bit_Input"}> ({
  ^bb0(%arg2: memref<16xi64, #spirv.storage_class<Input>>, %arg3: memref<16xf64, #spirv.storage_class<Input>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xi64, #spirv.storage_class<Output>>, memref<16xf64, #spirv.storage_class<Output>>) -> (), sym_name = "memref_64bit_Output"}> ({
  ^bb0(%arg0: memref<16xi64, #spirv.storage_class<Output>>, %arg1: memref<16xf64, #spirv.storage_class<Output>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageInputOutput16, Int64, Float64], [SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x4xf32, strided<[4, 1]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf32, strided<[4, 1], offset: 8>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf32, strided<[16, 1]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf32, strided<[1, 16]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf32, strided<[1, 22]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf16, strided<[4, 1]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf16, strided<[4, 1], offset: 8>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf16, strided<[16, 1]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf16, strided<[1, 16]>, #spirv.storage_class<StorageBuffer>>, memref<16x4xf16, strided<[1, 22]>, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_offset_strides"}> ({
  ^bb0(%arg0: memref<16x4xf32, strided<[4, 1]>, #spirv.storage_class<StorageBuffer>>, %arg1: memref<16x4xf32, strided<[4, 1], offset: 8>, #spirv.storage_class<StorageBuffer>>, %arg2: memref<16x4xf32, strided<[16, 1]>, #spirv.storage_class<StorageBuffer>>, %arg3: memref<16x4xf32, strided<[1, 16]>, #spirv.storage_class<StorageBuffer>>, %arg4: memref<16x4xf32, strided<[1, 22]>, #spirv.storage_class<StorageBuffer>>, %arg5: memref<16x4xf16, strided<[4, 1]>, #spirv.storage_class<StorageBuffer>>, %arg6: memref<16x4xf16, strided<[4, 1], offset: 8>, #spirv.storage_class<StorageBuffer>>, %arg7: memref<16x4xf16, strided<[16, 1]>, #spirv.storage_class<StorageBuffer>>, %arg8: memref<16x4xf16, strided<[1, 16]>, #spirv.storage_class<StorageBuffer>>, %arg9: memref<16x4xf16, strided<[1, 22]>, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageBuffer16BitAccess], [SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "unranked_memref"}> ({
  ^bb0(%arg13: memref<*xi32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi1, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_1bit_type"}> ({
  ^bb0(%arg12: memref<?xi1, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi2, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_2bit_type"}> ({
  ^bb0(%arg11: memref<?xi2, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi4, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_4bit_type"}> ({
  ^bb0(%arg10: memref<?xi4, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8x?xi32, #spirv.storage_class<StorageBuffer>>, memref<?x?xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "dynamic_dim_memref"}> ({
  ^bb0(%arg8: memref<8x?xi32, #spirv.storage_class<StorageBuffer>>, %arg9: memref<?x?xf32, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_8bit_StorageBuffer"}> ({
  ^bb0(%arg7: memref<?xi8, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xsi8, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_8bit_Uniform"}> ({
  ^bb0(%arg6: memref<?xsi8, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xui8, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_8bit_PushConstant"}> ({
  ^bb0(%arg5: memref<?xui8, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi16, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_16bit_StorageBuffer"}> ({
  ^bb0(%arg4: memref<?xi16, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xsi16, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_16bit_Uniform"}> ({
  ^bb0(%arg3: memref<?xsi16, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xui16, #spirv.storage_class<PushConstant>>) -> (), sym_name = "memref_16bit_PushConstant"}> ({
  ^bb0(%arg2: memref<?xui16, #spirv.storage_class<PushConstant>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf16, #spirv.storage_class<Input>>) -> (), sym_name = "memref_16bit_Input"}> ({
  ^bb0(%arg1: memref<?xf16, #spirv.storage_class<Input>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf16, #spirv.storage_class<Output>>) -> (), sym_name = "memref_16bit_Output"}> ({
  ^bb0(%arg0: memref<?xf16, #spirv.storage_class<Output>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xvector<2xf32>, #spirv.storage_class<StorageBuffer>>, memref<4xvector<4xf32>, #spirv.storage_class<Uniform>>) -> (), sym_name = "memref_vector"}> ({
  ^bb0(%arg2: memref<4xvector<2xf32>, #spirv.storage_class<StorageBuffer>>, %arg3: memref<4xvector<4xf32>, #spirv.storage_class<Uniform>>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8x?xvector<4xi32>, #spirv.storage_class<StorageBuffer>>, memref<?x?xvector<2xf32>, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "dynamic_dim_memref_vector"}> ({
  ^bb0(%arg0: memref<8x?xvector<4xi32>, #spirv.storage_class<StorageBuffer>>, %arg1: memref<?x?xvector<2xf32>, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xvector<5xf32>, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "memref_vector_wrong_size"}> ({
  ^bb0(%arg0: memref<4xvector<5xf32>, #spirv.storage_class<StorageBuffer>>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x4xi64>, tensor<8x4xi32>, tensor<8x4xi16>, tensor<8x4xi8>) -> (), sym_name = "int_tensor_types"}> ({
  ^bb0(%arg3: tensor<8x4xi64>, %arg4: tensor<8x4xi32>, %arg5: tensor<8x4xi16>, %arg6: tensor<8x4xi8>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x4xf64>, tensor<8x4xf32>, tensor<8x4xf16>) -> (), sym_name = "float_tensor_types"}> ({
  ^bb0(%arg0: tensor<8x4xf64>, %arg1: tensor<8x4xf32>, %arg2: tensor<8x4xf16>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x4xi32>, tensor<8x4xi16>, tensor<8x4xi8>) -> (), sym_name = "int_tensor_types"}> ({
  ^bb0(%arg3: tensor<8x4xi32>, %arg4: tensor<8x4xi16>, %arg5: tensor<8x4xi8>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x4xf32>, tensor<8x4xf16>) -> (), sym_name = "float_tensor_types"}> ({
  ^bb0(%arg1: tensor<8x4xf32>, %arg2: tensor<8x4xf16>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<4x5xindex>) -> (), sym_name = "index_tensor_type"}> ({
  ^bb0(%arg0: tensor<4x5xindex>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xi32>) -> (), sym_name = "unranked_tensor"}> ({
  ^bb0(%arg1: tensor<*xi32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<8x?xi32>) -> (), sym_name = "dynamic_dim_tensor"}> ({
  ^bb0(%arg0: tensor<8x?xi32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2, f8E4M3, f8E4M3FN, f8E5M2FNUZ, f8E4M3FNUZ, f8E4M3B11FNUZ, f8E3M4, f8E8M0FNU, vector<4xf8E4M3B11FNUZ>, memref<8xf8E4M3, #spirv.storage_class<StorageBuffer>>, tensor<4xf8E5M2>) -> (), sym_name = "float8_to_integer8"}> ({
  ^bb0(%arg0: f8E5M2, %arg1: f8E4M3, %arg2: f8E4M3FN, %arg3: f8E5M2FNUZ, %arg4: f8E4M3FNUZ, %arg5: f8E4M3B11FNUZ, %arg6: f8E3M4, %arg7: f8E8M0FNU, %arg8: vector<4xf8E4M3B11FNUZ>, %arg9: memref<8xf8E4M3, #spirv.storage_class<StorageBuffer>>, %arg10: tensor<4xf8E5M2>):
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8], []>, #spirv.resource_limits<>>} : () -> ()

