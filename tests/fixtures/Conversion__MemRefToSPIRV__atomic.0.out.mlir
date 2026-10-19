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
    %9 = spirv.AtomicIAdd <Device> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
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
    %9 = spirv.AtomicSMax <Workgroup> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, Workgroup>
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
    %9 = spirv.AtomicUMax <Device> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
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
    %9 = spirv.AtomicSMin <Workgroup> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, Workgroup>
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
    %9 = spirv.AtomicUMin <Device> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
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
    %9 = spirv.AtomicOr <Workgroup> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, Workgroup>
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
    %9 = spirv.AtomicAnd <Device> <AcquireRelease> %8, %arg0 : !spirv.ptr<i32, StorageBuffer>
    return %9 : i32
  }
}

