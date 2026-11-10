module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @atomic_addi_storage_buffer(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %9 = spirv.AtomicIAdd <Device> <AcquireRelease|UniformMemory> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
    return %9 : i32
  }
  func.func @atomic_maxs_workgroup(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<Workgroup>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>, i32, i32 -> !spirv.ptr<i32, Workgroup>
    %9 = spirv.AtomicSMax <Workgroup> <AcquireRelease|WorkgroupMemory> %8, %arg0 : !spirv.ptr<i32, Workgroup>
    return %9 : i32
  }
  func.func @atomic_maxu_storage_buffer(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %9 = spirv.AtomicUMax <Device> <AcquireRelease|UniformMemory> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
    return %9 : i32
  }
  func.func @atomic_mins_workgroup(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<Workgroup>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>, i32, i32 -> !spirv.ptr<i32, Workgroup>
    %9 = spirv.AtomicSMin <Workgroup> <AcquireRelease|WorkgroupMemory> %8, %arg0 : !spirv.ptr<i32, Workgroup>
    return %9 : i32
  }
  func.func @atomic_minu_storage_buffer(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %9 = spirv.AtomicUMin <Device> <AcquireRelease|UniformMemory> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
    return %9 : i32
  }
  func.func @atomic_ori_workgroup(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<Workgroup>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<Workgroup>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32>)>, Workgroup>, i32, i32 -> !spirv.ptr<i32, Workgroup>
    %9 = spirv.AtomicOr <Workgroup> <AcquireRelease|WorkgroupMemory> %8, %arg0 : !spirv.ptr<i32, Workgroup>
    return %9 : i32
  }
  func.func @atomic_andi_storage_buffer(%arg0: i32, %arg1: memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index) -> i32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xi32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %9 = spirv.AtomicAnd <Device> <AcquireRelease|UniformMemory> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
    return %9 : i32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @atomic_ori_i8_storage_buffer(%arg0: i8, %arg1: memref<16xi8, #spirv.storage_class<StorageBuffer>>, %arg2: index) -> i8 {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<16xi8, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>
    %2 = builtin.unrealized_conversion_cast %arg0 : i8 to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %3 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %cst4_i32 = spirv.Constant 4 : i32
    %cst8_i32 = spirv.Constant 8 : i32
    %4 = spirv.UMod %0, %cst4_i32 : i32
    %5 = spirv.IMul %4, %cst8_i32 : i32
    %cst4_i32_1 = spirv.Constant 4 : i32
    %6 = spirv.SDiv %0, %cst4_i32_1 : i32
    %7 = spirv.AccessChain %1[%cst0_i32, %6] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %cst255_i32 = spirv.Constant 255 : i32
    %8 = spirv.BitwiseAnd %2, %cst255_i32 : i32
    %9 = spirv.ShiftLeftLogical %8, %5 : i32, i32
    %10 = spirv.AtomicOr <Device> <AcquireRelease|UniformMemory> %7, %9 : !spirv.ptr<i32, StorageBuffer>
    %11 = spirv.ShiftRightLogical %10, %5 : i32, i32
    %cst255_i32_2 = spirv.Constant 255 : i32
    %12 = spirv.BitwiseAnd %11, %cst255_i32_2 : i32
    %13 = builtin.unrealized_conversion_cast %12 : i32 to i8
    return %13 : i8
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @atomic_andi_i8_storage_buffer(%arg0: i8, %arg1: memref<16xi8, #spirv.storage_class<StorageBuffer>>, %arg2: index) -> i8 {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<16xi8, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>
    %2 = builtin.unrealized_conversion_cast %arg0 : i8 to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %3 = spirv.AccessChain %1[%cst0_i32, %0] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %cst4_i32 = spirv.Constant 4 : i32
    %cst8_i32 = spirv.Constant 8 : i32
    %4 = spirv.UMod %0, %cst4_i32 : i32
    %5 = spirv.IMul %4, %cst8_i32 : i32
    %cst4_i32_1 = spirv.Constant 4 : i32
    %6 = spirv.SDiv %0, %cst4_i32_1 : i32
    %7 = spirv.AccessChain %1[%cst0_i32, %6] : !spirv.ptr<!spirv.struct<(!spirv.array<4 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %cst255_i32 = spirv.Constant 255 : i32
    %8 = spirv.BitwiseAnd %2, %cst255_i32 : i32
    %9 = spirv.ShiftLeftLogical %8, %5 : i32, i32
    %10 = spirv.ShiftLeftLogical %cst255_i32, %5 : i32, i32
    %11 = spirv.Not %10 : i32
    %12 = spirv.BitwiseOr %9, %11 : i32
    %13 = spirv.AtomicAnd <Device> <AcquireRelease|UniformMemory> %7, %12 : !spirv.ptr<i32, StorageBuffer>
    %14 = spirv.ShiftRightLogical %13, %5 : i32, i32
    %cst255_i32_2 = spirv.Constant 255 : i32
    %15 = spirv.BitwiseAnd %14, %cst255_i32_2 : i32
    %16 = builtin.unrealized_conversion_cast %15 : i32 to i8
    return %16 : i8
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, AtomicFloat32AddEXT], [SPV_EXT_shader_atomic_float_add]>, #spirv.resource_limits<>>} {
  func.func @atomic_addf_storage_buffer(%arg0: f32, %arg1: memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>>, %arg2: index, %arg3: index, %arg4: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg4 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg1 : memref<2x3x4xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst0_i32_0 = spirv.Constant 0 : i32
    %cst12_i32 = spirv.Constant 12 : i32
    %4 = spirv.IMul %2, %cst12_i32 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.IMul %1, %cst4_i32 : i32
    %6 = spirv.IAdd %5, %4 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %3[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<24 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %9 = spirv.EXT.AtomicFAdd <Device> <AcquireRelease|UniformMemory> %8, %arg0 : !spirv.ptr<f32, StorageBuffer>
    return %9 : f32
  }
}

