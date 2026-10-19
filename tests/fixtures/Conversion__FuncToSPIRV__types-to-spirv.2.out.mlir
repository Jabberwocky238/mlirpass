module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @integer8(%arg0: i32, %arg1: si32, %arg2: ui32) "None" {
    spirv.Return
  }
  spirv.func @integer16(%arg0: i32, %arg1: si32, %arg2: ui32) "None" {
    spirv.Return
  }
  func.func @integer64(%arg0: i64, %arg1: si64, %arg2: ui64) {
    spirv.Return
  }
  func.func @integer128(%arg0: i128) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64], []>, #spirv.resource_limits<>>} {
  spirv.func @integer8(%arg0: i8, %arg1: si8, %arg2: ui8) "None" {
    spirv.Return
  }
  spirv.func @integer16(%arg0: i16, %arg1: si16, %arg2: ui16) "None" {
    spirv.Return
  }
  spirv.func @integer64(%arg0: i64, %arg1: si64, %arg2: ui64) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @integer2(%arg0: i32) "None" {
    spirv.Return
  }
  spirv.func @integer4(%arg0: i32) "None" {
    spirv.Return
  }
  spirv.func @v3i4(%arg0: vector<3xi32>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @integer3(%arg0: i3) {
    spirv.Return
  }
  func.func @integer4(%arg0: i13) {
    spirv.Return
  }
  func.func @integer128(%arg0: i128) {
    spirv.Return
  }
  func.func @integer42(%arg0: i42) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @index_type(%arg0: i32) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @float16(%arg0: f32) "None" {
    spirv.Return
  }
  func.func @float64(%arg0: f64) {
    spirv.Return
  }
  spirv.func @bfloat16(%arg0: f32) "None" {
    spirv.Return
  }
  func.func @float80(%arg0: f80) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Float64], []>, #spirv.resource_limits<>>} {
  spirv.func @float16(%arg0: f16) "None" {
    spirv.Return
  }
  spirv.func @float64(%arg0: f64) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float64, StorageUniform16, StorageBuffer16BitAccess], [SPV_KHR_16bit_storage, SPV_KHR_8bit_storage]>, #spirv.resource_limits<>>} {
  spirv.func @complex_types(%arg0: vector<2xf32>, %arg1: vector<2xf64>) "None" {
    spirv.Return
  }
  spirv.func @memref_complex_types_with_cap(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<2xf16>, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x vector<2xf16>, stride=4> [0])>, Uniform>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @memref_complex_types_no_cap(%arg0: memref<4xcomplex<f16>, #spirv.storage_class<StorageBuffer>>, %arg1: memref<2x8xcomplex<f16>, #spirv.storage_class<Uniform>>) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @int_vector(%arg0: vector<2xi32>, %arg1: vector<3xsi32>) "None" {
    spirv.Return
  }
  spirv.func @float_vector(%arg0: vector<2xf32>) "None" {
    spirv.Return
  }
  spirv.func @one_element_vector(%arg0: i32) "None" {
    spirv.Return
  }
  spirv.func @index_vector(%arg0: vector<4xi32>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} {
  spirv.func @int_vector(%arg0: vector<2xi8>, %arg1: vector<3xsi16>, %arg2: vector<4xui64>) "None" {
    spirv.Return
  }
  spirv.func @float_vector(%arg0: vector<2xf16>, %arg1: vector<3xf64>) "None" {
    spirv.Return
  }
  spirv.func @one_element_vector(%arg0: i32) "None" {
    spirv.Return
  }
  spirv.func @zerod_vector(%arg0: f32) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @large_vector(%arg0: vector<1024xi32>) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.func @memref_mem_space(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, Uniform>, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Workgroup>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32, stride=4> [0])>, PushConstant>, %arg4: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Private>, %arg5: !spirv.ptr<!spirv.struct<(!spirv.array<4 x f32>)>, Function>) "None" {
    spirv.Return
  }
  spirv.func @memref_1bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32>)>, Function>) "None" {
    spirv.Return
  }
  spirv.func @memref_index_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32>)>, Function>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @numeric_memref_mem_space1(%arg0: memref<4xf32>) {
    spirv.Return
  }
  func.func @numeric_memref_mem_space2(%arg0: memref<4xf32, 3>) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @memref_1bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<2 x i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_2bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<3 x i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_4bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<2 x i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_8bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_8bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x si32, stride=4> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @memref_8bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x ui32, stride=4> [0])>, PushConstant>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<8 x i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<8 x si32, stride=4> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<8 x ui32, stride=4> [0])>, PushConstant>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Input(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32>)>, Input>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Output(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32>)>, Output>) "None" {
    spirv.Return
  }
  func.func @memref_64bit_StorageBuffer(%arg0: memref<16xi64, #spirv.storage_class<StorageBuffer>>) {
    spirv.Return
  }
  func.func @memref_64bit_Uniform(%arg0: memref<16xsi64, #spirv.storage_class<Uniform>>) {
    spirv.Return
  }
  func.func @memref_64bit_PushConstant(%arg0: memref<16xui64, #spirv.storage_class<PushConstant>>) {
    spirv.Return
  }
  func.func @memref_64bit_Input(%arg0: memref<16xf64, #spirv.storage_class<Input>>) {
    spirv.Return
  }
  func.func @memref_64bit_Output(%arg0: memref<16xf64, #spirv.storage_class<Output>>) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StoragePushConstant8, StoragePushConstant16, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} {
  spirv.func @memref_8bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, PushConstant>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, PushConstant>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, PushConstant>) "None" {
    spirv.Return
  }
  spirv.func @memref_64bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, PushConstant>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, PushConstant>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageBuffer8BitAccess, StorageBuffer16BitAccess, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} {
  spirv.func @memref_8bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_64bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [UniformAndStorageBuffer8BitAccess, StorageUniform16, Int64, Float64], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} {
  spirv.func @memref_8bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i8, stride=1> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16, stride=2> [0])>, Uniform>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16, stride=2> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @memref_64bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64, stride=8> [0])>, Uniform>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64, stride=8> [0])>, Uniform>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageInputOutput16, Int64, Float64], [SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} {
  spirv.func @memref_16bit_Input(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f16>)>, Input>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Output(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i16>)>, Output>) "None" {
    spirv.Return
  }
  spirv.func @memref_64bit_Input(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64>)>, Input>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64>)>, Input>) "None" {
    spirv.Return
  }
  spirv.func @memref_64bit_Output(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<16 x i64>)>, Output>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<16 x f64>)>, Output>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [StorageBuffer16BitAccess], [SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} {
  spirv.func @memref_offset_strides(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<72 x f32, stride=4> [0])>, StorageBuffer>, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f32, stride=4> [0])>, StorageBuffer>, %arg4: !spirv.ptr<!spirv.struct<(!spirv.array<88 x f32, stride=4> [0])>, StorageBuffer>, %arg5: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f16, stride=2> [0])>, StorageBuffer>, %arg6: !spirv.ptr<!spirv.struct<(!spirv.array<72 x f16, stride=2> [0])>, StorageBuffer>, %arg7: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f16, stride=2> [0])>, StorageBuffer>, %arg8: !spirv.ptr<!spirv.struct<(!spirv.array<64 x f16, stride=2> [0])>, StorageBuffer>, %arg9: !spirv.ptr<!spirv.struct<(!spirv.array<88 x f16, stride=2> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @unranked_memref(%arg0: memref<*xi32>) {
    spirv.Return
  }
  spirv.func @memref_1bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_2bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_4bit_type(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @dynamic_dim_memref(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_8bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_8bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<si32, stride=4> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @memref_8bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<ui32, stride=4> [0])>, PushConstant>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_StorageBuffer(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Uniform(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<si32, stride=4> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_PushConstant(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<ui32, stride=4> [0])>, PushConstant>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Input(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, Input>) "None" {
    spirv.Return
  }
  spirv.func @memref_16bit_Output(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, Output>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @memref_vector(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<2xf32>, stride=8> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>, stride=16> [0])>, Uniform>) "None" {
    spirv.Return
  }
  spirv.func @dynamic_dim_memref_vector(%arg0: !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<4xi32>, stride=16> [0])>, StorageBuffer>, %arg1: !spirv.ptr<!spirv.struct<(!spirv.rtarray<vector<2xf32>, stride=8> [0])>, StorageBuffer>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @memref_vector_wrong_size(%arg0: memref<4xvector<5xf32>, #spirv.storage_class<StorageBuffer>>) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} {
  spirv.func @int_tensor_types(%arg0: !spirv.array<32 x i64>, %arg1: !spirv.array<32 x i32>, %arg2: !spirv.array<32 x i16>, %arg3: !spirv.array<32 x i8>) "None" {
    spirv.Return
  }
  spirv.func @float_tensor_types(%arg0: !spirv.array<32 x f64>, %arg1: !spirv.array<32 x f32>, %arg2: !spirv.array<32 x f16>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @int_tensor_types(%arg0: !spirv.array<32 x i32>, %arg1: !spirv.array<32 x i32>, %arg2: !spirv.array<32 x i32>) "None" {
    spirv.Return
  }
  spirv.func @float_tensor_types(%arg0: !spirv.array<32 x f32>, %arg1: !spirv.array<32 x f32>) "None" {
    spirv.Return
  }
  spirv.func @index_tensor_type(%arg0: !spirv.array<20 x i32>) "None" {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @unranked_tensor(%arg0: tensor<*xi32>) {
    spirv.Return
  }
  func.func @dynamic_dim_tensor(%arg0: tensor<8x?xi32>) {
    spirv.Return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8], []>, #spirv.resource_limits<>>} {
  func.func @float8_to_integer8(%arg0: f8E5M2, %arg1: f8E4M3, %arg2: f8E4M3FN, %arg3: f8E5M2FNUZ, %arg4: f8E4M3FNUZ, %arg5: f8E4M3B11FNUZ, %arg6: f8E3M4, %arg7: f8E8M0FNU, %arg8: vector<4xf8E4M3B11FNUZ>, %arg9: memref<8xf8E4M3, #spirv.storage_class<StorageBuffer>>, %arg10: tensor<4xf8E5M2>) {
    spirv.Return
  }
}

