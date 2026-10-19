module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
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
    %6 = builtin.unrealized_conversion_cast %5 : i32 to i8
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
    %11 = builtin.unrealized_conversion_cast %10 : i32 to i16
    return %11 : i16
  }
  func.func @load_f32(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %2 = spirv.Load "StorageBuffer" %1 : f32
    return
  }
  func.func @store_i1(%arg0: memref<i1, #spirv.storage_class<StorageBuffer>>, %arg1: i1) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i1, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-256_i32 = spirv.Constant -256 : i32
    %cst1_i32 = spirv.Constant 1 : i32
    %1 = spirv.Select %arg1, %cst1_i32, %cst0_i32 : i1, i32
    %2 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %3 = spirv.AtomicAnd <Device> <AcquireRelease> %2, %cst-256_i32 : !spirv.ptr<i32, StorageBuffer>
    %4 = spirv.AtomicOr <Device> <AcquireRelease> %2, %1 : !spirv.ptr<i32, StorageBuffer>
    return
  }
  func.func @store_i8(%arg0: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg1: i8) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i8, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %1 = builtin.unrealized_conversion_cast %arg1 : i8 to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst255_i32 = spirv.Constant 255 : i32
    %cst-256_i32 = spirv.Constant -256 : i32
    %2 = spirv.BitwiseAnd %1, %cst255_i32 : i32
    %3 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %4 = spirv.AtomicAnd <Device> <AcquireRelease> %3, %cst-256_i32 : !spirv.ptr<i32, StorageBuffer>
    %5 = spirv.AtomicOr <Device> <AcquireRelease> %3, %2 : !spirv.ptr<i32, StorageBuffer>
    return
  }
  func.func @store_i16(%arg0: memref<10xi16, #spirv.storage_class<StorageBuffer>>, %arg1: index, %arg2: i16) {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<10xi16, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>
    %2 = builtin.unrealized_conversion_cast %arg2 : i16 to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst16_i32 = spirv.Constant 16 : i32
    %3 = spirv.UMod %0, %cst2_i32 : i32
    %4 = spirv.IMul %3, %cst16_i32 : i32
    %cst65535_i32 = spirv.Constant 65535 : i32
    %5 = spirv.ShiftLeftLogical %cst65535_i32, %4 : i32, i32
    %6 = spirv.Not %5 : i32
    %7 = spirv.BitwiseAnd %2, %cst65535_i32 : i32
    %8 = spirv.ShiftLeftLogical %7, %4 : i32, i32
    %9 = spirv.SDiv %0, %cst2_i32 : i32
    %10 = spirv.AccessChain %1[%cst0_i32, %9] : !spirv.ptr<!spirv.struct<(!spirv.array<5 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %11 = spirv.AtomicAnd <Device> <AcquireRelease> %10, %6 : !spirv.ptr<i32, StorageBuffer>
    %12 = spirv.AtomicOr <Device> <AcquireRelease> %10, %8 : !spirv.ptr<i32, StorageBuffer>
    return
  }
  func.func @store_f32(%arg0: memref<f32, #spirv.storage_class<StorageBuffer>>, %arg1: f32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %1 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    spirv.Store "StorageBuffer" %1, %arg1 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @load_i4(%arg0: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg1: index) -> i4 {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xi4, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst8_i32 = spirv.Constant 8 : i32
    %2 = spirv.SDiv %0, %cst8_i32 : i32
    %3 = spirv.AccessChain %1[%cst0_i32, %2] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %4 = spirv.Load "StorageBuffer" %3 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %5 = spirv.UMod %0, %cst8_i32 : i32
    %6 = spirv.IMul %5, %cst4_i32 : i32
    %7 = spirv.ShiftRightArithmetic %4, %6 : i32, i32
    %cst15_i32 = spirv.Constant 15 : i32
    %8 = spirv.BitwiseAnd %7, %cst15_i32 : i32
    %cst28_i32 = spirv.Constant 28 : i32
    %9 = spirv.ShiftLeftLogical %8, %cst28_i32 : i32, i32
    %10 = spirv.ShiftRightArithmetic %9, %cst28_i32 : i32, i32
    %11 = builtin.unrealized_conversion_cast %10 : i32 to i4
    return %11 : i4
  }
  func.func @store_i4(%arg0: memref<?xi4, #spirv.storage_class<StorageBuffer>>, %arg1: i4, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xi4, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>
    %2 = builtin.unrealized_conversion_cast %arg1 : i4 to i32
    %cst0_i32 = spirv.Constant 0 : i32
    %cst8_i32 = spirv.Constant 8 : i32
    %cst4_i32 = spirv.Constant 4 : i32
    %3 = spirv.UMod %0, %cst8_i32 : i32
    %4 = spirv.IMul %3, %cst4_i32 : i32
    %cst15_i32 = spirv.Constant 15 : i32
    %5 = spirv.ShiftLeftLogical %cst15_i32, %4 : i32, i32
    %6 = spirv.Not %5 : i32
    %7 = spirv.BitwiseAnd %2, %cst15_i32 : i32
    %8 = spirv.ShiftLeftLogical %7, %4 : i32, i32
    %9 = spirv.SDiv %0, %cst8_i32 : i32
    %10 = spirv.AccessChain %1[%cst0_i32, %9] : !spirv.ptr<!spirv.struct<(!spirv.rtarray<i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %11 = spirv.AtomicAnd <Device> <AcquireRelease> %10, %6 : !spirv.ptr<i32, StorageBuffer>
    %12 = spirv.AtomicOr <Device> <AcquireRelease> %10, %8 : !spirv.ptr<i32, StorageBuffer>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64, Int8], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
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
  func.func @store_i8(%arg0: memref<i8, #spirv.storage_class<StorageBuffer>>, %arg1: i8) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<i8, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>
    %cst0_i32 = spirv.Constant 0 : i32
    %cst-256_i32 = spirv.Constant -256 : i32
    %1 = spirv.UConvert %arg1 : i8 to i32
    %2 = spirv.AccessChain %0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<1 x i32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<i32, StorageBuffer>
    %3 = spirv.AtomicAnd <Device> <AcquireRelease> %2, %cst-256_i32 : !spirv.ptr<i32, StorageBuffer>
    %4 = spirv.AtomicOr <Device> <AcquireRelease> %2, %1 : !spirv.ptr<i32, StorageBuffer>
    return
  }
}

