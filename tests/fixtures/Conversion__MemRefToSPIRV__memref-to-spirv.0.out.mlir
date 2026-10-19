module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int8, Int16, Int64, Float16, Float64, StorageBuffer16BitAccess, StorageUniform16, StoragePushConstant16, StorageBuffer8BitAccess, UniformAndStorageBuffer8BitAccess, StoragePushConstant8, PhysicalStorageBufferAddresses], [SPV_KHR_16bit_storage, SPV_KHR_8bit_storage, SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer]>, #spirv.resource_limits<>>} {
  func.func @load_store_zero_rank_float(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<f32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<f32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %3 = spirv.Load "StorageBuffer" %2 : f32
    %4 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %4, %3 : f32
    return
  }
  func.func @load_store_zero_rank_int(%arg0: memref<i32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<i32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<i32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<i32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %3 = spirv.Load "StorageBuffer" %2 : i32
    %4 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    spirv.Store "StorageBuffer" %4, %3 : i32
    return
  }
  func.func @load_store_unknown_dim(%arg0: index, %arg1: memref<?xi32, #spirv.storage_class<StorageBuffer>>, %arg2: memref<?xi32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : memref<?xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg1 : memref<?xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %3 = spirv.AccessChain %2[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %4 = spirv.Load "StorageBuffer" %3 : i32
    %5 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    spirv.Store "StorageBuffer" %5, %4 : i32
    return
  }
  func.func @load_i1(%arg0: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg1: index) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i8, StorageBuffer>
    %3 = spirv.Load "StorageBuffer" %2 : i8
    %cst0_i8 = spirv.Constant 0 : i8
    %4 = spirv.INotEqual %3, %cst0_i8 : i8
    return %4 : i1
  }
  func.func @load_aligned(%arg0: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg1: index) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i8, StorageBuffer>
    %3 = spirv.Load "StorageBuffer" %2 ["Aligned", 32] : i8
    %cst0_i8 = spirv.Constant 0 : i8
    %4 = spirv.INotEqual %3, %cst0_i8 : i8
    return %4 : i1
  }
  func.func @load_aligned_nontemporal(%arg0: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg1: index) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i8, StorageBuffer>
    %3 = spirv.Load "StorageBuffer" %2 ["Aligned|Nontemporal", 32] : i8
    %cst0_i8 = spirv.Constant 0 : i8
    %4 = spirv.INotEqual %3, %cst0_i8 : i8
    return %4 : i1
  }
  func.func @load_aligned_psb(%arg0: memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>>, %arg1: index) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %3 = spirv.Load "PhysicalStorageBuffer" %2 ["Aligned", 32] : i8
    %cst0_i8 = spirv.Constant 0 : i8
    %4 = spirv.INotEqual %3, %cst0_i8 : i8
    return %4 : i1
  }
  func.func @store_i1(%arg0: memref<4xi1, #spirv.storage_class<StorageBuffer>>, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i8, stride=1> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i8, StorageBuffer>
    %cst1_i8 = spirv.Constant 1 : i8
    spirv.Store "StorageBuffer" %2, %cst1_i8 : i8
    return
  }
  func.func @load_i16(%arg0: memref<i16, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i16, stride=2> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i16, stride=2> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i16, StorageBuffer>
    %2 = spirv.Load "StorageBuffer" %1 : i16
    return
  }
  func.func @store_i16(%arg0: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg1: index, %arg2: i16) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<10xi16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<10 x i16, stride=2> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x i16, stride=2> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i16, StorageBuffer>
    spirv.Store "StorageBuffer" %2, %arg2 : i16
    return
  }
  func.func @load_store_i32_physical(%arg0: memref<i32, #spirv.storage_class<PhysicalStorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i32, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<i32, PhysicalStorageBuffer>
    %2 = spirv.Load "PhysicalStorageBuffer" %1 ["Aligned", 4] : i32
    spirv.Store "PhysicalStorageBuffer" %1, %2 ["Aligned", 4] : i32
    return
  }
  func.func @load_store_i8_physical(%arg0: memref<i8, #spirv.storage_class<PhysicalStorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i8, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %2 = spirv.Load "PhysicalStorageBuffer" %1 ["Aligned", 1] : i8
    spirv.Store "PhysicalStorageBuffer" %1, %2 ["Aligned", 1] : i8
    return
  }
  func.func @load_store_i1_physical(%arg0: memref<i1, #spirv.storage_class<PhysicalStorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i1, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i8, stride=1> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<i8, PhysicalStorageBuffer>
    %2 = spirv.Load "PhysicalStorageBuffer" %1 ["Aligned", 1] : i8
    %cst0_i8 = spirv.Constant 0 : i8
    %3 = spirv.INotEqual %2, %cst0_i8 : i8
    %cst1_i8 = spirv.Constant 1 : i8
    %4 = spirv.Select %3, %cst1_i8, %cst0_i8 : i1, i8
    spirv.Store "PhysicalStorageBuffer" %1, %4 ["Aligned", 1] : i8
    return
  }
  func.func @load_store_f32_physical(%arg0: memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<f32, PhysicalStorageBuffer>
    %2 = spirv.Load "PhysicalStorageBuffer" %1 ["Aligned", 4] : f32
    spirv.Store "PhysicalStorageBuffer" %1, %2 ["Aligned", 4] : f32
    return
  }
  func.func @load_store_f16_physical(%arg0: memref<f16, #spirv.storage_class<PhysicalStorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f16, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f16, stride=2> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f16, stride=2> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<f16, PhysicalStorageBuffer>
    %2 = spirv.Load "PhysicalStorageBuffer" %1 ["Aligned", 2] : f16
    spirv.Store "PhysicalStorageBuffer" %1, %2 ["Aligned", 2] : f16
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, Int8, Int16, Int64, Float16, Float64], []>, #spirv.resource_limits<>>} {
  func.func @load_store_zero_rank_float(%arg0: memref<f32, #spirv.storage_class<CrossWorkgroup>>, %arg1: memref<f32, #spirv.storage_class<CrossWorkgroup>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<f32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32] : !spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>, i32 -> !spirv.ptr<f32, CrossWorkgroup>
    %3 = spirv.Load "CrossWorkgroup" %2 : f32
    %4 = spirv.AccessChain %0[%cst0_i32] : !spirv.ptr<!spirv.array<1 x f32>, CrossWorkgroup>, i32 -> !spirv.ptr<f32, CrossWorkgroup>
    spirv.Store "CrossWorkgroup" %4, %3 : f32
    return
  }
  func.func @load_store_zero_rank_int(%arg0: memref<i32, #spirv.storage_class<CrossWorkgroup>>, %arg1: memref<i32, #spirv.storage_class<CrossWorkgroup>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<i32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<i32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %1[%cst0_i32] : !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>, i32 -> !spirv.ptr<i32, CrossWorkgroup>
    %3 = spirv.Load "CrossWorkgroup" %2 : i32
    %4 = spirv.AccessChain %0[%cst0_i32] : !spirv.ptr<!spirv.array<1 x i32>, CrossWorkgroup>, i32 -> !spirv.ptr<i32, CrossWorkgroup>
    spirv.Store "CrossWorkgroup" %4, %3 : i32
    return
  }
  func.func @load_store_unknown_dim(%arg0: index, %arg1: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>, %arg2: memref<?xi32, #spirv.storage_class<CrossWorkgroup>>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : memref<?xi32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<i32, CrossWorkgroup>
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg1 : memref<?xi32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<i32, CrossWorkgroup>
    %3 = spirv.PtrAccessChain %2[%1] : !spirv.ptr<i32, CrossWorkgroup>, i32 -> !spirv.ptr<i32, CrossWorkgroup>
    %4 = spirv.Load "CrossWorkgroup" %3 : i32
    %5 = spirv.PtrAccessChain %0[%1] : !spirv.ptr<i32, CrossWorkgroup>, i32 -> !spirv.ptr<i32, CrossWorkgroup>
    spirv.Store "CrossWorkgroup" %5, %4 : i32
    return
  }
  func.func @load_i1(%arg0: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg1: index) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>
    %2 = spirv.AccessChain %1[%0] : !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>, i32 -> !spirv.ptr<i8, CrossWorkgroup>
    %3 = spirv.Load "CrossWorkgroup" %2 : i8
    %cst0_i8 = spirv.Constant 0 : i8
    %4 = spirv.INotEqual %3, %cst0_i8 : i8
    return %4 : i1
  }
  func.func @store_i1(%arg0: memref<4xi1, #spirv.storage_class<CrossWorkgroup>>, %arg1: index) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<4xi1, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>
    %2 = spirv.AccessChain %1[%0] : !spirv.ptr<!spirv.array<4 x i8>, CrossWorkgroup>, i32 -> !spirv.ptr<i8, CrossWorkgroup>
    %cst1_i8 = spirv.Constant 1 : i8
    spirv.Store "CrossWorkgroup" %2, %cst1_i8 : i8
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} {
  func.func @memory_space_cast(%arg0: memref<4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4xf32, #spirv.storage_class<Function>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.array<4 x f32>, CrossWorkgroup>
    %1 = spirv.PtrCastToGeneric %0 : !spirv.ptr<!spirv.array<4 x f32>, CrossWorkgroup> to !spirv.ptr<!spirv.array<4 x f32>, Generic>
    %2 = spirv.GenericCastToPtr %1 : !spirv.ptr<!spirv.array<4 x f32>, Generic> to !spirv.ptr<!spirv.array<4 x f32>, Function>
    %3 = builtin.unrealized_conversion_cast %2 : !spirv.ptr<!spirv.array<4 x f32>, Function> to memref<4xf32, #spirv.storage_class<Function>>
    return %3 : memref<4xf32, #spirv.storage_class<Function>>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int8, Int16], [SPV_KHR_8bit_storage, SPV_KHR_16bit_storage, SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @load_i1(%arg0: memref<i1, #spirv.storage_class<StorageBuffer>>) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i1, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %2 = spirv.Load "StorageBuffer" %1 : i32
    %cst255_i32 = spirv.Constant 255 : i32
    %3 = spirv.BitwiseAnd %2, %cst255_i32 : i32
    %cst24_i32 = spirv.Constant 24 : i32
    %4 = spirv.ShiftLeftLogical %3, %cst24_i32 : i32, i32
    %5 = spirv.ShiftRightArithmetic %4, %cst24_i32 : i32, i32
    %cst1_i32 = spirv.Constant 1 : i32
    %6 = spirv.IEqual %5, %cst1_i32 : i32
    return %6 : i1
  }
  func.func @load_i8(%arg0: memref<i8, #spirv.storage_class<StorageBuffer>>) -> i8 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i8, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %2 = spirv.Load "StorageBuffer" %1 : i32
    %cst255_i32 = spirv.Constant 255 : i32
    %3 = spirv.BitwiseAnd %2, %cst255_i32 : i32
    %cst24_i32 = spirv.Constant 24 : i32
    %4 = spirv.ShiftLeftLogical %3, %cst24_i32 : i32, i32
    %5 = spirv.ShiftRightArithmetic %4, %cst24_i32 : i32, i32
    %6 = spirv.UConvert %5 : i32 to i8
    return %6 : i8
  }
  func.func @load_i16(%arg0: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg1: index) -> i16 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<10xi16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %2 = spirv.SDiv %0, %cst2_i32 : i32
    %3 = spirv.AccessChain %1[%cst0_i32, %2] : !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %4 = spirv.Load "StorageBuffer" %3 : i32
    %cst16_i32 = spirv.Constant 16 : i32
    %5 = spirv.UMod %0, %cst2_i32 : i32
    %6 = spirv.IMul %5, %cst16_i32 : i32
    %7 = spirv.ShiftRightArithmetic %4, %6 : i32, i32
    %cst65535_i32 = spirv.Constant 65535 : i32
    %8 = spirv.BitwiseAnd %7, %cst65535_i32 : i32
    %9 = spirv.ShiftLeftLogical %8, %cst16_i32 : i32, i32
    %10 = spirv.ShiftRightArithmetic %9, %cst16_i32 : i32, i32
    %11 = spirv.UConvert %10 : i32 to i16
    return %11 : i16
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} {
  func.func @reinterpret_cast(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>, %arg1: index) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<f32, CrossWorkgroup>
    %2 = spirv.InBoundsPtrAccessChain %1[%0] : !spirv.ptr<f32, CrossWorkgroup>, i32 -> !spirv.ptr<f32, CrossWorkgroup>
    %3 = builtin.unrealized_conversion_cast %2 : !spirv.ptr<f32, CrossWorkgroup> to memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    return %3 : memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
  }
  func.func @reinterpret_cast_0(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<f32, CrossWorkgroup>
    %1 = builtin.unrealized_conversion_cast %0 : !spirv.ptr<f32, CrossWorkgroup> to memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    return %1 : memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
  }
  func.func @reinterpret_cast_5(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<f32, CrossWorkgroup>
    %cst5_i32 = spirv.Constant 5 : i32
    %1 = spirv.InBoundsPtrAccessChain %0[%cst5_i32] : !spirv.ptr<f32, CrossWorkgroup>, i32 -> !spirv.ptr<f32, CrossWorkgroup>
    %2 = builtin.unrealized_conversion_cast %1 : !spirv.ptr<f32, CrossWorkgroup> to memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
    return %2 : memref<?xf32, strided<[1], offset: ?>, #spirv.storage_class<CrossWorkgroup>>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses, GenericPointer], []>, #spirv.resource_limits<>>} {
  func.func @cast(%arg0: memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<f32, CrossWorkgroup>
    %1 = builtin.unrealized_conversion_cast %0 : !spirv.ptr<f32, CrossWorkgroup> to memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
    return %1 : memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
  }
  func.func @cast_from_static(%arg0: memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>> {
    %cast = memref.cast %arg0 : memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>> to memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
    return %cast : memref<?x4xf32, #spirv.storage_class<CrossWorkgroup>>
  }
  func.func @cast_to_static(%arg0: memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>> {
    %cast = memref.cast %arg0 : memref<4x?xf32, #spirv.storage_class<CrossWorkgroup>> to memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>
    return %cast : memref<4x4xf32, #spirv.storage_class<CrossWorkgroup>>
  }
  func.func @cast_to_static_zero_elems(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> memref<0xf32, #spirv.storage_class<CrossWorkgroup>> {
    %cast = memref.cast %arg0 : memref<?xf32, #spirv.storage_class<CrossWorkgroup>> to memref<0xf32, #spirv.storage_class<CrossWorkgroup>>
    return %cast : memref<0xf32, #spirv.storage_class<CrossWorkgroup>>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Kernel, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} {
  func.func @extract_aligned_pointer_as_index_kernel(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<f32, CrossWorkgroup>
    %1 = spirv.ConvertPtrToU %0 : !spirv.ptr<f32, CrossWorkgroup> to i32
    %2 = builtin.unrealized_conversion_cast %1 : i32 to index
    return %2 : index
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [Shader, Int64, Addresses, PhysicalStorageBufferAddresses], []>, #spirv.resource_limits<>>} {
  func.func @extract_aligned_pointer_as_index_shader(%arg0: memref<?xf32, #spirv.storage_class<CrossWorkgroup>>) -> index {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, #spirv.storage_class<CrossWorkgroup>> to !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, CrossWorkgroup>
    %1 = spirv.ConvertPtrToU %0 : !spirv.ptr<!spirv.struct<(!spirv.rtarray<f32>)>, CrossWorkgroup> to i32
    %2 = builtin.unrealized_conversion_cast %1 : i32 to index
    return %2 : index
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer]>, #spirv.resource_limits<>>} {
  func.func @load_nontemporal(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %2 = spirv.Load "StorageBuffer" %1 ["Nontemporal"] : f32
    spirv.Store "StorageBuffer" %1, %2 ["Nontemporal"] : f32
    return
  }
  func.func @load_nontemporal_aligned(%arg0: memref<f32, #spirv.storage_class<PhysicalStorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<PhysicalStorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, PhysicalStorageBuffer>, i32, i32 -> !spirv.ptr<f32, PhysicalStorageBuffer>
    %2 = spirv.Load "PhysicalStorageBuffer" %1 ["Aligned|Nontemporal", 4] : f32
    spirv.Store "PhysicalStorageBuffer" %1, %2 ["Aligned|Nontemporal", 4] : f32
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1, d0)>
#map2 = affine_map<(d0, d1) -> (d0, d1 mod 2)>
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, PhysicalStorageBufferAddresses, Image1D, StorageImageExtendedFormats, Float16, StorageBuffer16BitAccess, StorageUniform16, Int16], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_physical_storage_buffer, SPV_KHR_16bit_storage]>, #spirv.resource_limits<>>} {
  func.func @load_from_image_1D(%arg0: memref<1xf32, #spirv.storage_class<Image>>, %arg1: memref<1xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<1xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<1xf32, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %c0 = arith.constant 0 : index
    %2 = builtin.unrealized_conversion_cast %c0 : index to i32
    %3 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %4 = spirv.Image %3 : !spirv.sampled_image<!spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %5 = spirv.ImageFetch %4, %2  : !spirv.image<f32, Dim1D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, i32 -> vector<4xf32>
    %6 = spirv.CompositeExtract %5[0 : i32] : vector<4xf32>
    %cst0_i32 = spirv.Constant 0 : i32
    %7 = spirv.AccessChain %0[%cst0_i32, %2] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %7, %6 : f32
    return
  }
  func.func @load_from_image_2D(%arg0: memref<2x4xf32, #spirv.storage_class<Image>>, %arg1: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x4xf32, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %c3 = arith.constant 3 : index
    %2 = builtin.unrealized_conversion_cast %c3 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<2xi32> -> vector<4xf32>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xf32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %9 = spirv.IMul %3, %cst4_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : f32
    return
  }
  func.func @load_from_col_major_image_2D(%arg0: memref<2x4xf32, #map, #spirv.storage_class<Image>>, %arg1: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x4xf32, #map, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %c3 = arith.constant 3 : index
    %2 = builtin.unrealized_conversion_cast %c3 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<f32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<2xi32> -> vector<4xf32>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xf32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %9 = spirv.IMul %3, %cst4_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : f32
    return
  }
  func.func @load_from_image_3D(%arg0: memref<2x3x4xf32, #spirv.storage_class<Image>>, %arg1: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3x4xf32, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %c3 = arith.constant 3 : index
    %2 = builtin.unrealized_conversion_cast %c3 : index to i32
    %c2 = arith.constant 2 : index
    %3 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %4 = builtin.unrealized_conversion_cast %c1 : index to i32
    %5 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %6 = spirv.Image %5 : !spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %7 = spirv.CompositeConstruct %2, %3, %4 : (i32, i32, i32) -> vector<3xi32>
    %8 = spirv.ImageFetch %6, %7  : !spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<3xi32> -> vector<4xf32>
    %9 = spirv.CompositeExtract %8[0 : i32] : vector<4xf32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %10 = spirv.IMul %4, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %11 = spirv.IMul %3, %cst4_i32 : i32
    %12 = spirv.IAdd %11, %10 : i32
    %13 = spirv.IAdd %2, %12 : i32
    %14 = spirv.AccessChain %0[%cst0_i32, %13] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %14, %9 : f32
    return
  }
  func.func @load_from_custom_layout_image_3D(%arg0: memref<2x3x4xf32, #map1, #spirv.storage_class<Image>>, %arg1: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3x4xf32, #map1, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>, UniformConstant>
    %c3 = arith.constant 3 : index
    %2 = builtin.unrealized_conversion_cast %c3 : index to i32
    %c2 = arith.constant 2 : index
    %3 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %4 = builtin.unrealized_conversion_cast %c1 : index to i32
    %5 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %6 = spirv.Image %5 : !spirv.sampled_image<!spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>>
    %7 = spirv.CompositeConstruct %2, %3, %4 : (i32, i32, i32) -> vector<3xi32>
    %8 = spirv.ImageFetch %6, %7  : !spirv.image<f32, Dim3D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32f>, vector<3xi32> -> vector<4xf32>
    %9 = spirv.CompositeExtract %8[0 : i32] : vector<4xf32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %10 = spirv.IMul %4, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %11 = spirv.IMul %3, %cst4_i32 : i32
    %12 = spirv.IAdd %11, %10 : i32
    %13 = spirv.IAdd %2, %12 : i32
    %14 = spirv.AccessChain %0[%cst0_i32, %13] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %14, %9 : f32
    return
  }
  func.func @load_from_image_2D_f16(%arg0: memref<2x3xf16, #spirv.storage_class<Image>>, %arg1: memref<2x3xf16, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3xf16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<6 x f16, stride=2> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xf16, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>, UniformConstant>
    %c2 = arith.constant 2 : index
    %2 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<f16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16f>, vector<2xi32> -> vector<4xf16>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xf16>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %9 = spirv.IMul %3, %cst3_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<6 x f16, stride=2> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f16, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : f16
    return
  }
  func.func @load_from_image_2D_i32(%arg0: memref<2x3xi32, #spirv.storage_class<Image>>, %arg1: memref<2x3xi32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xi32, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>, UniformConstant>
    %c2 = arith.constant 2 : index
    %2 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<i32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32i>, vector<2xi32> -> vector<4xi32>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xi32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %9 = spirv.IMul %3, %cst3_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : i32
    return
  }
  func.func @load_from_image_2D_ui32(%arg0: memref<2x3xui32, #spirv.storage_class<Image>>, %arg1: memref<2x3xui32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3xui32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<6 x ui32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xui32, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>, UniformConstant>
    %c2 = arith.constant 2 : index
    %2 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<ui32, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R32ui>, vector<2xi32> -> vector<4xui32>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xui32>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %9 = spirv.IMul %3, %cst3_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<6 x ui32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<ui32, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : ui32
    return
  }
  func.func @load_from_image_2D_i16(%arg0: memref<2x3xi16, #spirv.storage_class<Image>>, %arg1: memref<2x3xi16, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3xi16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<6 x i16, stride=2> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xi16, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>, UniformConstant>
    %c2 = arith.constant 2 : index
    %2 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<i16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16i>, vector<2xi32> -> vector<4xi16>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xi16>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %9 = spirv.IMul %3, %cst3_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<6 x i16, stride=2> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i16, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : i16
    return
  }
  func.func @load_from_image_2D_ui16(%arg0: memref<2x3xui16, #spirv.storage_class<Image>>, %arg1: memref<2x3xui16, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x3xui16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<6 x ui16, stride=2> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<2x3xui16, #spirv.storage_class<Image>> to !spirv.ptr<!spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>, UniformConstant>
    %c2 = arith.constant 2 : index
    %2 = builtin.unrealized_conversion_cast %c2 : index to i32
    %c1 = arith.constant 1 : index
    %3 = builtin.unrealized_conversion_cast %c1 : index to i32
    %4 = spirv.Load "UniformConstant" %1 : !spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>
    %5 = spirv.Image %4 : !spirv.sampled_image<!spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>>
    %6 = spirv.CompositeConstruct %2, %3 : (i32, i32) -> vector<2xi32>
    %7 = spirv.ImageFetch %5, %6  : !spirv.image<ui16, Dim2D, DepthUnknown, NonArrayed, SingleSampled, NeedSampler, R16ui>, vector<2xi32> -> vector<4xui16>
    %8 = spirv.CompositeExtract %7[0 : i32] : vector<4xui16>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst3_i32 = spirv.Constant 3 : i32
    %9 = spirv.IMul %3, %cst3_i32 : i32
    %10 = spirv.IAdd %2, %9 : i32
    %11 = spirv.AccessChain %0[%cst0_i32, %10] : !spirv.ptr<!spirv.struct<(!spirv.array<6 x ui16, stride=2> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<ui16, StorageBuffer>
    spirv.Store "StorageBuffer" %11, %8 : ui16
    return
  }
  func.func @load_from_image_2D_rank0(%arg0: memref<f32, #spirv.storage_class<Image>>, %arg1: memref<f32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<f32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %1 = memref.load %arg0[] : memref<f32, #spirv.storage_class<Image>>
    %cst0_i32 = spirv.Constant 0 : i32
    %2 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %2, %1 : f32
    return
  }
  func.func @load_from_image_2D_rank4(%arg0: memref<1x1x1x1xf32, #spirv.storage_class<Image>>, %arg1: memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<1x1x1x1xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %2 = memref.load %arg0[%c0, %c0, %c0, %c0] : memref<1x1x1x1xf32, #spirv.storage_class<Image>>
    %cst0_i32 = spirv.Constant 0 : i32
    %3 = spirv.IAdd %1, %1 : i32
    %4 = spirv.IAdd %1, %3 : i32
    %5 = spirv.IAdd %1, %4 : i32
    %6 = spirv.AccessChain %0[%cst0_i32, %5] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %6, %2 : f32
    return
  }
  func.func @load_from_image_2D_vector(%arg0: memref<1xvector<1xf32>, #spirv.storage_class<Image>>, %arg1: memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<1xvector<1xf32>, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i32
    %2 = memref.load %arg0[%c0] : memref<1xvector<1xf32>, #spirv.storage_class<Image>>
    %3 = builtin.unrealized_conversion_cast %2 : vector<1xf32> to f32
    %cst0_i32 = spirv.Constant 0 : i32
    %4 = spirv.AccessChain %0[%cst0_i32, %1] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %4, %3 : f32
    return
  }
  func.func @load_non_perm_layout(%arg0: memref<2x4xf32, #map2, #spirv.storage_class<Image>>, %arg1: memref<2x4xf32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg1 : memref<2x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>
    %c3 = arith.constant 3 : index
    %1 = builtin.unrealized_conversion_cast %c3 : index to i32
    %c1 = arith.constant 1 : index
    %2 = builtin.unrealized_conversion_cast %c1 : index to i32
    %3 = memref.load %arg0[%c1, %c3] : memref<2x4xf32, #map2, #spirv.storage_class<Image>>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %4 = spirv.IMul %2, %cst4_i32 : i32
    %5 = spirv.IAdd %1, %4 : i32
    %6 = spirv.AccessChain %0[%cst0_i32, %5] : !spirv.ptr<!spirv.struct<(!spirv.array<8 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %6, %3 : f32
    return
  }
}

